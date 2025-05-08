import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

@versioned(Versions)
namespace Microsoft.MessagingConnectors;

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@added(Versions.v2025_03_01_preview)
@doc("Request of validation")
model ValidationRequest {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@added(Versions.v2025_03_01_preview)
@doc("Request of connector configuration validation")
model ConnectorConfigurationValidationRequest {
  @doc("Connector properties")
  connectorProperties: ConnectorProperties;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@added(Versions.v2025_03_01_preview)
@doc("Request of datapreview configuration validation")
model DataPreviewConfigurationValidationRequest {
  @doc("Datapreview properties")
  dataPreviewProperties: DataPreviewProperties;
}

@added(Versions.v2025_03_01_preview)
@doc("Result of validation")
union ValidationResultStatus {
  @doc("Validation success.")
  Success: "Success",

  @doc("Validation failed.")
  Failed: "Failed",

  string,
}

@added(Versions.v2025_03_01_preview)
@doc("Validation error.")
model ValidationError {
  @doc("Error message.")
  message: string;

  @doc("Error code.")
  code: string;
}

@added(Versions.v2025_03_01_preview)
@doc("Result of validation")
model ValidationResult {
  @doc("Validation success or failed")
  result: ValidationResultStatus;

  @doc("Validation errors.")
  @Azure.ResourceManager.identifiers(#[])
  errors?: ValidationError[];
}
