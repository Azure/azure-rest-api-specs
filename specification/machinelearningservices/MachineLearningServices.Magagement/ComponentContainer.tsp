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
model ComponentContainer
  is Azure.ResourceManager.ProxyResource<ComponentContainerProperties, false> {
  ...ResourceNameParameter<
    Resource = ComponentContainer,
    KeyName = "componentName",
    SegmentName = "components",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$"
  >;
}

alias ComponentContainerOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    /** Container name. */
    @path
    @segment("components")
    @key
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
    componentName: string;
  }
>;

@armResourceOperations
interface ComponentContainers {
  /**
   * Get container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryComponentContainers_Get")
  get is ComponentContainerOps.Read<ComponentContainer>;

  /**
   * Create or update container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryComponentContainers_CreateOrUpdate")
  createOrUpdate is ComponentContainerOps.CreateOrUpdateAsync<ComponentContainer>;

  /**
   * Delete container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("RegistryComponentContainers_Delete")
  delete is ComponentContainerOps.DeleteWithoutOkAsync<
    ComponentContainer,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List containers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryComponentContainers_List")
  list is ComponentContainerOps.List<
    ComponentContainer,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    },
    Response = ArmResponse<ComponentContainerResourceArmPaginatedResult>
  >;
}
alias ComponentContainerOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    /** Container name. */
    @path
    @segment("components")
    @key
    name: string;
  }
>;

@armResourceOperations
interface ComponentContainerOperationGroup {
  /**
   * Get container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ComponentContainers_Get")
  get is ComponentContainerOperationGroupOps.Read<ComponentContainer>;

  /**
   * Create or update container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ComponentContainers_CreateOrUpdate")
  createOrUpdate is ComponentContainerOperationGroupOps.CreateOrUpdateSync<ComponentContainer>;

  /**
   * Delete container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ComponentContainers_Delete")
  delete is ComponentContainerOperationGroupOps.DeleteSync<ComponentContainer>;

  /**
   * List component containers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ComponentContainers_List")
  list is ComponentContainerOperationGroupOps.List<
    ComponentContainer,
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
    Response = ArmResponse<ComponentContainerResourceArmPaginatedResult>
  >;
}

@@doc(ComponentContainer.name, "Container name.");
@@doc(ComponentContainer.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(ComponentContainers.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);
@@doc(ComponentContainerOperationGroup.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);
