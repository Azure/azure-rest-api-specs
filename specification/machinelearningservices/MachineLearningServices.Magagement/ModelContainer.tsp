import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Registry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(Registry)
model ModelContainer
  is Azure.ResourceManager.ProxyResource<ModelContainerProperties, false> {
  ...ResourceNameParameter<
    Resource = ModelContainer,
    KeyName = "modelName",
    SegmentName = "models",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$"
  >;
}

alias ModelContainerOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of Azure Machine Learning registry. This is case-insensitive */
    @path
    @segment("registries")
    @key
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{2,32}$")
    registryName: string;
  },
  {
    /** Container name. This is case-sensitive. */
    @path
    @segment("models")
    @key
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    modelName: string;
  }
>;

@armResourceOperations
interface ModelContainers {
  /**
   * Get container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryModelContainers_Get")
  get is ModelContainerOps.Read<ModelContainer>;

  /**
   * Create or update model container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryModelContainers_CreateOrUpdate")
  createOrUpdate is ModelContainerOps.CreateOrUpdateAsync<ModelContainer>;

  /**
   * Delete container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("RegistryModelContainers_Delete")
  delete is ModelContainerOps.DeleteWithoutOkAsync<
    ModelContainer,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List model containers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryModelContainers_List")
  list is ModelContainerOps.List<
    ModelContainer,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * View type for including/excluding (for example) archived entities.
       */
      @query("listViewType")
      listViewType?: ListViewType;
    },
    Response = ArmResponse<ModelContainerResourceArmPaginatedResult>
  >;
}
alias ModelContainerOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of Azure Machine Learning workspace. */
    @path
    @segment("workspaces")
    @key
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
    workspaceName: string;
  },
  {
    /** Container name. This is case-sensitive. */
    @path
    @segment("models")
    @key
    name: string;
  }
>;

@armResourceOperations
interface ModelContainerOperationGroup {
  /**
   * Get container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ModelContainers_Get")
  get is ModelContainerOperationGroupOps.Read<ModelContainer>;

  /**
   * Create or update container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ModelContainers_CreateOrUpdate")
  createOrUpdate is ModelContainerOperationGroupOps.CreateOrUpdateSync<ModelContainer>;

  /**
   * Delete container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ModelContainers_Delete")
  delete is ModelContainerOperationGroupOps.DeleteSync<ModelContainer>;

  /**
   * List model containers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ModelContainers_List")
  list is ModelContainerOperationGroupOps.List<
    ModelContainer,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * Maximum number of results to return.
       */
      @query("count")
      count?: int32;

      /**
       * View type for including/excluding (for example) archived entities.
       */
      @query("listViewType")
      listViewType?: ListViewType;
    },
    Response = ArmResponse<ModelContainerResourceArmPaginatedResult>
  >;
}

@@doc(ModelContainer.name, "Container name. This is case-sensitive.");
@@doc(ModelContainer.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(ModelContainers.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);
@@doc(ModelContainerOperationGroup.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);
