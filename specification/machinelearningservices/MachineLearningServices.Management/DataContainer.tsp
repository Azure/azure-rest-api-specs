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
using Azure.Core;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(Registry)
model DataContainer
  is Azure.ResourceManager.ProxyResource<DataContainerProperties, false> {
  ...ResourceNameParameter<
    Resource = DataContainer,
    KeyName = "name",
    SegmentName = "data",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DataContainerOps
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
        @segment("data")
        @key
        name: string,
      }
    > {}

@armResourceOperations
interface DataContainerwithNamePatternOps
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
        @segment("data")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
        name: string,
      }
    > {}

@armResourceOperations
interface DataContainers {
  /**
   * Get container.
   */
  @summary("Get container.")
  get is DataContainerOps.Read<DataContainer>;

  /**
   * Create or update container.
   */
  @useFinalStateVia("original-uri")
  @summary("Create or update container.")
  createOrUpdate is DataContainerwithNamePatternOps.CreateOrUpdateAsync<
    DataContainer,
    Response = ArmResourceUpdatedResponse<DataContainer> | (ArmResourceCreatedResponse<
      DataContainer,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = CodeContainer> &
        Azure.Core.Foundations.RetryAfterHeader
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
  delete is DataContainerOps.DeleteWithoutOkAsync<
    DataContainer,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List Data containers.
   */
  @summary("List Data containers.")
  list is DataContainerOps.List<
    DataContainer,
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
    Response = ArmResponse<DataContainerResourceArmPaginatedResult>
  >;
}
@armResourceOperations
interface DataContainerOperationGroupOps
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
        @segment("data")
        @key
        name: string,
      }
    > {}

@armResourceOperations
interface DataContainerOperationGroup {
  /**
   * Get container.
   */
  @summary("Get container.")
  get is DataContainerOperationGroupOps.Read<DataContainer>;

  /**
   * Create or update container.
   */
  @summary("Create or update container.")
  createOrUpdate is DataContainerOperationGroupOps.CreateOrUpdateSync<DataContainer>;

  /**
   * Delete container.
   */
  @summary("Delete container.")
  delete is DataContainerOperationGroupOps.DeleteSync<DataContainer>;

  /**
   * List data containers.
   */
  @summary("List data containers.")
  list is DataContainerOperationGroupOps.List<
    DataContainer,
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
    Response = ArmResponse<DataContainerResourceArmPaginatedResult>
  >;
}

@@doc(DataContainer.name, "Container name.");
@@doc(DataContainer.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(DataContainers.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);
@@doc(DataContainerOperationGroup.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);
