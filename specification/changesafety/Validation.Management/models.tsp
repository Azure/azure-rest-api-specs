using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ChangeSafety;

@doc("The validator types.")
union ValidatorType {
  string,

  @doc("This is a Validation RP owned validator.")
  builtin: "builtin",

  @doc("This is a validator that is owned by the customer.")
  custom: "custom",
}

@doc("The outcome of the validation.")
union Outcome {
  string,

  @doc("The validation succeeded.")
  Succeeded: "Succeeded",

  @doc("The validation failed.")
  Failed: "Failed",

  @doc("The validation is running and the outcome is not yet known.")
  Pending: "Pending",

  @doc("The validation is deferred to a different system. When it is deferred to a different system, that system can inspect the validationOutput to determine the outcome.")
  Deferred: "Deferred",
}

@doc("The provisioning state of the resource.")
union ProvisioningState {
  string,

  @doc("The succeeded provisioning state.")
  Succeeded: "Succeeded",

  @doc("The failed provisioning state.")
  Failed: "Failed",

  @doc("The canceled provisioning state.")
  Canceled: "Canceled",
}

@doc("The validator properties.")
model ValidatorProperties {
  @doc("The description of the validator.")
  @visibility("read")
  description: string;

  @doc("The type of the validator.")
  @visibility("read")
  validatorType: ValidatorType;

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The validator version properties.")
model ValidatorVersionProperties {
  @doc("The ARM resource id of the parent validator resource.")
  validatorId: ValidatorResourceId;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
  @doc("The schema of parameters that is used for validation.")
  validationParameterSchema: {};

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
  @doc("The schema for the output from a validation run.")
  outputSchema: {};

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
  @doc("The description of the validator version.")
  description: string;

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The error definition.")
model ErrorDefinition {
  @doc("The error code.")
  @visibility("read")
  code: string;

  @doc("The error message.")
  @visibility("read")
  message: string;

  @doc("The error details.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  details?: ErrorDefinition[];
}

@doc("The validation properties.")
model ValidationProperties {
  @doc("The ARM resource Id of the validator version to use for validation.")
  validatorVersionId: ValidatorVersionResourceId;

  @doc("The changeState is a new resource that encapsulates the change and tracks the change state. The changeStateId is the ARM resource id of the changeState resource. ")
  changeStateId?: string;

  @doc("The token Id.")
  tokenId?: string;

  @doc("The stage Id.")
  stageId?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
  @doc("The stage parameters.")
  stageParameters?: {};

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
  @doc("The parameters used for validation. This property will be checked against the validationParameterSchema in the validator resource.")
  validationParameters?: {};

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The validation properties extended.")
model ValidationPropertiesExtended {
  ...ValidationProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
  @doc("The output of the validation. This property will match the output schema in the validator version resource.")
  validationOutput?: {};

  @doc("The outcome of the validation.")
  @visibility("read")
  @madeOptional(Versions.v2025_01_15_preview)
  outcome?: Outcome;

  @doc("Time duration in ISO8601 format to retry after, when the outcome property is 'Pending'. For all other values, the retryAfter is not present. This is an indication to the client to 'PATCH' validation after the duration.")
  @visibility("read")
  retryAfter?: string;

  @doc("Optional message to provide descriptive information about the outcome of the validation.")
  @visibility("read")
  message?: string;
}
