# Agentic Search

Generic procedure for fetching external documentation and searching it locally.

## Input

A set of document URLs to fetch (provided by the caller).

## Procedure

1. **Create temp folder** — create a temporary directory for downloaded content (e.g., `<os-temp>/typespec-references/`).
2. **Fetch documents** — for each URL, download the page content and save it as a `.md` file in the temp folder. Use the URL path to derive the filename (e.g., `02-preview-after-preview.md`).
3. **Search locally** — read the downloaded files and search for the information relevant to the current task. Extract key instructions, code examples, and patterns.
4. **Build plan** — synthesize the extracted content into a concrete implementation plan grounded in the downloaded material.

> Do not proceed without a plan grounded in the downloaded reference material.
