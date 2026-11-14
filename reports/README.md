# Analysis Reports & Data Exports

This folder contains the project outputs generated during data inspection and marketing performance analysis. The files listed here are the canonical analytical exports used by the project; avoid uploading duplicate copies under alternate names or folders.

## Markdown analysis

- `data_inspection_findings.md` — initial data profile and quality observations.
- `campaign_performance_analysis.md` — campaign-level performance findings.
- `channel_performance_analysis.md` — channel comparison and cost-efficiency findings.
- `attribution_analysis.md` — first-touch and last-touch attribution interpretation.

## CSV exports

| File | Purpose |
|---|---|
| `table_summary.csv` | Source table inventory |
| `data_quality_summary.csv` | Data-quality summary |
| `primary_key_checks.csv` | Primary-key validation results |
| `foreign_key_checks.csv` | Relationship validation results |
| `campaign_coverage.csv` | Campaign coverage summary |
| `campaign_summary.csv` | Campaign-level summary |
| `campaign_performance.csv` | Campaign performance metrics |
| `channel_performance.csv` | Channel performance metrics |
| `attribution_comparison.csv` | First-touch vs last-touch comparison |
| `attribution_change.csv` | Attribution change by channel |
| `conversion_date_diagnostics.csv` | Conversion date-coverage diagnostics |
| `conversion_diagnostic_summary.csv` | Conversion diagnostic summary |
| `performance_totals.csv` | Performance totals used in reconciliation |

The supplementary Colab dashboard-assets ZIP contains six CSV exports with these same names: `attribution_change.csv`, `campaign_performance.csv`, `campaign_summary.csv`, `attribution_comparison.csv`, `channel_performance.csv`, and `campaign_coverage.csv`. These are already represented by the canonical files in this folder; do not create a second copy of them.

## Parquet extracts

The five Parquet files provide the source tables used by the analysis: `channels`, `campaigns`, `ad_groups`, `daily_performance`, and `conversions`.

## Dashboard chart bundle

The Colab-generated `marketing_dashboard_assets.zip` also contains seven supplementary PNG charts:

- Top 10 Campaigns by Revenue
- Channel Revenue
- Bottom 10 Campaigns by ROI
- Campaign Spend vs Revenue
- Channel ROI
- Top 10 Campaigns by ROI
- Channel ROAS

These are additional analytical charts, not replacements for the four Power BI page previews in `../visuals/`. The ZIP is a local download artifact; the PNGs are not currently committed as individual repository files.

## Important interpretation note

The daily-performance `conversion_value` and conversion-event `revenue` totals are separate measures and do not reconcile directly. Review the attribution and date-coverage documentation before comparing them. See [the data dictionary](../docs/data_dictionary.md) for metric definitions and caveats.
