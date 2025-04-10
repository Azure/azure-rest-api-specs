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
/**
 * The assembly definition.
 */
@parentResource(IntegrationAccount)
model AssemblyDefinition
  is Azure.ResourceManager.TrackedResource<AssemblyProperties, false> {
  ...ResourceNameParameter<
    Resource = AssemblyDefinition,
    KeyName = "assemblyArtifactName",
    SegmentName = "assemblies",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AssemblyDefinitions {
  /**
   * Get an assembly for an integration account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationAccountAssemblies_Get")
  get is ArmResourceRead<AssemblyDefinition>;

  /**
   * Create or update an assembly for an integration account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationAccountAssemblies_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AssemblyDefinition>;

  /**
   * Delete an assembly for an integration account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationAccountAssemblies_Delete")
  delete is ArmResourceDeleteSync<AssemblyDefinition>;

  /**
   * List the assemblies for an integration account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationAccountAssemblies_List")
  list is ArmResourceListByParent<
    AssemblyDefinition,
    Response = ArmResponse<AssemblyCollection>
  >;

  /**
   * Get the content callback url for an integration account assembly.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationAccountAssemblies_ListContentCallbackUrl")
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
