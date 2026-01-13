# Swagger to Excel Converter

Converts Azure Search Resource Manager (ARM) Swagger/OpenAPI JSON files into Excel format for API analysis and overview.

## Quick Start

1. Install dependencies: `pip install -r requirements.txt`
2. Configure file paths in `config.yaml`
3. Run: `python swagger_to_excel.py`

## Usage

```bash
python swagger_to_excel.py                           # Use config.yaml
python swagger_to_excel.py --output "./custom_dir"   # Custom output directory
python swagger_to_excel.py --config "./my_config"    # Custom config file
```

## Configuration

Edit `config.yaml` to set input swagger files and categories:

```yaml
input_files:
  resource_manager:
    - path: "../../resource-manager/Microsoft.Search/Search/stable/2025-05-01/rp-2025-05-01-search.json"
      category: "ARM-2025-05-01"
```

Add multiple API versions by adding more entries under `resource_manager`.

## Output

Single Excel file with 6 sheets:

1. **API Overview** - High-level statistics (total paths, operations, HTTP methods, tags)
2. **Operation Overview** - Simple operation list with parameter/response counts
3. **Endpoints Detail** - Complete endpoint information (parameters by type, responses, security)
4. **Parameters** - Detailed parameter analysis (type, required, constraints, descriptions)
5. **Responses** - Response definitions with schema references
6. **Data Models** - Schema definitions from the definitions section

Each sheet includes a **Category** column to distinguish between different API versions or sources.

## Files

- `swagger_to_excel.py` - Main converter script
- `config.yaml` - Input file configuration
- `requirements.txt` - Python dependencies (PyYAML, pandas, openpyxl)
- `output/` - Generated Excel files

## Example Output

The generated Excel file provides a comprehensive overview of the ARM API:
- 28 operations across 21 paths
- Operations grouped by tags (Services, PrivateEndpointConnections, QueryKeys, etc.)
- Detailed parameter analysis with constraints and types
- Response schema references
- Complete data model definitions

## Troubleshooting

- **Config not found**: Ensure `config.yaml` exists in the script directory
- **File not found**: Verify the relative path in `config.yaml` points to the correct swagger file
- **Empty Excel**: Check that the swagger file was loaded successfully (look for "Loading..." message)
- **File not found**: Update paths in `config.yaml`
- **Missing deps**: Run `pip install -r requirements.txt`