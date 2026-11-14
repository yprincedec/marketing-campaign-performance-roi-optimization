# Campaign Performance Analysis

## Scope
- Source tables: `campaigns`, `channels`, `ad_groups`, and `daily_performance`
- Campaign records: 600
- Campaigns with daily performance: 516
- Campaigns without daily performance: 84
- Daily performance date coverage: 2024-01-09 to 2025-12-31 (from the inspection milestone)

## Validated delivery totals
| Metric | Total |
|---|---:|
| Impressions | 795,641,662 |
| Clicks | 3,214,946 |
| Spend | 3,240,599.18 |
| Platform-reported conversions | 34,392 |
| Platform conversion value | 2,524,740.59 |

These totals reconcile to the earlier data-inspection totals for `daily_performance`.

## Coverage and spend checks
| Status | Campaigns |
|---|---:|
| Performance available | 516 |
| No performance data | 84 |
| Available with positive spend | 355 |
| Available with zero spend | 161 |
| **Total campaigns** | **600** |

All 161 zero-spend campaigns belong to unpaid channels in the observed data. No paid-channel campaign with zero spend was found.

## Metric handling
- CTR = clicks / impressions.
- CPC = spend / clicks.
- CPM = spend / impressions × 1,000.
- CPA = spend / platform-reported conversions.
- ROAS = platform conversion value / spend.
- ROI = (platform conversion value - spend) / spend × 100.
- Cost and return ratios are NULL when spend is zero; they are not reported as zero.
- Campaigns without performance rows are retained using a LEFT JOIN and labelled `No Performance Data`.
- `daily_performance.conversion_value` is not interchangeable with `conversions.revenue`. Event revenue is analyzed separately in the attribution queries.

## Interpretation cautions
- The 84 campaigns without daily performance are not assigned zero performance; they have no matching daily records.
- The dataset's daily conversion totals/value do not reconcile to the conversion-event table totals. These measures remain separate pending business-definition and date-coverage validation.
- ROI here is a platform conversion-value-to-spend calculation, not net profit ROI; it excludes product costs, overhead, and other business expenses.

## Reproducibility
The corresponding DuckDB SQL is maintained at `sql/01_campaign_channel_performance.sql`. The detailed campaign-level and summary CSV exports are committed in this folder: `campaign_performance.csv`, `campaign_summary.csv`, and `campaign_coverage.csv`, alongside the other supporting analysis exports.
