# REA-Agent-mcp — Healthcare Pain-Points Bundle

**Repo:** `~/health-agent-workspace/REA-Agent-mcp`
**Mode:** Self-host (use REA on itself for healthcare-domain SRS coverage) + legacy bridge expansion
**Death-spiral nodes:** Fragmented EHR / fax medicine, Documentation burden

## 1. Context
REA generates ISO 29148 SRS for others — but lacks its own healthcare-domain SRS, and its legacy-bridge MCP tools need scenario coverage and visual evidence.

## 2. REQUIREMENTS

| ID | Type | Statement | Priority |
|---|---|---|---|
| RE-FR-01 | Functional | Shall produce ISO/IEC/IEEE 29148-conformant SRS from natural-language requirements. | HIGH |
| RE-FR-02 | Functional | Shall detect 12 documented requirement smells. | HIGH |
| RE-FR-03 | Functional | Shall expose MCP tools `rea_generate_srs`, `rea_validate`, `rea_smell_check`. | HIGH |
| RE-FR-04 | Functional | Shall bridge legacy HL7v2 messages into FHIR R4 resources. | HIGH |
| RE-FR-05 | Functional | Shall produce INVEST + QUS user stories from epics. | MEDIUM |
| RE-NFR-01 | Quality | Generated SRS shall pass own quality engine on first try ≥95% of the time. | HIGH |

## 3. USE CASES
- **UC-RE-01**: Healthcare PM generates SRS for new feature.
- **UC-RE-02**: Legacy HL7v2 ADT message bridged to FHIR Patient.
- **UC-RE-03**: Quality engine validates third-party SRS.
- **UC-RE-04**: BDD Gherkin generation from user stories.
- **UC-RE-05**: Smell detection on existing requirements doc.

## 4. IMPLEMENTATION PLAN
1. Backup. 2. Materialise bundle. 3. Run REA on itself to produce its own healthcare SRS. 4. Generate ≥500 scenarios via test-matrix-generator. 5. Add HL7v2→FHIR conformance fixtures. 6. Visual harness for any web UI. 7. 100% pass gate. 8. Update docs.

## 5. SESSION PROMPT
> Continue workspace healthcare pain-points refactor for **REA-Agent-mcp**. Read `~/health-agent-workspace/_workspace_plans/REA-Agent-mcp/healthcare-pain-points.md`. Back up to `versions/v2/`. Materialise bundle into `plans/healthcare-pain-points/`. Self-host REA: invoke `rea_generate_srs` on the requirements in this bundle to produce a clean SRS, then `rea_validate` it. Run `test-matrix-generator` per UC (UC-RE-01..05) → ≥100 scenarios each. Run `v-model-test`. Scaffold `test-harness/`. Use real BT FHIR services for HL7v2 bridge tests — no mocks. Run scenarios at 100% pass. Update README, CLAUDE.md, docs/. Honour all workspace memory rules.

## 6. DOC_UPDATES
README.md, CLAUDE.md, docs/srs-format.md, docs/legacy-bridge.md, docs/test-strategy.md, INTEROP.md.

## 7. Traceability header
`RequirementID,UseCaseID,ScenarioID,TestType,VerificationLevel,AutomationStatus,Status`

## 8. V-model
Unit (per smell rule) → Integration (real FHIR server) → System (full SRS gen flow) → Acceptance (scenarios.json + REA self-validation).
