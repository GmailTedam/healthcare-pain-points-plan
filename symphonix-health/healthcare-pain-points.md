# symphonix-health — Healthcare Pain-Points Bundle

**Repo:** `~/symphonix-health` (BT symlink — modify in place; no central duplicate write)
**Mode:** Hub-layer additions
**Death-spiral nodes:** Cross-org orchestration, multi-tenant federation

## 1. Context
symphonix-health is the federated hub above BT. Needs explicit hub-layer use cases beyond BT primitives.

## 2. REQUIREMENTS
| ID | Type | Statement | Priority |
|---|---|---|---|
| SY-FR-01 | Functional | Shall route cross-tenant requests through Nexus-A2A while preserving tenant isolation. | HIGH |
| SY-FR-02 | Functional | Shall publish hub-level GHARRA agent cards aggregating tenant capabilities. | HIGH |
| SY-FR-03 | Functional | Shall provide a hub dashboard showing federation health and tenant SLAs. | MEDIUM |
| SY-NFR-01 | Privacy | Cross-tenant requests shall require explicit consent records. | HIGH |
| SY-NFR-02 | Multi-tenancy | Shall enforce `X-Tenant-Id` on every call. | HIGH |

## 3. USE CASES
- **UC-SY-01**: Tenant A requests data from Tenant B with consent token.
- **UC-SY-02**: Hub publishes aggregate capability card to GHARRA.
- **UC-SY-03**: Hub dashboard shows tenant SLA breach.
- **UC-SY-04**: Consent revocation propagates within 5 s.

## 4. IMPLEMENTATION PLAN
1. Backup. 2. Materialise bundle. 3. Implement consent token verification. 4. Aggregate capability publisher. 5. Dashboard with visual baselines. 6. test-matrix-generator ×4. 7. 100% pass. 8. Docs.

## 5. SESSION PROMPT
> Continue workspace healthcare pain-points refactor for **symphonix-health**. NOTE: this path is a symlink to BulletTrain — write only in place, do not duplicate. Read `~/health-agent-workspace/_workspace_plans/symphonix-health/healthcare-pain-points.md`. Back up to `versions/v2/`. Materialise bundle. Run `test-matrix-generator` per UC (UC-SY-01..04) → ≥100 scenarios each. Run `v-model-test`. Implement consent token verification, aggregate publisher, dashboard. Use REAL BT services and Nexus + GHARRA — no mocks. Multi-tenant DB seed. Cypress headed + Playwright headless visual baselines. Run scenarios at 100% pass. Update README, CLAUDE.md, docs/, INTEROP.md. Honour all workspace memory rules.

## 6. DOC_UPDATES
README.md, CLAUDE.md, docs/multi-tenancy.md, docs/architecture.md, docs/test-strategy.md, INTEROP.md.

## 7. Traceability header
`RequirementID,UseCaseID,ScenarioID,TestType,VerificationLevel,AutomationStatus,Status`

## 8. V-model
Unit (consent verifier) → Integration (BT + GHARRA + Nexus) → System (cross-tenant flow) → Acceptance (scenarios.json).
