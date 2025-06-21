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
