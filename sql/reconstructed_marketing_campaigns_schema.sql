-- Reconstructed relational schema for the Marketing Campaign Performance project.
-- Based on the column names, observed Parquet dtypes, and key relationships
-- recorded in notebooks/01_data_inspection.ipynb.
-- This is a reproducible project schema, not a byte-for-byte copy of the
-- original vendor-provided SQL schema.

CREATE TABLE channels (
    channel_id INTEGER PRIMARY KEY,
    channel_name TEXT NOT NULL,
    medium TEXT NOT NULL,
    is_paid BOOLEAN NOT NULL
);

CREATE TABLE campaigns (
    campaign_id INTEGER PRIMARY KEY,
    campaign_name TEXT NOT NULL,
    channel_id INTEGER NOT NULL REFERENCES channels(channel_id),
    objective TEXT NOT NULL,
    started_on DATE NOT NULL,
    ended_on DATE,
    budget NUMERIC(14, 2) NOT NULL
);

CREATE TABLE ad_groups (
    ad_group_id INTEGER PRIMARY KEY,
    campaign_id INTEGER NOT NULL REFERENCES campaigns(campaign_id),
    ad_group_name TEXT NOT NULL,
    target_audience TEXT NOT NULL,
    status TEXT NOT NULL
);

CREATE TABLE daily_performance (
    performance_id INTEGER PRIMARY KEY,
    ad_group_id INTEGER NOT NULL REFERENCES ad_groups(ad_group_id),
    activity_date DATE NOT NULL,
    impressions INTEGER NOT NULL,
    clicks INTEGER NOT NULL,
    spend NUMERIC(14, 2) NOT NULL,
    conversions INTEGER NOT NULL,
    conversion_value NUMERIC(14, 2) NOT NULL,
    UNIQUE (ad_group_id, activity_date)
);

CREATE TABLE conversions (
    conversion_id INTEGER PRIMARY KEY,
    ad_group_id INTEGER NOT NULL REFERENCES ad_groups(ad_group_id),
    first_touch_channel_id INTEGER NOT NULL REFERENCES channels(channel_id),
    last_touch_channel_id INTEGER NOT NULL REFERENCES channels(channel_id),
    converted_at TIMESTAMP NOT NULL,
    revenue NUMERIC(14, 2) NOT NULL,
    touch_count INTEGER NOT NULL,
    device TEXT NOT NULL
);
