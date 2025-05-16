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
  @doc("The health validation resource name.")
  @key("healthValidationName")
  @pattern("^[a-zA-Z0-9]{1}[a-zA-Z0-9-_.]{0,62}[a-zA-Z0-9_]{1}$")
  @segment("healthValidations")
  @path
  name: string;
}

@doc("The generic properties of the health validation resource.")
@added(Versions.v2024_10_01_preview)
model HealthValidationProperties {
  @visibility(Lifecycle.Read)
  @doc("The start time of health validation, in UTC.")
  startTime: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The end time of health validation, in UTC.")
  endTime: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The current health validation status.")
  status: validationStatus;

  @visibility(Lifecycle.Read)
  @identifiers(#[])
  @doc("The list of issues found by health validation.")
  issues: ValidationIssue[];

  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the health validation resource.")
  provisioningState?: ResourceProvisioningState;
}

@doc("Health validation status.")
@added(Versions.v2024_10_01_preview)
union validationStatus {
  string,

  @doc("Health validation has not started.")
  NotStarted: "NotStarted",

  @doc("Health validation is running.")
  Running: "Running",

  @doc("Health validation completed successfully.")
  Succeeded: "Succeeded",

  @doc("Health validation failed.")
  Failed: "Failed",

  @doc("Health validation was canceled.")
  Canceled: "Canceled",

  @doc("Health validation timed out.")
  TimedOut: "TimedOut",
}

@doc("The model of a health validation issue.")
@added(Versions.v2024_10_01_preview)
model ValidationIssue {
  @visibility(Lifecycle.Read)
  @doc("The error code of the issue.")
  errorCode: string;

  @visibility(Lifecycle.Read)
  @doc("The error message of the issue.")
  errorMessage: string;

  @visibility(Lifecycle.Read)
  @doc("The additional details for the issue.")
  additionalDetails?: string;

  @visibility(Lifecycle.Read)
  @doc("The recommendation for resolving the issue.")
  recommendationMessage: string;

  @visibility(Lifecycle.Read)
  @doc("The URL related to resolving the issue.")
  recommendationUrl?: url;

  @visibility(Lifecycle.Read)
  @doc("The resource ID of the Azure resource related to the issue.")
  relatedResourceId?: Azure.Core.armResourceIdentifier<[]>;

  @visibility(Lifecycle.Read)
  @doc("The type of the Azure resource related to the issue.")
  relatedResourceType?: string;
}
