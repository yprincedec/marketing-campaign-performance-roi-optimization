# Data Directory

The supplied dataset archive contains five Parquet tables and one SQL schema file.

## Local setup

1. Keep the original ZIP outside version control.
2. Extract the archive locally or in Google Colab.
3. Place the extracted Parquet files in `data/raw/` for local analysis.
4. Do not commit raw data until its redistribution terms and repository size impact have been checked.

Expected files:
- `channels.parquet`
- `campaigns.parquet`
- `ad_groups.parquet`
- `daily_performance.parquet`
- `conversions.parquet`

The SQL schema is documented in [the data dictionary](../docs/data_dictionary.md). Actual row counts and data-quality findings will be added after inspection.
