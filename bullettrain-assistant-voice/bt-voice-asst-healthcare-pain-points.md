# bullettrain assistant + voice — Healthcare Pain-Points Bundle

**Repo:** `~/bt/BulletTrain/bullettrain/{assistant,voice}`
**Mode:** Refactor (Partial → add ambient-scribe healthcare scenarios)
**Death-spiral nodes:** Documentation burden (50% physician burnout)

## 1. Context
The ambient scribe stack is the most direct attack on EHR documentation burden. Existing assistant + voice modules need explicit healthcare encounter scenarios, FHIR-output verification, and visual baselines for the live transcription UI.

## 2. REQUIREMENTS
| ID | Type | Statement | Priority |
|---|---|---|---|
| AV-FR-01 | Functional | Shall capture clinical encounter audio and produce FHIR DocumentReference + Composition. | HIGH |
| AV-FR-02 | Functional | Shall extract structured FHIR Observation, Condition, MedicationStatement from speech. | HIGH |
| AV-FR-03 | Functional | Shall present a clinician review UI before commit to record. | HIGH |
| AV-FR-04 | Functional | Shall integrate with prompt-engine for SOAP note generation. | HIGH |
| AV-NFR-01 | Privacy | Audio shall be encrypted at rest and purged after structured extraction unless retention requested. | HIGH |
| AV-NFR-02 | Latency | Live transcription shall display within 1.5 s of utterance. | HIGH |

## 3. USE CASES
- **UC-AV-01**: Primary care visit captured → SOAP note + FHIR resources.
- **UC-AV-02**: Specialist consult with multi-speaker diarisation.
- **UC-AV-03**: Clinician edits and commits structured output.
- **UC-AV-04**: Audio purged after extraction; manifest signed.
- **UC-AV-05**: Voice command to fetch prior labs during encounter.

## 4. IMPLEMENTATION PLAN
1. Backup assistant/ + voice/. 2. Materialise bundle. 3. test-matrix-generator ×5. 4. Add FHIR extractor with prompt-engine. 5. Live UI Cypress headed + Playwright headless visual baselines. 6. Audio retention policy + signed purge manifest. 7. 100% pass gate. 8. Docs.

## 5. SESSION PROMPT
> Continue workspace healthcare pain-points refactor for **bullettrain assistant + voice**. Read `~/health-agent-workspace/_workspace_plans/bullettrain-assistant-voice/healthcare-pain-points.md`. Back up to `versions/v2/`. Materialise bundle into `bullettrain/assistant/plans/healthcare-pain-points/` AND `bullettrain/voice/plans/healthcare-pain-points/`. Run `test-matrix-generator` per UC (UC-AV-01..05) → ≥100 scenarios each. Run `v-model-test`. Implement FHIR extractor via prompt-engine, retention/purge with signed manifest. Use REAL BT FHIR + EventBus — no mocks. Cypress headed + Playwright headless baselines for live transcription UI. Add icons/imagery to any new pages. Test all links/buttons. Run scenarios at 100% pass. Update READMEs, CLAUDE.md, docs/, INTEROP.md. Honour all workspace memory rules.

## 6. DOC_UPDATES
assistant/README.md, voice/README.md, BulletTrain/CLAUDE.md, docs/ambient-scribe.md, docs/test-strategy.md, INTEROP.md.

## 7. Traceability header
`RequirementID,UseCaseID,ScenarioID,TestType,VerificationLevel,AutomationStatus,Status`

## 8. V-model
Unit (extractor, diarisation) → Integration (real BT FHIR) → System (live UI flow) → Acceptance (scenarios.json).
