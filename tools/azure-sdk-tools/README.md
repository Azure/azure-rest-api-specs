# Azure SDK Tools - Namespace Parser

This tool provides improved namespace parsing for Azure SDK packages by examining the actual package structure instead of simply replacing hyphens with dots.

## Problem

Previously, the `parse_pyproject` function would calculate the namespace by simply replacing `-` with `.` in the package name. This approach was incorrect for packages like `azure-eventhub-checkpointstoreblob`, which has:

- **Package Name**: `azure-eventhub-checkpointstoreblob`
- **Actual Namespace**: `azure.eventhub.extensions.checkpointstoreblob`
- **Incorrect (old) namespace**: `azure.eventhub.checkpointstoreblob`

## Solution

The new implementation examines the package's `__init__.py` files to discover the actual namespace structure:

1. Walks through the package directory structure
2. Identifies `__init__.py` files that contain actual package content (not just extension declarations)
3. Returns the correct namespace based on the directory structure

## Usage

```python
from tools.azure_sdk_tools.tests.test_parse_functionality import parse_pyproject

# Parse a package and get its correct namespace
result = parse_pyproject("azure-eventhub-checkpointstoreblob", "/path/to/package/root")
print(result["namespace"])  # Output: azure.eventhub.extensions.checkpointstoreblob
```

## Testing

Run the tests to verify the functionality:

```bash
python3 -m unittest tools.azure-sdk-tools.tests.test_parse_functionality -v
```

## Demonstration

Run the demo script to see the difference between old and new approaches:

```bash
cd tools/azure-sdk-tools
python3 demo_namespace_parsing.py
```

## Files

- `tests/test_parse_functionality.py` - Main implementation and test cases
- `demo_namespace_parsing.py` - Demonstration script showing improvements
- `../sdk/eventhub/azure-eventhub-checkpointstoreblob/` - Example package structure for testing