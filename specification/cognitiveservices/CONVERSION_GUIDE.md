# Converting Cognitive Services from Swagger to TypeSpec

This directory contains scripts to automate the conversion of Cognitive Services control plane API definitions from Swagger (OpenAPI v2) to TypeSpec.

## Prerequisites

- **Node.js** (with npm) - Required to install and run the TypeSpec tools
- **Git** - For version control

## Conversion Scripts

Two scripts are provided for different environments:

### Bash Script (Linux/macOS/WSL)

```bash
./convert-to-typespec.sh
```

### PowerShell Script (Windows)

```powershell
.\convert-to-typespec.ps1
```

## What the Scripts Do

The conversion scripts will:

1. **Install dependencies** - Runs `npm ci` in the repository root to install required TypeSpec tools
2. **Convert Swagger to TypeSpec** - Uses `tsp-client convert` to convert the Swagger specification
3. **Create TypeSpec project structure** - Sets up the appropriate directory structure following Azure conventions
4. **Provide next steps** - Gives guidance on reviewing and validating the converted specification

## Expected Output

After running the conversion script, you'll find the generated TypeSpec files in:

```
specification/cognitiveservices/resource-manager/Microsoft.CognitiveServices/CognitiveServices.Management/
├── main.tsp           # Main TypeSpec file with service definition
├── models.tsp         # Model definitions (may be split across multiple files)
├── tspconfig.yaml     # TypeSpec configuration file
└── examples/          # Example files
```

## Post-Conversion Steps

After conversion, you **must** review and update the generated TypeSpec:

### 1. Verify Service Configuration

Check `main.tsp` for correct service definitions:

```typescript
@service({
  title: "Microsoft Cognitive Services",
})
@versioned(Versions)
namespace Microsoft.CognitiveServices;
```

### 2. Add Security Definition

Ensure `@useAuth` is specified (should appear only once, above `@server`):

```typescript
@useAuth(AzureAuth)
@server(...)
```

### 3. Validate Versioning

Confirm the versions enum is properly configured:

```typescript
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_10_01_preview: "2025-10-01-preview",
}
```

### 4. Review and Document

- Add documentation comments (`/** ... */`) to all models, properties, operations, and parameters
- Review enum/union definitions and ensure they're properly documented
- Convert `enum` to `union` where appropriate (Azure best practice)

### 5. Compile and Validate

```bash
cd specification/cognitiveservices/resource-manager/Microsoft.CognitiveServices/CognitiveServices.Management
tsp compile .
```

Address any compilation errors or warnings.

### 6. Compare Generated OpenAPI

After successful compilation, review the generated OpenAPI files in the `preview/` or `stable/` directories and compare them with the original Swagger files to ensure fidelity.

## Troubleshooting

### Common Issues

1. **Missing dependencies** - Run `npm ci` in the repository root
2. **Compilation errors** - See the [TypeSpec troubleshooting guide](/.github/instructions/typespec-project.instructions.md#troubleshooting-tsp-compile-errors-and-warnings)
3. **Versioning errors** - Ensure `@useDependency` decorators are specified for all imported versioned namespaces

## Documentation References

- [TypeSpec Project Instructions](/.github/instructions/typespec-project.instructions.md)
- [ARM Migration Instructions](/.github/instructions/mgmt-migration.instructions.md)
- [Getting Started with TypeSpec](../../documentation/Getting-started-with-TypeSpec-specifications.md)
- [TypeSpec Structure Guidelines](../../documentation/typespec-structure-guidelines.md)

## Support

For questions or issues with the conversion:

1. Check the [TypeSpec documentation](https://typespec.io/docs/)
2. Review the [Azure TypeSpec guidelines](https://azure.github.io/typespec-azure/docs/intro/)
3. Consult the reference implementation in `specification/widget/`
