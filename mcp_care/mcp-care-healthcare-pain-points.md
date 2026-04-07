# mcp_care — Healthcare Pain-Points Bundle

**Repo:** `~/bt/BulletTrain/mcp_care`
**Mode:** Refactor (Partial → add README/CLAUDE.md, scenarios, MCP coverage)
**Death-spiral nodes:** Fragmented EHR (MCP surface over BT), Data quality

## 1. Context
mcp_care exposes BT care services through MCP for downstream agents. Lacks README, CLAUDE.md, canonical scenarios.

## 2. REQUIREMENTS
| ID | Type | Statement | Priority |
|---|---|---|---|
| MC-FR-01 | Functional | Shall expose MCP tools for FHIR Patient, Encounter, Observation read/write. | HIGH |
| MC-FR-02 | Functional | Shall enforce OAuth scope per tool. | HIGH |
| MC-FR-03 | Functional | Shall surface BT data-quality-api signals as MCP resources. | HIGH |
| MC-FR-04 | Functional | Shall be discoverable via GHARRA. | MEDIUM |
| MC-NFR-01 | Privacy | All reads shall enforce tenant boundary. | HIGH |

## 3. USE CASES
- **UC-MC-01**: Downstream agent reads patient FHIR record via MCP.
- **UC-MC-02**: Agent writes encounter; quality signal raised on missing field.
- **UC-MC-03**: GHARRA discovery returns mcp_care card.
- **UC-MC-04**: Scope-violating call rejected.

## 4. IMPLEMENTATION PLAN
1. Backup. 2. Generate README + CLAUDE.md. 3. Materialise bundle. 4. test-matrix-generator ×4. 5. Implement OAuth scope enforcement. 6. GHARRA card publisher. 7. 100% pass. 8. Docs.

## 5. SESSION PROMPT
> Continue workspace healthcare pain-points refactor for **mcp_care**. Read `~/health-agent-workspace/_workspace_plans/mcp_care/mcp-care-healthcare-pain-points.md`. Back up to `versions/v2/`. Generate NEW README.md and NEW CLAUDE.md. Materialise bundle. Run `test-matrix-generator` per UC (UC-MC-01..04) → ≥100 scenarios each. Run `v-model-test`. Implement OAuth scope enforcement, GHARRA card publisher. Use REAL BT FHIR + data-quality-api + GHARRA — no mocks. Run scenarios at 100% pass. Update INTEROP.md. Honour all workspace memory rules.

## 6. DOC_UPDATES
NEW README.md, NEW CLAUDE.md, docs/mcp-tools.md, docs/test-strategy.md, INTEROP.md.

## 7. Traceability header
`RequirementID,UseCaseID,ScenarioID,TestType,VerificationLevel,AutomationStatus,Status`

## 8. V-model
Unit (scope check, tool registry) → Integration (real BT + GHARRA) → System (downstream agent flow) → Acceptance (scenarios.json).
