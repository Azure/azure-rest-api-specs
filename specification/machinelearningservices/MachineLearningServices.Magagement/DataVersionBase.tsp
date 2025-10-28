import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataContainer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(DataContainer)
model DataVersionBase
  is Azure.ResourceManager.ProxyResource<DataVersionBaseProperties, false> {
  ...ResourceNameParameter<
    Resource = DataVersionBase,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

alias DataVersionBaseOps = Azure.ResourceManager.Legacy.LegacyOperations<
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

    /** Container name. */
    @path
    @segment("data")
    @key
    name: string;
  },
  {
    /** Version identifier. */
    @path
    @segment("versions")
    @key
    version: string;
  }
>;

@armResourceOperations
interface DataVersionBases {
  /**
   * Get version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryDataVersions_Get")
  get is DataVersionBaseOps.Read<DataVersionBase>;

  /**
   * Create or update version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryDataVersions_CreateOrUpdate")
  createOrUpdate is DataVersionBaseOps.CreateOrUpdateAsync<DataVersionBase>;

  /**
   * Delete version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("RegistryDataVersions_Delete")
  delete is DataVersionBaseOps.DeleteWithoutOkAsync<
    DataVersionBase,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List data versions in the data container
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryDataVersions_List")
  list is DataVersionBaseOps.List<
    DataVersionBase,
    Parameters = {
      /**
       * Please choose OrderBy value from ['createdtime', 'modifiedtime']
       */
      @query("$orderBy")
      $orderBy?: string;

      /**
       * Top count of results, top count cannot be greater than the page size.
       *                               If topCount > page size, results with be default page size count will be returned
       */
      @query("$top")
      $top?: int32;

      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2
       */
      @query("$tags")
      $tags?: string;

      /**
       * [ListViewType.ActiveOnly, ListViewType.ArchivedOnly, ListViewType.All]View type for including/excluding (for example) archived entities.
       */
      @query("listViewType")
      listViewType?: ListViewType;
    },
    Response = ArmResponse<DataVersionBaseResourceArmPaginatedResult>
  >;

  /**
   * Generate a storage location and credential for the client to upload a data asset to.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegistryDataVersions_CreateOrGetStartPendingUpload")
  @action("startPendingUpload")
  createOrGetStartPendingUpload is DataVersionBaseOps.ActionSync<
    DataVersionBase,
    PendingUploadRequestDto,
    ArmResponse<PendingUploadResponseDto>
  >;
}
alias DataVersionOps = Azure.ResourceManager.Legacy.LegacyOperations<
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

    /** Container name. */
    @path
    @segment("data")
    @key
    name: string;
  },
  {
    /** Version identifier. */
    @path
    @segment("versions")
    @key
    version: string;
  }
>;

@armResourceOperations
interface DataVersions {
  /**
   * Get version.
   */
  get is DataVersionOps.Read<DataVersionBase>;

  /**
   * Create or update version.
   */
  createOrUpdate is DataVersionOps.CreateOrUpdateSync<DataVersionBase>;

  /**
   * Delete version.
   */
  delete is DataVersionOps.DeleteSync<DataVersionBase>;

  /**
   * List data versions in the data container
   */
  list is DataVersionOps.List<
    DataVersionBase,
    Parameters = {
      /**
       * Please choose OrderBy value from ['createdtime', 'modifiedtime']
       */
      @query("$orderBy")
      $orderBy?: string;

      /**
       * Top count of results, top count cannot be greater than the page size.
       *                               If topCount > page size, results with be default page size count will be returned
       */
      @query("$top")
      $top?: int32;

      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2
       */
      @query("$tags")
      $tags?: string;

      /**
       * [ListViewType.ActiveOnly, ListViewType.ArchivedOnly, ListViewType.All]View type for including/excluding (for example) archived entities.
       */
      @query("listViewType")
      listViewType?: ListViewType;
    },
    Response = ArmResponse<DataVersionBaseResourceArmPaginatedResult>
  >;

  /**
   * Publish version asset into registry.
   */
  publish is DataVersionOps.ActionAsync<
    DataVersionBase,
    DestinationAsset,
    OkResponse
  >;
}

@@doc(DataVersionBase.name, "Version identifier.");
@@doc(DataVersionBase.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(DataVersionBases.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);
@@doc(DataVersionBases.createOrGetStartPendingUpload::parameters.body,
  "Pending upload request object"
);
@@doc(DataVersions.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);
@@doc(DataVersions.publish::parameters.body, "Destination registry info");
