# Data Inspection Findings

**Project:** Marketing Campaign Performance & ROI Optimization  
**Inspection date:** 2026-11-13  
**Status:** Initial inspection complete; metric reconciliation and cleaning are still pending.

## Dataset inventory

| Table | Rows | Columns |
|---|---:|---:|
| ad_groups | 3,000 | 5 |
| campaigns | 600 | 7 |
| channels | 9 | 4 |
| conversions | 40,000 | 8 |
| daily_performance | 260,000 | 8 |

The five related tables contain 303,609 rows in total. This is a combined table-row count, not a count of unique marketing events or fact-level observations.

## Structural quality checks

- No duplicate rows were detected in any of the five tables.
- All five declared primary-key checks passed: no null or duplicate key values.
- All six tested foreign-key relationships had zero unmatched child keys.
- Missing values were found only in `campaigns.ended_on`: 127 nulls across 127 campaigns.
- These missing end dates are preserved as unspecified; they are not automatically interpreted as active campaigns.

## Type and value validation

- Campaign budgets, daily spend, daily conversion value, and conversion revenue were successfully parsed as numeric values with zero invalid parses.
- Campaign start/end dates and daily activity dates had zero invalid date parses.
- No campaign had an end date earlier than its start date.
- Daily performance checks found zero cases of clicks exceeding impressions, negative spend, negative conversion value, clicks with zero impressions, positive spend with zero clicks, or positive conversion value with zero conversions.
- Daily performance date range: 2024-01-09 to 2025-12-31.
- Conversion event timestamp range: 2024-01-01 to 2025-12-31.

## Reconciliation observations

| Metric | Result |
|---|---:|
| Sum of `daily_performance.conversions` | 34,392 |
| Rows in `conversions` | 40,000 |
| Difference (daily total minus event rows) | -5,608 |
| Sum of `daily_performance.conversion_value` | 2,524,740.59 |
| Sum of `conversions.revenue` | 3,275,701.84 |
| Difference (event revenue minus daily value) | 750,961.25 |

There were no duplicate `(ad_group_id, activity_date)` keys in daily performance.

Conversion events were aggregated by ad group and conversion date, then compared with daily performance keys:

- Conversion event groups: 39,605
- Exact ad-group/date matches: 4,613
- Groups inside the corresponding ad group's observed performance date range without an exact daily row: 0
- Groups outside the corresponding ad group's observed performance date range: 34,992
- Ad groups represented in daily performance: 3,000
- Ad groups represented in conversions: 3,000

The 34,992 unmatched groups are outside the observed date range for their respective ad groups. This is a date-coverage/reconciliation limitation, not proof that those conversion records are invalid. The two tables may have different recording coverage or metric definitions. Their totals must not be combined or treated as directly equivalent until the source schema and business definitions are reviewed.

## Decisions and next steps

1. Preserve the 127 missing campaign end dates; do not impute or infer campaign status.
2. Review the supplied SQL schema and clarify the definitions/grain of daily performance conversions, conversion events, conversion value, and revenue.
3. Keep daily performance metrics and conversion-event metrics separate until reconciliation rules are established.
4. Continue with documented cleaning and exploratory analysis only after these definitions are understood.
5. Do not publish a definitive ROI/ROAS result until its numerator, denominator, attribution basis, and date coverage are validated.

## Scope note

These are initial inspection findings. Passing the tested checks does not establish that the dataset is free of all quality issues or that every business metric is semantically comparable.
