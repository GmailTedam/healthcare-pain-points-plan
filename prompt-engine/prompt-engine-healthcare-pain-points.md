# prompt-engine — Healthcare Pain-Points Bundle

**Repo:** `~/health-agent-workspace/prompt-engine`
**Mode:** Refactor (Beta → add docs, CLAUDE.md, scenarios)
**Death-spiral nodes:** Documentation burden, Patient advocacy

## 1. Context
Templated NLG library used by caid-agent and assistant. Lacks docs, CLAUDE.md, and canonical scenarios.

## 2. REQUIREMENTS
| ID | Type | Statement | Priority |
|---|---|---|---|
| PE-FR-01 | Functional | Shall render appeal/dispute/summary templates with FHIR-resource input. | HIGH |
| PE-FR-02 | Functional | Shall validate template output against a JSON schema. | HIGH |
| PE-FR-03 | Functional | Shall version templates and support A/B variants. | MEDIUM |
| PE-NFR-01 | Quality | Templates shall include readability score and reading-grade target. | MEDIUM |
| PE-NFR-02 | Privacy | Shall redact PHI from template debug logs. | HIGH |

## 3. USE CASES
- **UC-PE-01**: Render appeal letter from FHIR Coverage + denial reason.
- **UC-PE-02**: Render bill dispute from FHIR Account + ChargeItem.
- **UC-PE-03**: Render visit summary at reading grade 6.
- **UC-PE-04**: A/B test two appeal variants with metrics callback.

## 4. IMPLEMENTATION PLAN
1. Backup. 2. Add CLAUDE.md (claude-md-management skill). 3. Materialise bundle. 4. test-matrix-generator ×4. 5. Add JSON-schema validators. 6. Add readability scorer. 7. PHI redaction tests. 8. 100% pass. 9. Docs.

## 5. SESSION PROMPT
> Continue workspace healthcare pain-points refactor for **prompt-engine**. Read `~/health-agent-workspace/_workspace_plans/prompt-engine/prompt-engine-healthcare-pain-points.md`. Back up to `versions/v2/`. Generate CLAUDE.md via `claude-md-management:revise-claude-md`. Materialise bundle into `plans/healthcare-pain-points/`. Run `test-matrix-generator` per UC (UC-PE-01..04) → ≥100 scenarios each. Run `v-model-test`. Use real FHIR fixture data from BT — no in-memory dicts. Implement readability scorer + PHI redaction. Run scenarios at 100% pass. Update README, new CLAUDE.md, docs/, INTEROP.md. Honour all workspace memory rules.

## 6. DOC_UPDATES
README.md, NEW CLAUDE.md, docs/templates.md, docs/test-strategy.md, INTEROP.md.

## 7. Traceability header
`RequirementID,UseCaseID,ScenarioID,TestType,VerificationLevel,AutomationStatus,Status`

## 8. V-model
Unit (each template) → Integration (real FHIR fixture) → System (caid-agent integration) → Acceptance (scenarios.json).
