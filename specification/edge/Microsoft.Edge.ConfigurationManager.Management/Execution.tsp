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

@doc("Result of Stage execution")
model StageStatus {
  @doc("Deployment status")
  status?: int32;

  @doc("Status message")
  statusMessage?: string;

  @doc("Current stage")
  stage?: string;

  @doc("Next stage")
  nextstage?: string;

  @doc("Error message")
  errorMessage?: string;

  @doc("whether this stage is active or inactive")
  isActive?: ActiveState;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The inputs of the StageHistory, Inputs holds a key-value map of user-defined parameters for the initial stage")
  inputs?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The outputs of the StageHistory, it is different as the different input stages.")
  outputs?: Record<unknown>;
}

@doc("Execution Status")
model ExecutionStatus {
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

@doc("Execution Properties")
model ExecutionProperties {
  @doc("Workflow version of execution")
  workflowVersionId: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("Execution specification")
  specification?: Record<unknown>;

  @doc("Status of Execution")
  @visibility(Lifecycle.Read)
  status?: ExecutionStatus;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Execution Resource")
@parentResource(WorkflowVersion)
model Execution is Azure.ResourceManager.ProxyResource<ExecutionProperties> {
  @doc("The name of the Execution.")
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

@armResourceOperations
interface Executions {
  @doc("Get Execution Resource")
  get is ArmResourceRead<Execution>;

  @doc("Create or update Execution Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Execution>;

  @doc("update an Execution Resource")
  update is ArmResourcePatchAsync<Execution, ExecutionProperties>;

  @doc("Delete Execution Resource")
  delete is ArmResourceDeleteWithoutOkAsync<Execution>;

  @doc("List Execution Resources")
  listByWorkflowVersion is ArmResourceListByParent<Execution>;
}
