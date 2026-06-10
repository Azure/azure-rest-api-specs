# Agentic Search

Procedure for fetching external documentation and extracting actionable guidance.

## Input

A set of document URLs to fetch (provided by the caller).

## Procedure

1. **Fetch documents** — use `web_fetch` to download each URL. Extract the page content as markdown.
2. **Search content** — read the downloaded content and identify instructions, code examples, and patterns relevant to the current task.
3. **Build authoring plan** — synthesize the extracted content into a concrete authoring plan grounded in the fetched material.

> Do not proceed without an authoring plan grounded in the fetched reference material.
