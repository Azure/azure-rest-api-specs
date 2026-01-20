# MongoDB Cluster Armstrong Testing

This directory contains comprehensive Armstrong testing configuration for the MongoDB Cluster API (Microsoft.DocumentDB/mongoClusters@2025-09-01).

## Quick Start

### 1. Install Prerequisites

```bash
./armstrong-scenario.sh install
source ~/.bashrc  # Reload shell to use Armstrong and OAV
```

### 2. Configure Azure and Generate Test Configuration

```bash
# Login to Azure
az login
az account set --subscription <your-subscription-id>

# Generate test configuration
./armstrong-scenario.sh regenerate --subscription-id <your-subscription-id>
```

### 3. Run Tests

```bash
# Run full test cycle (validate + test + cleanup)
./armstrong-scenario.sh full

# Or run individual steps
./armstrong-scenario.sh validate  # Validate Terraform configuration
./armstrong-scenario.sh test      # Run Armstrong tests (preserves resources)
./armstrong-scenario.sh cleanup   # Clean up Azure resources
```

## Armstrong Scenario Script

The `armstrong-scenario.sh` script provides a complete wrapper for Armstrong testing with configuration management, logging, and automation.

### Commands

| Command | Description |
|---------|-------------|
| `install` | Install all prerequisites (Go, Terraform, Armstrong, OAV, expect) |
| `regenerate` | Generate new configuration with fresh resource names and passwords |
| `validate` | Validate Terraform configuration |
| `test` | Run Armstrong tests against Azure API |
| `cleanup` | Remove Azure resources |
| `full` | Run complete cycle: validate → test → cleanup |

### Options

| Option | Description |
|--------|-------------|
| `--working-dir <path>` | Terraform working directory (default: current directory) |
| `--subscription-id <id>` | Azure subscription ID |
| `--regenerate-resources` | Generate new resource names and passwords |
| `--resource-name <name>` | Specific resource name to use |
| `--swagger-path <path>` | Path to swagger file (default: auto-detect) |
| `--location <region>` | Azure region (default: westus3) |
| `--replica-location <region>` | Replica region (default: centralus) |
| `--no-log` | Disable output logging for better interactive experience |

### Examples

```bash
# Install with custom subscription
./armstrong-scenario.sh regenerate --subscription-id 455f5b7e-620f-4f41-b67a-56513a1cdf29

# Run test without logging (cleaner output)
./armstrong-scenario.sh test --no-log

# Use custom regions
./armstrong-scenario.sh test --location eastus --replica-location westus2

# Regenerate resources and run full cycle
./armstrong-scenario.sh full --regenerate-resources
```

## Configuration Files

### armstrong-scenario.conf

Auto-generated configuration file containing:
- Subscription ID
- Resource names (with timestamp for uniqueness)
- Admin passwords
- Azure regions
- Swagger file path
- Last updated timestamp

Example:
```bash
SUBSCRIPTION_ID=455f5b7e-620f-4f41-b67a-56513a1cdf29
RESOURCE_NAME=acctest1730000000
LOCATION=westus3
REPLICA_LOCATION=centralus
ADMIN_PASSWORD=terraformTest@2025-1730000000!
RESTORE_ADMIN_PASSWORD=restoreTest@2025-1730000000!
```

## Terraform Files

This directory contains modular Terraform configuration files that can be customized for different test scenarios:

### testing.tf

Primary test configuration file for defining MongoDB cluster resources to cover various test scenarios. Add or modify cluster configurations, authentication modes, storage settings, and advanced features to expand test coverage.

### dependency.tf

Defines supporting Azure resources required for MongoDB cluster testing, such as resource groups, key vaults for customer-managed encryption, and network resources. Modify this file to add additional dependencies or change resource configurations.

### provider.tf

Contains Terraform provider configurations and version constraints. Update this file to change provider versions, add required features, or configure provider-specific settings.

## Logs and Reports

### armstrong-scenario.log

Detailed execution log containing:
- Timestamp for each operation
- Command execution details
- Success/failure status
- Error messages and debugging information

The log is automatically created and appended to during test runs. Use `--no-log` flag for cleaner interactive output.

### Armstrong Coverage Reports

Armstrong automatically generates coverage reports showing:
- API endpoints tested
- Property coverage analysis
- Missing properties and operations
- Test execution results

Coverage reports are displayed in the terminal output during test execution.

### Test Artifacts

During test execution, the following artifacts are preserved:
- Terraform state files (`.terraform/`, `terraform.tfstate`)
- Azure resource configurations
- Error logs and debugging information
- Armstrong test results

## Troubleshooting

### Common Issues

1. **Armstrong not found after install**
   ```bash
   source ~/.bashrc  # Reload shell configuration
   ```

2. **Azure authentication errors**
   ```bash
   az login
   az account set --subscription <subscription-id>
   ```

3. **Resource naming conflicts**
   ```bash
   ./armstrong-scenario.sh regenerate --subscription-id <id>  # Generate new names
   ```

4. **Test failures**
   - Check `armstrong-scenario.log` for detailed error information
   - Verify Azure subscription permissions
   - Ensure resource quotas are available
   - Run `./armstrong-scenario.sh cleanup` to remove stuck resources

### Prerequisites Issues

If the install command fails:
- Ensure you have sudo access for package installation
- Check internet connectivity for downloading packages
- Verify your package manager (apt/yum/dnf) is working
- For OAV installation, ensure npm is available

### Debugging Commands

```bash
# Check tool installations
terraform version
go version
armstrong --version
oav --version

# Verify Azure login
az account show

# Check Terraform configuration
terraform validate
terraform plan
```

## Directory Structure

```
terraform/
├── README.md                    # This file
├── armstrong-scenario.sh        # Main automation script
├── armstrong-scenario.conf      # Auto-generated configuration
├── armstrong-scenario.conf.template # Configuration template
├── armstrong-scenario.log       # Execution logs
├── testing.tf                   # Primary test resource configuration
├── dependency.tf                # Supporting Azure resources
└── provider.tf                  # Terraform provider configuration
```

## Additional Resources

- [Armstrong Documentation](https://github.com/Azure/armstrong)
- [Armstrong API Testing Guide (Internal)](https://eng.ms/docs/cloud-ai-platform/azure-core/azure-experiences-and-ecosystems/azure-portal-and-client-tools-ruhim/azure-cli-tools-azure-cli-powershell-and-terraform/azure-cli-tools/onboarding/terraform/ecosystem/api_testing/api_testing)
- [MongoDB Cluster API Documentation](https://docs.microsoft.com/en-us/azure/cosmos-db/mongodb/)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
- [OAV OpenAPI Validator](https://github.com/Azure/oav)

## Support

For issues with:
- **Armstrong testing**: Check Armstrong repository issues
- **MongoDB Cluster API**: Review Azure documentation and API specifications
- **This automation script**: Check logs and verify prerequisites
- **Terraform configuration**: Validate syntax and Azure provider version