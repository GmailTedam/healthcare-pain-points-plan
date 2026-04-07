# clinical-pathways — Healthcare Pain-Points Bundle

**Repo:** `~/health-agent-workspace/clinical-pathways`
**Mode:** **Greenfield** (Stub → full implementation)
**Death-spiral nodes:** Care coordination, Workflow intelligence

## 1. Context
Currently a stub. Needed to deliver pathway-driven referrals and clinical decision support. Closes the "60% long specialist wait" + "20% repeat tests" gaps.

## 2. REQUIREMENTS
| ID | Type | Statement | Priority |
|---|---|---|---|
| CP-FR-01 | Functional | Shall execute clinical pathways defined in CQL/PlanDefinition (FHIR R4). | HIGH |
| CP-FR-02 | Functional | Shall create FHIR ServiceRequest referrals when a pathway step requires specialist input. | HIGH |
| CP-FR-03 | Functional | Shall integrate with appointment-system to schedule referred encounters. | HIGH |
| CP-FR-04 | Functional | Shall detect duplicate diagnostic orders within last 90 days and warn. | HIGH |
| CP-FR-05 | Functional | Shall support evidence linking (UpToDate / clinical guideline citation). | MEDIUM |
| CP-NFR-01 | Reliability | Pathway execution shall be idempotent and resumable. | HIGH |
| CP-NFR-02 | Audit | Every step shall emit an EventBus event with `X-Trace-Id`. | HIGH |

## 3. USE CASES
- **UC-CP-01**: Diabetes follow-up pathway triggers HbA1c order — duplicate-check passes.
- **UC-CP-02**: Cardiology pathway issues referral + books appointment via appointment-system.
- **UC-CP-03**: Pathway resumes after orchestrator restart.
- **UC-CP-04**: Duplicate-order detection blocks redundant CT scan within 90 days.
- **UC-CP-05**: Clinician overrides pathway recommendation with documented reason.

## 4. IMPLEMENTATION PLAN (greenfield)
1. Backup any existing scaffolding. 2. Materialise bundle. 3. Scaffold FastAPI app + DB schema (PostgreSQL via real SQLAlchemy, seeded). 4. Implement CQL evaluator wrapper. 5. Integrate BT shared_health_record + workflow_orchestrator + EventBus. 6. Integrate appointment-system. 7. test-matrix-generator ×5. 8. v-model-test. 9. Cypress + Playwright visual specs for clinician review UI. 10. 100% pass gate. 11. Generate README/CLAUDE.md from scratch. 12. Docs.

## 5. SESSION PROMPT
> Continue workspace healthcare pain-points GREENFIELD build for **clinical-pathways**. Read `~/health-agent-workspace/_workspace_plans/clinical-pathways/clinical-pathways-healthcare-pain-points.md`. This is a greenfield session — current repo is a stub. Back up the stub to `versions/v0/`. Materialise the bundle into `plans/healthcare-pain-points/`. Scaffold FastAPI + PostgreSQL (seeded, no in-memory dicts). Integrate REAL BT services (shared_health_record, workflow_orchestrator, EventBus), appointment-system, and Nexus-A2A — no mocks. Implement all 5 use cases. Run `test-matrix-generator` per UC → ≥100 scenarios each. Run `v-model-test`. Build clinician review UI; capture Cypress headed + Playwright headless baselines via `visual_baseline`. Run scenarios at 100% pass. Generate README.md and CLAUDE.md from scratch via `claude-md-management:revise-claude-md`. Update INTEROP.md. Honour all workspace memory rules.

## 6. DOC_UPDATES
NEW README.md, NEW CLAUDE.md, NEW docs/architecture.md, docs/use-cases.md, docs/test-strategy.md, INTEROP.md, MASTER_INDEX.md status flip.

## 7. Traceability header
`RequirementID,UseCaseID,ScenarioID,TestType,VerificationLevel,AutomationStatus,Status`

## 8. V-model
Unit (CQL evaluator, dedup) → Integration (real BT + appointment-system) → System (full pathway → referral → booking) → Acceptance (scenarios.json).
