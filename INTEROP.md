# Workspace Interoperability Contract

**Date:** 2026-04-07
**Authority:** Required reading for all Phase B per-repo sessions. Any deviation must be flagged in `cross-repo-audit.md`.

## Pinned versions

| Dimension | Pinned value | Notes |
|---|---|---|
| Python (lower bound) | **3.11** | caid-agent + appointment-system may use 3.12 features but must keep `python_requires>=3.11` |
| Node | **18 LTS** | Frontends (assistant, voice, GHARRA UI, symphonix UIs) |
| FHIR | **R4** (4.0.1) | Profile URLs must resolve under `http://hl7.org/fhir/StructureDefinition/` |
| A2A protocol | **1.0.0** | Defined in `Nexus-A2A-protocol/pyproject.toml`. All consumers pin via `nexus-a2a-protocol==1.0.*` |
| MCP spec | **2024-11-05** or later | All MCP servers (REA, signalbox, mcp_care) |
| Auth | JWT HS256 dev / RS256 prod + DPoP | mTLS required between GHARRA tiers and for high-trust signalbox attestations |
| Event schema | CloudEvents 1.0 over EventBus | Schemas stored in `BulletTrain/event-schemas/` and referenced by URI |

## Identity & trust model

- **Patient identity**: BT `client_registry` MPI is the source of truth; GHARRA stores agent identities, not patient identities.
- **Agent identity**: DID-based via Nexus-A2A; agent cards published to GHARRA.
- **Clinician identity**: Provider Registry (BT) federated to GHARRA via adapter.
- **Attestation chain**: signalbox-mcp signs evidence → published to GHARRA chain → consumed by Nexus-A2A peers via `verify` capability.

## Cross-repo capability matrix

| Capability | Producer | Consumers |
|---|---|---|
| Agent discovery | GHARRA | Nexus-A2A, caid-agent, clinical-pathways, appointment-system, symphonix-health |
| A2A choreography | Nexus-A2A | All agent-layer repos |
| FHIR record store | BT `shared_health_record` | All clinical repos |
| MPI | BT `client_registry` | clinical-pathways, appointment-system, mcp_care |
| Workflow exec | BT `workflow_orchestrator` | clinical-pathways, caid-agent |
| Event bus | BT `EventBus` | All |
| MCP wrapping | REA-Agent-mcp, mcp_care, signalbox-mcp | caid-agent, bullettrain assistant/voice |
| Templated NLG | prompt-engine | caid-agent, bullettrain assistant |
| SRS generation | REA-Agent-mcp | All Phase B sessions |

## Required headers in every cross-repo HTTP/A2A call

- `Authorization: Bearer <JWT>`
- `X-Trace-Id: <ULID>` — propagated end-to-end for traceability matrix linkage
- `X-Tenant-Id: <tenant>` — for symphonix-health multi-tenancy
- `X-FHIR-Profile: 4.0.1`

## Versioning rule

Every modification to a shared schema (FHIR profiles, event schemas, A2A capabilities, MCP tool defs) requires:
1. Backup of prior version to `versions/v{N}/`.
2. Bump of consumer pin in `pyproject.toml`/`package.json`.
3. Entry in this repo's `cross-repo-audit.md` under "Schema changes".
