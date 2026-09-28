#!/usr/bin/env bash
#
# Build the eBook (EPUB + PDF) from the Markdown chapters in this folder.
#
# Requirements:
#   - pandoc          (https://pandoc.org)
#   - xelatex          (for PDF; part of a TeX Live install — texlive-xetex on Debian/Ubuntu)
#   - A Thai font installed and visible to fontconfig. Preferred: "Sarabun" (Google Fonts,
#     https://fonts.google.com/specimen/Sarabun). Fallback used automatically if Sarabun is
#     not found: "Waree" (Debian/Ubuntu: `sudo apt install fonts-thai-tlwg`).
#
# Usage:
#   ./build.sh            # builds both EPUB and PDF
#   ./build.sh epub        # EPUB only
#   ./build.sh pdf          # PDF only
#
# Output goes to ../dist/ (gitignored).

set -euo pipefail
cd "$(dirname "$0")"

OUT_DIR="../dist"
mkdir -p "$OUT_DIR"

# Chapters, in reading order. Add new chapter files here as they're written.
CHAPTERS=(
  "00_intro.md"
  # "01_images.md"
  # "02_roboflow.md"
  # "03_train.md"
  # "04_deploy.md"
)

# --- Sanity checks ---

if ! command -v pandoc >/dev/null 2>&1; then
  echo "ERROR: pandoc not found. Install it: https://pandoc.org/installing.html" >&2
  exit 1
fi

MISSING_CHAPTERS=()
for ch in "${CHAPTERS[@]}"; do
  [ -f "$ch" ] || MISSING_CHAPTERS+=("$ch")
done
if [ ${#MISSING_CHAPTERS[@]} -gt 0 ]; then
  echo "WARNING: skipping missing chapter files: ${MISSING_CHAPTERS[*]}" >&2
fi

EXISTING_CHAPTERS=()
for ch in "${CHAPTERS[@]}"; do
  [ -f "$ch" ] && EXISTING_CHAPTERS+=("$ch")
done
if [ ${#EXISTING_CHAPTERS[@]} -eq 0 ]; then
  echo "ERROR: no chapter files found. Nothing to build." >&2
  exit 1
fi

# --- Pick a Thai font that's actually installed ---

THAI_FONT="Sarabun"
if command -v fc-list >/dev/null 2>&1; then
  # Capture fc-list output first, then grep the variable — piping straight into
  # `grep -q` under `set -o pipefail` can make fc-list receive SIGPIPE and the
  # pipeline report failure even when grep DID find a match.
  INSTALLED_FONTS="$(fc-list 2>/dev/null || true)"
  if ! grep -qi "Sarabun" <<< "$INSTALLED_FONTS"; then
    if grep -qi "Waree" <<< "$INSTALLED_FONTS"; then
      echo "NOTE: 'Sarabun' font not found — falling back to 'Waree'." >&2
      echo "      For a nicer result, install Sarabun: https://fonts.google.com/specimen/Sarabun" >&2
      THAI_FONT="Waree"
    else
      echo "WARNING: neither 'Sarabun' nor 'Waree' found. PDF Thai text may render as boxes." >&2
      echo "         Debian/Ubuntu quick fix: sudo apt install fonts-thai-tlwg" >&2
    fi
  fi
else
  echo "WARNING: fontconfig (fc-list) not found — cannot verify Thai font availability." >&2
fi

TARGET="${1:-all}"

build_epub() {
  echo "Building EPUB..."
  if [ ! -f "assets/cover.png" ]; then
    echo "NOTE: assets/cover.png not found — building without a cover image." >&2
    pandoc metadata.yaml "${EXISTING_CHAPTERS[@]}" \
      --toc \
      --css=epub.css \
      -o "$OUT_DIR/book.epub"
  else
    pandoc metadata.yaml "${EXISTING_CHAPTERS[@]}" \
      --toc \
      --css=epub.css \
      --epub-cover-image=assets/cover.png \
      -o "$OUT_DIR/book.epub"
  fi
  echo "  -> $OUT_DIR/book.epub"
}

build_pdf() {
  if ! command -v xelatex >/dev/null 2>&1; then
    echo "ERROR: xelatex not found — cannot build PDF. Install texlive-xetex." >&2
    return 1
  fi
  echo "Building PDF (font: $THAI_FONT)..."
  pandoc metadata.yaml "${EXISTING_CHAPTERS[@]}" \
    --pdf-engine=xelatex \
    -V mainfont="$THAI_FONT" \
    --toc \
    -o "$OUT_DIR/book.pdf"
  echo "  -> $OUT_DIR/book.pdf"
}

case "$TARGET" in
  epub) build_epub ;;
  pdf) build_pdf ;;
  all) build_epub; build_pdf ;;
  *)
    echo "Usage: $0 [epub|pdf|all]" >&2
    exit 1
    ;;
esac

echo "Done."
