# SQL Assets

This folder contains the SQL used to explore the marketing dataset and document its relational structure.

## Files

- `01_campaign_channel_performance.sql` — campaign and channel performance analysis.
- `reconstructed_marketing_campaigns_schema.sql` — reconstructed relational schema based on the inspected source tables.
- `original_dataset_schema.sql` — original schema definition supplied with the dataset archive, retained as a reference.

## Usage

Run the analysis query in a SQL environment after loading the five source tables. The original schema includes Parquet `COPY` statements; update file paths to match your local data location before executing it.

The reconstructed schema is documentation for reproducibility and is not represented as the original vendor DDL.
