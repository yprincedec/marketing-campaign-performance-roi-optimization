-- 01_campaign_channel_performance.sql
-- Campaign-level performance using daily_performance as the source of delivery metrics.
-- PostgreSQL syntax. Ratios use NULLIF to avoid division by zero.
-- conversion_value is kept separate from conversions.revenue; do not mix these measures.

WITH campaign_delivery AS (
    SELECT
        ag.campaign_id,
        SUM(dp.impressions) AS impressions,
        SUM(dp.clicks) AS clicks,
        SUM(dp.spend) AS spend,
        SUM(dp.conversions) AS platform_conversions,
        SUM(dp.conversion_value) AS platform_conversion_value
    FROM daily_performance AS dp
    INNER JOIN ad_groups AS ag
        ON dp.ad_group_id = ag.ad_group_id
    GROUP BY ag.campaign_id
)
SELECT
    c.campaign_id,
    c.campaign_name,
    ch.channel_name,
    c.objective,
    c.started_on,
    c.ended_on,
    c.budget,
    COALESCE(cd.impressions, 0) AS impressions,
    COALESCE(cd.clicks, 0) AS clicks,
    COALESCE(cd.spend, 0) AS spend,
    COALESCE(cd.platform_conversions, 0) AS platform_conversions,
    COALESCE(cd.platform_conversion_value, 0) AS platform_conversion_value,
    100.0 * cd.clicks / NULLIF(cd.impressions, 0) AS ctr_pct,
    cd.spend / NULLIF(cd.clicks, 0) AS cpc,
    cd.spend / NULLIF(cd.platform_conversions, 0) AS cpa,
    100.0 * cd.platform_conversions / NULLIF(cd.clicks, 0) AS click_to_conversion_pct,
    cd.platform_conversion_value / NULLIF(cd.spend, 0) AS platform_roas,
    100.0 * (cd.platform_conversion_value - cd.spend) / NULLIF(cd.spend, 0) AS platform_roi_pct
FROM campaigns AS c
LEFT JOIN channels AS ch
    ON c.channel_id = ch.channel_id
LEFT JOIN campaign_delivery AS cd
    ON c.campaign_id = cd.campaign_id
ORDER BY spend DESC NULLS LAST, c.campaign_id;

-- Channel-level rollup. Aggregate before calculating rates; never average
-- campaign-level percentages to obtain an overall channel percentage.
WITH channel_delivery AS (
    SELECT
        c.channel_id,
        SUM(dp.impressions) AS impressions,
        SUM(dp.clicks) AS clicks,
        SUM(dp.spend) AS spend,
        SUM(dp.conversions) AS platform_conversions,
        SUM(dp.conversion_value) AS platform_conversion_value
    FROM daily_performance AS dp
    INNER JOIN ad_groups AS ag
        ON dp.ad_group_id = ag.ad_group_id
    INNER JOIN campaigns AS c
        ON ag.campaign_id = c.campaign_id
    GROUP BY c.channel_id
)
SELECT
    ch.channel_id,
    ch.channel_name,
    ch.medium,
    ch.is_paid,
    COALESCE(cd.impressions, 0) AS impressions,
    COALESCE(cd.clicks, 0) AS clicks,
    COALESCE(cd.spend, 0) AS spend,
    COALESCE(cd.platform_conversions, 0) AS platform_conversions,
    COALESCE(cd.platform_conversion_value, 0) AS platform_conversion_value,
    100.0 * cd.clicks / NULLIF(cd.impressions, 0) AS ctr_pct,
    cd.spend / NULLIF(cd.clicks, 0) AS cpc,
    cd.spend / NULLIF(cd.platform_conversions, 0) AS cpa,
    cd.platform_conversion_value / NULLIF(cd.spend, 0) AS platform_roas
FROM channels AS ch
LEFT JOIN channel_delivery AS cd
    ON ch.channel_id = cd.channel_id
ORDER BY spend DESC NULLS LAST, ch.channel_id;

-- Conversion event attribution by first-touch and last-touch channel.
-- This uses conversions.revenue and must remain a separate event-level view:
-- it is not directly interchangeable with daily_performance.conversion_value.
SELECT
    ch.channel_id,
    ch.channel_name,
    COUNT(*) AS attributed_conversion_events,
    SUM(cv.revenue) AS attributed_revenue,
    AVG(cv.touch_count) AS avg_touch_count
FROM conversions AS cv
INNER JOIN channels AS ch
    ON cv.last_touch_channel_id = ch.channel_id
GROUP BY ch.channel_id, ch.channel_name
ORDER BY attributed_revenue DESC, ch.channel_id;
