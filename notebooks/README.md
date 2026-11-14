# Analysis Notebooks

## Available notebook

- [`01_data_inspection.ipynb`](01_data_inspection.ipynb) — inspects the five source tables, schema, row counts, primary/foreign keys, missing values, duplicate rows, and initial diagnostics.

The notebook runs in Google Colab or local Jupyter. For local use, place the original project ZIP beside the notebook; in Colab, upload it when prompted. The notebook is the starting point for inspecting the source data. Supporting CSV, Parquet, and Markdown outputs are maintained in [`reports/`](../reports/README.md).

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
