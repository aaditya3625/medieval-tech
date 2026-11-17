# Habib technology adoption database

Coded database of technologies and implements in Irfan Habib, *Technology in Medieval India c. 650-1750*,
ch. 3 (military technology, land transport, navigation), pp. 85-112. Pages 108 and 110 are not yet coded.
Habib is the only source. All years are dates of *first notice* in the evidence (see Date caveat). Years I coded myself are flagged in `analyst_notes`.
One row = one technology, implement

## Pipeline
1. Export the Sheets workbook to `data/raw/habib_technology_db.xlsx` (keep the sheet name `Technologies`).
2. `python src/clean.py` -> `data/processed/technologies.csv` (renames columns, recomputes lags, validates labels).
3. `python src/analyze.py` -> tables and charts in `output/`.

`make setup && make all` runs everything.

## Variables (`data/processed/technologies.csv`)

| Variable | Type | Description |
|---|---|---|
| `tech_id` | text | Unique row ID, `C3-01` onward (C3 = chapter 3). |
| `technology_name` | text | The technology, implement or institution. |
| `domain` | text | Area of use: Weapons, Gunpowder, Land transport, Roads and bridges, Communications, Finance (transit), Ship construction, Navigation. |
| `adoption_outcome` | category | What happened in India (see codes below). |
| `year_first_noticed_abroad` | year | Date of first notice outside India, as Habib gives it. Blank if none. |
| `year_first_noticed_india` | year | Date of first notice in India: the earliest Indian evidence Habib cites. Treated as the exact date. Blank if undated. |
| `year_first_noticed_india_late` | year | Latest alternative Indian date where Habib reports a dating dispute. Blank otherwise. |
| `lag_years_min` | years | Diffusion lag: `year_first_noticed_india - year_first_noticed_abroad`. Negative means India came first. |
| `lag_years_max` | years | Same, using `year_first_noticed_india_late` when present, else equals `lag_years_min`. |
| `habib_pages` | text | Page(s) in Habib. |
| `origin_region` | text | Where the technology came from, per Habib. |
| `transmission_channel` | text | How it reached India, per Habib. "Not stated" if he gives none. |
| `evidence_type` | text | Kind of evidence for the Indian case: text, painting, chronicle, traveller account, company records, etc. |
| `habib_explanation` | text | What Habib says, including his reasons for adoption or non-adoption. |
| `date_precision` | category | How firm the Indian date is: Exact, Approx, Coarse, None stated. |
| `analyst_notes` | text | Caveats, my coding choices, and cross-references. |
| `military_scope` | Yes/No | Yes for C3-01 to C3-25 (cavalry equipment, weapons, gunpowder). Ships, navigation, roads and posts are No. |
| `presence_in_india` | category | Derived from `adoption_outcome`: Present, Partial, Substituted, Absent. |
| `function_served` | category | The job a military technology did (five groups). My grouping, not Habib's. Blank outside military scope. |
| `stood_in_for_it` | text | What served in its place, only where Habib's text says so. Blank means not recorded, not "nothing". |

Blank year fields mean Habib gives no usable date, not zero.

## `adoption_outcome` codes
- **Adopted:** taken up in India with little change.
- **Adapted or improved:** taken up and modified or bettered.
- **Indigenous innovation:** developed in India, not copied.
- **Partial or slow:** taken up late, patchily or in part.
- **Retained older tech:** the older technology kept its place.
- **Substituted:** replaced by a different technology, not the foreign one.
- **Not adopted:** the technology did not take hold.
- **Introduced by invaders:** arrived with an invading force.

See `IMPLEMENTS.md` for the list of implements and `USES.md` for what collaborators can do with it.

## Date caveat
Habib mostly dates things from chronicles, traveller accounts and paintings, which rarely give a clean
first-use date. Typical phrases are "in the 13th century", "by the end of the 16th century" or "about
the middle of the 17th". The absence of a technology is dated by whenever a traveller happened to notice
it, such as Polo around 1290 or Barbosa in 1516, so those years are when someone wrote, not when the
technology first existed or arrived. The overseas date is just as rough, for example the horse collar's
"beginning of the tenth century". This database therefore records the **date of first notice** and treats
it as the exact date. A lag is a gap between two first-notice dates, not between true first uses, so
it can overstate or understate real diffusion time.

## Known limits
- Rows with only a 1666 or 1677 date record a request or complaint, not adoption, so no lag is computed.
- The telescope lag overstates adoption: the 1739 date is recognition only.
- Several first-notice years are my coding of phrases like "13th c." (see `analyst_notes`).
- Next: pp. 108, 110, 112+ and other chapters.
