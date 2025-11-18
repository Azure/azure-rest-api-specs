# Swagger to Excel Converter

A Python tool to convert Swagger/OpenAPI JSON files into human-readable Excel format for Azure Search API analysis.

## Purpose

This tool helps understand complex API definitions and dependencies for Azure Search by generating Excel files with multiple sheets containing:

- API Overview and Statistics
- Detailed Endpoint Information
- Parameters Analysis
- Response Definitions
- Data Models/Schemas
- API Tag Groups Summary

## Setup

1. **Install Python dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

## Usage

### Process all 4 Azure Search swagger files:

```bash
python run.py
```

### Process a single file:

```bash
python swagger_to_excel.py "../../data-plane/Azure.Search/preview/2025-11-01-preview/searchservice.json"
```

### Process a single file with custom output name:

```bash
python swagger_to_excel.py "../../data-plane/Azure.Search/preview/2025-11-01-preview/searchservice.json" --name "my_custom_name"
```

### Specify custom output directory:

```bash
python swagger_to_excel.py "../../data-plane/Azure.Search/preview/2025-11-01-preview/searchservice.json" --output "./custom_output"
```

## Files

- `swagger_to_excel.py` - Main conversion script (processes single file)
- `run.py` - Batch processor (processes all 4 Azure Search files)
- `config.yaml` - Optional configuration for sheet settings
- `requirements.txt` - Python dependencies
- `excel_output/` - Generated Excel files (created automatically)

## Azure Search Files Processed

The `run.py` script processes these 4 files:

1. **search.json** (TSP-compiled) - Complete Search API from TypeSpec compilation
2. **searchservice.json** (Hand-authored) - Search Service management API
3. **searchindex.json** (Hand-authored) - Search Index management API
4. **knowledgebase.json** (Hand-authored) - Knowledge Base management API

## Output

Each Swagger JSON file generates an Excel file with these sheets:

1. **API Overview** - High-level statistics and summary
2. **Endpoints Detail** - Complete API endpoint information
3. **Parameters** - All parameters with types and constraints
4. **Responses** - Response codes and schemas
5. **Data Models** - Schema definitions from the definitions section
6. **Tag Groups** - API groupings and their statistics

## Examples

### Generated Excel Structure

- `azure_search_api_searchservice_2025-11-01-preview_20231117_143022.xlsx`
  - Sheet: "API Overview"
  - Sheet: "Endpoints Detail"
  - Sheet: "Parameters"
  - Sheet: "Responses"
  - Sheet: "Data Models"
  - Sheet: "Tag Groups"

## Files

- `swagger_to_excel.py` - Main conversion script
- `config.yaml` - Configuration file
- `requirements.txt` - Python dependencies
- `excel_output/` - Generated Excel files (created automatically)

## Troubleshooting

**File not found errors**: Update paths in `config.yaml` to match your file structure.

**Missing dependencies**: Run `pip install -r requirements.txt`

**Large files**: The tool handles large Swagger files by truncating long descriptions to keep Excel readable.