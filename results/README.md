# Results

Committed artifacts used directly in the book — keep these small (PNG/CSV/MD), never raw
datasets or model weights.

Expected files once the pipeline has run:

- `confusion_matrix.png` — from `notebooks/03_export_eval.ipynb`
- `training_curves.png` — loss/mAP over epochs
- `fps_comparison.md` — table of FPS by export format (ONNX/NCNN/etc.) on the Pi 5, from
  `pi/benchmark.py`
- `dataset_versions.md` — table of Roboflow dataset versions, what changed, and resulting mAP
  (this becomes the backbone of Chapter 2–3 content)
