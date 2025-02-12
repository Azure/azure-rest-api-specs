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
model StageResult {
  @doc("Deployment status")
  status: string;

  @doc("status details")
  statusDetails: string;
}

@doc("Execution Status")
model ExecutionStatus {
  @doc("The lastModified of the Status")
  lastModified: utcDateTime;

  @doc("Deployment status")
  status: string;

  @doc("status details")
  statusDetails: string;

  @doc("target resource statuses")
  @extension("x-ms-identifiers", [])
  stageHistory?: StageResult[];
}

@doc("Execution Properties")
model ExecutionProperties {
  @doc("Workflow version of execution")
  @visibility("read")
  workflowVersionId: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("Execution specification")
  specification: Record<unknown>;

  @doc("Status of Execution")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  status: ExecutionStatus;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Execution Resource")
@parentResource(WorkflowVersion)
model Execution is Azure.ResourceManager.ProxyResource<ExecutionProperties> {
  @doc("The name of the Execution.")
  @maxLength(61)
  @minLength(3)
  @pattern("^(?!v-)(?!.*-v-)[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
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
