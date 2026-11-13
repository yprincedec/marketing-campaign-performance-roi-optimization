# First-Touch vs Last-Touch Attribution Analysis

## Objective
Compare how channel-level conversion-event counts and attributed revenue change under first-touch and last-touch attribution.

## Data and method
- Source: `conversions` joined to `channels`.
- Conversion-event counts and revenue use `conversions.revenue`.
- Each conversion event is attributed once to its recorded first-touch channel and once to its recorded last-touch channel.
- This report is based on 40,000 conversion-event records. It is an attribution comparison, not a causal incrementality test.

## Key findings

| Measure | Leading channel | Result |
|---|---|---:|
| First-touch attributed revenue | Paid Social | $377,792.76 |
| First-touch conversion events | Direct | 4,557 |
| Last-touch attributed revenue | Video | $375,925.95 |
| Last-touch conversion events | Display | 4,552 |

## Channel-level results

| Channel | First-touch events | First-touch revenue | Last-touch events | Last-touch revenue |
|---|---:|---:|---:|---:|
| Paid Social | 4,519 | $377,792.76 | 4,410 | $365,272.00 |
| Direct | 4,557 | $374,901.74 | 4,517 | $369,948.20 |
| Video | 4,540 | $370,835.07 | 4,520 | $375,925.95 |
| Affiliate | 4,474 | $365,489.20 | 4,424 | $360,068.08 |
| Email | 4,429 | $364,731.70 | 4,420 | $366,962.88 |
| Display | 4,484 | $363,712.40 | 4,552 | $367,404.52 |
| Organic Search | 4,390 | $355,550.66 | 4,438 | $357,766.22 |
| Retargeting | 4,242 | $351,423.48 | 4,333 | $353,842.44 |
| Paid Search | 4,365 | $351,264.83 | 4,386 | $358,511.55 |

## First-touch to last-touch change

Change is calculated as last-touch minus first-touch attribution.

| Channel | Conversion change | Revenue change |
|---|---:|---:|
| Paid Search | +21 | +$7,246.72 |
| Video | -20 | +$5,090.88 |
| Display | +68 | +$3,692.12 |
| Retargeting | +91 | +$2,418.96 |
| Email | -9 | +$2,231.18 |
| Organic Search | +48 | +$2,215.56 |
| Direct | -40 | -$4,953.54 |
| Affiliate | -50 | -$5,421.12 |
| Paid Social | -109 | -$12,520.76 |

- Paid Search has the largest positive attributed revenue change (+$7,246.72).
- Paid Social has the largest negative attributed revenue change (-$12,520.76).
- Display gains the most conversion-event credit (+68), while Retargeting has +91 events; Retargeting's count gain is actually the largest.
- These changes describe reassignment of credit between two attribution rules, not revenue gained or lost by changing marketing activity.

## Interpretation
- Paid Social receives the highest revenue credit when the first recorded touch gets credit.
- Video receives the highest revenue credit under last-touch attribution.
- Direct leads first-touch event count, while Display leads last-touch event count.
- The differences show that channel rankings depend on the attribution rule. They do not prove that a channel caused the conversion.

## Limitations and recommended next analysis
- First-touch and last-touch are rule-based credit assignments, not incremental lift measurements.
- The conversion table provides event revenue, not profit or customer lifetime value.
- Do not use these rankings alone to reallocate budget. Validate with controlled experiments or incrementality analysis, contribution margin, and a consistent attribution window.
- Daily performance conversion_value and conversion-event revenue are distinct measures and should not be combined or forced to reconcile.

## Reproducibility
- Results: [attribution_comparison.csv](attribution_comparison.csv)
- Attribution change: [attribution_change.csv](attribution_change.csv)
- SQL: [01_campaign_channel_performance.sql](../sql/01_campaign_channel_performance.sql), including the combined first-touch/last-touch comparison query.
