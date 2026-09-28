"""
Real-time Habanero quality detection on Raspberry Pi 5.

Usage:
    python3 detect_camera.py --model best.onnx --conf 0.5

This is a scaffold: swap in the actual exported model path and tune thresholds
once training is done (see notebooks/03_export_eval.ipynb).
"""
import argparse
import time

import cv2
from ultralytics import YOLO


def parse_args():
    p = argparse.ArgumentParser(description="Real-time pepper quality detection")
    p.add_argument("--model", default="best.onnx", help="Path to exported model (ONNX/NCNN/.pt)")
    p.add_argument("--conf", type=float, default=0.5, help="Confidence threshold")
    p.add_argument("--source", default=0, help="Camera index or video file path")
    p.add_argument("--show", action="store_true", help="Show live preview window")
    return p.parse_args()


def main():
    args = parse_args()
    model = YOLO(args.model)

    cap = cv2.VideoCapture(args.source)
    if not cap.isOpened():
        raise RuntimeError(f"Could not open camera/source: {args.source}")

    frame_count = 0
    t0 = time.time()

    try:
        while True:
            ok, frame = cap.read()
            if not ok:
                break

            results = model.predict(frame, conf=args.conf, verbose=False)
            annotated = results[0].plot()

            # TODO: tally per-class counts here and push to LINE Notify / MQTT / GPIO
            # as described in the "Beyond the Book" appendix.

            if args.show:
                cv2.imshow("Habanero Quality Detection", annotated)
                if cv2.waitKey(1) & 0xFF == ord("q"):
                    break

            frame_count += 1
            if frame_count % 30 == 0:
                fps = frame_count / (time.time() - t0)
                print(f"[{frame_count} frames] running FPS: {fps:.1f}")

    finally:
        cap.release()
        if args.show:
            cv2.destroyAllWindows()


if __name__ == "__main__":
    main()
