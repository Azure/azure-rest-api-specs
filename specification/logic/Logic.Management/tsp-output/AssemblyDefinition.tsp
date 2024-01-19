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
@doc("The assembly definition.")
@parentResource(IntegrationAccount)
model AssemblyDefinition is TrackedResource<AssemblyProperties> {
  @doc("The assembly artifact name.")
  @path
  @key("assemblyArtifactName")
  @segment("assemblies")
  name: string;
}

@armResourceOperations
interface AssemblyDefinitions {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get an assembly for an integration account.")
  @operationId("IntegrationAccountAssemblies_Get")
  get is ArmResourceRead<AssemblyDefinition>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update an assembly for an integration account.")
  @operationId("IntegrationAccountAssemblies_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AssemblyDefinition>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete an assembly for an integration account.")
  @operationId("IntegrationAccountAssemblies_Delete")
  delete is ArmResourceDeleteSync<AssemblyDefinition>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List the assemblies for an integration account.")
  @operationId("IntegrationAccountAssemblies_List")
  list is ArmResourceListByParent<AssemblyDefinition>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the content callback url for an integration account assembly.")
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
