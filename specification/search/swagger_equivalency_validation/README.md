# Swagger Equivalency Validation Tool

A simple Python tool to validate equivalency between TypeSpec-compiled swagger JSON and hand-authored swagger files for Azure Search.


## Setup

**Requirements**: Python 3.11 or higher

```bash
# Check Python version first
python --version
# Should show "Python 3.11.x" or higher

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

```bash
# Basic validation
python main.py

# Custom config file
python main.py --config custom.yaml
```

## Files Structure

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
