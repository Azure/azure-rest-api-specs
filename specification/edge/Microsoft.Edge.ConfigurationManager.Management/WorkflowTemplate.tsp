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

namespace Microsoft.Edge;

@doc("Workflow Template Properties")
model WorkflowTemplateProperties {
  @doc("Description of Workflow template")
  description: string;

  @doc("Latest Workflow template version")
  latestVersion?: string;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Workflow Template Resource")
model WorkflowTemplate is TrackedResource<WorkflowTemplateProperties> {
  ...ResourceNameParameter<WorkflowTemplate>;
  ...EntityTagProperty;
}

@armResourceOperations
interface WorkflowTemplates {
  @doc("Get a Workflow Template Resource")
  get is ArmResourceRead<WorkflowTemplate>;

  @doc("Create or update a Workflow Template Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<WorkflowTemplate>;

  @doc("update a Workflow Template Resource")
  update is ArmResourcePatchSync<WorkflowTemplate, WorkflowTemplateProperties>;

  @doc("Delete a Workflow Template Resource")
  delete is ArmResourceDeleteWithoutOkAsync<WorkflowTemplate>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<WorkflowTemplate>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<WorkflowTemplate>;
}
