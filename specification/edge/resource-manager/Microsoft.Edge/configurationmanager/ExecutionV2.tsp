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
@doc("ExecutionV2 Status")
model ExecutionV2Status {
  @doc("The lastModified timestamp of the Status")
  updateTime?: utcDateTime;

  @doc("Deployment status")
  status?: int32;

  @doc("status details")
  statusMessage?: string;

  @doc("target resource statuses")
  @Azure.ResourceManager.identifiers(#[])
  stageHistory?: StageStatus[];
}

@added(Versions.v2025_08_15_preview)
@removed(Versions.v2026_03_01)
@doc("ExecutionV2 Properties")
model ExecutionV2Properties {
  @doc("Workflow version of ExecutionV2")
  workflowVersionId?: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("ExecutionV2 specification")
  specification?: Record<unknown>;

  @doc("Status of ExecutionV2")
  @visibility(Lifecycle.Read)
  status?: ExecutionV2Status;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2025_08_15_preview)
@removed(Versions.v2026_03_01)
@doc("ExecutionV2 Resource")
@resource("executions")
@parentResource(WorkflowVersionV2)
model ExecutionV2
  is Azure.ResourceManager.ProxyResource<ExecutionV2Properties> {
  @doc("The name of the ExecutionV2.")
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?(\\.[a-zA-Z0-9]([-a-zA-Z0-9]*[a-zA-Z0-9])?)*$")
  @path
  @key("executionName")
  @segment("executions")
  name: string;

  ...ExtendedLocationProperty;
  ...EntityTagProperty;
}

@added(Versions.v2025_08_15_preview)
@removed(Versions.v2026_03_01)
@armResourceOperations
interface ExecutionV2s {
  @doc("Get ExecutionV2 Resource")
  get is ArmResourceRead<ExecutionV2>;

  @doc("Create or update ExecutionV2 Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExecutionV2>;

  @doc("update an ExecutionV2 Resource")
  update is ArmResourcePatchAsync<ExecutionV2, ExecutionV2Properties>;

  @doc("Delete ExecutionV2 Resource")
  delete is ArmResourceDeleteWithoutOkAsync<ExecutionV2>;

  @doc("List ExecutionV2 Resources")
  listByWorkflowVersionV2 is ArmResourceListByParent<ExecutionV2>;
}
