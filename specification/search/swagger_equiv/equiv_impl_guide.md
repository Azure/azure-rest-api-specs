# Implementation Instructions for GitHub Copilot Agent

This project implements a **semantic Swagger equivalency checker** in Python.

The **source of truth for requirements** is the file:

* `equiv_contract.md`

That document defines the **Semantic Equivalency Contract** for comparing:

* Input A: three hand-authored Swagger files

  * `../data-plane/Azure.Search/preview/2025-11-01-preview/searchservice.json`
  * `../data-plane/Azure.Search/preview/2025-11-01-preview/searchindex.json`
  * `../data-plane/Azure.Search/preview/2025-11-01-preview/knowledgebase.json`
  * external dependencies: `../../common-types/data-plane/v1/types.json`

* Input B: one TypeSpec-compiled Swagger file

  * `../data-plane/Search/preview/2025-11-01-preview/search.json`

You must strictly follow that contract. Do not invent your own rules or relax any constraints unless they explicitly appear in `equiv_contract.md`.

## 1. High-level Goals

Implement a Python package and a small CLI that:

1. Loads and merges the three hand-authored Swagger files into a single in-memory spec (Input A merged).
2. Loads the TypeSpec-compiled Swagger file (Input B).
3. Canonicalizes both specs according to the rules in `equiv_contract.md` (allowed differences vs required exact matches).
4. Builds an internal, canonical representation of the APIs (paths, operations, parameters, responses, schemas).
5. Compares the two canonical APIs for **strict semantic equivalency**.
6. Returns:

   * Exit code 0 if they are semantically equivalent.
   * Non-zero exit code and a concise, human-readable list of differences otherwise.

## 2. Files and Structure

Create a Python package with a layout similar to:

* `swagger_equiv/`

  * `__init__.py`
  * `loader.py`         (file loading and JSON parsing)
  * `merge.py`          (merge three hand-authored specs into one)
  * `canonicalize.py`   (canonicalization logic)
  * `models.py`         (canonical data classes / containers)
  * `compare.py`        (comparison logic and diff reporting)
  * `cli.py`            (command-line entry point)

* `tests/`

  * Unit tests for canonicalization and comparison
  * Integration tests for real or synthetic Swagger pairs
* `equiv_contract.md` (already exists, do not modify via code)

Use standard Python packaging patterns, but keep dependencies minimal (standard library plus, optionally, a JSON diff library if it simplifies certain checks).

## 3. Contract Reference

Before implementing any logic, always refer back to:

* Which fields are explicitly allowed to differ or be ignored.
* Which fields must match exactly.
* How schemas, parameters, paths, operations, and definitions should be compared.

Whenever there is ambiguity, prefer the stricter interpretation in `equiv_contract.md`:

* If a field is not explicitly listed under “Allowed Differences”, assume it must match exactly.
* If a type, format, or enum is different, treat that as a mismatch.
* If a path, method, response code, or definition is missing or extra, treat that as a mismatch.

The module-level docstrings and key functions should reference `equiv_contract.md` by name so future maintainers understand the dependency.

## 4. Core Responsibilities by Module

### 4.1 loader.py

Responsibilities:

* Provide functions to load Swagger JSON files from disk into Python dictionaries.
* Validate basic structure (presence of `paths`, `definitions` for OpenAPI 2.0).
* Handle I/O errors and JSON parsing errors with clear exceptions.

The loader must not apply any semantic logic; it only reads raw JSON into memory.

### 4.2 merge.py

Responsibilities:

* Take the three hand-authored Swagger dicts (searchservice, searchindex, knowledgebases).
* Merge them into a single Swagger dict that represents the union of:

  * `paths`
  * `definitions`
  * Relevant top-level fields (such as `host`, `schemes`, `basePath`, if needed).

Rules:

* If the three files share a path or definition name, you should assume this is an error and surface it clearly.
* Otherwise, the merged Swagger should be a straightforward union of paths and definitions.
* Do not perform canonicalization here; merging should preserve raw content.

### 4.3 canonicalize.py

Responsibilities:

* Implement the canonicalization rules described in `equiv_contract.md`:

  * Remove documentation-only fields (description, summary, externalDocs, example(s), x-ms-examples, doc-only x-ms-*).
  * Remove or ignore tags if they are not part of the behavioral contract.
  * Normalize ordering for:

    * Object keys (for deterministic comparisons).
    * Set-like arrays (consumes, produces, schemes, security, and any others defined in the contract).
* Ensure that after canonicalization:

  * Only behaviorally relevant fields remain.
  * All arrays that should be sets are deduplicated and sorted.
  * The structure is stable and deterministic for comparison.

This module should expose a function that takes a raw Swagger dict and returns a “canonical Swagger dict” (still JSON-like, but cleaned and normalized according to the contract).

### 4.4 models.py

Responsibilities:

* Define Python data structures (for example, dataclasses) that capture the canonical form of:

  * Schemas
  * Parameters
  * Responses
  * Operations
  * Paths
  * Definitions
  * The overall API

The purpose of this layer is to:

* Make it easy to compare APIs via structured equality.
* Encapsulate schema comparison rules in a centralized, testable way.

Ensure that these structures:

* Store only the fields required by the semantic contract.
* Use immutable containers where reasonable (e.g., tuples, frozensets) to make equality comparisons straightforward.

### 4.5 compare.py

Responsibilities:

* Convert canonical Swagger dicts into `CanonicalApi` (or equivalent) objects via helper builders.
* Implement comparison functions that:

  * Compare path sets.
  * Compare HTTP methods for each path.
  * Compare operations (operationId, parameters, responses).
  * Compare schemas and definitions recursively.

Output:

* A result object that contains:

  * A boolean flag `equivalent`.
  * A list of structured differences (kind, message, path, method, and optional detail).

Differences should be concise, focusing on:

* Missing or extra paths.
* Missing or extra methods for a given path.
* Missing or extra parameters.
* Parameter mismatches (type, format, constraints, enum, default).
* Missing or extra responses.
* Schema mismatches (definitions or inline).

Avoid noisy output; everything reported must be relevant to the semantic contract.

### 4.6 cli.py

Responsibilities:

* Provide a command-line interface that:

  * Accepts file paths for:

    * Three hand-authored specs.
    * One TypeSpec-compiled spec.
  * Or a configuration file pointing to these paths.
* Steps executed:

  * Load three hand-authored specs via loader.
  * Merge them via merge module.
  * Load the TypeSpec spec.
  * Canonicalize both Swagger specs.
  * Build canonical models.
  * Compare them using compare module.
* Exit behavior:

  * Exit code 0 if `equivalent` is true.
  * Exit code non-zero if `equivalent` is false and print differences.

The CLI should also support a “summary only” mode and a “verbose diff” mode if needed.

## 5. Testing Expectations

Create tests that:

* Verify canonicalization:

  * Documentation-only fields are removed.
  * Set-like arrays are deduplicated and sorted.
  * Tags and examples are ignored as per the contract.
* Verify schema equality logic:

  * Identical schemas are considered equal.
  * Any change in type, format, enum, required fields, or additionalProperties is detected.
* Verify full API equivalency:

  * Specs that are equal after canonicalization result in `equivalent=True`.
  * Specs with missing paths, different parameters, or different schemas result in `equivalent=False`.

Whenever adding or changing behavior in the code, re-check that it is still aligned with `equiv_contract.md`. If behavior appears to conflict, adjust the implementation, not the contract, unless the contract document is explicitly and intentionally updated by a human.
