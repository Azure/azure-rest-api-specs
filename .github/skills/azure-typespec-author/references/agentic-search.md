# Agentic Search

Enter this procedure after Step 3 has selected the Web family either because the
request is fully covered by the reference catalog or because the required retrieval
MCP tool is not exposed. Do not call `azsdk_typespec_retrieve_knowledge` during the
same execution.

## Input

- **Step 1 result** — project analysis output from [analyze-project.md](analyze-project.md): service type, existing API versions, latest version, intent, target resource/interface, and constraints.
- **User request** — the user's stated goal for this session.

## Procedure

1. **Select URLs** — for a catalog-covered request, use the successful coverage
   decision from [reference-document-links.md](reference-document-links.md). For a
   retrieval-unavailable fallback, locate authoritative TypeSpec or Azure
   documentation that covers the complete request. Select only URLs that directly
   cover the user's request and Step 1 result. Do not fetch every URL as a substitute
   for resolving uncertainty.
2. **Fetch** — `web_fetch` each selected URL. Extract content as markdown.
3. **Search** — find content matching a query derived from the user's request and Step 1 result. Choose the most effective local search tool available.
4. **Iterate within Web** — if initial results are insufficient, refine the query or
   fetch another relevant catalog URL. Do not switch to retrieval MCP.
5. **Return and reuse** — return the extracted guidance and URLs to the caller. Reuse
   this grounding record for local planning, editing, and final citations; do not
   fetch again only to recreate citations.
