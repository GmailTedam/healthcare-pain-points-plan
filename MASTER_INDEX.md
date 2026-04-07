# Master Index — Healthcare Pain Points Workspace Plan

**Phase A status:** Complete
**Phase B status:** Pending — user starts one Claude Code session per repo

## Top-level docs

| Doc | Purpose |
|---|---|
| [workspace-capability-mapping.md](./workspace-capability-mapping.md) | Death-spiral → repo mapping (supersedes BT-only mapping) |
| [INTEROP.md](./INTEROP.md) | Pinned versions, identity model, capability matrix |
| [cross-repo-audit.md](./cross-repo-audit.md) | Dependency-alignment audit |
| MASTER_INDEX.md | This file |

## Per-repo bundles

Each bundle is a single self-contained markdown file containing: REQUIREMENTS (REA-style SRS), USE_CASES, IMPLEMENTATION_PLAN, SESSION_PROMPT, DOC_UPDATES, traceability-matrix header, and V-model outline. The Phase B session expands these into the full file structure inside each repo's `plans/healthcare-pain-points/` directory.

| # | Repo | Bundle | State | Phase B mode |
|---|---|---|---|---|
| 1 | global-agent-registry (GHARRA) | [bundle](./global-agent-registry/healthcare-pain-points.md) | Alpha | Refactor |
| 2 | Nexus-A2A-protocol | [bundle](./Nexus-A2A-protocol/healthcare-pain-points.md) | Stable | Refactor (add matrices, visual tests) |
| 3 | REA-Agent-mcp | [bundle](./REA-Agent-mcp/healthcare-pain-points.md) | Stable | Self-host SRS for healthcare features |
| 4 | caid-agent | [bundle](./caid-agent/healthcare-pain-points.md) | Alpha | Refactor (canonicalise existing 732 tests) |
| 5 | prompt-engine | [bundle](./prompt-engine/healthcare-pain-points.md) | Beta | Refactor + add docs |
| 6 | clinical-pathways | [bundle](./clinical-pathways/healthcare-pain-points.md) | **Stub** | **Greenfield** |
| 7 | appointment-system | [bundle](./appointment-system/healthcare-pain-points.md) | **Stub** | **Greenfield** |
| 8 | signalbox-mcp | [bundle](./signalbox-mcp/healthcare-pain-points.md) | Beta | Refactor + add CLAUDE.md, scenarios |
| 9 | symphonix-health | [bundle](./symphonix-health/healthcare-pain-points.md) | Partial | Hub-layer additions |
| 10 | bullettrain assistant + voice | [bundle](./bullettrain-assistant-voice/healthcare-pain-points.md) | Partial | Add ambient-scribe scenarios |
| 11 | mcp_care | [bundle](./mcp_care/healthcare-pain-points.md) | Partial | Refactor + docs |

## How to run Phase B

For each repo above:

1. Open a fresh Claude Code session in that repo's directory.
2. Paste the **SESSION_PROMPT** section from the bundle.
3. The session will:
   - Back up current files to `versions/v{N}/`
   - Read REQUIREMENTS + USE_CASES from this bundle
   - Invoke `test-matrix-generator` per use case → `scenarios.json` (≥100/UC, 85/10/5)
   - Invoke `v-model-test` → `v-model.md`
   - Scaffold `test-harness/{unit,integration,e2e,visual}/`
   - Implement code per IMPLEMENTATION_PLAN
   - Run scenarios → must hit 100% pass against real services
   - Update docs per DOC_UPDATES
   - Commit with traceability links
4. After all 11 sessions complete, re-run the validation block in `cross-repo-audit.md`.

## Acceptance gates (every Phase B session)

1. ✅ scenarios.json executes 100% pass
2. ✅ Traceability matrix has zero orphans
3. ✅ Visualisation baselines captured (Cypress headed + Playwright headless)
4. ✅ All required docs updated per DOC_UPDATES.md
5. ✅ versions/ backup confirmed
6. ✅ REA-Agent-mcp quality engine passes on the SRS
7. ✅ Cross-repo audit re-run is green for this repo
