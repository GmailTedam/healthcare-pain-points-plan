# Nexus-A2A — Healthcare Pain-Points Bundle

**Repo:** `~/health-agent-workspace/Nexus-A2A-protocol`
**Mode:** Refactor (Stable → add canonical scenarios + visual tests)
**Death-spiral nodes:** Insurance complexity (PA negotiation), Cross-org orchestration, Care coordination

## 1. Context
Nexus-A2A 1.0.0 is the choreography protocol; it lacks 14-column matrices, requirement traceability, and visualisation tests for the management dashboards.

## 2. REQUIREMENTS

| ID | Type | Statement | Priority |
|---|---|---|---|
| NX-FR-01 | Functional | Shall negotiate prior-authorisation between provider and payer agents within 60 s p95. | HIGH |
| NX-FR-02 | Functional | Shall propagate `X-Trace-Id` end-to-end across all hops. | HIGH |
| NX-FR-03 | Functional | Shall verify peer DID signatures on every message. | HIGH |
| NX-FR-04 | Functional | Shall expose Prometheus metrics for handshake latency, denial rate, retries. | MEDIUM |
| NX-FR-05 | Functional | Shall support choreography patterns: request-response, publish-subscribe, saga. | HIGH |
| NX-NFR-01 | Reliability | Failed handshakes shall retry with exponential backoff up to 3 attempts. | HIGH |
| NX-NFR-02 | Security | JWT scopes (`nexus:invoke`) enforced at every endpoint. | HIGH |
| NX-IR-01 | Interface | Compatible with GHARRA agent cards (read via `gharra_invoke`). | HIGH |

## 3. USE CASES
- **UC-NX-01**: Provider negotiates PA with payer (saga, multi-step approval).
- **UC-NX-02**: Cross-org referral handoff (provider → specialist).
- **UC-NX-03**: Claims submission saga with rollback on denial.
- **UC-NX-04**: Patient agent fetches consolidated record across 3 EHRs.
- **UC-NX-05**: Real-time observability dashboard for choreography health.

## 4. IMPLEMENTATION PLAN
1. Backup `src/`, `tests/`, dashboards → `versions/v2/`.
2. Materialise bundle → `plans/healthcare-pain-points/`.
3. `test-matrix-generator` ×5 → ≥500 scenarios.
4. Add Grafana dashboard JSON to `test-harness/visual/` with Playwright baselines.
5. Add saga rollback test fixtures using real BT EventBus.
6. Run scenarios → 100% pass gate.
7. Update docs.

## 5. SESSION PROMPT
> Continue the workspace healthcare pain-points refactor for **Nexus-A2A-protocol**. Read `~/health-agent-workspace/_workspace_plans/Nexus-A2A-protocol/nexus-a2a-protocol-healthcare-pain-points.md`. Back up to `versions/v2/`. Materialise the bundle into `plans/healthcare-pain-points/`. Run `test-matrix-generator` per UC (UC-NX-01..05) → ≥100 scenarios each. Run `v-model-test`. Scaffold `test-harness/{unit,integration,e2e,visual}/` using real GHARRA + BT — no mocks. Capture Playwright headless + Cypress headed baselines for the Grafana dashboards via `visual_baseline`. Implement saga rollback fixtures. Run scenarios at 100% pass. Validate SRS via REA quality engine. Update README, CLAUDE.md, docs/architecture.md, docs/test-strategy.md, docs/observability.md per DOC_UPDATES. Honour all workspace memory rules.

## 6. DOC_UPDATES
- README.md, CLAUDE.md, docs/architecture.md, docs/observability.md, docs/test-strategy.md, INTEROP.md.

## 7. Traceability header
`RequirementID,UseCaseID,ScenarioID,TestType,VerificationLevel,AutomationStatus,Status`

## 8. V-model outline
Unit (per choreography primitive) → Integration (real GHARRA) → System (multi-agent saga) → Acceptance (scenarios.json).
