# Dataset Schema & Data Dictionary

This document describes the five source tables used in the Marketing Campaign Performance & ROI Optimization project. Column definitions are based on the supplied schema and the inspected Parquet data.

## Dataset inventory

| Table | Rows | Columns | Primary key |
|---|---:|---:|---|
| `channels` | 9 | 4 | `channel_id` |
| `campaigns` | 600 | 7 | `campaign_id` |
| `ad_groups` | 3,000 | 5 | `ad_group_id` |
| `daily_performance` | 260,000 | 8 | `performance_id` |
| `conversions` | 40,000 | 8 | `conversion_id` |

## Table definitions

### `channels`
| Column | Declared type | Description |
|---|---|---|
| `channel_id` | INTEGER | Unique channel identifier; primary key |
| `channel_name` | VARCHAR | Channel name |
| `medium` | VARCHAR | Marketing medium |
| `is_paid` | BOOLEAN | Whether the channel is paid |

### `campaigns`
| Column | Declared type | Description |
|---|---|---|
| `campaign_id` | INTEGER | Unique campaign identifier; primary key |
| `campaign_name` | VARCHAR | Campaign name |
| `channel_id` | INTEGER | Foreign key to `channels.channel_id` |
| `objective` | VARCHAR | Campaign objective |
| `started_on` | DATE | Campaign start date |
| `ended_on` | DATE | Campaign end date; nullable |
| `budget` | DECIMAL(12,2) | Campaign budget |

### `ad_groups`
| Column | Declared type | Description |
|---|---|---|
| `ad_group_id` | INTEGER | Unique ad-group identifier; primary key |
| `campaign_id` | INTEGER | Foreign key to `campaigns.campaign_id` |
| `ad_group_name` | VARCHAR | Ad-group name |
| `target_audience` | VARCHAR | Target audience |
| `status` | VARCHAR | Ad-group status |

### `daily_performance`
| Column | Declared type | Description |
|---|---|---|
| `performance_id` | INTEGER | Unique performance-row identifier; primary key |
| `ad_group_id` | INTEGER | Foreign key to `ad_groups.ad_group_id` |
| `activity_date` | DATE | Performance date |
| `impressions` | INTEGER | Impressions |
| `clicks` | INTEGER | Clicks |
| `spend` | DECIMAL(12,2) | Advertising spend |
| `conversions` | INTEGER | Daily reported conversions |
| `conversion_value` | DECIMAL(12,2) | Daily reported conversion value |

### `conversions`
| Column | Declared type | Description |
|---|---|---|
| `conversion_id` | INTEGER | Unique conversion-event identifier; primary key |
| `ad_group_id` | INTEGER | Foreign key to `ad_groups.ad_group_id` |
| `first_touch_channel_id` | INTEGER | Foreign key to `channels.channel_id` |
| `last_touch_channel_id` | INTEGER | Foreign key to `channels.channel_id` |
| `converted_at` | TIMESTAMP | Conversion timestamp |
| `revenue` | DECIMAL(12,2) | Revenue recorded for the conversion event |
| `touch_count` | INTEGER | Number of recorded touches |
| `device` | VARCHAR | Device category |

## Relationships

- `campaigns.channel_id` → `channels.channel_id`
- `ad_groups.campaign_id` → `campaigns.campaign_id`
- `daily_performance.ad_group_id` → `ad_groups.ad_group_id`
- `conversions.ad_group_id` → `ad_groups.ad_group_id`
- `conversions.first_touch_channel_id` → `channels.channel_id`
- `conversions.last_touch_channel_id` → `channels.channel_id`

## Metric definitions and cautions

- CTR = clicks / impressions.
- CPC = spend / clicks.
- CPM = spend / impressions × 1,000.
- CPA = spend / a clearly defined conversion count.
- ROAS = attributed conversion value / advertising spend.
- ROI = (attributed conversion value − advertising spend) / advertising spend.

The dashboard's revenue KPI uses the analyzed daily-performance `conversion_value` measure. The conversion-event `revenue` field is a separate measure. The two totals do not reconcile directly because their date coverage and aggregation differ; they must not be silently combined or forced to match.

Do not calculate cost-efficiency ratios for zero-spend channels. Avoid joining daily performance directly to individual conversion rows before aggregation, as this can multiply spend and performance values.

## Validation and supporting evidence

The project notebook and report exports document schema inspection, row counts, primary-key checks, foreign-key checks, missing-value review, date-coverage diagnostics, and metric reconciliation notes.

- [Data inspection notebook](../notebooks/01_data_inspection.ipynb)
- [Data inspection findings](../reports/data_inspection_findings.md)
- [Data quality summary](../reports/data_quality_summary.csv)
- [Primary-key checks](../reports/primary_key_checks.csv)
- [Foreign-key checks](../reports/foreign_key_checks.csv)
- [Conversion date diagnostics](../reports/conversion_date_diagnostics.csv)
- [Performance totals](../reports/performance_totals.csv)
