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

@armResourceOperations
interface ModelContainerOps
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
        /** Container name. This is case-sensitive. */
        @path
        @segment("models")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
        modelName: string,
      }
    > {}

@armResourceOperations
interface ModelContainers {
  /**
   * Get container.
   */
  @summary("Get container.")
  get is ModelContainerOps.Read<ModelContainer>;

  /**
   * Create or update model container.
   */
  @Azure.Core.useFinalStateVia("original-uri")
  @summary("Create or update model container.")
  createOrUpdate is ModelContainerOps.CreateOrUpdateAsync<
    ModelContainer,
    Response = ArmResourceUpdatedResponse<ModelContainer> | (ArmResourceCreatedResponse<
      ModelContainer,
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete container.")
  delete is ModelContainerOps.DeleteWithoutOkAsync<
    ModelContainer,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List model containers.
   */
  @summary("List model containers.")
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
      listViewType?: ListViewType = ListViewType.ActiveOnly;
    },
    Response = ArmResponse<ModelContainerResourceArmPaginatedResult>
  >;
}
@armResourceOperations
interface ModelContainerOperationGroupOps
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
        /** Container name. This is case-sensitive. */
        @path
        @segment("models")
        @key
        name: string,
      }
    > {}

@armResourceOperations
interface ModelContainerOperationGroup {
  /**
   * Get container.
   */
  @summary("Get container.")
  get is ModelContainerOperationGroupOps.Read<ModelContainer>;

  /**
   * Create or update container.
   */
  @summary("Create or update container.")
  createOrUpdate is ModelContainerOperationGroupOps.CreateOrUpdateSync<ModelContainer>;

  /**
   * Delete container.
   */
  @summary("Delete container.")
  delete is ModelContainerOperationGroupOps.DeleteSync<ModelContainer>;

  /**
   * List model containers.
   */
  @summary("List model containers.")
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
      listViewType?: ListViewType = ListViewType.ActiveOnly;
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
