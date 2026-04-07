# Workspace Capability Mapping — Healthcare Pain Points → Repos

**Companion to:** `Healthcare Industry Complaints & Pain Points Research` (BT-focused doc)
**Date:** 2026-04-07
**Status:** Authoritative — supersedes the BT-only "BulletTrain Service Architecture Mapping" section

## Why this exists

The original research mapped every pain point onto BulletTrain services. BT is the standards-compliant substrate (FHIR, events, identity, workflows) but it cannot, alone, attack every node in the administrative-cost-access death spiral. The workspace contains 10 sibling repos whose agent-layer capabilities close the gaps. This doc is the canonical mapping.

## Death-spiral nodes → repo coverage

| Death-spiral node | Pain points | Substrate (BT) | Agent layer | Status |
|---|---|---|---|---|
| **Insurance complexity** (907 payers, prior auth) | $477B admin waste, 34 hr/wk physician PA burden | `finance_insurance_service` | **GHARRA** (payer agent discovery), **Nexus-A2A** (PA negotiation), **caid-agent** (appeals) | Partial — GHARRA Alpha, Nexus stable, caid Alpha |
| **Care coordination failures** | 60% long specialist waits, 20% repeat tests | `shared_health_record` (FHIR R4) | **clinical-pathways** (referral pathways), **appointment-system** (booking), **Nexus-A2A** (cross-org choreography) | **Stub** — clinical-pathways + appointment-system need greenfield impl |
| **Documentation burden** | 50% physician burnout, EHR click fatigue | `workflow_orchestrator` | **bullettrain/assistant** (ambient scribe), **bullettrain/voice** (voice→FHIR), **prompt-engine** (templated extraction) | Partial — assistant/voice exist; prompt-engine Beta |
| **Fragmented EHR / fax medicine** | Information blocking, no national patient ID | `client_registry` (MPI) | **REA-Agent-mcp** (MCP wrapper for legacy), **signalbox-mcp** (signal extraction), **mcp_care** (MCP care surface) | Partial — REA stable, signalbox Beta, mcp_care partial |
| **Patient advocacy** ($220B medical debt, denials) | 66% bill worry, 36% care deferral | — | **caid-agent** (patient-side appeals/disputes), **prompt-engine** (template letters) | Alpha |
| **Trust & attestation** | Information blocking, claim provenance | `gdhcn` | **signalbox-mcp** (signed signals), **Nexus-A2A** (DID + JWT) | Beta |
| **Cross-org orchestration** | EHR vendor lock-in, no interop | `EventBus` | **Nexus-A2A** (1.0.0), **symphonix-health** (federated hub) | Stable + Partial |
| **Discovery (specialist scarcity, rural)** | 135+ rural closures, weeks-to-months wait | — | **GHARRA** (federated agent registry, 3-tier), **appointment-system** | Alpha + Stub |
| **Data quality at scale** | Reporting gaps, no MPI matching | `data-quality-api` | **mcp_care** (quality signals as MCP), **signalbox-mcp** | Partial |
| **Workflow intelligence** | Rigid orchestration | `workflow_orchestrator` | **caid-agent** (agentic dev/verify), **bullettrain agents** | Alpha |

## Repo-by-repo role summary

| Repo | Role in the death-spiral fight | Current state | Bundle path |
|---|---|---|---|
| **global-agent-registry (GHARRA)** | Turn the "907 insurers" problem into a discovery problem; 3-tier federation | Alpha — no canonical scenarios, no V-model | [bundle](./global-agent-registry/global-agent-registry-healthcare-pain-points.md) |
| **Nexus-A2A-protocol** | Cross-org agent choreography (PA negotiation, referrals, claims) | Stable — no 14-col matrices, no visual tests | [bundle](./Nexus-A2A-protocol/nexus-a2a-protocol-healthcare-pain-points.md) |
| **REA-Agent-mcp** | ISO 29148 SRS generator + legacy/fax→FHIR bridge | Stable — needs own healthcare SRS coverage | [bundle](./REA-Agent-mcp/rea-agent-mcp-healthcare-pain-points.md) |
| **caid-agent** | Patient/clinician-side advocacy + dev SDLC for new agents | Alpha — 732 tests, no canonical traceability | [bundle](./caid-agent/caid-agent-healthcare-pain-points.md) |
| **prompt-engine** | Templated extraction/generation (appeals, summaries) | Beta — no docs, no scenarios | [bundle](./prompt-engine/prompt-engine-healthcare-pain-points.md) |
| **clinical-pathways** | Pathway-driven referrals + decision support | **Stub — greenfield** | [bundle](./clinical-pathways/clinical-pathways-healthcare-pain-points.md) |
| **appointment-system** | Specialist discovery + booking | **Stub — greenfield** | [bundle](./appointment-system/appt-sys-healthcare-pain-points.md) |
| **signalbox-mcp** | Signed clinical signals + browser-attested evidence | Beta — no CLAUDE.md, no scenarios | [bundle](./signalbox-mcp/signalbox-mcp-healthcare-pain-points.md) |
| **symphonix-health** | Federated hub layer above BT | Partial (BT symlink) | [bundle](./symphonix-health/healthcare-pain-points.md) |
| **bullettrain assistant + voice** | Ambient scribe → FHIR | Partial | [bundle](./bullettrain-assistant-voice/bt-voice-asst-healthcare-pain-points.md) |
| **mcp_care** | MCP surface over BT care services | Partial — no README/CLAUDE.md | [bundle](./mcp_care/mcp-care-healthcare-pain-points.md) |

## Re-framed thesis

> BulletTrain provides the **standards-compliant substrate** (FHIR R4, EventBus, identity, workflows). The 10 sibling repos provide the **agent layer** that turns substrate into outcomes — converting integration problems into discovery problems, fax workflows into A2A negotiations, and clinician documentation into ambient capture. Together they target every node of the administrative-cost-access death spiral.

## How this doc relates to the original research

The original `Healthcare Industry Complaints & Pain Points Research` document remains the authoritative pain-point evidence base. Its **"BulletTrain Service Architecture Mapping"** section is **superseded** by the table above. A versioned backup of the original is stored at `versions/v1/Healthcare-Pain-Points-Research-v1.md` before any in-place edit.

## Marketing language note

Per `feedback_no_country_shaming`, all marketing-derived copy uses "your system" rather than naming countries alongside problems.
