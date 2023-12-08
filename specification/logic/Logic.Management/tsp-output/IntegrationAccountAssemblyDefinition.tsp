import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Logic;
@doc("The assembly definition.")
@parentResource(IntegrationAccount)
model IntegrationAccountAssemblyDefinition
  is TrackedResource<AssemblyProperties> {
  @doc("The assembly artifact name.")
  @path
  @key("assemblyArtifactName")
  @segment("assemblies")
  name: string;
}

@armResourceOperations
interface IntegrationAccountAssemblyDefinitions {
  @doc("Get an assembly for an integration account.")
  get is ArmResourceRead<IntegrationAccountAssemblyDefinition>;
  @doc("Create or update an assembly for an integration account.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<IntegrationAccountAssemblyDefinition>;
  @doc("Delete an assembly for an integration account.")
  delete is ArmResourceDeleteSync<IntegrationAccountAssemblyDefinition>;
  @doc("List the assemblies for an integration account.")
  list is ArmResourceListByParent<IntegrationAccountAssemblyDefinition>;
  @doc("Get the content callback url for an integration account assembly.")
  listContentCallbackUrl is ArmResourceActionSync<
    IntegrationAccountAssemblyDefinition,
    {},
    WorkflowTriggerCallbackUrl
  >;
}
