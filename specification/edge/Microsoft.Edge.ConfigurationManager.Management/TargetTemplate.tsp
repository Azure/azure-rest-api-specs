import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./SolutionTemplateVersion.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Target Template Properties")
model TargetTemplateProperties {
  @doc("Description of Target template")
  description: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("target spec")
  targetSpec: Record<unknown>;

  @doc("Orchestrator Type")
  orchestratorType?: OrchestratorType;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Target Template Resource, which is a template for creation of Targets")
model TargetTemplate is TrackedResource<TargetTemplateProperties> {
  ...ResourceNameParameter<TargetTemplate>;
  ...EntityTagProperty;
}

@armResourceOperations
interface TargetTemplates {
  @doc("Get a Target Template Resource")
  get is ArmResourceRead<TargetTemplate>;

  @doc("Create or update a Target Template Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<TargetTemplate>;

  @doc("update a Target Template Resource")
  update is ArmResourcePatchAsync<TargetTemplate, TargetTemplateProperties>;

  @doc("Delete a Target Template Resource")
  delete is ArmResourceDeleteWithoutOkAsync<TargetTemplate>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<TargetTemplate>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<TargetTemplate>;
}
