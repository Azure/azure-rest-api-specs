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

## Usage

**Sheet 1: Routes Diff**
- One row per Preview operation
- Shows route-level differences only (parameters, responses)
- Does NOT include model/schema changes
- Columns: Spec, Path, Method, Operation ID, GA Presence, Detail Diff, Decision

**Sheet 2: Models Diff**
- One row per model/property change
- Shows schema-level differences (types, required fields, etc.)
- Columns: Spec, Model Name, Property Name, Change Type, GA Value, Preview Value, Impact, Decision

## Usage

```bash
# Generate report (default: output/ directory)
python generate_ga_preview_diff.py

# Custom output directory
python generate_ga_preview_diff.py --output-dir ./reports
```

## Output Structure

Creates **`ga_preview_diff_YYYYMMDD_HHMMSS.xlsx`** with two sheets:

### Sheet 1: Routes Diff

| Column | Description | Example Values |
|--------|-------------|----------------|
| **Spec** | Which spec file | searchservice, searchindex, knowledgebase |
| **2025-11-01-preview Path** | API path (preview) | `/knowledgebases('{knowledgeBaseName}')` |
| **Method** | HTTP method | GET, POST, PUT, DELETE |
| **Operation ID** | Operation identifier | `KnowledgeBases_Get` |
| **2025-09-01 GA Presence** | GA comparison | `present in 2025-09-01`<br/>`new in 2025-11-01-preview` |
| **Detail Diff** | Route changes only | `new operation`<br/>`no changes for existing operation`<br/>`Parameters: + query: ignoreResetRequirements (optional) boolean` |
| **2026-04-01 GA Decision** | Manual review | (blank - for team input) |

**Detail Diff Rules:**
- New operations: `"new operation"`
- Unchanged operations: `"no changes for existing operation"`
- Changed operations: Lists only changed parts
  - Parameters: `"Parameters: + query: paramName (optional) type; - header: oldParam (required) string"`
  - Responses: `"Responses: + 202; - 404"`
- Does NOT include schema/model changes

### Sheet 2: Models Diff

| Column | Description | Example Values |
|--------|-------------|----------------|
| **Spec** | Which spec file | searchservice, searchindex, knowledgebase |
| **Model Name** | Definition name | `SearchRequest`, `KnowledgeBase` |
| **Property Name** | Property within model | `hybridSearch`, `description` (blank for model-level) |
| **Change Type** | Type of change | `added_model`, `removed_model`, `added_property`, `removed_property`, `type_changed`, `required_changed` |
| **2025-09-01 GA** | GA value | `(not present)`, `string (required)`, `integer (optional)` |
| **2025-11-01-preview** | Preview value | `new model`, `array of string (required)`, `(not present)` |
| **Impact Surface** | Breaking analysis | `breaking`, `non-breaking`, `unknown` |
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
- GA (2025-09-01) is used only for diff annotation
- For knowledgebase spec: GA doesn't exist, all marked as "new in 2025-11-01-preview"

**Route Matching:**
- Operations matched by: normalized path + HTTP method
- Case-insensitive method comparison

**Model Matching:**
- Models matched by: definition name
- Properties matched by: property name within model

## Project Structure

```
swagger_discrepancy_ga_preview/
├── generate_ga_preview_diff.py  # Main entry point
├── ref_resolver.py              # Reference resolution utility
├── requirements.txt             # Python dependencies
├── README.md                    # This file
├── .gitignore                  # Git ignore rules
└── output/                      # Generated Excel reports
```

## Dependencies

- Python 3.7+
- openpyxl (for Excel generation)

Install via:
```bash
pip install -r requirements.txt
```

## File Paths

The tool uses these default file paths (relative to the repository root):

**GA (2025-09-01):**
- `specification/search/data-plane/Search/stable/2025-09-01/searchservice.json`
- `specification/search/data-plane/Search/stable/2025-09-01/searchindex.json`

**Preview (2025-11-01-preview):**
- `specification/search/data-plane/Search/preview/2025-11-01-preview_unmigrated/searchservice.json`
- `specification/search/data-plane/Search/preview/2025-11-01-preview_unmigrated/searchindex.json`
- `specification/search/data-plane/Search/preview/2025-11-01-preview_unmigrated/knowledgebase.json`

## Contributing

When modifying the comparison logic:
1. Update both route and model diff functions
2. Ensure color coding rules remain consistent
3. Test against all three specs (searchservice, searchindex, knowledgebase)
4. Verify Excel output formatting is preserved


