# Lean Repo Separation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Split Lean engineering out of the synced knowledge-base repo into a new standalone local-and-GitHub private repository at `D:\Playground\topological-order-lean`, while keeping the knowledge repo as the long-term explanation and roadmap layer.

**Architecture:** Keep two repos with different responsibilities. `14-拓扑序学习库` remains the synced knowledge and planning surface; `topological-order-lean` becomes the single engineering truth for `.lean` sources, dependencies, build state, and article-slice implementation. Do **not** migrate the current broken `.lake` / build state; reinitialize a clean Lean repo pinned to `v4.28.0`/`mathlib v4.28.0` for compatibility with the existing notes and old build traces.

**Tech Stack:** Git, GitHub CLI (`gh`), Lean 4 / Lake, mathlib4, PowerShell on Windows

---

## File Structure

### Knowledge Repo (`D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\14-拓扑序学习库`)

- Modify: [archive/lean-sandbox/README.md](</D:/BaiduSyncdisk/code/OB_NOTE/MY NOTE/14-拓扑序学习库/archive/lean-sandbox/README.md>)
  - Add an archive banner that points future work to the new Lean repo.
- Modify: [docs/lean-formalization-roadmap.md](</D:/BaiduSyncdisk/code/OB_NOTE/MY NOTE/14-拓扑序学习库/docs/lean-formalization-roadmap.md>)
  - Add the new engineering-home link.
- Create: [docs/lean-engineering-home.md](</D:/BaiduSyncdisk/code/OB_NOTE/MY NOTE/14-拓扑序学习库/docs/lean-engineering-home.md>)
  - Record canonical local path, GitHub URL, repo responsibilities, and write-back rules.

### New Lean Repo (`D:\Playground\topological-order-lean`)

- Create: `D:\Playground\topological-order-lean\lakefile.toml`
- Create: `D:\Playground\topological-order-lean\lean-toolchain`
- Create: `D:\Playground\topological-order-lean\TopoOrder.lean`
- Create: `D:\Playground\topological-order-lean\TopoOrder\Basic.lean`
- Create: `D:\Playground\topological-order-lean\README.md`
- Create: `D:\Playground\topological-order-lean\docs\RECOVERY.md`
- Create: `D:\Playground\topological-order-lean\docs\KNOWLEDGE-LINKS.md`
- Create: `D:\Playground\topological-order-lean\docs\STATE.md`

The new repo will be created from a clean `lake +v4.28.0 init TopoOrder math-lax` scaffold. It should not import the current broken `.lake` tree from the synced repo.

---

### Task 1: Create The Clean Lean Repo Skeleton

**Files:**
- Create: `D:\Playground\topological-order-lean\*`
- Test: `D:\Playground\topological-order-lean\lakefile.toml`

- [ ] **Step 1: Create the target directory**

```powershell
if (Test-Path 'D:\Playground\topological-order-lean') {
  throw 'Refusing to overwrite existing D:\Playground\topological-order-lean'
}
New-Item -ItemType Directory -Path 'D:\Playground\topological-order-lean' | Out-Null
Get-ChildItem -LiteralPath 'D:\Playground\topological-order-lean' -Force
```

Expected: empty directory listing.

- [ ] **Step 2: Initialize a clean Lean project pinned to Lean 4.28.0**

```powershell
Push-Location 'D:\Playground\topological-order-lean'
try {
  & $env:USERPROFILE\.elan\bin\lake.exe +v4.28.0 init TopoOrder math-lax
} finally {
  Pop-Location
}
```

Expected created files:

```text
D:\Playground\topological-order-lean\.git
D:\Playground\topological-order-lean\.github
D:\Playground\topological-order-lean\.lake
D:\Playground\topological-order-lean\TopoOrder
D:\Playground\topological-order-lean\lakefile.toml
D:\Playground\topological-order-lean\lean-toolchain
D:\Playground\topological-order-lean\TopoOrder.lean
```

- [ ] **Step 3: Verify the generated version pins**

Run:

```powershell
Get-Content -LiteralPath 'D:\Playground\topological-order-lean\lean-toolchain'
Get-Content -LiteralPath 'D:\Playground\topological-order-lean\lakefile.toml'
```

Expected:

- `lean-toolchain` contains `leanprover/lean4:v4.28.0`
- `lakefile.toml` contains `rev = "v4.28.0"`

- [ ] **Step 4: Hydrate dependencies**

Run:

```powershell
Push-Location 'D:\Playground\topological-order-lean'
try {
  & $env:USERPROFILE\.elan\bin\lake.exe update
  & $env:USERPROFILE\.elan\bin\lake.exe exe cache get
} finally {
  Pop-Location
}
```

Expected:

- `.lake\packages\mathlib` exists
- `lake exe cache get` finishes successfully

- [ ] **Step 5: Run the first clean build**

Run:

```powershell
Push-Location 'D:\Playground\topological-order-lean'
try {
  & $env:USERPROFILE\.elan\bin\lake.exe build
} finally {
  Pop-Location
}
```

Expected: exit code `0`.

- [ ] **Step 6: Commit the clean scaffold locally**

```powershell
git -C 'D:\Playground\topological-order-lean' add .
git -C 'D:\Playground\topological-order-lean' commit -m "chore: initialize clean Lean repo scaffold"
```

---

### Task 2: Replace Stub Files With Real Repo Documentation

**Files:**
- Modify: `D:\Playground\topological-order-lean\README.md`
- Create: `D:\Playground\topological-order-lean\docs\RECOVERY.md`
- Create: `D:\Playground\topological-order-lean\docs\KNOWLEDGE-LINKS.md`
- Create: `D:\Playground\topological-order-lean\docs\STATE.md`
- Test: `D:\Playground\topological-order-lean\README.md`

- [ ] **Step 1: Replace the generated README**

Write this file to `D:\Playground\topological-order-lean\README.md`:

````md
# topological-order-lean

Standalone Lean engineering repository for the topological-order knowledge system.

## Purpose

This repo is the engineering home for:

- `.lean` source files
- `lake` / dependency state
- build and recovery workflows
- canonical model formalization
- article-slice implementation

It is intentionally **not** the main knowledge-base repo.

## Knowledge-Base Home

The long-term learning and writing repo remains:

- Local: `D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\14-拓扑序学习库`
- GitHub: `https://github.com/Taishaojie061/topological-order-kb`

## Current Scope

Current first-wave goals:

1. Restore a clean Lean engineering baseline.
2. Rebuild the `TopoOrder` spine in a non-synced workspace.
3. Start the first canonical model lane with `Z2 / toric code`.

## Core Commands

```powershell
& $env:USERPROFILE\.elan\bin\lake.exe update
& $env:USERPROFILE\.elan\bin\lake.exe exe cache get
& $env:USERPROFILE\.elan\bin\lake.exe build
````
```

- [ ] **Step 2: Create recovery guidance**

Write this file to `D:\Playground\topological-order-lean\docs\RECOVERY.md`:

````md
# Recovery

## Build Refresh

```powershell
& $env:USERPROFILE\.elan\bin\lake.exe update
& $env:USERPROFILE\.elan\bin\lake.exe exe cache get
& $env:USERPROFILE\.elan\bin\lake.exe build
````

## If Package State Looks Corrupted

Do not copy `.lake` from the synced knowledge repo.

Instead:

```powershell
Remove-Item -LiteralPath '.lake' -Recurse -Force
& $env:USERPROFILE\.elan\bin\lake.exe update
& $env:USERPROFILE\.elan\bin\lake.exe exe cache get
& $env:USERPROFILE\.elan\bin\lake.exe build
```
```

- [ ] **Step 3: Create the bridge back to the knowledge repo**

Write this file to `D:\Playground\topological-order-lean\docs\KNOWLEDGE-LINKS.md`:

````md
# Knowledge Links

## Knowledge Repo

- Local: `D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\14-拓扑序学习库`
- GitHub: `https://github.com/Taishaojie061/topological-order-kb`

## Key Design Documents

- `docs/lean-formalization-roadmap.md`
- `docs/lean-translation-contract.md`
- `docs/lean-first-canonical-model-choice.md`
- `docs/lean-first-article-slice-selection.md`
- `docs/lean-z2-first-slice-formalization-sketch.md`
````

- [ ] **Step 4: Seed an engineering state file**

Write this file to `D:\Playground\topological-order-lean\docs\STATE.md`:

````md
# STATE

## Current Phase

Clean repository bootstrap.

## Next Action

Recreate the `TopoOrder` source spine in this non-synced repo, starting from the documented module map and the `Z2` first-slice plan.

## Constraints

- Do not import the broken `.lake` state from the synced repo.
- Treat the knowledge repo as the explanation layer, not the engineering worktree.
````

- [ ] **Step 5: Re-run a clean build after documentation changes**

Run:

```powershell
Push-Location 'D:\Playground\topological-order-lean'
try {
  & $env:USERPROFILE\.elan\bin\lake.exe build
} finally {
  Pop-Location
}
```

Expected: exit code `0`.

- [ ] **Step 6: Commit the repo documentation**

```powershell
git -C 'D:\Playground\topological-order-lean' add README.md docs
git -C 'D:\Playground\topological-order-lean' commit -m "docs: add repo purpose and recovery notes"
```

---

### Task 3: Publish The Lean Repo To GitHub

**Files:**
- Modify: `D:\Playground\topological-order-lean\.git\config`
- Test: GitHub repository `Taishaojie061/topological-order-lean`

- [ ] **Step 1: Verify local git state before publication**

Run:

```powershell
git -C 'D:\Playground\topological-order-lean' status --short
git -C 'D:\Playground\topological-order-lean' log --oneline -2
git -C 'D:\Playground\topological-order-lean' remote -v
```

Expected:

- clean working tree
- 2 local commits
- no remote configured yet

- [ ] **Step 2: Create the private GitHub repo from the local directory**

Run:

```powershell
Push-Location 'D:\Playground\topological-order-lean'
try {
  gh repo create Taishaojie061/topological-order-lean `
    --private `
    --source=. `
    --remote=origin `
    --push `
    --description "Standalone Lean engineering repo for topological-order formalization."
} finally {
  Pop-Location
}
```

Expected:

- remote `origin` configured
- current branch pushed
- private GitHub repo created

- [ ] **Step 3: Verify remote wiring**

Run:

```powershell
git -C 'D:\Playground\topological-order-lean' remote -v
gh repo view Taishaojie061/topological-order-lean --json name,visibility,url
```

Expected:

- `origin` points to `github.com/Taishaojie061/topological-order-lean`
- visibility is `PRIVATE`

---

### Task 4: Freeze The Old Synced Sandbox And Add A Bridge Document

**Files:**
- Modify: [archive/lean-sandbox/README.md](</D:/BaiduSyncdisk/code/OB_NOTE/MY NOTE/14-拓扑序学习库/archive/lean-sandbox/README.md>)
- Modify: [docs/lean-formalization-roadmap.md](</D:/BaiduSyncdisk/code/OB_NOTE/MY NOTE/14-拓扑序学习库/docs/lean-formalization-roadmap.md>)
- Create: [docs/lean-engineering-home.md](</D:/BaiduSyncdisk/code/OB_NOTE/MY NOTE/14-拓扑序学习库/docs/lean-engineering-home.md>)
- Test: knowledge repo docs render cleanly and point to the new repo

- [ ] **Step 1: Create the canonical bridge document in the knowledge repo**

Write this file to [docs/lean-engineering-home.md](</D:/BaiduSyncdisk/code/OB_NOTE/MY NOTE/14-拓扑序学习库/docs/lean-engineering-home.md>):

````md
# Lean Engineering Home

## Canonical Engineering Repo

- Local: `D:\Playground\topological-order-lean`
- GitHub: `https://github.com/Taishaojie061/topological-order-lean`

## Responsibility Split

### `14-拓扑序学习库`

- roadmap
- concept cards
- paper notes
- relation graph
- stage-level Lean write-back

### `topological-order-lean`

- `.lean` sources
- `lake` state
- build / recovery
- canonical model code
- article-slice implementation

## Write-Back Rule

Lean proof-level iteration stays in `topological-order-lean`.
Only stage changes, canonical-model choices, article-slice milestones, and capability-boundary changes write back to the knowledge repo.
````

- [ ] **Step 2: Add an archive banner to the old synced sandbox README**

Insert this block at the top of [archive/lean-sandbox/README.md](</D:/BaiduSyncdisk/code/OB_NOTE/MY NOTE/14-拓扑序学习库/archive/lean-sandbox/README.md>), immediately after the title:

````md
> Archived engineering stub.
>
> Active Lean engineering now lives in:
>
> - Local: `D:\Playground\topological-order-lean`
> - GitHub: `https://github.com/Taishaojie061/topological-order-lean`
>
> This directory remains as archive/recovery context only.
````

- [ ] **Step 3: Add the new engineering-home link to the roadmap**

Append this bullet to the “相关现状见” list in [docs/lean-formalization-roadmap.md](</D:/BaiduSyncdisk/code/OB_NOTE/MY NOTE/14-拓扑序学习库/docs/lean-formalization-roadmap.md>):

````md
- [Lean Engineering Home](lean-engineering-home.md)
````

- [ ] **Step 4: Verify the knowledge-repo doc diff**

Run:

```powershell
git -C 'D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\14-拓扑序学习库' diff -- `
  'archive/lean-sandbox/README.md' `
  'docs/lean-engineering-home.md' `
  'docs/lean-formalization-roadmap.md'
```

Expected: only the archive banner, the new bridge document, and the roadmap link change.

- [ ] **Step 5: Commit the knowledge-repo bridge changes**

```powershell
git -C 'D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\14-拓扑序学习库' add `
  'archive/lean-sandbox/README.md' `
  'docs/lean-engineering-home.md' `
  'docs/lean-formalization-roadmap.md'
git -C 'D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\14-拓扑序学习库' commit -m "docs: split Lean engineering into standalone repo"
```

---

### Task 5: Seed The New Lean Repo With The Minimum Planning Context

**Files:**
- Modify: `D:\Playground\topological-order-lean\docs\KNOWLEDGE-LINKS.md`
- Create: `D:\Playground\topological-order-lean\docs\FIRST-SLICE.md`
- Test: `D:\Playground\topological-order-lean\docs\FIRST-SLICE.md`

- [ ] **Step 1: Create a local first-slice handoff in the Lean repo**

Write this file to `D:\Playground\topological-order-lean\docs\FIRST-SLICE.md`:

````md
# First Slice

## Default Canonical Model

- `Z2`
- `toric code`

## Default First Slice

1. four anyon labels
2. fusion rules
3. `M_{e,m}=-1`

## Upstream Knowledge-Base Docs

- `docs/lean-first-canonical-model-choice.md`
- `docs/lean-first-article-slice-selection.md`
- `docs/lean-z2-first-slice-formalization-sketch.md`
````

- [ ] **Step 2: Expand the new repo's knowledge-links file with the local first-slice doc**

Append this section to `D:\Playground\topological-order-lean\docs\KNOWLEDGE-LINKS.md`:

````md
## Local Engineering Entry

- `docs/FIRST-SLICE.md`
- `docs/STATE.md`
- `docs/RECOVERY.md`
````

- [ ] **Step 3: Commit the minimum planning context in the Lean repo**

```powershell
git -C 'D:\Playground\topological-order-lean' add docs
git -C 'D:\Playground\topological-order-lean' commit -m "docs: seed first-slice engineering context"
git -C 'D:\Playground\topological-order-lean' push
```

---

### Task 6: Final Verification Of The Separation

**Files:**
- Test only

- [ ] **Step 1: Verify the new Lean repo builds cleanly**

Run:

```powershell
Push-Location 'D:\Playground\topological-order-lean'
try {
  & $env:USERPROFILE\.elan\bin\lake.exe build
} finally {
  Pop-Location
}
```

Expected: exit code `0`.

- [ ] **Step 2: Verify the new Lean repo remote exists and is private**

Run:

```powershell
gh repo view Taishaojie061/topological-order-lean --json name,visibility,url
```

Expected:

- `name = topological-order-lean`
- `visibility = PRIVATE`

- [ ] **Step 3: Verify the knowledge repo points to the new engineering home**

Run:

```powershell
Get-Content -LiteralPath 'D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\14-拓扑序学习库\docs\lean-engineering-home.md'
Get-Content -LiteralPath 'D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\14-拓扑序学习库\archive\lean-sandbox\README.md' -TotalCount 20
```

Expected:

- new local path present
- new GitHub URL present
- archive banner present

- [ ] **Step 4: Commit nothing else**

Run:

```powershell
git -C 'D:\Playground\topological-order-lean' status --short
git -C 'D:\BaiduSyncdisk\code\OB_NOTE\MY NOTE\14-拓扑序学习库' status --short
```

Expected:

- only intentional changes are committed
- no accidental `.lake` or cache state got staged into the knowledge repo
