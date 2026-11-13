-- 01_campaign_channel_performance.sql
-- SQL dialect: DuckDB (also broadly compatible with PostgreSQL).
-- Source: daily_performance for delivery metrics; conversions for event attribution.
-- Scope: all dates present in the source Parquet tables.
-- IMPORTANT: daily_performance.conversion_value and conversions.revenue are
-- different measures and are reported separately, never added together.

-- 1. Campaign performance: preserve all 600 campaigns, including those
-- without daily performance rows. Zero-spend cost/return ratios stay NULL.
WITH campaign_delivery AS (
    SELECT
        ag.campaign_id,
        SUM(dp.impressions) AS impressions,
        SUM(dp.clicks) AS clicks,
        SUM(dp.spend) AS spend,
        SUM(dp.conversions) AS platform_conversions,
        SUM(dp.conversion_value) AS platform_conversion_value
    FROM daily_performance dp
    JOIN ad_groups ag ON dp.ad_group_id = ag.ad_group_id
    GROUP BY ag.campaign_id
)
SELECT
    c.campaign_id,
    c.campaign_name,
    c.objective,
    ch.channel_name,
    ch.is_paid,
    c.budget,
    COALESCE(cd.impressions, 0) AS impressions,
    COALESCE(cd.clicks, 0) AS clicks,
    COALESCE(cd.spend, 0) AS spend,
    COALESCE(cd.platform_conversions, 0) AS conversions,
    COALESCE(cd.platform_conversion_value, 0) AS conversion_value,
    CASE WHEN cd.campaign_id IS NULL THEN 'No Performance Data'
         ELSE 'Available' END AS data_status,
    ROUND(100.0 * cd.clicks / NULLIF(cd.impressions, 0), 2) AS ctr_pct,
    CASE WHEN cd.spend > 0
         THEN ROUND(cd.spend / NULLIF(cd.clicks, 0), 2) END AS cpc,
    CASE WHEN cd.spend > 0
         THEN ROUND(1000.0 * cd.spend / NULLIF(cd.impressions, 0), 2) END AS cpm,
    CASE WHEN cd.spend > 0
         THEN ROUND(cd.spend / NULLIF(cd.platform_conversions, 0), 2) END AS cpa,
    CASE WHEN cd.spend > 0
         THEN ROUND(cd.platform_conversion_value / cd.spend, 2) END AS roas,
    CASE WHEN cd.spend > 0
         THEN ROUND(100.0 * (cd.platform_conversion_value - cd.spend) / cd.spend, 2) END AS roi_pct
FROM campaigns c
LEFT JOIN channels ch ON c.channel_id = ch.channel_id
LEFT JOIN campaign_delivery cd ON c.campaign_id = cd.campaign_id
ORDER BY c.campaign_id;

-- 2. Channel performance: aggregate raw totals first, then calculate rates.
WITH channel_delivery AS (
    SELECT
        c.channel_id,
        SUM(dp.impressions) AS impressions,
        SUM(dp.clicks) AS clicks,
        SUM(dp.spend) AS spend,
        SUM(dp.conversions) AS platform_conversions,
        SUM(dp.conversion_value) AS platform_conversion_value
    FROM daily_performance dp
    JOIN ad_groups ag ON dp.ad_group_id = ag.ad_group_id
    JOIN campaigns c ON ag.campaign_id = c.campaign_id
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
    COALESCE(cd.platform_conversions, 0) AS conversions,
    COALESCE(cd.platform_conversion_value, 0) AS conversion_value,
    ROUND(100.0 * cd.clicks / NULLIF(cd.impressions, 0), 2) AS ctr_pct,
    CASE WHEN cd.spend > 0
         THEN ROUND(cd.spend / NULLIF(cd.clicks, 0), 2) END AS cpc,
    CASE WHEN cd.spend > 0
         THEN ROUND(cd.spend / NULLIF(cd.platform_conversions, 0), 2) END AS cpa,
    CASE WHEN cd.spend > 0
         THEN ROUND(cd.platform_conversion_value / cd.spend, 2) END AS roas
FROM channels ch
LEFT JOIN channel_delivery cd ON ch.channel_id = cd.channel_id
ORDER BY spend DESC, ch.channel_id;

-- 3. Conversion-event attribution by last-touch channel.
-- Uses conversions.revenue; this is a separate measure from conversion_value.
SELECT
    ch.channel_id,
    ch.channel_name,
    COUNT(*) AS attributed_conversion_events,
    SUM(cv.revenue) AS attributed_revenue,
    AVG(cv.touch_count) AS avg_touch_count
FROM conversions cv
JOIN channels ch ON cv.last_touch_channel_id = ch.channel_id
GROUP BY ch.channel_id, ch.channel_name
ORDER BY attributed_revenue DESC, ch.channel_id;

-- 4. Conversion-event attribution by first-touch channel.
SELECT
    ch.channel_id,
    ch.channel_name,
    COUNT(*) AS attributed_conversion_events,
    SUM(cv.revenue) AS attributed_revenue,
    AVG(cv.touch_count) AS avg_touch_count
FROM conversions cv
JOIN channels ch ON cv.first_touch_channel_id = ch.channel_id
GROUP BY ch.channel_id, ch.channel_name
ORDER BY attributed_revenue DESC, ch.channel_id;
