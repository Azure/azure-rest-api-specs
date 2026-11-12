# Agentic Search

Enter this procedure during Step 2 when intake selects the Web knowledge route. The
catalog may guide URL selection but is not required: if it is unavailable, discover
authoritative TypeSpec or Azure documentation directly. Use the resulting Web
guidance to determine the required intake decisions, then retain it for the local
authoring plan. Do not call a knowledge MCP after selecting this route.

## Input

- **Step 1 result** — project analysis output from [analyze-project.md](analyze-project.md): service type, existing API versions, latest version, intent, target resource/interface, and constraints.
- **User request** — the user's stated goal for this session.

## Procedure

1. **Select URLs** — when available, start with matching URLs from
   [reference-document-links.md](reference-document-links.md). When the catalog is
   unavailable, has no direct match, or does not fully cover the request, locate
   additional
   authoritative TypeSpec or Azure documentation for the complete request. Select
   only directly relevant URLs; do not fetch every URL as a substitute for resolving
   uncertainty.
2. **Fetch** — `web_fetch` each selected URL. Extract content as markdown.
3. **Search** — find content matching a query derived from the user's request and Step 1 result. Choose the most effective local search tool available.
4. **Iterate within Web** — if initial results are insufficient for intake, refine
   the query or fetch another authoritative URL. Do not call a knowledge MCP during
   intake.
5. **Return and reuse** — return the extracted intake and authoring guidance with its
   URLs to the caller. Reuse this grounding record for intake, local planning,
   editing, and final citations; do not fetch again only to recreate citations.
