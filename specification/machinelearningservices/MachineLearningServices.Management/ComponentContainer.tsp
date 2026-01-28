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

@armResourceOperations
interface ComponentContainerOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of Azure Machine Learning registry. This is case-insensitive */
        @path
        @segment("registries")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{2,32}$")
        registryName: string,
      },
      {
        /** Container name. */
        @path
        @segment("components")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
        componentName: string,
      }
    > {}

@armResourceOperations
interface ComponentContainers {
  /**
   * Get container.
   */
  @summary("Get container.")
  get is ComponentContainerOps.Read<ComponentContainer>;

  /**
   * Create or update container.
   */
  @Azure.Core.useFinalStateVia("original-uri")
  @summary("Create or update container.")
  createOrUpdate is ComponentContainerOps.CreateOrUpdateAsync<
    ComponentContainer,
    Response = ArmResourceUpdatedResponse<ComponentContainer> | (ArmResourceCreatedResponse<
      ComponentContainer,
      ArmAsyncOperationHeader
    > & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    })
  >;

  /**
   * Delete container.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API returns additional response codes for LRO delete"
  @summary("Delete container.")
  delete is ComponentContainerOps.DeleteWithoutOkAsync<
    ComponentContainer,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List containers.
   */
  @summary("List containers.")
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
@armResourceOperations
interface ComponentContainerOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of Azure Machine Learning workspace. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
        workspaceName: string,
      },
      {
        /** Container name. */
        @path
        @segment("components")
        @key
        name: string,
      }
    > {}

@armResourceOperations
interface ComponentContainerOperationGroup {
  /**
   * Get container.
   */
  @summary("Get container.")
  get is ComponentContainerOperationGroupOps.Read<ComponentContainer>;

  /**
   * Create or update container.
   */
  @summary("Create or update container.")
  createOrUpdate is ComponentContainerOperationGroupOps.CreateOrUpdateSync<ComponentContainer>;

  /**
   * Delete container.
   */
  @summary("Delete container.")
  delete is ComponentContainerOperationGroupOps.DeleteSync<ComponentContainer>;

  /**
   * List component containers.
   */
  @summary("List component containers.")
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
      listViewType?: ListViewType = ListViewType.ActiveOnly;
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
