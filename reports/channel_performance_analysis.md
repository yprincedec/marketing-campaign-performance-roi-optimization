# Channel Performance Analysis

## Scope and method
- All 9 channels were returned in the channel-level aggregation.
- Delivery metrics come from `daily_performance`, joined through `ad_groups` and `campaigns`.
- CTR = clicks / impressions × 100.
- CPC = spend / clicks; CPM = spend / impressions × 1,000.
- CPA = spend / platform-reported conversions.
- ROAS = platform conversion value / spend.
- ROI = (platform conversion value - spend) / spend × 100.
- Cost and return ratios are undefined for zero-spend channels and are retained as NULL/NaN, not zero.
- `daily_performance.conversion_value` is not the same measure as `conversions.revenue`; event attribution is analyzed separately.

## Channel results
| Channel | Paid? | Impressions | Clicks | Spend | Conversions | Conversion value | CTR % | CPC | CPM | CPA | ROAS | ROI % |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Display | Yes | 198,969,054 | 662,411 | 941,503.02 | 7,410 | 525,861.67 | 0.33 | 1.42 | 4.73 | 127.06 | 0.56 | -44.15 |
| Video | Yes | 116,001,512 | 496,303 | 714,625.57 | 5,199 | 378,259.08 | 0.43 | 1.44 | 6.16 | 137.45 | 0.53 | -47.07 |
| Email | No | 87,006,582 | 365,664 | 0.00 | 4,077 | 310,216.33 | 0.42 | — | — | — | — | — |
| Affiliate | Yes | 91,617,268 | 369,981 | 534,744.24 | 3,901 | 287,157.98 | 0.40 | 1.45 | 5.84 | 137.08 | 0.54 | -46.30 |
| Paid Social | Yes | 80,766,614 | 351,989 | 510,973.29 | 3,690 | 272,841.73 | 0.44 | 1.45 | 6.33 | 138.48 | 0.53 | -46.60 |
| Organic Search | No | 66,785,962 | 298,933 | 0.00 | 3,171 | 236,099.42 | 0.45 | — | — | — | — | — |
| Direct | No | 64,956,605 | 292,648 | 0.00 | 3,033 | 227,190.75 | 0.45 | — | — | — | — | — |
| Paid Search | Yes | 48,442,994 | 193,190 | 275,961.87 | 2,045 | 152,407.12 | 0.40 | 1.43 | 5.70 | 134.94 | 0.55 | -44.77 |
| Retargeting | Yes | 41,095,071 | 183,827 | 262,791.19 | 1,866 | 134,706.51 | 0.45 | 1.43 | 6.39 | 140.83 | 0.51 | -48.74 |

## Findings
- Display has the largest platform conversion value (941,503.02 spend; 525,861.67 conversion value) and the highest paid-channel ROAS (0.56), but its ROI is still negative (-44.15%).
- Paid Search has the least-negative ROI among paid channels (-44.77%) and the second-highest paid ROAS (0.55).
- Retargeting has the lowest paid-channel ROAS (0.51) and most-negative ROI (-48.74%).
- Email has the highest conversion value among unpaid channels (310,216.33). Organic Search and Direct also show conversion value with no recorded spend.
- All five paid channels have ROAS below 1.00 and negative platform-value ROI in this dataset.

## Interpretation limits and next checks
- A ROAS below 1 means recorded platform conversion value is below recorded spend; it does not by itself establish net business loss or justify stopping a channel.
- The ROI calculation is based on platform conversion value, not gross margin or net profit. Product costs, overhead, customer lifetime value, incrementality, and attribution quality are not included.
- Unpaid channels have no paid-media spend in this dataset; their CPC/CPM/CPA/ROAS/ROI are not comparable to paid-channel metrics and remain NULL.
- Before reallocating budget, compare first-touch and last-touch event attribution, validate the conversion-value/revenue definitions, and examine campaign-level and time-based performance.

## Reproducibility
The channel and campaign SQL queries are maintained in `sql/01_campaign_channel_performance.sql`. The channel CSV export is committed at [`channel_performance.csv`](channel_performance.csv).
