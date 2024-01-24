import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
/**
 * The assembly definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(IntegrationAccount)
@Azure.ResourceManager.Private.armResourceInternal(AssemblyProperties)
@includeInapplicableMetadataInPayload(false)
model AssemblyDefinition extends Resource {
  /**
   * The assembly artifact name.
   */
  @path
  @key("assemblyArtifactName")
  @segment("assemblies")
  name: string;

  /**
   * The assembly properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: AssemblyProperties;
}

@armResourceOperations
interface AssemblyDefinitions {
  /**
   * Get an assembly for an integration account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationAccountAssemblies_Get")
  get is ArmResourceRead<AssemblyDefinition>;

  /**
   * Create or update an assembly for an integration account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationAccountAssemblies_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AssemblyDefinition>;

  /**
   * Delete an assembly for an integration account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationAccountAssemblies_Delete")
  delete is ArmResourceDeleteSync<AssemblyDefinition>;

  /**
   * List the assemblies for an integration account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationAccountAssemblies_List")
  list is ArmResourceListByParent<AssemblyDefinition>;

  /**
   * Get the content callback url for an integration account assembly.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationAccountAssemblies_ListContentCallbackUrl")
  listContentCallbackUrl is ArmResourceActionSync<
    AssemblyDefinition,
    void,
    WorkflowTriggerCallbackUrl
  >;
}

@@projectedName(AssemblyDefinitions.createOrUpdate::parameters.resource,
  "json",
  "assemblyArtifact"
);
@@extension(AssemblyDefinitions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "assemblyArtifact"
);
@@doc(AssemblyDefinitions.createOrUpdate::parameters.resource,
  "The assembly artifact."
);
