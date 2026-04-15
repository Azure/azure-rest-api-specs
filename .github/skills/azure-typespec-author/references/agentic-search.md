# Agentic Search

## Input

- **URLs** — document URLs to fetch.
- **Query** — what to search for in the fetched content.

## Procedure

1. **Fetch** — `web_fetch` each URL. Extract content as markdown.
2. **Search** — use any local available search tools to find content matching the query. Choose the most effective tool for each search.
3. **Iterate** — if initial results are insufficient, refine the query or fetch additional pages/URLs until the information satisfies the query.
4. **Return** — provide the extracted guidance to the caller.
