# Marketing Campaign Performance & ROI Optimization

> A marketing analytics project using Python, SQL, and Power BI to evaluate campaign effectiveness, compare channel performance, and identify opportunities to improve marketing return.

## Project Overview

This project analyzes campaign, channel, daily performance, and conversion data to understand how marketing activity translates into engagement, conversions, and business value. It combines data-quality checks, analytical reports, attribution comparisons, and an interactive Power BI dashboard.

## Business Questions

- Which campaigns generate the highest revenue and return?
- How do marketing channels compare on spend, conversion value, ROAS, and ROI?
- How do first-touch and last-touch attribution views differ?
- Where should campaign budgets be reviewed or optimized?

## Tools & Technologies

- **Python** — data inspection, analysis, and visualizations
- **SQL** — campaign and channel analysis
- **Power BI** — interactive dashboard and executive summary
- **Pandas / NumPy / Matplotlib** — data handling and analysis
- **Git & GitHub** — version control and project documentation

## Power BI Dashboard

The interactive report is available here:

[Open the Power BI dashboard file](powerbi/Marketing_Campaign_Performance_Dashboard.pbix)

The report contains four pages:

1. **Campaign Overview** — headline KPIs, top campaigns by revenue and ROI, and channel distribution.
2. **Channel Analysis** — channel-level revenue, ROAS, ROI, and revenue-versus-spend comparisons.
3. **Attribution Analysis** — first-touch versus last-touch conversions and revenue, including channel-level change.
4. **Executive Summary** — key performance indicators, business insights, and optimization recommendations.

## Key Dashboard Results

| KPI | Result |
|---|---:|
| Total Revenue / Conversion Value | 2.52M |
| Total Spend | 3.24M |
| Overall ROAS | 0.78x |
| Overall ROI | -22.09% |
| Campaigns | 600 |

**Interpretation:** The overall ROAS is below 1.0x, and the reported ROI is negative. This indicates that the measured conversion value is below the recorded advertising spend. Paid campaigns and channels should therefore be reviewed before increasing budgets. Channels with zero recorded spend should not be ranked using ROAS or ROI.

*Metric note: the dashboard's revenue KPI uses the analyzed daily performance conversion-value measure. Conversion-event totals are maintained separately because the dataset's date coverage and aggregation do not reconcile directly; the two measures are not forced to match.*

## Data Quality & Analysis

Initial inspection covered five source tables:

| Table | Rows | Columns |
|---|---:|---:|
| ad_groups | 3,000 | 5 |
| campaigns | 600 | 7 |
| channels | 9 | 4 |
| conversions | 40,000 | 8 |
| daily_performance | 260,000 | 8 |

Documented checks include duplicate and primary-key checks, foreign-key validation, missing-value review, date coverage diagnostics, and performance-total comparisons. For example, `campaigns.ended_on` contains 127 missing values; these are preserved as unknown rather than inferred. Daily performance and conversion-event totals have a documented reconciliation limitation.

## Repository Structure

- `notebooks/` — Python data-inspection notebook
- `reports/` — analysis notes, CSV exports, diagnostics, and supporting data files
- `sql/` — SQL analysis queries and reconstructed schema
- `docs/` — data dictionary and project documentation
- `powerbi/` — Power BI report file
- `visuals/` — space for exported charts and dashboard previews
- `data/` — dataset organization notes and data directories

## Recommendations

- Review campaigns with persistently weak ROAS before allocating additional spend.
- Investigate high-spend channels with negative ROI and identify the drivers of poor return.
- Compare first-touch and last-touch attribution before making channel-level budget decisions.
- Monitor CPA, ROAS, ROI, and conversion quality together rather than relying on clicks or impressions alone.
- Treat zero-spend channels separately when evaluating cost-efficiency metrics.

## Project Status

**Analysis and dashboard completed.** The repository includes the data-inspection notebook, SQL queries, exported analytical reports, attribution comparisons, and the four-page Power BI dashboard. Dashboard screenshots and further documentation can be added as presentation enhancements.

## Author

**Prince Yadav**

[GitHub Repository](https://github.com/yprincedec/marketing-campaign-performance-roi-optimization)
