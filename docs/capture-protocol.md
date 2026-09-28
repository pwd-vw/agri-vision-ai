# Capture Protocol

Standardize this before the full shoot. Fill in the blanks and treat this file as the source of
truth for Chapter 1 of the book.

## Camera

- Device: TBD (ideally the same camera/module you'll deploy on the Pi 5, or a phone if not)
- Resolution: TBD
- Fixed focus / auto-focus: TBD (fixed is more consistent for a repeatable rig)

## Rig

- Distance from lens to pepper: TBD (keep constant)
- Angle: TBD (top-down recommended for consistent grading)
- Background: plain, non-reflective, high-contrast to pepper color (e.g. matte gray or black)
- Surface: TBD (tray, conveyor mock-up, etc.)

## Lighting

- Light source: TBD (diffuse, even lighting — avoid single hard light causing glare/shadow)
- Avoid: direct sunlight (inconsistent between shooting sessions), colored ambient light

## Shot plan per pepper

- Number of angles per pepper: TBD (e.g. 2–4 rotations to capture surface defects)
- Multiple peppers per frame vs. one-per-frame: TBD (multiple is more realistic for the
  production use case — a tray of peppers — but harder to label consistently at first)

## Lot tracking (important)

- Tag every image with its harvest lot (e.g. `lot-A`, `lot-B`) at capture time — this is required
  to split train/valid/test by lot later in Roboflow, not by random image.
- Keep a `capture_log.csv` (date, lot, number of images, notes) alongside the shoot — not
  committed to git, but referenced from `VERSIONS.md`.

## File naming

`<lot>_<class-hint-optional>_<sequence>.jpg`, e.g. `lotA_0001.jpg` — actual class label happens
in Roboflow, this is just for traceability back to the shoot.
