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
@removed(Versions.v2026_03_01)
@doc("Workflow Properties")
model WorkflowV2Properties {
  @doc("Workflow template Id")
  @visibility(Lifecycle.Read)
  workflowTemplateId?: string;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2025_08_15_preview)
@removed(Versions.v2026_03_01)
@doc("WorkflowV2 Resource")
@resource("workflows")
model WorkflowV2
  is Azure.ResourceManager.TrackedResource<WorkflowV2Properties> {
  @doc("Name of the workflow")
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  @path
  @key("workflowName")
  @segment("workflows")
  name: string;

  ...ExtendedLocationProperty;
  ...EntityTagProperty;
}

@added(Versions.v2025_08_15_preview)
@removed(Versions.v2026_03_01)
@armResourceOperations
interface WorkflowV2s {
  @doc("Get a Workflow resource")
  get is ArmResourceRead<WorkflowV2>;

  @doc("Create or update a Workflow resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<WorkflowV2>;

  @doc("update a Workflow resource")
  update is ArmResourcePatchAsync<WorkflowV2, WorkflowV2Properties>;

  @doc("Delete a Workflow resource")
  delete is ArmResourceDeleteWithoutOkAsync<WorkflowV2>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<WorkflowV2>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<WorkflowV2>;
}
