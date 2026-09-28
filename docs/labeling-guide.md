# Labeling Guide — Habanero Quality Grades

Fill this in **before** shooting any images — it defines what you photograph and how you label it.
Everything downstream (dataset, training, book chapters) depends on this being settled first.

## Classes (draft — replace with your real criteria)

| Class | Definition | Example criteria |
|---|---|---|
| `graded` | Ripe, sellable | Even orange/red color, smooth skin, no visible defects |
| `unripe` | Not yet ready | Predominantly green |
| `defective` | Reject | Black spots, mold, bruising, shriveling — pick one sub-cause list below if you want finer grades |

## Optional: defect sub-classes

If you want the model to distinguish *why* something was rejected (useful for the book's later
chapters), list them here, e.g.:

- `defect_blackspot`
- `defect_mold`
- `defect_bruise`
- `defect_shrivel`

Decide whether to use these from the start — merging classes later means re-labeling.

## Annotation rules

- One bounding box per whole pepper, tight to the visible fruit (not the stem-only region).
- Partially occluded peppers: label if >50% visible, otherwise skip.
- Peppers touching the frame edge: label if the visible portion is enough to judge grade.
- When in doubt between two grades, use a third label like `review` and resolve it as a batch
  before finalizing the dataset version — don't guess pepper-by-pepper.

## Consistency check

Before finalizing a dataset version: re-label ~20 random images blind (without seeing your first
pass) and compare. Large disagreement = the guide above needs tightening, not the labeler.
