# Dataset Schema & Data Dictionary

This document records the structure declared by the SQL schema included in the supplied dataset archive. It describes expected columns and relationships; actual Parquet row counts, observed values, and data-quality results are pending programmatic inspection.

## Tables and expected columns

### `channels`
| Column | Declared type | Notes |
|---|---|---|
| `channel_id` | INTEGER | Primary key |
| `channel_name` | VARCHAR | Channel name |
| `medium` | VARCHAR | Marketing medium |
| `is_paid` | BOOLEAN | Whether the channel is paid |

### `campaigns`
| Column | Declared type | Notes |
|---|---|---|
| `campaign_id` | INTEGER | Primary key |
| `campaign_name` | VARCHAR | Campaign name |
| `channel_id` | INTEGER | Foreign key to `channels.channel_id` |
| `objective` | VARCHAR | Campaign objective |
| `started_on` | DATE | Campaign start date |
| `ended_on` | DATE | Nullable campaign end date |
| `budget` | DECIMAL(12,2) | Declared campaign budget |

### `ad_groups`
| Column | Declared type | Notes |
|---|---|---|
| `ad_group_id` | INTEGER | Primary key |
| `campaign_id` | INTEGER | Foreign key to `campaigns.campaign_id` |
| `ad_group_name` | VARCHAR | Ad group name |
| `target_audience` | VARCHAR | Target audience |
| `status` | VARCHAR | Ad group status |

### `daily_performance`
| Column | Declared type | Notes |
|---|---|---|
| `performance_id` | INTEGER | Primary key |
| `ad_group_id` | INTEGER | Foreign key to `ad_groups.ad_group_id` |
| `activity_date` | DATE | Performance date |
| `impressions` | INTEGER | Impressions |
| `clicks` | INTEGER | Clicks |
| `spend` | DECIMAL(12,2) | Advertising spend |
| `conversions` | INTEGER | Reported conversions |
| `conversion_value` | DECIMAL(12,2) | Reported conversion value |

### `conversions`
| Column | Declared type | Notes |
|---|---|---|
| `conversion_id` | INTEGER | Primary key |
| `ad_group_id` | INTEGER | Foreign key to `ad_groups.ad_group_id` |
| `first_touch_channel_id` | INTEGER | Foreign key to `channels.channel_id` |
| `last_touch_channel_id` | INTEGER | Foreign key to `channels.channel_id` |
| `converted_at` | TIMESTAMP | Conversion timestamp |
| `revenue` | DECIMAL(12,2) | Conversion revenue |
| `touch_count` | INTEGER | Number of recorded touches |
| `device` | VARCHAR | Device category |

## Declared relationships

- `campaigns.channel_id` → `channels.channel_id`
- `ad_groups.campaign_id` → `campaigns.campaign_id`
- `daily_performance.ad_group_id` → `ad_groups.ad_group_id`
- `conversions.ad_group_id` → `ad_groups.ad_group_id`
- `conversions.first_touch_channel_id` → `channels.channel_id`
- `conversions.last_touch_channel_id` → `channels.channel_id`

## Metric interpretation cautions

- CTR = clicks / impressions.
- CPC = spend / clicks.
- CPA requires a clearly selected conversion definition; daily reported conversions and rows in the conversions table must not be assumed equivalent until reconciled.
- ROAS requires a defensible revenue/value numerator and spend denominator. The `conversion_value` and `revenue` fields must be compared before selecting one.
- ROI requires an explicit definition of return and investment. It is not interchangeable with ROAS.
- Avoid joining daily performance directly to individual conversion rows without aggregation; this may multiply spend or performance metrics.

## Validation status

- [x] SQL schema file found in the supplied ZIP.
- [x] Table names, declared columns, and key relationships documented.
- [ ] Parquet row counts and physical schemas inspected.
- [ ] Nulls, duplicates, date ranges, value ranges, and key integrity checked.
- [ ] Conversion and revenue fields reconciled.
