# signalbox-mcp — Healthcare Pain-Points Bundle

**Repo:** `~/health-agent-workspace/signalbox-mcp`
**Mode:** Refactor (Beta → add CLAUDE.md, scenarios, visual tests)
**Death-spiral nodes:** Trust & attestation, Fragmented EHR (browser-attested signal extraction)

## 1. Context
signalbox provides browser-attested clinical signals via Playwright MCP. Lacks CLAUDE.md, canonical scenarios, and visual baselines for the UI capture flows.

## 2. REQUIREMENTS
| ID | Type | Statement | Priority |
|---|---|---|---|
| SB-FR-01 | Functional | Shall capture browser-rendered clinical signals from EHR portals via Playwright. | HIGH |
| SB-FR-02 | Functional | Shall sign captured evidence with workspace-issued key, attached to GHARRA chain. | HIGH |
| SB-FR-03 | Functional | Shall extract structured FHIR fragments (Observation, Condition) from captured DOM. | HIGH |
| SB-FR-04 | Functional | Shall expose MCP tools for capture, sign, verify, replay. | HIGH |
| SB-NFR-01 | Privacy | Captured screenshots shall redact PHI before storage. | HIGH |
| SB-NFR-02 | Auditability | Every capture shall produce a signed manifest. | HIGH |

## 3. USE CASES
- **UC-SB-01**: Clinician-initiated capture of lab result page → signed Observation.
- **UC-SB-02**: Auditor verifies capture chain via GHARRA.
- **UC-SB-03**: Replay capture in evidence-review UI.
- **UC-SB-04**: PHI redaction on screenshot before storage.

## 4. IMPLEMENTATION PLAN
1. Backup. 2. Generate CLAUDE.md. 3. Materialise bundle. 4. test-matrix-generator ×4. 5. Add signing + GHARRA chain integration. 6. Add PHI redaction pipeline. 7. Visual baselines for evidence-review UI. 8. 100% pass gate. 9. Docs.

## 5. SESSION PROMPT
> Continue workspace healthcare pain-points refactor for **signalbox-mcp**. Read `~/health-agent-workspace/_workspace_plans/signalbox-mcp/healthcare-pain-points.md`. Back up to `versions/v2/`. Generate CLAUDE.md. Materialise bundle. Run `test-matrix-generator` per UC (UC-SB-01..04) → ≥100 scenarios each. Run `v-model-test`. Implement signing + real GHARRA chain integration (no mocks), PHI redaction pipeline. Use real EHR portal fixtures via Playwright. Capture Cypress headed + Playwright headless visual baselines for evidence-review UI. Run scenarios at 100% pass. Update README, NEW CLAUDE.md, docs/, INTEROP.md. Honour all workspace memory rules.

## 6. DOC_UPDATES
README.md, NEW CLAUDE.md, docs/architecture.md, docs/security.md, docs/test-strategy.md, INTEROP.md.

## 7. Traceability header
`RequirementID,UseCaseID,ScenarioID,TestType,VerificationLevel,AutomationStatus,Status`

## 8. V-model
Unit (signer, redactor) → Integration (real GHARRA chain + Playwright MCP) → System (capture→sign→verify) → Acceptance (scenarios.json).
