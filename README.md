# Agri Vision AI — Habanero Quality Inspection

eBook + working code: capture → annotate (Roboflow) → train (Google Colab) → deploy (Raspberry Pi 5).

Capstone project: an object-detection model that grades Habanero chili peppers by quality
(ripe/graded, unripe, defective) from a live camera feed on a Raspberry Pi 5.

This repo is the "system of record" for the eBook sold on Gumroad and Thai eBook platforms —
every number, screenshot, and code sample in the manuscript comes from actually running this
pipeline, not from a mock-up.

## Repo layout

```
agri-vision-ai/
├── README.md               # this file
├── VERSIONS.md              # locked software/hardware versions the book was tested against
├── docs/
│   ├── labeling-guide.md    # quality-grade definitions for annotation (fill in before shooting)
│   └── capture-protocol.md  # camera, lighting, angle, background standards
├── notebooks/
│   ├── 01_dataset_download.ipynb
│   ├── 02_train.ipynb
│   └── 03_export_eval.ipynb
├── pi/
│   ├── requirements.txt
│   ├── detect_camera.py     # real-time inference on Pi 5
│   ├── benchmark.py         # FPS measurement
│   └── systemd/             # run-as-a-service unit file
├── sample_data/              # a handful of sample images (NOT the full dataset)
├── results/                  # confusion matrices, FPS tables, eval charts used in the book
├── manuscript/                # book chapters in Markdown + build tooling
│   ├── 00_intro.md
│   ├── build.sh              # Pandoc build script → dist/book.{epub,pdf}
│   ├── metadata.yaml
│   ├── epub.css
│   └── assets/                # screenshots used in the book
└── .gitignore
```

## Quick start

1. Read `docs/labeling-guide.md` and `docs/capture-protocol.md` before shooting any images.
2. Run the pilot: 50–100 images through the full pipeline (capture → label → train → Pi) before
   committing to full-scale data collection.
3. Full dataset lives in Roboflow (not in this repo) — see `VERSIONS.md` for the project link.
4. Train in `notebooks/02_train.ipynb` on Google Colab.
5. Deploy with `pi/detect_camera.py` on the Raspberry Pi 5.
6. Build the book with `manuscript/build.sh` (requires Pandoc — see that script's header comment).

## What is NOT committed here

- Full-resolution dataset (lives in Roboflow / Google Drive)
- Trained model weights (`.pt`, `.onnx` — too large for git; link them from `results/`)
- API keys / secrets (use Colab Secrets and a `.env` file on the Pi, never commit either)

## Status

Scaffold created — pipeline and manuscript content not yet written.
