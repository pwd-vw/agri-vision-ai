"""
Benchmark inference FPS on Raspberry Pi 5 across export formats.

Usage:
    python3 benchmark.py --model best.onnx --frames 100
    python3 benchmark.py --model best_ncnn_model --frames 100

Writes results as a row you can paste into ../results/fps_comparison.md
"""
import argparse
import time

import numpy as np
from ultralytics import YOLO


def parse_args():
    p = argparse.ArgumentParser(description="Benchmark model FPS on this device")
    p.add_argument("--model", required=True, help="Path to exported model")
    p.add_argument("--frames", type=int, default=100, help="Number of inference passes")
    p.add_argument("--imgsz", type=int, default=224, help="Input image size used at export/train")
    return p.parse_args()


def main():
    args = parse_args()
    model = YOLO(args.model)

    # Dummy frame — for a real benchmark, use captured sample images instead.
    dummy = np.random.randint(0, 255, (args.imgsz, args.imgsz, 3), dtype=np.uint8)

    # Warm-up
    for _ in range(5):
        model.predict(dummy, verbose=False)

    t0 = time.time()
    for _ in range(args.frames):
        model.predict(dummy, verbose=False)
    elapsed = time.time() - t0

    fps = args.frames / elapsed
    print(f"model={args.model} frames={args.frames} imgsz={args.imgsz} "
          f"elapsed={elapsed:.2f}s fps={fps:.2f}")


if __name__ == "__main__":
    main()
