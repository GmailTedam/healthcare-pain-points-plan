# caid-agent — Healthcare Pain-Points Bundle

**Repo:** `~/health-agent-workspace/caid-agent`
**Mode:** Refactor (Alpha → canonicalise existing 732 tests, add patient-advocacy use cases)
**Death-spiral nodes:** Patient advocacy ($220B medical debt), Workflow intelligence, Documentation burden

## 1. Context
caid-agent already has 732 tests but no canonical 14-column matrices, no requirement traceability, and no patient-side advocacy use cases (appeals, bill disputes, formulary navigation).

## 2. REQUIREMENTS

| ID | Type | Statement | Priority |
|---|---|---|---|
| CA-FR-01 | Functional | Shall draft prior-authorisation appeals from denial letters using prompt-engine templates. | HIGH |
| CA-FR-02 | Functional | Shall dispute medical bills against insurer EOB and provider charge data. | HIGH |
| CA-FR-03 | Functional | Shall navigate formulary changes and propose therapeutic alternatives via FHIR MedicationKnowledge. | HIGH |
| CA-FR-04 | Functional | Shall coordinate with Nexus-A2A peers for cross-org actions (referral, claim status). | HIGH |
| CA-FR-05 | Functional | Shall persist a patient-facing audit log of every action for trust. | HIGH |
| CA-NFR-01 | Privacy | Shall never transmit PHI outside the patient's tenant boundary. | HIGH |
| CA-NFR-02 | Quality | Drafted appeals shall be reviewable by the patient before send (human-in-the-loop). | HIGH |

## 3. USE CASES
- **UC-CA-01**: Patient receives denial → caid-agent drafts appeal → patient reviews and sends.
- **UC-CA-02**: Patient receives surprise bill → caid-agent disputes against EOB.
- **UC-CA-03**: Formulary change → caid-agent proposes alternatives.
- **UC-CA-04**: Clinician asks caid-agent to summarise patient history (chart-prep).
- **UC-CA-05**: Clinician burnout-reducer: caid-agent triages inbox messages.

## 4. IMPLEMENTATION PLAN
1. Backup. 2. Materialise bundle. 3. Map existing 732 tests to new traceability matrix. 4. test-matrix-generator ×5. 5. Implement appeal/dispute templates via prompt-engine integration. 6. Add Nexus-A2A client. 7. HITL review UI with Cypress headed visual baseline. 8. 100% pass gate. 9. Docs.

## 5. SESSION PROMPT
> Continue workspace healthcare pain-points refactor for **caid-agent**. Read `~/health-agent-workspace/_workspace_plans/caid-agent/healthcare-pain-points.md`. Back up to `versions/v2/`. Materialise bundle into `plans/healthcare-pain-points/`. Map existing 732 tests into the new traceability matrix; flag orphans for resolution (no test deletion, only addition per `feedback_scenario_requirements_integrity`). Run `test-matrix-generator` per UC (UC-CA-01..05) → ≥100 scenarios each. Run `v-model-test`. Implement appeal/dispute templates via prompt-engine, Nexus-A2A client integration, HITL review UI with Cypress headed visual baseline (`visual_baseline`). Use real BT FHIR services and Nexus peers — no mocks; seeded DB only. Run all scenarios + existing 732 tests at 100% pass. Update README, CLAUDE.md, docs/. Honour all workspace memory rules.

## 6. DOC_UPDATES
README.md, CLAUDE.md, docs/architecture.md, docs/use-cases.md, docs/test-strategy.md, docs/privacy.md, INTEROP.md.

## 7. Traceability header
`RequirementID,UseCaseID,ScenarioID,TestType,VerificationLevel,AutomationStatus,Status`

## 8. V-model
Unit (template/extractor) → Integration (real FHIR + Nexus + prompt-engine) → System (HITL UI flow) → Acceptance (scenarios.json + 732 legacy).
