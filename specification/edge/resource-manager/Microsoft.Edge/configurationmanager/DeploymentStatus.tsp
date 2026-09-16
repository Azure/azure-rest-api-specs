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

@doc("Component Status")
model ComponentStatus {
  @doc("Component name")
  name?: string;

  @doc("Component status")
  status?: string;
}

@doc("Target Status")
model TargetStatus {
  @doc("Target name")
  name?: string;

  @doc("Target status")
  status?: string;

  @doc("Component statuses")
  @Azure.ResourceManager.identifiers(#[])
  componentStatuses?: ComponentStatus[];
}

@doc("Deployment Status")
model DeploymentStatus {
  @doc("The lastModified of the Status")
  lastModified?: utcDateTime;

  @doc("Indicates if Instance is deployed")
  deployed?: int32;

  @doc("The expected running job id")
  expectedRunningJobId?: int32;

  @doc("The running job id")
  runningJobId?: int32;

  @doc("Deployment status")
  status?: string;

  @doc("Status details")
  statusDetails?: string;

  @doc("Deployment Generation")
  generation?: int32;

  @doc("Target resource statuses")
  @Azure.ResourceManager.identifiers(#[])
  targetStatuses?: TargetStatus[];
}
