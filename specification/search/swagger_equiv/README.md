# Swagger Equivalency Checker

A Python tool for comparing hand-authored and TypeSpec-compiled Swagger specifications for semantic equivalency. This tool implements strict semantic comparison while ignoring documentation-only fields and ordering differences.

## Overview

This tool compares three hand-authored Swagger files plus common types against a single TypeSpec-compiled Swagger file to determine if they represent the same API contract.

## Features

- **Semantic Comparison**: Focuses on API behavior, ignoring documentation differences
- **Multi-File Merging**: Combines multiple hand-authored Swagger files into a single specification
- **Canonicalization**: Removes documentation fields and normalizes ordering for comparison
- **Detailed Reporting**: Provides specific differences when APIs don't match
- **Clean Output**: Production-ready tool with minimal verbose output

## Setup

**Requirements**:
- Python 3.11 or higher
- PyYAML

### Install Dependencies

```bash
# Install required Python package
pip install PyYAML
# Option 1: If python command points to 3.11+
python -m venv .venv

```

## Usage

### Basic Usage

```bash
# Run the equivalency check
python main.py

# Use custom config file
python main.py --config custom.yaml

# Show detailed differences
python main.py --verbose

# Save canonicalized specs for debugging
python main.py --save-canonical

# Ignore operationId mismatches
python main.py --ignore-operation-id
```

### Configuration

Create a `config.yaml` file specifying the file paths:

```yaml
typespec_compiled:
  path: "../data-plane/Search/preview/2025-11-01-preview/search.json"

hand_authored:
  searchservice:
    path: "../data-plane/Azure.Search/preview/2025-11-01-preview/searchservice.json"
  searchindex:
    path: "../data-plane/Azure.Search/preview/2025-11-01-preview/searchindex.json"
  knowledgebase:
    path: "../data-plane/Azure.Search/preview/2025-11-01-preview/knowledgebase.json"
  common_types:
    path: "../../common-types/data-plane/v1/types.json"

output:
  path: "./.output"
```

### Output

The tool creates:

- `./.output/comparison_result.json` - Detailed comparison results
- `./.output/differences_report.txt` - Human-readable differences (if not equivalent)
- `./.output/hand_authored_canonical.json` - Canonicalized hand-authored spec (if --save-canonical)
- `./.output/typespec_canonical.json` - Canonicalized TypeSpec spec (if --save-canonical)

### Benefits of This Approach

- **Industry Standard**: Uses `openapi-diff` for professional API comparison
- **Spec Compliant**: Maintains OpenAPI spec validity by replacing (not removing) required fields
- **Debugging Friendly**: Intermediate files can be inspected manually
### Exit Codes

- `0`: Specifications are semantically equivalent
- `1`: Specifications are NOT equivalent
- `2`: Configuration or file loading error
- `3`: Processing error

## Implementation Details

This tool follows the semantic equivalency contract defined in `equiv_contract.md`. It:

1. **Merges** three hand-authored Swagger files plus common types into a single specification
2. **Canonicalizes** both specifications by removing documentation fields and normalizing ordering
3. **Compares** the canonical specifications for strict semantic equivalency

### Canonicalization Rules

According to `equiv_contract.md`, these fields are ignored during comparison:

- Documentation fields: `description`, `summary`, `externalDocs`
- Example fields: `example`, `examples`, `x-ms-examples`
- Non-behavioral tags
- Documentation-only vendor extensions: `x-ms-summary`
- Ordering differences in objects and set-like arrays

### Comparison Rules

The comparison checks three dimensions:

1. **Paths + HTTP methods**: Path sets and method sets must match exactly
2. **Operations**: Parameters, request bodies, and responses must match
3. **Schemas/definitions**: All schema definitions must be equivalent
