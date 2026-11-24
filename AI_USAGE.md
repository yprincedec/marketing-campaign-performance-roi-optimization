# Responsible AI-Assisted Development

## Purpose
AI was used as a learning and development assistant during this marketing analytics project. It supported problem decomposition, technical learning, troubleshooting, interpretation of analytical concepts, and documentation. It was not used as a substitute for the project's calculations or as evidence that an AI model was trained.

## Where AI assistance was used

| Stage | AI assistance | Project owner's responsibility |
|---|---|---|
| Problem framing | Helped translate the topic into questions about campaign performance, channel efficiency, spend, conversion value, and attribution. | Chose the scope and business questions. |
| Dataset understanding | Explained relationships among the five source tables and the checks needed before analysis. | Inspected actual files, row counts, keys, date coverage, and quality results. |
| Python and data preparation | Explained Pandas workflows, suggested validation approaches, and helped troubleshoot code. | Executed the notebook and checked cleaning outputs. |
| SQL and DuckDB | Helped explain query structure, joins, aggregations, and campaign/channel metrics. | Ran queries against project data and reviewed exported results. |
| Marketing KPIs | Clarified CTR, CPC, CPM, CPA, ROAS, ROI, conversion, and conversion-value concepts. | Interpreted computed metrics and identified caveats. |
| Attribution | Explained first-touch versus last-touch attribution and comparison approaches. | Reviewed implemented outputs and avoided treating attribution as proof of causality. |
| Power BI and reporting | Helped organize dashboard narratives, KPI explanations, and recommendations. | Checked that dashboard figures and recommendations reflected saved analysis outputs. |
| Troubleshooting and documentation | Explained errors and unfamiliar concepts and helped structure methodology documentation. | Understood the final workflow and checked that documentation matched the work. |

## Representative prompt types
These illustrate the kinds of assistance used; they are not presented as verbatim historical prompts.

- How should I validate relationships and key integrity across campaign datasets?
- Explain ROAS and ROI and how to calculate them from spend and conversion value.
- Help me aggregate performance by campaign and channel using DuckDB.
- What are the limitations of first-touch versus last-touch attribution?
- Help me understand this Python, SQL, or Power BI issue and debug it.

## How suggestions were handled
1. AI-generated code and approaches were treated as drafts to inspect and test.
2. Queries and calculations were executed against project datasets; saved outputs informed the analysis.
3. KPI definitions and aggregation choices were considered alongside data coverage and metric caveats.
4. Recommendations were based on calculated project results, not generic AI assumptions.
5. AI assistance did not replace understanding SQL, explaining metrics, or justifying conclusions.

## Limitations
- AI can produce incorrect code, explanations, or assumptions; results require verification.
- This is a marketing analytics project, not a deployed AI marketing system.
- First-touch and last-touch attribution are analytical views, not proof of causal impact.
- Conversion-value and conversion-event revenue are different measures with different aggregation/date-coverage contexts; they should not be forced to reconcile.
- The project does not currently claim a trained campaign-conversion prediction model or automated budget-allocation model.

## What this demonstrates
The project uses AI as a learning and productivity assistant alongside practical work with Python, SQL, DuckDB, marketing KPIs, attribution analysis, and Power BI. The analyst remains responsible for data quality, metric interpretation, validation, and business recommendations.
