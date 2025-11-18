# Implementation Instructions for GitHub Copilot Agent

This project implements a **semantic Swagger equivalency checker** in Python.

The **source of truth for requirements** is the file:

- `equiv_contract.md`

That document defines the **Semantic Equivalency Contract** for comparing:

- Input A: three hand-authored Swagger files (plus shared common types)
  - `../data-plane/Azure.Search/preview/2025-11-01-preview/searchservice.json`
  - `../data-plane/Azure.Search/preview/2025-11-01-preview/searchindex.json`
  - `../data-plane/Azure.Search/preview/2025-11-01-preview/knowledgebase.json`
  - `../../common-types/data-plane/v1/types.json` (common types referenced by the hand-authored specs)

- Input B: one TypeSpec-compiled Swagger file
  - `../data-plane/Search/preview/2025-11-01-preview/search.json`

You must strictly follow the rules described in `equiv_contract.md`. Do not invent your own equivalency rules or relax any constraints unless they are explicitly changed in that document.

## 1. High-level Goals

Implement a Python package and a small CLI that:

1. Reads configuration from `config.yaml` (see section 2).
2. Loads and merges the three hand-authored Swagger files (plus common types if needed) into a single in-memory spec (Input A merged).
3. Loads the TypeSpec-compiled Swagger file (Input B).
4. Canonicalizes both specs according to the rules in `equiv_contract.md` (allowed differences vs required exact matches).
5. Builds an internal, canonical representation of the APIs (paths, operations, parameters, responses, schemas).
6. Compares the two canonical APIs for **strict semantic equivalency**.
7. Returns:
   - Exit code 0 if they are semantically equivalent.
   - Non-zero exit code and a concise, human-readable list of differences otherwise.

## 2. Configuration File (`config.yaml`)

The tool should use a YAML configuration file named `config.yaml` at the project root (or a specified path) with the following structure:

- `typespec_compiled.path`
  - Path to the TypeSpec-compiled Swagger file.
  - Example: `../data-plane/Search/preview/2025-11-01-preview/search.json`

- `hand_authored.searchservice.path`
  - Path to the hand-authored `searchservice.json` Swagger.

- `hand_authored.searchindex.path`
  - Path to the hand-authored `searchindex.json` Swagger.

- `hand_authored.knowledgebase.path`
  - Path to the hand-authored `knowledgebase.json` Swagger.

- `hand_authored.common_types.path`
  - Path to the shared common types Swagger file (e.g., `types.json`) used by the hand-authored specs.

- `output.path`
  - Directory where the tool can write diff reports, logs, and any other output artifacts.
  - Example: `./.output`

Implementation expectations:

- The CLI should read paths from this `config.yaml` instead of hardcoding file locations.
- The tool should fail with a clear error message if any configured path does not exist or cannot be read.
- When generating debugging artifacts (such as canonicalized Swagger JSON, diff reports, or logs), place them under `output.path`.

## 3. Contract Reference

All behavior must align with the **semantic equivalency contract** described in `equiv_contract.md`.

Key rules for implementation:

- Fields explicitly listed under “Allowed Differences (Removed During Canonicalization)” in `equiv_contract.md` must be ignored or normalized during canonicalization.
- All other fields that represent the API contract must match exactly after canonicalization.
- If a field is not mentioned as “allowed to differ”, treat it as “must match”.
- Differences in paths, methods, parameters, responses, schemas, or definitions must be detected and reported as **not equivalent**.

Wherever necessary, include comments or docstrings that reference `equiv_contract.md` so that future maintainers know where the rules come from and can update them consistently if the contract changes.

## 4. Files and Structure

Create a Python package with a structure similar to:

- `swagger_equiv/`
  - `__init__.py`
  - `loader.py` (file loading and JSON parsing)
  - `merge.py` (merging three hand-authored specs plus common types)
  - `canonicalize.py` (canonicalization logic driven by `equiv_contract.md`)
  - `models.py` (canonical data classes / containers)
  - `compare.py` (comparison logic and diff reporting)
  - `cli.py` (command-line entry point)
  - `config.py` (optional: parsing and validating `config.yaml`)

- `tests/`
  - Unit tests for canonicalization and comparison
  - Integration tests for real or synthetic Swagger pairs

- `equiv_contract.md`
  - The contract document; never modified automatically by code.

Use standard Python patterns and keep dependencies minimal. The design should make it easy to test each piece in isolation.

## 5. Core Responsibilities by Module

### 5.1 loader.py

Responsibilities:

- Load Swagger JSON files and return Python dictionaries.
- Handle file-not-found and JSON parsing errors with clear exceptions and messages.
- Do not perform any canonicalization or semantic checks here; just raw loading.

Inputs:

- Paths from `config.yaml`:
  - `typespec_compiled.path`
  - `hand_authored.searchservice.path`
  - `hand_authored.searchindex.path`
  - `hand_authored.knowledgebase.path`
  - `hand_authored.common_types.path` (if needed for resolving references)

### 5.2 merge.py

Responsibilities:

- Merge the three hand-authored Swagger dictionaries (and common types) into a single Swagger dictionary representing the original API surface.

Rules (aligned with `equiv_contract.md` and project needs):

- Combine `paths` from `searchservice`, `searchindex`, and `knowledgebase` into a single `paths` object.
- Combine `definitions` from all input files, including `common_types`, into a single `definitions` object.
- If there are conflicting definitions or paths with the same key but different contents, surface this as an explicit error (these are not expected in a clean migration scenario).
- Do not remove any fields here; leave canonicalization to `canonicalize.py`.

Output:

- A single “merged hand-authored Swagger” dictionary representing Input A (pre-canonicalization).

### 5.3 canonicalize.py

Responsibilities:

- Implement the canonicalization rules from `equiv_contract.md`:
  - Remove documentation-only fields (description, summary, externalDocs, example, examples, x-ms-examples, doc-only x-ms-\*).
  - Ignore or strip tags if they are not part of the behavioral contract.
  - Normalize set-like arrays (consumes, produces, schemes, security, etc.) by deduplicating and sorting.
  - Normalize object key ordering and nested structures so that canonicalized outputs are deterministic.

Outputs:

- A “canonical Swagger dict” for the merged hand-authored spec.
- A “canonical Swagger dict” for the TypeSpec-compiled spec.

The resulting canonical dicts should only contain fields that are relevant to the semantic contract.

### 5.4 models.py

Responsibilities:

- Define canonical data structures for:
  - Schemas
  - Parameters
  - Responses
  - Operations
  - Paths
  - Definitions
  - The overall API (CanonicalApi or similar)

Design goals:

- Capture only the fields that matter for the semantic equivalency check as defined in `equiv_contract.md`.
- Use immutable data structures where convenient (for example, dataclasses with tuples / frozensets) so equality comparison is straightforward.
- Encapsulate logic for building these models from the canonical Swagger dicts in helper builder functions; keep comparison logic in `compare.py`.

### 5.5 compare.py

Responsibilities:

- Build canonical API models from the canonical Swagger dicts.
- Implement the comparison logic specified in `equiv_contract.md`:
  - Paths and methods:
    - Path sets match exactly.
    - Method sets per path match exactly.

  - Operations:
    - operationId (unless configuration allows ignoring it).
    - Parameters: matched by (in, name), including type, format, constraints, enums, default.
    - Request body schemas.

  - Responses:
    - Status code sets.
    - Response schemas (including headers).

  - Schemas/definitions:
    - Definition name sets.
    - Recursive schema equality (type, format, properties, required, enum, additionalProperties, arrays, composition, etc.).

Outputs:

- A result structure containing:
  - A boolean `equivalent` flag.
  - A list of differences, each with a kind, message, and optional context (path, method, parameter name, definition name, etc.).

Differences should be focused and readable so that developers can quickly identify what to fix to restore equivalency.

### 5.6 cli.py

Responsibilities:

- Implement a CLI entry point that:
  - Reads `config.yaml` to discover:
    - Path to TypeSpec-compiled Swagger.
    - Paths to hand-authored Swagger files and common types.
    - Output directory path.

  - Calls:
    - loader to load all specs.
    - merge to assemble the hand-authored spec.
    - canonicalize to canonicalize both specs.
    - models + compare to compute equivalency.

  - Writes:
    - A summary (pass/fail) to stdout.
    - Optional detailed diff report to `output.path` if inequivalent.

- Exit with:
  - Code 0 if `equivalent` is true.
  - Non-zero code if `equivalent` is false or a fatal error occurs.

Optional features:

- A `--verbose` flag to print detailed differences.
- A `--save-canonical` flag to write canonicalized Swagger JSON into `output.path` for debugging.

## 6. Testing Expectations

Create tests that exercise the full contract in `equiv_contract.md`:

- Canonicalization tests:
  - Verify that documentation fields are removed.
  - Verify that examples and tags are removed where expected.
  - Verify that set-like arrays are deduplicated and sorted.

- Schema comparison tests:
  - Verify equality of identical schemas with different field orders.
  - Verify that changes in type, format, required fields, enum values, or additionalProperties are detected as mismatches.

- API comparison tests:
  - Specs that only differ in documentation or ordering should be considered equivalent.
  - Specs that differ in paths, methods, parameters, responses, or schemas should be considered not equivalent and should produce understandable difference reports.

Whenever behavior is unclear or ambiguous, re-read `equiv_contract.md` and align with the contract. If the desired behavior appears to diverge from the contract, the contract document should be updated explicitly by a human; the implementation must not silently change semantics on its own.
