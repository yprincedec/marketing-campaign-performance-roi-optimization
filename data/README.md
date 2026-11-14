# Data Directory

This folder defines the local data layout used by the project. The five source tables are currently versioned as supporting Parquet exports in `reports/`; the `raw/` and `processed/` folders are reserved for local source and transformed data.

## Source tables

| Table | Rows | Columns | Description |
|---|---:|---:|---|
| `channels` | 9 | 4 | Marketing channel reference data |
| `campaigns` | 600 | 7 | Campaign metadata, dates, objectives, and budgets |
| `ad_groups` | 3,000 | 5 | Campaign-level audience and ad-group details |
| `daily_performance` | 260,000 | 8 | Daily impressions, clicks, spend, conversions, and conversion value |
| `conversions` | 40,000 | 8 | Conversion events and first-/last-touch channel fields |

## Folder conventions

- `raw/` — original source files, kept separate from transformed data.
- `processed/` — cleaned or derived datasets created during analysis.
- `reports/` — committed analytical extracts and supporting Parquet files for this repository.

## Data handling

Do not add new raw datasets until redistribution rights, privacy, and repository size have been checked. Keep credentials, local environment files, and temporary exports out of Git. See [the data dictionary](../docs/data_dictionary.md) for table schemas and [the reports folder](../reports/README.md) for analysis outputs.
