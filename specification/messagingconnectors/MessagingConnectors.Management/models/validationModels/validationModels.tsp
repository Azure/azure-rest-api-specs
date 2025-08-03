import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.MessagingConnectors.Models.Validation;

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Request of validation")
model ValidationRequest {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Request of connector configuration validation")
model ConnectorConfigurationValidationRequest {
  @doc("Connector properties")
  connectorProperties: Models.Connector.ConnectorProperties;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Request of datapreview configuration validation")
model DataPreviewConfigurationValidationRequest {
  @doc("Datapreview properties")
  dataPreviewProperties: Models.DataPreview.DataPreviewProperties;
}

@doc("Result of validation")
union ValidationResultStatus {
  @doc("Validation success.")
  Success: "Success",

  @doc("Validation failed.")
  Failed: "Failed",

  string,
}

@doc("Validation error.")
model ValidationError {
  @doc("Error message.")
  message: string;

  @doc("Error code.")
  code: string;
}

@doc("Result of validation")
model ValidationResult {
  @doc("Validation success or failed")
  result: ValidationResultStatus;

  @doc("Validation errors.")
  @Azure.ResourceManager.identifiers(#[])
  errors?: ValidationError[];
}
