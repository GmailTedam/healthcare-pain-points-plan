# appointment-system — Healthcare Pain-Points Bundle

**Repo:** `~/health-agent-workspace/appointment-system`
**Mode:** **Greenfield** (Stub → full implementation)
**Death-spiral nodes:** Care coordination, Discovery (specialist scarcity, rural access)

## 1. Context
Stub today. Required as the booking layer for clinical-pathways referrals and the rural-access answer behind GHARRA discovery.

## 2. REQUIREMENTS
| ID | Type | Statement | Priority |
|---|---|---|---|
| AP-FR-01 | Functional | Shall expose FHIR Appointment + Slot resources. | HIGH |
| AP-FR-02 | Functional | Shall accept booking requests from clinical-pathways via Nexus-A2A. | HIGH |
| AP-FR-03 | Functional | Shall surface specialist availability via GHARRA-discovered provider agents. | HIGH |
| AP-FR-04 | Functional | Shall support telehealth + in-person + waiting-list modes. | HIGH |
| AP-FR-05 | Functional | Shall send patient confirmation + reminder via BT notification service. | MEDIUM |
| AP-NFR-01 | Privacy | Shall enforce tenant boundary on slot visibility. | HIGH |

## 3. USE CASES
- **UC-AP-01**: Pathway-driven booking from clinical-pathways → confirmed Appointment.
- **UC-AP-02**: Patient self-service search across federated specialists via GHARRA.
- **UC-AP-03**: Waiting-list promotion when earlier slot frees.
- **UC-AP-04**: Telehealth slot booked + Meet link generated.
- **UC-AP-05**: Reminder sent 24 h before appointment.

## 4. IMPLEMENTATION PLAN (greenfield)
1. Backup stub. 2. Materialise bundle. 3. Scaffold FastAPI + Postgres seeded. 4. FHIR R4 Appointment/Slot. 5. Nexus-A2A booking endpoint. 6. GHARRA discovery client. 7. BT notification integration. 8. test-matrix-generator ×5. 9. v-model-test. 10. Cypress visual baselines for booking UI. 11. 100% pass gate. 12. README/CLAUDE.md from scratch.

## 5. SESSION PROMPT
> Continue workspace healthcare pain-points GREENFIELD build for **appointment-system**. Read `~/health-agent-workspace/_workspace_plans/appointment-system/appt-sys-healthcare-pain-points.md`. Stub repo — back up to `versions/v0/`. Materialise bundle. Scaffold FastAPI + PostgreSQL (real seeded DB). Implement FHIR R4 Appointment/Slot, Nexus-A2A booking endpoint, GHARRA discovery client, BT notification integration. Use REAL BT, GHARRA, and Nexus services — no mocks. Run `test-matrix-generator` per UC (UC-AP-01..05) → ≥100 scenarios each. Run `v-model-test`. Build booking UI with Cypress headed + Playwright headless visual baselines. Add icons/imagery on every new page (`feedback_icons_imagery_pages`). Test all links and buttons (`feedback_test_links_and_buttons`). Run scenarios at 100% pass. Generate README/CLAUDE.md. Update INTEROP.md. Honour all workspace memory rules.

## 6. DOC_UPDATES
NEW README.md, NEW CLAUDE.md, NEW docs/, INTEROP.md.

## 7. Traceability header
`RequirementID,UseCaseID,ScenarioID,TestType,VerificationLevel,AutomationStatus,Status`

## 8. V-model
Unit (slot, dedup) → Integration (real GHARRA + Nexus + BT) → System (UI booking) → Acceptance (scenarios.json).
