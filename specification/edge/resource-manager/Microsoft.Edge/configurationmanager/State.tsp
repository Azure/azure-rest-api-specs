import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Resource Type State")
union ResourceState {
  @doc("Resource is active")
  active: "active",

  @doc("Resource is inactive")
  inactive: "inactive",

  string,
}

@doc("Solution Instance State")
union State {
  @doc("Solution Instance is in review")
  InReview: "InReview",

  @doc("Solution Instance upgrade is in review")
  UpgradeInReview: "UpgradeInReview",

  @doc("Solution Instance is ready to deploy")
  ReadyToDeploy: "ReadyToDeploy",

  @doc("Solution Instance is ready to upgrade")
  ReadyToUpgrade: "ReadyToUpgrade",

  @doc("Solution Instance is deploying")
  Deploying: "Deploying",

  @doc("Solution Instance is deployed")
  Deployed: "Deployed",

  @doc("Solution Instance failed to deploy")
  Failed: "Failed",

  @doc("Solution Instance is undeployed")
  Undeployed: "Undeployed",

  @doc("Solution Instance is pending external validation")
  PendingExternalValidation: "PendingExternalValidation",

  @doc("Solution Instance failed external validation")
  ExternalValidationFailed: "ExternalValidationFailed",

  @doc("Solution Instance is staging the images")
  Staging: "Staging",

  @added(Versions.v2025_08_01)
  @doc("State is not applicable")
  NotApplicable: "NotApplicable",

  string,
}

@doc("Solution Instance Validation Status")
union ValidationStatus {
  @doc("Solution Instance is valid")
  Valid: "Valid",

  @doc("Solution Instance is invalid")
  Invalid: "Invalid",

  string,
}

@added(Versions.v2025_08_01)
@doc("Stage Map for Solution Version")
model StageMap {
  @doc("Display State")
  @visibility(Lifecycle.Read)
  displayState: string;

  @doc("Stage name")
  @visibility(Lifecycle.Read)
  stage: CMStages;

  @doc("Stage status")
  @visibility(Lifecycle.Read)
  status: StateCategory;

  @doc("Stage start time")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("Stage end time")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  @doc("Child stages which represents more granular level stage status if any")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  childStages?: StageMap[];
}

@added(Versions.v2025_08_01)
@doc("Stages for Solution Version")
union CMStages {
  @doc("Configuration stage")
  Configuration: "Configuration",

  @doc("Publish stage")
  Publish: "Publish",

  @doc("Deployment stage")
  Deployment: "Deployment",

  @doc("Uninstallation stage")
  Uninstallation: "Uninstallation",

  @doc("External Validation stage")
  ExternalValidation: "ExternalValidation",

  @doc("Staging stage")
  Staging: "Staging",

  @doc("Unstaging stage")
  Unstaging: "Unstaging",

  string,
}

@added(Versions.v2025_08_01)
@doc("State Category for Solution Version")
union StateCategory {
  @doc("Pending state [Non-Terminal]")
  Pending: "Pending",

  @doc("InProgress state [Non-Terminal]")
  InProgress: "InProgress",

  @doc("Completed state [Terminal]")
  Completed: "Completed",

  @doc("Failed state [Terminal]")
  Failed: "Failed",

  @doc("None state [Terminal]")
  None: "None",

  string,
}
