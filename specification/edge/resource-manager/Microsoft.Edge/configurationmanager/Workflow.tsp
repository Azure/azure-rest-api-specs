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

@doc("Workflow Properties")
model WorkflowProperties {
  @doc("Workflow template Id")
  @visibility(Lifecycle.Read)
  workflowTemplateId?: string;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Workflow Resource")
@parentResource(Context)
model Workflow is Azure.ResourceManager.ProxyResource<WorkflowProperties> {
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

@armResourceOperations
interface Workflows {
  @doc("Get a Workflow resource")
  get is ArmResourceRead<Workflow>;

  @doc("Create or update a Workflow resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Workflow>;

  @doc("update a Workflow resource")
  update is ArmResourcePatchAsync<Workflow, WorkflowProperties>;

  @doc("Delete a Workflow resource")
  delete is ArmResourceDeleteWithoutOkAsync<Workflow>;

  @doc("List Workflow resources")
  listByContext is ArmResourceListByParent<Workflow>;
}
