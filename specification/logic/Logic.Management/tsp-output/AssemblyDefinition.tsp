import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Logic;
@doc("The assembly definition.")
@parentResource(IntegrationAccount)
model AssemblyDefinition is TrackedResource<AssemblyProperties> {
  @doc("The assembly artifact name.")
  @key("assemblyArtifactName")
  @segment("assemblies")
  name: string;
}

@armResourceOperations
@projectedName("client", "IntegrationAccountAssemblies")
interface AssemblyDefinitions_IntegrationAccountAssemblies {
  @doc("Get an assembly for an integration account.")
  get is ArmResourceRead<AssemblyDefinition>;

  @doc("Create or update an assembly for an integration account.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AssemblyDefinition>;

  @doc("Delete an assembly for an integration account.")
  delete is ArmResourceDeleteSync<AssemblyDefinition>;

  @doc("List the assemblies for an integration account.")
  list is ArmResourceListByParent<AssemblyDefinition>;

  @doc("Get the content callback url for an integration account assembly.")
  listContentCallbackUrl is ArmResourceActionSync<
    AssemblyDefinition,
    void,
    WorkflowTriggerCallbackUrl
  >;
}
