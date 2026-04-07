# Cross-Repo Dependency Audit

**Date:** 2026-04-07
**Trigger:** Phase A of healthcare-pain-points workspace plan
**Authority:** `feedback_cross_repo_dependency_alignment`

## Summary

11 repos audited. **0 hard conflicts**, **5 alignment actions** required, all assigned to Phase B sessions.

## Findings

| # | Dimension | Finding | Affected repos | Action | Owner (Phase B session) |
|---|---|---|---|---|---|
| 1 | Python version | clinical-pathways, appointment-system, prompt-engine, signalbox-mcp do not declare `python_requires` | 4 repos | Pin `>=3.11` in pyproject.toml | Each repo's session |
| 2 | A2A pin | Only Nexus-A2A declares 1.0.0; consumers do not pin | GHARRA, caid-agent, clinical-pathways, appointment-system, symphonix-health | Add `nexus-a2a-protocol==1.0.*` dep | Each consumer session |
| 3 | FHIR profile pin | No repo currently declares R4 explicitly in metadata | All clinical repos | Add `X-FHIR-Profile: 4.0.1` enforcement; document in CLAUDE.md | Each repo's session |
| 4 | CLAUDE.md missing | prompt-engine, clinical-pathways, appointment-system, signalbox-mcp, mcp_care lack CLAUDE.md | 5 repos | Generate CLAUDE.md from `claude-md-management:revise-claude-md` skill | Each repo's session |
| 5 | README missing | clinical-pathways, appointment-system, mcp_care lack README.md | 3 repos | Generate from REQUIREMENTS.md + USE_CASES.md | Each repo's session |

## No-conflict confirmations

- **Python**: All declared versions ≥3.10; lower bound 3.11 is universally satisfiable.
- **Node**: Only frontends use Node; all on 18+.
- **MCP spec**: REA, signalbox, mcp_care all use `mcp` Python SDK ≥1.0.
- **Auth**: JWT model is consistent. mTLS only declared for GHARRA tiers — no conflict with non-mTLS consumers since gateway terminates.
- **EventBus schemas**: Single source in `BulletTrain/event-schemas/`; no fork detected.

## Schema changes (none this round)

No producer repo has modified a shared schema in this audit window. Phase B sessions that introduce new event types must add entries here.

## Validation procedure (re-run at end of Phase B)

```bash
# From workspace root:
for repo in global-agent-registry Nexus-A2A-protocol REA-Agent-mcp caid-agent prompt-engine \
            clinical-pathways appointment-system signalbox-mcp ; do
  ( cd $repo && python -c "import sys; assert sys.version_info >= (3,11)" \
    && grep -q 'nexus-a2a-protocol' pyproject.toml || echo "FAIL: $repo missing A2A pin" ) ;
done
```

Re-run produces a green report — append to this file under "Phase B re-audit".
