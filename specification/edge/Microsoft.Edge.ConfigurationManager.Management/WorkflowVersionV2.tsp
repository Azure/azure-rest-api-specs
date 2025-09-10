import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.Edge;

@added(Versions.v2025_08_15_preview)
@doc("Workflow Version Properties")
model WorkflowVersionV2Properties {
  @doc("Revision number of resolved config for this workflow version")
  @visibility(Lifecycle.Read)
  revision?: int32;

  @doc("Resolved configuration values")
  @visibility(Lifecycle.Read)
  configuration?: string;

  @Azure.ResourceManager.identifiers(#[])
  @doc("A list of stage specs")
  stageSpec: StageSpec[];

  @doc("Review id of resolved config for this workflow version")
  @visibility(Lifecycle.Read)
  reviewId?: string;

  @doc("State of workflow version")
  @visibility(Lifecycle.Read)
  state?: State;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("Execution specification")
  specification?: Record<unknown>;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2025_08_15_preview)
@doc("Workflow Version Resource")
@parentResource(WorkflowV2)
@resource("versions")
model WorkflowVersionV2
  is Azure.ResourceManager.ProxyResource<WorkflowVersionV2Properties> {
  @doc("The name of the WorkflowVersionV2.")
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  @path
  @key("versionName")
  @segment("versions")
  name: string;

  ...ExtendedLocationProperty;
  ...EntityTagProperty;
}

@added(Versions.v2025_08_15_preview)
@armResourceOperations
interface WorkflowVersionV2s {
  @doc("Get a Workflow Version Resource")
  get is ArmResourceRead<WorkflowVersionV2>;

  @doc("Create or update a Workflow Version Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<WorkflowVersionV2>;

  @doc("update an WorkflowVersionV2 Resource")
  update is ArmResourcePatchAsync<
    WorkflowVersionV2,
    WorkflowVersionV2Properties
  >;

  @doc("Delete a Workflow Version Resource")
  delete is ArmResourceDeleteWithoutOkAsync<WorkflowVersionV2>;

  @doc("List Workflow Version Resources")
  listByWorkflowV2 is ArmResourceListByParent<WorkflowVersionV2>;
}
