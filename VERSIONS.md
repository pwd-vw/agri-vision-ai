# Locked Versions

Update this file every time you upgrade a tool, and note the date. The book must state exactly
what it was tested against, because Ultralytics/PyTorch/Roboflow all move fast enough to break
copy-pasted commands within months.

## Training (Google Colab)

| Tool | Version | Notes |
|---|---|---|
| Python | TBD | Colab default at time of writing |
| PyTorch | TBD | check `torch.__version__`; PyTorch 2.6+ changed `torch.load` default to `weights_only=True` |
| ultralytics | TBD | `pip show ultralytics` |
| CUDA / GPU | TBD | Colab runtime type used (e.g. T4) |

## Annotation

| Tool | Version / Plan | Notes |
|---|---|---|
| Roboflow | TBD (Free/Starter/etc.) | note project visibility (public/private) and image-count limits |
| Export format | YOLOv8 | |

## Deployment (Raspberry Pi 5)

| Item | Version | Notes |
|---|---|---|
| Raspberry Pi OS | TBD | 64-bit, Bookworm or later recommended |
| Python | TBD | |
| Camera | TBD | model + picamera2 version |
| Model export format | TBD | ONNX / NCNN — record which was benchmarked |
| AI accelerator (optional) | TBD | e.g. Hailo AI HAT, if used |

## Roboflow project reference

- Workspace: TBD
- Project: TBD
- Project URL: TBD

## Last updated

2026-09-28 — scaffold created, versions not yet locked.
