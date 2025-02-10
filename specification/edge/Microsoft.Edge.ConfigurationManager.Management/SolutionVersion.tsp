import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./State.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.Edge;

@doc("Solution Version Properties")
model SolutionVersionProperties {
  @doc("Revision number of resolved config for this solution version")
  @visibility("read")
  revision?: int32;

  @doc("Name of applicable target's display name")
  @visibility("read")
  targetDisplayName?: string;

  @doc("Resolved configuration values")
  @visibility("read")
  configuration?: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("App components spec")
  @visibility("read")
  specification: Record<unknown>;

  @doc("Review id of resolved config for this solution version")
  @visibility("read")
  reviewId?: string;

  @doc("State of solution instance")
  @visibility("read")
  state?: State;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Solution Version Resource")
@parentResource(Solution)
@resource("versions")
model SolutionVersion
  is Azure.ResourceManager.ProxyResource<SolutionVersionProperties> {
  // Name will be set to solutionTemplateVersion-revision
  @doc("Name of the solution version")
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  @path
  @key("solutionVersionName")
  @segment("solutionVersions")
  name: string;

  ...ExtendedLocationProperty;
  ...EntityTagProperty;
}

@armResourceOperations
interface SolutionVersions {
  @doc("Get a Solution Version Resource")
  get is ArmResourceRead<SolutionVersion>;

  @doc("List Solution Version Resources")
  listBySolution is ArmResourceListByParent<SolutionVersion>;
}
