# Swagger Equivalency Validation Tool

A simple Python tool to validate equivalency between TypeSpec-compiled swagger JSON and hand-authored swagger files for Azure Search using `openapi-diff`.

## Features

- **Professional Comparison**: Uses `openapi-diff` for industry-standard API comparison
- **Breaking Change Detection**: Identifies breaking vs non-breaking changes
- **Two-Step Workflow**: Generate normalized files first, then compare for better debugging
- **CSV Reports**: Detailed reports with change categorization
- **Multi-File Support**: Merges multiple hand-authored swagger files for comparison

## Setup

**Requirements**:
- Python 3.11 or higher
- Node.js and npm (for openapi-diff)

### Install Dependencies

```bash
# Check versions first
python --version  # Should show "Python 3.11.x" or higher
node --version    # Should show Node.js version
npm --version     # Should show npm version

# Install openapi-diff globally
npm install -g openapi-diff

# Create virtual environment with specific Python version
# Option 1: If python command points to 3.11+
python -m venv .venv

# Option 2: Use specific Python executable
py -3.11 -m venv .venv

# Activate virtual environment
.venv\Scripts\activate

# Verify Python version in virtual environment
python --version

# Install dependencies
pip install -r requirements.txt
```

## Usage

## Usage

### Default Workflow (Recommended)

```bash
# Complete workflow: normalize + validate in one step
python main.py
```

This will:

1. **Step 1**: Load and normalize swagger files (replacing descriptions/examples with standardized placeholders)
2. **Step 2**: Save intermediate files (`tsp-search.json`, `hand-search.json`)
3. **Step 3**: Run `openapi-diff` comparison and generate report

### Advanced Options

```bash
# Skip normalization and use existing intermediate files
python main.py --disable-norm

# Use custom config file
python main.py --config custom.yaml

# Get help
python main.py --help
```

### Generated Files

The tool creates several output files:

- `tsp-search.json` - Normalized TypeSpec-compiled swagger
- `hand-search.json` - Normalized and merged hand-authored swagger files
- `openapi_diff_report_TIMESTAMP.txt` - Detailed comparison results

### Benefits of This Approach

- **Industry Standard**: Uses `openapi-diff` for professional API comparison
- **Spec Compliant**: Maintains OpenAPI spec validity by replacing (not removing) required fields
- **Debugging Friendly**: Intermediate files can be inspected manually
- **One Command**: Default workflow handles everything automatically## Files Structure

- `main.py` - Entry point script
- `validator.py` - SwaggerValidator class
- `config.yaml` - Configuration file
- `requirements.txt` - Dependencies
- `.output/` - Generated CSV reports

## Configuration

Edit `config.yaml` to set file paths:

```yaml
typespec_compiled:
  path: "../path/to/search.json"

hand_authored:
  searchservice:
    path: "../path/to/searchservice.json"
  searchindex:
    path: "../path/to/searchindex.json"
  knowledgebase:
    path: "../path/to/knowledgebase.json"

output:
  path: "./.output"
```

## Dependencies

- Python 3.11+
- deepdiff 6.7.1 (deep comparison)
- PyYAML 6.0.1 (YAML config)
- colorama 0.4.6 (colored output)

## Exit Codes

- `0`: All swagger files are equivalent
- `1`: Differences found or validation error
