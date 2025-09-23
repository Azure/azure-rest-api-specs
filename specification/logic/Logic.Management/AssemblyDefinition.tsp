import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
@doc("The assembly definition.")
@parentResource(IntegrationAccount)
model AssemblyDefinition
  is ProxyResource<AssemblyProperties, false> {
  ...ResourceNameParameter<
    Resource = AssemblyDefinition,
    KeyName = "assemblyArtifactName",
    SegmentName = "assemblies",
    NamePattern = "[a-zA-Z0-9_.()-]{0,79}$"
  >;
}

@armResourceOperations
interface AssemblyDefinitions {
  @doc("Get an assembly for an integration account.")
  get is ArmResourceRead<AssemblyDefinition>;

  @doc("Create or update an assembly for an integration account.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AssemblyDefinition>;

  @doc("Delete an assembly for an integration account.")
  delete is ArmResourceDeleteSync<AssemblyDefinition>;

  @doc("List the assemblies for an integration account.")
  list is ArmResourceListByParent<
    AssemblyDefinition,
    Response = ArmResponse<AssemblyCollection>
  >;

  @doc("Get the content callback url for an integration account assembly.")
  listContentCallbackUrl is ArmResourceActionSync<
    AssemblyDefinition,
    void,
    ArmResponse<WorkflowTriggerCallbackUrl>
  >;
}

@@doc(AssemblyDefinition.name, "The assembly artifact name.");
@@doc(AssemblyDefinition.properties, "The assembly properties.");
@@doc(AssemblyDefinitions.createOrUpdate::parameters.resource,
  "The assembly artifact."
);
