# GHARRA — Healthcare Pain-Points Bundle

**Repo:** `~/health-agent-workspace/global-agent-registry`
**Mode:** Refactor (Alpha → canonicalised)
**Death-spiral nodes addressed:** Insurance complexity, Discovery, Cross-org orchestration

## 1. Context

GHARRA is the federated agent registry that turns the "907 insurers" integration problem into a discovery problem. To deliver on this promise, it needs canonical 14-column scenarios, requirements traceability, V-model coverage, and visualisation baselines.

## 2. REQUIREMENTS (REA-style SRS, ISO/IEC/IEEE 29148)

| ID | Type | Statement | Priority | Verification |
|---|---|---|---|---|
| GR-FR-01 | Functional | The system **shall** publish payer agent cards conforming to A2A 1.0.0 schema. | HIGH | Test (TC-GR-PUB-*) |
| GR-FR-02 | Functional | The system **shall** support 3-tier federation (root/sovereign/organisational) with chain-of-trust verification. | HIGH | Test + Inspection |
| GR-FR-03 | Functional | The system **shall** allow agents to advertise prior-authorisation, eligibility, formulary, and claims capabilities. | HIGH | Test (TC-GR-CAP-*) |
| GR-FR-04 | Functional | The system **shall** return discovery results within 500 ms p95 for queries scoped to a single sovereign tier. | HIGH | Performance test |
| GR-FR-05 | Functional | The system **shall** verify hash-chain integrity of every published agent card before exposing it via the discovery API. | HIGH | Test (TC-GR-CHAIN-*) |
| GR-NFR-01 | Security | All inter-tier traffic **shall** require mTLS in production. | HIGH | Inspection |
| GR-NFR-02 | Security | Agent identities **shall** use DID Key or DID Web. | HIGH | Inspection |
| GR-NFR-03 | Reliability | Federation queries **shall** degrade gracefully on tier outage (return partial + mark stale). | HIGH | Chaos test |
| GR-NFR-04 | Auditability | Every discovery query **shall** be logged with `X-Trace-Id` and retained 90 days. | MEDIUM | Inspection |
| GR-IR-01 | Interface | The system **shall** expose MCP tools `gharra_invoke`, `gharra_list_chains`, `gharra_verify_card`. | HIGH | Test |

## 3. USE CASES

**UC-GR-01: Provider discovers payer prior-auth agent.**
Actor: Clinical agent (caid-agent / Nexus-A2A consumer). Trigger: Need to submit PA. Flow: Query GHARRA → returns ranked payer agents with `prior_auth` capability → consumer initiates A2A handshake.

**UC-GR-02: Sovereign tier publishes new payer.**
Actor: Sovereign tier admin agent. Flow: Validate card → hash-chain append → propagate to root → root verifies and indexes.

**UC-GR-03: Patient agent finds specialist agent across regions.**
Actor: Patient-side caid-agent. Flow: Query GHARRA root with `specialty=cardiology` → returns federated specialist agents → patient initiates appointment-system booking.

**UC-GR-04: Verifier audits chain integrity.**
Actor: External auditor. Flow: Call `gharra_verify_card` → walk hash chain → return PASS/FAIL with broken-link diagnostics.

**UC-GR-05: Tier degradation during regional outage.**
Actor: Any consumer. Flow: Query during outage → root returns cached entries marked `stale=true` + remaining-tier results.

## 4. IMPLEMENTATION PLAN

1. Backup `src/gharra/`, `tests/`, `README.md`, `CLAUDE.md` → `versions/v2/`.
2. Create `plans/healthcare-pain-points/` with full bundle (REQUIREMENTS.md, USE_CASES.md, scenarios.json, traceability-matrix.csv, v-model.md, test-harness/, IMPLEMENTATION_PLAN.md, SESSION_PROMPT.md, DOC_UPDATES.md).
3. Invoke `test-matrix-generator` once per UC → 5 × ≥100 = ≥500 scenarios in `scenarios.json`.
4. Add `nexus-a2a-protocol==1.0.*` and FHIR R4 profile pin to `pyproject.toml`.
5. Implement any missing capability advertisement endpoints for UC-GR-01/03 (`POST /agents/{id}/capabilities`).
6. Add chaos-test fixture for UC-GR-05 using existing pytest-playwright setup.
7. Implement Cypress (headed) + Playwright (headless) visual specs for the Next.js admin UI; capture baselines via `visual_baseline`.
8. Run scenarios; gate at 100% pass.
9. Update README, CLAUDE.md, docs/architecture.md, docs/test-strategy.md per DOC_UPDATES.

## 5. SESSION PROMPT (paste into fresh Claude Code session opened in this repo)

> You are continuing the workspace-wide healthcare pain-points refactor for **global-agent-registry (GHARRA)**. Read `~/health-agent-workspace/_workspace_plans/global-agent-registry/healthcare-pain-points.md` end-to-end before any action. Follow phases strictly:
>
> 1. Back up everything you will modify to `versions/v2/`.
> 2. Materialise the bundle into `plans/healthcare-pain-points/` as separate files (REQUIREMENTS.md, USE_CASES.md, IMPLEMENTATION_PLAN.md, DOC_UPDATES.md, traceability-matrix.csv with header).
> 3. Invoke the `test-matrix-generator` skill once per use case (UC-GR-01..05) to produce `scenarios.json` with ≥100 scenarios per UC, 85/10/5 distribution, 14-column canonical format.
> 4. Invoke the `v-model-test` skill to produce `v-model.md` mapping every requirement to unit/integration/system/acceptance levels.
> 5. Scaffold `test-harness/{unit,integration,e2e,visual}/`. Use real Nexus-A2A and BT services — no mocks (`feedback_real_services_over_simulations`). Use seeded DB, no in-memory dicts (`feedback_no_dict_test_data`).
> 6. Implement capability advertisement endpoints, chaos-test for tier degradation, and the Next.js visual specs (Cypress headed + Playwright headless; capture baselines via `visual_baseline`).
> 7. Run `scenarios.json` against the harness — gate at **100% pass**. Do NOT skip failing tests (`feedback_no_skip_tests`).
> 8. Validate the SRS using REA-Agent-mcp's quality engine. Re-write until clean.
> 9. Update README.md, CLAUDE.md, docs/architecture.md, docs/test-strategy.md per DOC_UPDATES.md.
> 10. Run cross-repo audit validation block from `~/health-agent-workspace/_workspace_plans/cross-repo-audit.md` for this repo. Report green.
> 11. Commit with messages linking each change to its traceability row.
>
> **Honour the workspace memory rules**: real services > sims, JSON not CSV, no orphan requirements, version before overwrite, test links/buttons + icons/imagery on any new UI page, never name countries with problems.

## 6. DOC_UPDATES

- `README.md` — add capabilities, federation diagram, link to bundle.
- `CLAUDE.md` — refresh with new commands, test-matrix locations, V-model location.
- `docs/architecture.md` — diagram of 3-tier federation + chain-of-trust.
- `docs/test-strategy.md` — V-model, scenario counts, real-service stance.
- `docs/api.md` — capability advertisement endpoints.
- `INTEROP.md` (workspace) — add GHARRA producer/consumer rows if missing.

## 7. Traceability matrix header (CSV)

```
RequirementID,UseCaseID,ScenarioID,TestType,VerificationLevel,AutomationStatus,Status
```

Phase B fills body; zero orphans required.

## 8. V-model outline

| Level | Artefacts | Bound to |
|---|---|---|
| Unit | pytest tests in `test-harness/unit/` | Each function in `src/gharra/` |
| Integration | pytest with real Nexus-A2A + BT in `test-harness/integration/` | UC-GR-01, 02, 03 |
| System | Cypress headed + Playwright headless in `test-harness/e2e/` | All UCs end-to-end |
| Acceptance | scenarios.json execution | All requirements via traceability matrix |
