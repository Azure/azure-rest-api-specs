# Swagger GA vs Preview Discrepancy Checker

A standalone CLI tool for comparing GA (stable) and Preview swagger files to identify breaking changes and discrepancies in Azure Search Data Plane API specifications.

## Overview

This tool compares GA (stable) swagger files against Preview swagger files to detect:
- **Breaking changes**: Removed or incompatibly changed operations, parameters, or schemas in preview
- **Non-breaking additions**: New operations, parameters, or relaxed constraints in preview
- **Schema differences**: Type, format, required field, and constraint changes

The comparison logic is based on the semantic equivalency checker in `../swagger_equiv/semantic_equiv` but reimplemented as a standalone tool without shared dependencies.

## Prerequisites

```bash
pip install -r requirements.txt
```

## Usage

### Default Comparison (Both File Pairs)

Compares both searchindex.json and searchservice.json and generates a single Excel file with two sheets:

```bash
python compare_ga_preview.py
```

This creates **`ga_preview_discrepancy.xlsx`** with:
- **searchindex** sheet - Discrepancies in searchindex.json
- **searchservice** sheet - Discrepancies in searchservice.json

### Compare Specific File Pair

```bash
# Compare searchindex.json only (still creates Excel with one sheet)
python compare_ga_preview.py --file searchindex

# Compare searchservice.json only (still creates Excel with one sheet)
python compare_ga_preview.py --file searchservice
```

### Custom File Paths

```bash
python compare_ga_preview.py \
  --ga-index /path/to/ga/searchindex.json \
  --preview-index /path/to/preview/searchindex.json \
  --ga-service /path/to/ga/searchservice.json \
  --preview-service /path/to/preview/searchservice.json
```

### Output Options

```bash
# Verbose console output with detailed diffs
python compare_ga_preview.py --verbose

# Custom output directory
python compare_ga_preview.py --output-dir ./my-reports

# Both
python compare_ga_preview.py --verbose --output-dir ./reports
```

## Output Format

### Excel File Structure

The tool generates **`ga_preview_discrepancy.xlsx`** with these columns:

| Column | Description | Example |
|--------|-------------|---------|
| **Category** | Type of difference | operation, parameter, schema, response, other |
| **Identifier** | Detailed location | `/docs [get] param:queryLanguage`<br/>`definition:SearchRequest property:hybridSearch` |
| **GA Value** | Value in GA swagger | `object`, `true`, `(not present)` |
| **Preview Value** | Value in Preview swagger | `None`, `false`, `(not present)` |
| **Difference Summary** | Human-readable description | Schema type changed: object -> None |
| **Severity** | Impact classification | breaking, non-breaking, unknown |
| **Notes** | Empty for reviewer comments | (blank) |

### Identifier Format

Identifiers include detailed path, method, operation ID, and component information:

**Operation-level:**
- `/docs [get]` - Path and HTTP method
- `/indexes/{indexName} [put]` - Path with parameter and method

**Parameter-level:**
- `/docs [get] param:queryLanguage` - Parameter in operation
- `/docs [post] request_body` - Request body

**Response-level:**
- `/docs [get] response:200` - Response for status code

**Schema/Definition-level:**
- `definition:SearchRequest` - Model definition
- `definition:SearchRequest property:hybridSearch` - Property in model
- `definition:VectorQuery items` - Array items schema

### Severity Classification

- **breaking**: Changes that break existing clients
  - Removed operations, parameters, or schemas
  - Required fields added
  - Type changes
  - Stricter constraints

- **non-breaking**: Additions or relaxations
  - New optional parameters
  - New operations or schemas
  - Optional fields removed from required

- **unknown**: Changes requiring manual review
  - Operation ID changes
  - Format changes
  - Content type changes

### Row Ordering

Rows are sorted deterministically for version control:
1. Severity (breaking → non-breaking → unknown)
2. Category (operation → parameter → response → schema → other)
3. Identifier (alphabetical)
4. Type (alphabetical)

## Exit Codes

- `0` - No discrepancies found or only non-breaking changes
- `1` - Breaking changes detected
- `2` - File loading or processing error

## Examples

### Example 1: Check Both Files for Breaking Changes

```bash
python compare_ga_preview.py
```

Console output:
```
Comparing searchindex.json...
Comparing searchservice.json...
[OK] Excel report saved to: output\ga_preview_discrepancy.xlsx

============================================================
=== GA vs Preview Comparison Report ===
============================================================

File: searchindex.json
  Breaking Changes: 1
  Non-Breaking Changes: 33
  Unknown: 1

File: searchservice.json
  Breaking Changes: 3
  Non-Breaking Changes: 95
  Unknown: 0

============================================================
Total: 4 breaking, 128 non-breaking, 1 unknown
============================================================

[WARNING] BREAKING CHANGES DETECTED - Manual review required
```

Excel file contains two sheets with all discrepancies categorized and color-coded.

### Example 2: Verbose Output for Detailed Analysis

```bash
python compare_ga_preview.py --verbose
```

Shows each difference in console plus generates Excel report.

### Example 3: Review Excel Output

Open `output/ga_preview_discrepancy.xlsx` in Excel:

- **Breaking changes** highlighted in light red
- **Non-breaking changes** highlighted in light green
- **Unknown changes** highlighted in light yellow
- **Notes column** available for reviewer comments
- Freeze panes on header row for easy scrolling
- Auto-adjusted column widths

## Comparison Logic

This tool mirrors the semantic_equiv comparison approach:

1. **Canonicalization**: Removes documentation-only fields (description, summary, examples, tags)
2. **Normalization**: Sorts and deduplicates set-like fields (consumes, produces, schemes)
3. **Deep Comparison**:
   - Path and method sets
   - Operation parameters (by location + name)
   - Request/response schemas
   - Type, format, required fields, constraints
4. **Severity Classification**: Automatic breaking/non-breaking detection

## Default File Paths

The tool compares these file pairs by default:

**GA (Stable):**
- `specification/search/data-plane/Search/stable/2025-09-01/searchindex.json`
- `specification/search/data-plane/Search/stable/2025-09-01/searchservice.json`

**Preview:**
- `specification/search/data-plane/Search/preview/2025-11-01-preview_unmigrated/searchindex.json`
- `specification/search/data-plane/Search/preview/2025-11-01-preview_unmigrated/searchservice.json`

## Notes

- This tool is completely self-contained with no dependencies on `../swagger_equiv/semantic_equiv`
- All comparisons use deterministic ordering for stable output across runs
- Reference fields ($ref) are normalized for cross-file comparison
- Excel formatting makes it easy to review and add comments directly in the spreadsheet
