# Analysis Notebooks

## Available notebook

- [`01_data_inspection.ipynb`](01_data_inspection.ipynb) — inspects the five source tables, schema, row counts, relationships, data quality, date coverage, and initial diagnostics.

The notebook is the reproducible starting point for understanding the data. Supporting CSV, Parquet, and Markdown outputs are maintained in [`reports/`](../reports/README.md).

## Environment setup

From the repository root:

```bash
python -m venv .venv
```

Activate the environment, then install dependencies:

```bash
pip install -r requirements.txt
jupyter notebook
```

See the root [README](../README.md) for the project overview and dashboard.
