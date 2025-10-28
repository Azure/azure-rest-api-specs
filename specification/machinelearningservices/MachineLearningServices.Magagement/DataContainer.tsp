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
model DataContainer
  is Azure.ResourceManager.ProxyResource<DataContainerProperties, false> {
  ...ResourceNameParameter<
    Resource = DataContainer,
    KeyName = "name",
    SegmentName = "data",
    NamePattern = ""
  >;
}

alias DataContainerOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    @segment("data")
    @key
    name: string;
  }
>;

@armResourceOperations
interface DataContainers {
  /**
   * Get container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryDataContainers_Get")
  get is DataContainerOps.Read<DataContainer>;

  /**
   * Create or update container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryDataContainers_CreateOrUpdate")
  createOrUpdate is DataContainerOps.CreateOrUpdateAsync<DataContainer>;

  /**
   * Delete container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("RegistryDataContainers_Delete")
  delete is DataContainerOps.DeleteWithoutOkAsync<
    DataContainer,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List Data containers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryDataContainers_List")
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
      listViewType?: ListViewType;
    },
    Response = ArmResponse<DataContainerResourceArmPaginatedResult>
  >;
}
alias DataContainerOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    @segment("data")
    @key
    name: string;
  }
>;

@armResourceOperations
interface DataContainerOperationGroup {
  /**
   * Get container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataContainers_Get")
  get is DataContainerOperationGroupOps.Read<DataContainer>;

  /**
   * Create or update container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataContainers_CreateOrUpdate")
  createOrUpdate is DataContainerOperationGroupOps.CreateOrUpdateSync<DataContainer>;

  /**
   * Delete container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataContainers_Delete")
  delete is DataContainerOperationGroupOps.DeleteSync<DataContainer>;

  /**
   * List data containers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataContainers_List")
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
      listViewType?: ListViewType;
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
