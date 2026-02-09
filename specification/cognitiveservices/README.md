# Cognitive Services API Specifications

This directory contains API specifications for Microsoft Cognitive Services.

## Contents

- **data-plane/**: Data plane (service) API specifications
- **resource-manager/**: Control plane (ARM) API specifications

## Swagger to TypeSpec Conversion

### Quick Start

This directory includes scripts to convert the Cognitive Services control plane API from Swagger to TypeSpec:

**Bash (Linux/macOS/WSL):**
```bash
./convert-to-typespec.sh
```

**PowerShell (Windows):**
```powershell
.\convert-to-typespec.ps1
```

### Documentation

- **[SWAGGER_TO_TYPESPEC.md](./SWAGGER_TO_TYPESPEC.md)** - Comprehensive guide for manual conversion, including:
  - Detailed step-by-step instructions
  - Post-conversion validation checklist
  - Common issues and solutions
  - Commands reference
  - Resource links

- **[CONVERSION_GUIDE.md](./CONVERSION_GUIDE.md)** - Quick reference guide focusing on:
  - Script usage
  - Expected output
  - Post-conversion steps
  - Troubleshooting

### About the Scripts

The conversion scripts automate the following:
1. Install npm dependencies (TypeSpec tools)
2. Run `tsp-client convert` with appropriate flags for ARM specs
3. Generate TypeSpec project structure
4. Provide guidance for next steps

The scripts use the official `@azure-tools/typespec-client-generator-cli` package to perform the conversion.

## Support

For questions about:
- **TypeSpec conversion**: See [SWAGGER_TO_TYPESPEC.md](./SWAGGER_TO_TYPESPEC.md)
- **TypeSpec language**: Visit [typespec.io](https://typespec.io/docs/)
- **Azure TypeSpec guidelines**: Visit [azure.github.io/typespec-azure](https://azure.github.io/typespec-azure/docs/intro/)
