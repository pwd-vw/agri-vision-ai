# Notebooks

One Colab notebook per pipeline stage, matching the book chapters. Each notebook must run
top-to-bottom on a **fresh runtime** with no manual steps outside the notebook itself.

- `01_dataset_download.ipynb` — pull the labeled dataset from Roboflow via API
- `02_train.ipynb` — install pinned `ultralytics`/`torch`, train, log metrics
- `03_export_eval.ipynb` — export to ONNX/NCNN, run eval, save confusion matrix + report to
  `../results/`

First cell of every notebook should print installed versions (`torch.__version__`,
`ultralytics.__version__`, GPU type) and pin installs with `==` — see `../VERSIONS.md`.

Add an "Open in Colab" badge pointing at the GitHub-hosted copy once this repo is public/pushed,
e.g.:

```markdown
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/pwd-vw/agri-vision-ai/blob/main/notebooks/02_train.ipynb)
```

