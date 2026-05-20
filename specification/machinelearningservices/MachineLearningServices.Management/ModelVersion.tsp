import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ModelContainer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(ModelContainer)
model ModelVersion
  is Azure.ResourceManager.ProxyResource<ModelVersionProperties, false> {
  ...ResourceNameParameter<
    Resource = ModelVersion,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ModelVersionOps
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

        /** Container name. This is case-sensitive. */
        @path
        @segment("models")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
        modelName: string,
      },
      {
        /** Version identifier. This is case-sensitive. */
        @path
        @segment("versions")
        @key
        version: string,
      }
    > {}

@armResourceOperations
interface ModelVersions {
  /**
   * Get version.
   */
  @summary("Get version.")
  get is ModelVersionOps.Read<ModelVersion>;

  /**
   * Create or update version.
   */
  @Azure.Core.useFinalStateVia("original-uri")
  @summary("Create or update version.")
  createOrUpdate is ModelVersionOps.CreateOrUpdateAsync<
    ModelVersion,
    Response = ArmResourceUpdatedResponse<ModelVersion> | (ArmResourceCreatedResponse<
      ModelVersion,
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
   * Delete version.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API returns additional response codes for LRO delete"
  @summary("Delete version.")
  delete is ModelVersionOps.DeleteWithoutOkAsync<
    ModelVersion,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List versions.
   */
  @summary("List versions.")
  list is ModelVersionOps.List<
    ModelVersion,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * Ordering of list.
       */
      @query("$orderBy")
      $orderBy?: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      $top?: int32;

      /**
       * Version identifier.
       */
      @query("version")
      version?: string;

      /**
       * Model description.
       */
      @query("description")
      description?: string;

      /**
       * Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2
       */
      @query("tags")
      tags?: string;

      /**
       * Comma-separated list of property names (and optionally values). Example: prop1,prop2=value2
       */
      @query("properties")
      properties?: string;

      /**
       * View type for including/excluding (for example) archived entities.
       */
      @query("listViewType")
      listViewType?: ListViewType = ListViewType.ActiveOnly;
    },
    Response = ArmResponse<ModelVersionResourceArmPaginatedResult>
  >;

  /**
   * Generate a storage location and credential for the client to upload a model asset to.
   */
  @action("startPendingUpload")
  @summary("Generate a storage location and credential for the client to upload a model asset to.")
  createOrGetStartPendingUpload is ModelVersionOps.ActionSync<
    ModelVersion,
    PendingUploadRequestDto,
    ArmResponse<PendingUploadResponseDto>
  >;
}
@armResourceOperations
interface ModelVersionOperationGroupOps
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

        /** Container name. This is case-sensitive. */
        @path
        @segment("models")
        @key
        name: string,
      },
      {
        /** Version identifier. This is case-sensitive. */
        @path
        @segment("versions")
        @key
        version: string,
      }
    > {}

@armResourceOperations
interface ModelVersionOperationGroup {
  /**
   * Get version.
   */
  @summary("Get version.")
  get is ModelVersionOperationGroupOps.Read<ModelVersion>;

  /**
   * Create or update version.
   */
  @summary("Create or update version.")
  createOrUpdate is ModelVersionOperationGroupOps.CreateOrUpdateSync<ModelVersion>;

  /**
   * Delete version.
   */
  @summary("Delete version.")
  delete is ModelVersionOperationGroupOps.DeleteSync<ModelVersion>;

  /**
   * List model versions.
   */
  @summary("List model versions.")
  list is ModelVersionOperationGroupOps.List<
    ModelVersion,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * Ordering of list.
       */
      @query("$orderBy")
      $orderBy?: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      $top?: int32;

      /**
       * Model version.
       */
      @query("version")
      version?: string;

      /**
       * Model description.
       */
      @query("description")
      description?: string;

      /**
       * Number of initial results to skip.
       */
      @query("offset")
      offset?: int32;

      /**
       * Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2
       */
      @query("tags")
      tags?: string;

      /**
       * Comma-separated list of property names (and optionally values). Example: prop1,prop2=value2
       */
      @query("properties")
      properties?: string;

      /**
       * Name of the feed.
       */
      @query("feed")
      feed?: string;

      /**
       * View type for including/excluding (for example) archived entities.
       */
      @query("listViewType")
      listViewType?: ListViewType = ListViewType.ActiveOnly;
    },
    Response = ArmResponse<ModelVersionResourceArmPaginatedResult>
  >;

  /**
   * Publish version asset into registry.
   */
  @summary("Publish version asset into registry.")
  publish is ModelVersionOperationGroupOps.ActionAsync<
    ModelVersion,
    DestinationAsset,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;
}

@@doc(ModelVersion.name, "Version identifier. This is case-sensitive.");
@@doc(ModelVersion.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(ModelVersions.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);
@@doc(ModelVersions.createOrGetStartPendingUpload::parameters.body,
  "Pending upload request object"
);
@@doc(ModelVersionOperationGroup.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);
@@doc(ModelVersionOperationGroup.publish::parameters.body,
  "Destination registry info"
);
