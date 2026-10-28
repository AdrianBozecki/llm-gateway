---
description: Log time spent on the project and show totals
argument-hint: <minutes> [what I did]
allowed-tools: Read, Edit
---

Append one row to the table in `docs/timelog.md`:

- Date: today, `YYYY-MM-DD`.
- Minutes: the first word of `$ARGUMENTS`. If it is not a number (e.g. `1h30`), convert it to
  minutes; if you can't, ask me.
- Milestone: the current milestone from "Current status" in CLAUDE.md (just the code, e.g. `M0`).
- What: the rest of `$ARGUMENTS`. If empty, write a short summary of what we did in this session.

Don't change existing rows. Then reply in 2–3 lines: total time this week (Mon–Sun) against the
5–6 h budget, total for the current milestone, and total overall. Format hours as `Xh YYmin`.
