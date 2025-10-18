# Microsoft Genome Resource Provider TypeSpec

This directory contains the TypeSpec specification for the Microsoft.Genome resource provider.

## Structure

- `main.tsp` - Main TypeSpec specification file containing all models, operations, and interfaces
- `tspconfig.yaml` - TypeSpec configuration file
- `examples/` - Directory for API examples

## API Version

This specification covers API version 2021-08-01-preview.

## Resources

The specification includes the following resources:

- **GenomeAccount** - Main genome account resource with CRUD operations
  - Create genome account
  - Get genome account details
  - Update genome account properties
  - Delete genome account
  - List accounts by resource group
  - List accounts by subscription

## Key Features

- Support for managed identity (system-assigned and user-assigned)
- Network access control rules (IP rules and VNet rules)
- Customer-managed encryption with Key Vault
- SKU-based pricing tiers
- Comprehensive resource tagging
- Environment-based deployment support

## Models

The specification defines the following main models:

- `GenomeAccount` - The main resource model extending TrackedResource
- `GenomeAccountProperties` - Properties specific to genome accounts
- `Sku` - SKU configuration with tier, size, family, and capacity
- `Identity` - Managed identity configuration (system/user-assigned)
- `NetworkRuleSet` - Network access control configuration
- `Encryption` - Encryption configuration with Key Vault support
- `GenomeAccountUpdate` - Parameters for updating genome accounts

## Union Types

The specification uses union types for enums as per Azure TypeSpec guidelines:

- `SkuTier` - Free, Basic, Standard, Premium, Enterprise
- `ResourceIdentityType` - None, SystemAssigned, UserAssigned, etc.
- `ProvisioningState` - Provisioning, Active, Updating, Suspended, Deleting
- `NetworkRuleAction` - Allow, Deny
- `KeySource` - Microsoft.Genome, Microsoft.KeyVault

## Prerequisites

Before working with this TypeSpec project, ensure you have:

1. **Node.js** (version 18 or later)
2. **npm** (comes with Node.js)
3. **Repository dependencies** installed at the root level

### Installation

From the azure-rest-api-specs repository root directory, install dependencies:

```bash
npm ci
```

This installs all required TypeSpec tools and dependencies globally for the repository.

## Compilation

To compile this TypeSpec specification to OpenAPI:

```bash
npx tsp compile .
```

This will:
- Validate the TypeSpec specification
- Generate OpenAPI 3.0 specification (`genome.json`)
- Include example files from the `examples/` directory
- Output to the configured directory structure

### Compilation Output

The generated files will be placed in:
```
specification/genome/resource-manager/Microsoft.Genome/preview/2021-08-01-preview/genome.json
```

## Development Workflow

1. **Edit TypeSpec files** (`main.tsp`, `models.tsp`, `client.tsp`)
2. **Update examples** in `examples/2021-08-01-preview/`
3. **Compile and validate**:
   ```bash
   npx tsp compile .
   ```
4. **Review output**: Check compilation messages and generated `genome.json`

## Architecture & Design

This TypeSpec project follows Azure Resource Manager patterns:
- Uses `TrackedResource` for the main resource type
- Implements standard ARM operations with `ArmResourceOperations`
- Follows ARM naming conventions and decorators
- Uses proper visibility controls for read-only properties
- Implements async operations for long-running operations

When compiled, generates:
- OpenAPI 3.0 specification (`genome.json`)
- ARM template schemas
- SDK generation artifacts