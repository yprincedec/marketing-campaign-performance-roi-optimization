# Marketing Campaign Performance & ROI Optimization

> Uncovering marketing insights, measuring campaign effectiveness, and driving smarter budget decisions with Python, SQL & Power BI.

## Project Overview

This project analyzes marketing campaign performance to understand how advertising activity translates into engagement, conversions, and business value. The goal is to move beyond surface-level click and impression counts and identify which campaigns and channels deliver measurable outcomes.

The analysis is being developed incrementally. Data validation and metric definitions are documented before drawing business conclusions.

## Objectives

- Evaluate campaign performance across channels and campaigns.
- Measure audience engagement and conversion outcomes.
- Compare spend against attributed revenue or conversion value where the dataset supports it.
- Identify inefficient campaigns and opportunities to improve budget allocation.
- Build an interactive Power BI dashboard that communicates actionable findings.

## Planned Metrics

Metrics will be calculated only when the required source fields are available and their definitions have been validated.

| Metric | Planned definition |
|---|---|
| CTR | Clicks / Impressions |
| CPC | Advertising Spend / Clicks |
| CPA | Advertising Spend / Attributed Conversions |
| ROAS | Attributed Revenue / Advertising Spend |
| ROI | (Attributed Return - Investment) / Investment |

**Important:** ROAS and ROI are not interchangeable. Final calculations will state exactly what the dataset treats as revenue, conversion value, and investment.

## Tools & Technologies

- **Python** — data inspection, cleaning, exploratory analysis, and visualizations
- **SQL** — relational data exploration and analytical queries
- **Power BI** — interactive reporting and dashboard development
- **Git & GitHub** — version control and project documentation

## Repository Structure

- `notebooks/` — reproducible Python analysis
- `reports/` — data inspection findings and exported quality/reconciliation reports
- Dataset files — supplied Parquet tables and SQL schema (currently stored at the repository root)
- `powerbi/` — planned Power BI report files
- `visuals/` — planned exported charts and dashboard previews

The supplied dataset is included in this repository for this project. Check the dataset's original terms before redistributing it elsewhere.

## Data Inspection Milestone

Initial inspection covered five tables:

| Table | Rows | Columns |
|---|---:|---:|
| ad_groups | 3,000 | 5 |
| campaigns | 600 | 7 |
| channels | 9 | 4 |
| conversions | 40,000 | 8 |
| daily_performance | 260,000 | 8 |

Key findings:
- No duplicate rows or duplicate/null primary keys were found.
- All six tested foreign-key relationships had zero unmatched rows.
- `campaigns.ended_on` contains 127 missing values; these are preserved as unknown rather than inferred.
- Daily performance and conversion-event totals do not reconcile directly. The date-coverage diagnostics document this limitation; the two measures will not be forced to match.

Detailed evidence and CSV exports are available in `reports/`.

## Workflow

1. Inspect the supplied dataset files and schema. **Completed.**
2. Validate table relationships, data types, missing values, duplicates, and date ranges. **Initial checks completed.**
3. Clean and prepare analysis-ready data.
4. Perform exploratory and campaign-performance analysis.
5. Write SQL queries for key business questions.
6. Build and validate the Power BI dashboard.
7. Summarize findings, limitations, and budget recommendations.

## Project Status

**In progress — initial dataset inspection and report exports completed; cleaning, metric validation, and analysis are next.**

Analysis results, dashboard screenshots, and recommendations will be added only after they have been produced and checked.

## Author

**Prince Yadav**

[GitHub Repository](https://github.com/yprincedec/marketing-campaign-performance-roi-optimization)
