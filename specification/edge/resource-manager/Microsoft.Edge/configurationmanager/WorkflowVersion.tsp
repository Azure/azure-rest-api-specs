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

@doc("Error Action Mode")
union ErrorActionMode {
  @doc("Stop on any failure")
  stopOnAnyFailure: "stopOnAnyFailure",

  @doc("Stop after N cumulative failures")
  stopOnNFailures: "stopOnNFailures",

  @doc("Continue silently despite errors")
  silentlyContinue: "silentlyContinue",

  string,
}

@doc("Error Action Properties")
model ErrorAction {
  @doc("Error action mode")
  mode?: ErrorActionMode = ErrorActionMode.stopOnAnyFailure;

  @doc("Max tolerated failures")
  @minValue(0)
  maxToleratedFailures?: int32;
}

@doc("Task Option Properties")
model TaskOption {
  @doc("Parallel worker numbers of the tasks")
  @minValue(1)
  @maxValue(8)
  concurrency?: int32 = 1;

  @doc("Error action for the tasks")
  errorAction?: ErrorAction;
}

@doc("Task Spec")
model TaskSpec {
  @doc("Name of Task")
  name: string;

  @doc("Target ARM id")
  targetId?: armResourceIdentifier<[
    {
      type: "Microsoft.Edge/targets";
    }
  ]>;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("Task specification")
  specification: Record<unknown>;
}

@doc("Stage Properties")
model StageSpec {
  @doc("Name of Stage")
  name: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("Stage specification")
  specification?: Record<unknown>;

  @doc("List of tasks in the stage")
  tasks?: TaskSpec[];

  @doc("Task option for the stage")
  taskOption?: TaskOption;
}

@doc("Workflow Version Properties")
model WorkflowVersionProperties {
  @doc("Revision number of resolved config for this workflow version")
  @visibility(Lifecycle.Read)
  revision?: int32;

  @doc("Resolved configuration values")
  @visibility(Lifecycle.Read)
  configuration?: string;

  @doc("A list of stage specs")
  @Azure.ResourceManager.identifiers(#[])
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

@doc("Workflow Version Resource")
@parentResource(Workflow)
@resource("versions")
model WorkflowVersion
  is Azure.ResourceManager.ProxyResource<WorkflowVersionProperties> {
  @doc("The name of the workflowVersion.")
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

@armResourceOperations
interface WorkflowVersions {
  @doc("Get a Workflow Version Resource")
  get is ArmResourceRead<WorkflowVersion>;

  @doc("Create or update a Workflow Version Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<WorkflowVersion>;

  @doc("update an WorkflowVersion Resource")
  update is ArmResourcePatchAsync<WorkflowVersion, WorkflowVersionProperties>;

  @doc("Delete a Workflow Version Resource")
  delete is ArmResourceDeleteWithoutOkAsync<WorkflowVersion>;

  @doc("List Workflow Version Resources")
  listByWorkflow is ArmResourceListByParent<WorkflowVersion>;
}
