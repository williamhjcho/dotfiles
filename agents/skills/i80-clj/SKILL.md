---
name: i80-clj
description: >-
  Applies 180 Seguros (i80) Clojure service conventions. Use when editing .clj,
  .cljc, or .edn files, working in an i80 Clojure service (tubarao, sagas,
  canguruga, and siblings), or when the user asks to extract logic, add
  Prismatic schemas, show alternatives, reuse an existing handler, fix
  nested lets, or review a Clojure branch.
---

# i80 Clojure

Conventions for 180 Seguros Clojure services. Apply these on the first pass so the work does not have to be redone.

Typical layout: `routes.clj` → `ports/http_in.clj` → `controllers/` → `logic/` / `adapters/` / `db/` / outbound `ports/`. Wire and domain schemas live in `lib/`.

## How to work

- Design choice (new route, extra DB call, extra helper, extra schema field): show 2–3 options, wait unless the instruction is already “implement X”.
- After the human edits the branch, **re-read the current diff** and adjust to their code. Do not replay an older plan.
- Optimize for smallest changes. Do not “improve” neighboring helpers, seeds, ports, or shared fixtures.

## Style

- Public functions: `s/defn` with arg and return schemas. Same for **reused test helpers**.
- Prefer **`medley.core/assoc-some`** over `cond->` / `if` + `assoc` for optional keys.
- **No nested `let`.** Inline small bindings or flatten into one `let`. Do not extract a one-line private fn just to dodge a `let`.
- Inline locals used once. Names must describe the result.
- After edits, run the repo README linter (`clojure-lsp` format + clean-ns + diagnostics).

## HTTP, routes, OPA

- Extend existing handlers instead of duplicating them.
- Public routes return the **API / wire model**, not necessarily the internal nested entity.

## Tests

- Unit tests for new `logic/` and adapters. Integration tests for new routes.
- Shared HTTP/token/sale setup in some repos goes in `test/<service>/integration/helpers/`. Do not copy helpers across test files.
- Helpers must **not silently mock** outbound services. The test that needs a sale mocks it (or calls an explicit helper).
- After a refactor, run unit + integration for the **routes touched**, not only the edited file. After a merge conflict, re-check those tests.
- “Don’t add tests yet” means skip until asked; then include the interesting case, not only the happy path.

```bash
clj -M:test-env:test-run :unit
clj -M:test-env:test-run :integration
clj -M:clojure-lsp format && clj -M:clojure-lsp clean-ns && clj -M:clojure-lsp diagnostics
```

## `/review`

Read the **current branch diff**, check controllers + tests (especially after merges), fix what is actually wrong. Do not restyle the whole PR.
