# Swagger to Excel Converter

Converts multiple Swagger/OpenAPI JSON files into a single combined Excel file for Azure Search API analysis.

## Quick Start

1. Install dependencies: `pip install -r requirements.txt`
2. Configure file paths in `config.yaml`
3. Run: `python swagger_to_excel.py`

## Usage

```bash
python swagger_to_excel.py                           # Use config.yaml
python swagger_to_excel.py --output "./custom_dir"   # Custom output
python swagger_to_excel.py --config "./my_config"    # Custom config
```

## Configuration

Edit `config.yaml` to set input files and categories:

| Category | Source | Description |
|----------|--------|-------------|
| `tsp` | search.json | TSP-compiled Search API |
| `searchservice` | searchservice.json | Hand-authored Search Service API |
| `searchindex` | searchindex.json | Hand-authored Search Index API |
| `knowledgebase` | knowledgebase.json | Hand-authored Knowledge Base API |

## Output

Single Excel file with 6 sheets, each with **Category** as first column:

1. **API Overview** - Statistics by category
2. **Operation Overview** - Simple operation list
3. **Endpoints Detail** - Complete endpoint information
4. **Parameters** - Parameter analysis with descriptions
5. **Responses** - Response definitions with descriptions
6. **Data Models** - Schema definitions with descriptions

## Files

- `swagger_to_excel.py` - Main script
- `config.yaml` - Input configuration
- `requirements.txt` - Dependencies (PyYAML, pandas, openpyxl)
- `excel_output/` - Generated files

## Troubleshooting

- **Config not found**: Ensure `config.yaml` exists
- **File not found**: Update paths in `config.yaml`
- **Missing deps**: Run `pip install -r requirements.txt`