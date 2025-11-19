# Semantic Equivalency Checker

A Python tool for comparing hand-authored and TypeSpec-compiled Swagger specifications for semantic equivalency. This tool implements strict semantic comparison while ignoring documentation-only fields and ordering differences.

## Overview

This tool compares three hand-authored Swagger files plus common types against a single TypeSpec-compiled Swagger file to determine if they represent the same API contract.

## Quick Start

### Setup Dependencies
```bash
pip install -r requirements.txt
```

### Run the Equivalency Check
```bash
# Basic usage - uses config.yaml in current directory
python cli.py

# With custom config file
python cli.py --config custom.yaml

# Show detailed differences
python cli.py --verbose

# Save canonicalized specs for debugging
python cli.py --save-canonical

# Ignore operationId mismatches
python cli.py --ignore-operation-id
```

## Exit Codes

- `0` - Specifications are semantically equivalent
- `1` - Specifications are NOT equivalent
- `2` - Configuration or file loading error
- `3` - Processing error

## Configuration

Edit `config.yaml` to specify the paths to your Swagger files. See `equiv_contract.md` for detailed equivalency rules and `equiv_impl_guide.md` for implementation details.

## Output

Results are written to the configured output directory:
- `comparison_result.json` - Structured comparison results
- `differences_report.txt` - Detailed diff report (if not equivalent)
- `*_canonical.json` - Canonicalized specs (if `--save-canonical` used)