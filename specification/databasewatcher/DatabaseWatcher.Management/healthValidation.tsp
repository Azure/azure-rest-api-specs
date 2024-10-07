import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.DatabaseWatcher;

using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;

@armResourceOperations
@added(Versions.v2024_10_01_preview)
interface HealthValidations {
  get is ArmResourceRead<HealthValidation>;
  listByParent is ArmResourceListByParent<HealthValidation>;
  @doc("Starts health validation for a watcher.")
  startValidation is ArmResourceActionAsync<
    HealthValidation,
    void,
    HealthValidation
  >;
}

@parentResource(Watcher)
@added(Versions.v2024_10_01_preview)
model HealthValidation is ProxyResource<HealthValidationProperties> {
  @doc("The health validation proxy resource name.")
  @key("healthValidationName")
  @pattern("^[a-zA-Z0-9]{1}[a-zA-Z0-9-_.]{0,62}[a-zA-Z0-9_]{1}$")
  @segment("healthValidations")
  @path
  name: string;
}

@doc("The generic properties of the health validation proxy resource.")
@added(Versions.v2024_10_01_preview)
model HealthValidationProperties {
  @visibility("read")
  @doc("The start time of health validation, in UTC.")
  startTime: utcDateTime;

  @visibility("read")
  @doc("The end time of the health validation.")
  endTime: utcDateTime;

  @visibility("read")
  @doc("The current status of the validation.")
  status: validationStatus;

  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["errorCode"])
  @doc("The list of issues generated from the health validation.")
  issues: ValidationIssue[];

  @visibility("read")
  @doc("The provisioning state of the health validation resource.")
  provisioningState?: ResourceProvisioningState;
}

@doc("The current status of health validation.")
@added(Versions.v2024_10_01_preview)
union validationStatus {
  string,

  @doc("The health validation has not started yet.")
  NotStarted: "NotStarted",

  @doc("The health validation is running.")
  Running: "Running",

  @doc("The health validation has successfully completed.")
  Succeeded: "Succeeded",

  @doc("The health validation haa failed.")
  Failed: "Failed",

  @doc("The health validation has been canceled.")
  Canceled: "Canceled",

  @doc("The health validation has timed out.")
  TimedOut: "TimedOut",
}

@doc("The model of the issue generated from the health validation.")
@added(Versions.v2024_10_01_preview)
model ValidationIssue {
  @visibility("read")
  @doc("The error code of the issue.")
  errorCode: string;

  @visibility("read")
  @doc("The error message of the issue.")
  errorMessage: string;

  @visibility("read")
  @doc("The additional details of the issue.")
  additionalDetails?: string;

  @visibility("read")
  @doc("The recommendation message for fixing the issue.")
  recommendationMessage: string;

  @visibility("read")
  @doc("The recommendation url for fixing the issue.")
  recommendationUrl?: url;

  @visibility("read")
  @doc("The resource ID of the validated resource.")
  validationResourceId?: Azure.Core.armResourceIdentifier<[]>;

  @visibility("read")
  @doc("The type of the Azure resource related to the issue.")
  validationResourceType?: string;
}
