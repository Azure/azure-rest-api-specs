# Swagger GA vs Preview Diff Report Generator

A standalone CLI tool for comparing GA (stable) and Preview swagger files for Azure Search Data Plane API specifications.

## Overview

**`generate_ga_preview_diff.py`** - Unified GA vs Preview diff report

- Generates a single Excel workbook with two sheets: **Routes Diff** and **Models Diff**
- Preview (2025-11-01-preview) is the source of truth
- Compares against GA (2025-09-01)
- Provides structured, color-coded format for 2026-04-01 GA decision-making
- Supports searchservice, searchindex, and knowledgebase specs

## Prerequisites

```bash
pip install -r requirements.txt
```

## Tool 1: Unified GA vs Preview Diff Report (`generate_ga_preview_diff.py`) **[RECOMMENDED]**

### Overview

Generates a comprehensive Excel workbook with two focused sheets comparing three swagger versions:

**Comparisons (Nov preview is source of truth):**
- GA (2025-09-01) vs Nov Preview (2025-11-01-preview) - for GA scoping
- Aug Preview (2025-08-01-preview) vs Nov Preview (2025-11-01-preview) - to distinguish truly new from preview-only features

**Sheet 1: Routes Diff**
- One row per Preview operation
- Shows route-level differences only (parameters, responses)
- Does NOT include model/schema changes
- Columns include both GA and Aug preview comparisons

**Sheet 2: Models Diff**
- One row per model/property change
- Shows schema-level differences (types, required fields, etc.)
- Columns include both GA and Aug preview comparisons

### Usage

```bash
# Generate report (default: output/ directory)
python generate_ga_preview_diff.py

# Custom output directory
python generate_ga_preview_diff.py --output-dir ./reports
```

### Output

Creates **`ga_preview_diff_YYYYMMDD_HHMMSS.xlsx`** with two sheets.

#### Routes Diff Sheet

| Column | Description | Example Values |
|--------|-------------|----------------|
| **Spec** | Which spec file | searchservice, searchindex, knowledgebase |
| **2025-11-01-preview Path** | API path (preview) | `/knowledgebases('{knowledgeBaseName}')` |
| **Method** | HTTP method | GET, POST, PUT, DELETE |
| **Operation ID** | Operation identifier | `KnowledgeBases_Get` |
| **2025-09-01 GA Presence** | GA comparison | `present in 2025-09-01`<br/>`new in 2025-11-01-preview` |
| **Detail Diff** | Route changes vs GA | `new operation`<br/>`no changes for existing operation`<br/>`Parameters: + query: ignoreResetRequirements (optional) boolean` |
| **2025-08-01-preview Presence** | Aug preview comparison | `present in 2025-08-01-preview`<br/>`new in 2025-11-01-preview` |
| **Detailed Diff from 2025-08-01-preview** | Route changes vs Aug preview | `new operation`<br/>`no changes from 2025-08-01-preview`<br/>`Parameters: + query: speller (optional) string` |
| **2026-04-01 GA Decision** | Manual review | (blank - for team input) |

**Detail Diff Rules:**
- New operations: `"new operation"`
- Unchanged operations: `"no changes for existing operation"`
- Changed operations: Lists only changed parts
  - Parameters: `"Parameters: + query: paramName (optional) type; - header: oldParam (required) string"`
  - Responses: `"Responses: + 202; - 404"`
- Does NOT include schema/model changes

#### Models Diff Sheet

| Column | Description | Example Values |
|--------|-------------|----------------|
| **Spec** | Which spec file | searchservice, searchindex, knowledgebase |
| **Model Name** | Definition name | `SearchRequest`, `KnowledgeBase` |
| **Property Name** | Property within model | `hybridSearch`, `description` (blank for model-level) |
| **Change Type** | Type of change | `added_model`, `removed_model`, `added_property`, `removed_property`, `type_changed`, `required_changed` |
| **2025-09-01 GA** | GA value | `(not present)`, `string (required)`, `integer (optional)` |
| **2025-11-01-preview** | Preview value | `new model`, `array of string (required)`, `(not present)` |
| **Impact Surface** | Breaking analysis | `breaking`, `non-breaking`, `unknown` |
| **2025-08-01-preview Presence** | Aug preview comparison | `present in 2025-08-01-preview`<br/>`new in 2025-11-01-preview` |
| **Detailed Diff from 2025-08-01-preview** | Model changes vs Aug preview | `new model`<br/>`no changes from 2025-08-01-preview`<br/>`property added in Nov vs Aug (optional)` |
| **2026-04-01 GA Decision** | Manual review | (blank - for team input) |

**Impact Rules:**
- New models/properties: `non-breaking` (unless property is required)
- Removed models/properties: `breaking`
- Type changes: `breaking`
- Optional → Required: `breaking`
- Required → Optional: `non-breaking`

### Row Coloring

The Excel output applies background colors to guide human review:

#### Routes Diff Sheet Colors

| Color | Condition | Meaning |
|-------|-----------|---------|
| **Light Blue** | New operation (`new in 2025-11-01-preview` + `new operation`) | Additive change; GA inclusion decision required |
| **Light Yellow** | Existing operation with changes (`present in 2025-09-01` + changes) | Behavior/surface changed; needs careful review |
| **White (no fill)** | No route-level changes (`no changes for existing operation`) | No action needed at route level |

#### Models Diff Sheet Colors

| Color | Condition | Meaning |
|-------|-----------|---------|
| **Light Red** | Breaking changes (`removed_property`, `type_changed`, `removed_model`, or `impact=breaking`) | High risk; must be explicitly handled in TypeSpec |
| **Light Yellow** | Added properties or required changes with `impact=non-breaking` | Non-breaking but may affect SDKs or typed clients |
| **Light Gray** | New models (`added_model`) | Low risk; mostly informational |
| **White (no fill)** | Other changes | Standard review |

**Note:** Colors guide review only and do not encode final GA decisions.

### Comparison Logic

**Preview as Source of Truth:**
- All Preview (2025-11-01-preview) operations are listed
- GA (2025-09-01) is used for diff annotation
- Aug Preview (2025-08-01-preview) is used for diff annotation
- For knowledgebase spec: GA doesn't exist, all marked as "new in 2025-11-01-preview"

**Row Generation Rules:**

Routes Diff:
- All Nov preview operations are listed (source of truth)
- Each row includes both GA and Aug preview comparisons

Models Diff:
- **Rows are generated ONLY from Sep GA vs Nov preview differences**
- Aug preview columns provide annotation context (NOT a source of new rows)
- For knowledgebase: Since no Sep GA exists, all Nov preview models/properties generate rows

**Route Matching:**
- Operations matched by: normalized path + HTTP method
- Case-insensitive method comparison

**Model Matching:**
- Models matched by: definition name
- Properties matched by: property name within model

---

## Tool 2: Schema-Level Discrepancy Checker (`compare_ga_preview.py`)

### Overview

Compares GA (stable) swagger files against Preview swagger files to detect:
- **Breaking changes**: Removed or incompatibly changed operations, parameters, or schemas in preview
- **Non-breaking additions**: New operations, parameters, or relaxed constraints in preview
- **Schema differences**: Type, format, required field, and constraint changes

The comparison logic is based on the semantic equivalency checker in `../swagger_equiv/semantic_equiv` but reimplemented as a standalone tool without shared dependencies.

## Usage

### Default Comparison (All Files)

Compares searchindex.json, searchservice.json, and knowledgebase.json and generates a single Excel file with three sheets:

```bash
python compare_ga_preview.py
```

This creates **`ga_preview_discrepancy_YYYYMMDD_HHMMSS.xlsx`** with:
- **searchindex** sheet - Discrepancies in searchindex.json
- **searchservice** sheet - Discrepancies in searchservice.json
- **knowledgebase** sheet - Discrepancies in knowledgebase.json (preview-only, no GA version)

### Compare Specific File Pair

```bash
# Compare searchindex.json only
python compare_ga_preview.py --file searchindex

# Compare searchservice.json only
python compare_ga_preview.py --file searchservice

# Compare knowledgebase.json only (preview-only file)
python compare_ga_preview.py --file knowledgebase
```

### Custom File Paths

```bash
python compare_ga_preview.py \
  --ga-index /path/to/ga/searchindex.json \
  --preview-index /path/to/preview/searchindex.json \
  --ga-service /path/to/ga/searchservice.json \
  --preview-service /path/to/preview/searchservice.json \
  --preview-knowledgebase /path/to/preview/knowledgebase.json
```

**Note**: `--ga-knowledgebase` is optional since no GA version exists yet. The tool compares against an empty baseline.

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

The tool generates **`ga_preview_discrepancy_YYYYMMDD_HHMMSS.xlsx`** with these columns:

| Column | Description | Example |
|--------|-------------|---------|
| **Category** | Type of difference | operation, parameter, schema, response, other |
| **Identifier** | Detailed location | `/docs [get] param:queryLanguage`<br/>`SearchRequest property:hybridSearch` |
| **2025-09-01 GA Value** | Value in GA swagger | `object`, `true`, `(not present)` |
| **2025-11-01-preview Value** | Value in Preview swagger | `None`, `false`, `(not present)` |
| **Difference Summary** | Human-readable description | Schema type changed: object -> None |
| **Severity** | Impact classification | breaking, non-breaking, unknown |
| **2026-04-01 Decision** | Manual review field for decisions | (blank) |
| **TSP Action** | Manual review field for TypeSpec actions | (blank) |

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
[OK] Excel report saved to: output\ga_preview_discrepancy_20260115_143022.xlsx

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

Open the generated Excel file (e.g., `output/ga_preview_discrepancy_20260115_143022.xlsx`) in Excel:

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
- *(knowledgebase.json - no GA version exists)*

**Preview:**
- `specification/search/data-plane/Search/preview/2025-11-01-preview_unmigrated/searchindex.json`
- `specification/search/data-plane/Search/preview/2025-11-01-preview_unmigrated/searchservice.json`
- `specification/search/data-plane/Search/preview/2025-11-01-preview_unmigrated/knowledgebase.json`

## Notes

- This tool is completely self-contained with no dependencies on `../swagger_equiv/semantic_equiv`
- All comparisons use deterministic ordering for stable output across runs
- Reference fields ($ref) are normalized for cross-file comparison
- Excel formatting makes it easy to review and add comments directly in the spreadsheet
---

## Tool 3: Operation Surface Report Generator (`generate_operation_surface.py`)

### Overview

Generates an operation-centric API surface Excel report using **Preview (2025-11-01-preview) as the source of truth**. Each row represents an operation with detailed parameter and response information, annotated with differences vs GA (2025-09-01) to guide 2026-04-01 GA decisions.

**Key differences from `compare_ga_preview.py`:**
- **Baseline**: Preview is the baseline (not GA)
- **Focus**: Operations are the primary unit (not schemas)
- **Output**: Detailed parameter/response lists in bullet format
- **Purpose**: Planning guide for next GA version

### Usage

#### Generate Report (Always Creates 3 Sheets)

```bash
python generate_operation_surface.py
```

This creates **`operation_surface_YYYYMMDD_HHMMSS.xlsx`** with **3 sheets** in a single workbook:
- **searchservice** - All operations from searchservice.json (sorted by path, method)
- **searchindex** - All operations from searchindex.json (sorted by path, method)
- **knowledgebase** - All operations from knowledgebase.json (sorted by path, method)

**Note**: The tool always processes all 3 files and generates one workbook with 3 sheets. This ensures a complete API surface view.

#### Custom Output Directory

```bash
python generate_operation_surface.py --output-dir ./reports
```

#### Custom File Paths (Rarely Needed)

```bash
python generate_operation_surface.py \
  --preview-index /path/to/preview/searchindex.json \
  --ga-index /path/to/ga/searchindex.json \
  --preview-service /path/to/preview/searchservice.json \
  --ga-service /path/to/ga/searchservice.json \
  --preview-knowledgebase /path/to/preview/knowledgebase.json
```
python generate_operation_surface.py --output-dir ./my-reports
```

### Output Format

#### Excel Structure

| Column | Description | Example |
|--------|-------------|---------|
| **2025-11-01-preview Path** | API endpoint path from Preview | `/indexes/{indexName}/docs/search.post.search` |
| **Method** | HTTP method | `POST` |
| **OperationId** | Operation identifier | `Documents_SearchPost` |
| **Parameters** | Bullet list of all parameters | • query: api-version (required) string<br>• path: indexName (required) string<br>• body: request (required) SearchRequest<br>• ref: ClientRequestIdParameter (optional) |
| **Responses** | Bullet list of all responses | • 200: SearchDocumentsResult (application/json)<br>• 400: SearchError (application/json) |
| **2025-09-01 GA Presence** | Whether operation exists in GA | `present` or `missing` |
| **Detail Diff** | Structured multi-section diff vs GA | See below for format |
| **2026-04-01 Decision** | Manual review field | (blank for user input) |
| **TSP Action** | Manual review field | (blank for user input) |

#### Parameter Format

Each parameter is formatted as a single-line bullet:

```
{in}: {name} ({required/optional}) {type} [additional details]
```

**Examples:**
- `query: queryLanguage (optional) string (enum: simple, full)`
- `path: indexName (required) string`
- `header: api-version (required) string`
- `body: request (required) SearchRequest`
- `ref: ClientRequestIdParameter (optional)` - For $ref parameters (resolved when possible)

**Note:** The tool automatically resolves `$ref` parameters (e.g., `"$ref": "#/parameters/ClientRequestIdParameter"`) to show actual parameter details. If resolution fails, it displays the reference name.

#### Response Format

Each response is formatted as a single-line bullet:

```
{status_code}: {schema_name} ({content_type})
```

**Examples:**
- `200: SearchDocumentsResult (application/json)`
- `400: SearchError (application/json)`
- `201: (no content) (application/json)`

#### Detail Diff Format

The **Detail Diff** column contains a structured multi-section diff with the following sections:

**Path/Method/Operation:**
- GA presence status: `present in 2025-09-01` or `new in 2025-11-01-preview`
- OperationId comparison (GA vs Preview)

**Parameters:**
- `+ {param}` - Parameter added in Preview
- `- {param}` - Parameter removed in Preview
- `~ {param} ({change})` - Parameter changed (type, required status, etc.)
- `(no changes)` - No parameter differences
- `(new operation)` - For operations not in GA

**Responses:**
- `+ {code}` - Response code added in Preview
- `- {code}` - Response code removed in Preview
- `~ {code} schema changed: {old} → {new}` - Response schema changed
- `(no changes)` - No response differences
- `(new operation)` - For operations not in GA

**Example Detail Diff (new operation):**
```
Path/Method/Operation
• GA presence: new in 2025-11-01-preview
• operationId: GA=n/a, Preview=Aliases_Create

Parameters
• (new operation)

Responses
• (new operation)
```

**Example Detail Diff (existing operation with changes):**
```
Path/Method/Operation
• GA presence: present in 2025-09-01
• operationId: Documents_Search

Parameters
• + query: speller (optional) string
• + query: semanticFields (optional) string
• ~ query: top (optional→required)

Responses
• + 202
• ~ 200 schema changed: SearchResult → SearchDocumentsResult
```

### Operation Matching Logic

Operations are matched between Preview and GA using:
- **Primary key**: Normalized path + HTTP method
- If operationId differs but path+method match → same operation (recorded as operationId change)
- If path+method doesn't exist in GA → marked as "new in 2025-11-01-preview"

### Excel Formatting

- **Single workbook with 3 sheets**: searchservice, searchindex, knowledgebase (in that order)
- **Header row**: Blue background, white bold text, centered
- **Data cells**: Top-aligned with text wrapping for multi-line content
- **New operations**: Yellow background highlight (`ga_presence = "new in 2025-11-01-preview"`)
- **Row ordering**: Sorted by path then method within each sheet for stable ordering
- **Column widths**: Auto-adjusted for readability
- **Row heights**: Auto-sized for multi-line parameter/response lists

### Output Structure

Each sheet contains:
| Column | Description | Example |
|--------|-------------|---------|
| **2025-11-01-preview Path** | API path from Preview | `/indexes('{indexName}')` |
| **Method** | HTTP method | `GET`, `POST`, `PUT`, `DELETE` |
| **OperationId** | Operation identifier | `Indexes_Get` |
| **Parameters** | Formatted parameter list | `• path: indexName (required) string`<br>`• header: api-version (required) string` |
| **Responses** | Formatted response list | `• 200: SearchIndex (application/json)`<br>`• 404: ErrorResponse (application/json)` |
| **2025-09-01 GA Presence** | Comparison status | `present in 2025-09-01` or `new in 2025-11-01-preview` |
| **Detail Diff** | Structured multi-section diff | See Detail Diff Format above |
| **2026-04-01 Decision** | Manual review column | (blank for manual input) |
| **TSP Action** | Manual review column | (blank for manual input) |

### Default File Paths

Preview (baseline):
- `specification/search/data-plane/Search/preview/2025-11-01-preview_unmigrated/searchindex.json`
- `specification/search/data-plane/Search/preview/2025-11-01-preview_unmigrated/searchservice.json`
- `specification/search/data-plane/Search/preview/2025-11-01-preview_unmigrated/knowledgebase.json`

GA (comparison):
- `specification/search/data-plane/Search/stable/2025-09-01/searchindex.json`
- `specification/search/data-plane/Search/stable/2025-09-01/searchservice.json`
- *(knowledgebase.json - no GA version, all operations marked as "new in 2025-11-01-preview")*

### Example Output

Console output:
```
Processing searchservice.json...
  Preview operations: 51
  GA operations: 31
  Annotated operations: 51

Processing searchindex.json...
  Preview operations: 9
  GA operations: 9
  Annotated operations: 9

Processing knowledgebase.json...
  Preview operations: 1
  No GA file provided, treating as empty
  Annotated operations: 1

Generating Excel report...
✓ Excel report saved: output/operation_surface_20260123_170110.xlsx

============================================================
Operation Surface Report Summary
============================================================

searchservice.json:
  Total operations: 51
  Present in 2025-09-01: 31
  New in 2025-11-01-preview: 20

searchindex.json:
  Total operations: 9
  Present in 2025-09-01: 9
  New in 2025-11-01-preview: 0

knowledgebase.json:
  Total operations: 1
  Present in 2025-09-01: 0
  New in 2025-11-01-preview: 1

============================================================
Report saved to: output/operation_surface_20260123_143022.xlsx
============================================================
```

### When to Use This Tool

Use `generate_operation_surface.py` when you need to:
- **Plan the next GA version** based on Preview operations
- **Review all operations** in Preview with their parameters and responses
- **Identify new operations** not present in GA
- **Compare API surface** at operation level (not schema level)
- **Make decisions** about what to include in 2026-04-01 GA

Use `compare_ga_preview.py` when you need to:
- **Identify breaking changes** for migration impact
- **Review schema-level changes** in models and definitions
- **Track severity** of all changes (breaking vs non-breaking)
- **Detailed diff analysis** of parameters, responses, and constraints

### Notes

- This tool prioritizes **operation surface** over deep schema comparisons
- Parameter/response type comparisons are **best-effort** (shallow comparison by name/$ref)
- Both Swagger 2.0 and OpenAPI 3.0 are supported
- Multi-line bullet lists render properly in Excel with wrapped text
- Operations sorted by path then method for stable ordering