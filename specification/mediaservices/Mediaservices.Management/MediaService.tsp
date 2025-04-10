import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * A Media Services account.
 */
model MediaService
  is Azure.ResourceManager.TrackedResource<MediaServiceProperties> {
  ...ResourceNameParameter<
    Resource = MediaService,
    KeyName = "accountName",
    SegmentName = "mediaservices",
    NamePattern = ""
  >;

  /**
   * The Managed Identity for the Media Services account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: MediaServiceIdentity;
}

@armResourceOperations
interface MediaServiceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = MediaService,
        KeyName = "accountName",
        SegmentName = "mediaservices",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface MediaServices {
  /**
   * Get the details of a Media Services account
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Mediaservices_Get")
  get is MediaServiceOps.Read<MediaService>;

  /**
   * Creates or updates a Media Services account
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Mediaservices_CreateOrUpdate")
  createOrUpdate is MediaServiceOps.CreateOrUpdateAsync<
    MediaService,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates an existing Media Services account
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("Mediaservices_Update")
  update is MediaServiceOps.CustomPatchAsync<
    MediaService,
    PatchModel = MediaServiceUpdate,
    Response = ArmAcceptedLroResponse & {
      @bodyRoot
      _: MediaService;
    }
  >;

  /**
   * Deletes a Media Services account
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Mediaservices_Delete")
  delete is MediaServiceOps.DeleteSync<MediaService>;

  /**
   * List Media Services accounts in the resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Mediaservices_List")
  list is MediaServiceOps.List<
    MediaService,
    Response = ArmResponse<MediaServiceCollection>
  >;

  /**
   * List Media Services accounts in the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Mediaservices_ListBySubscription")
  listBySubscription is MediaServiceOps.ListBySubscription<
    MediaService,
    Response = ArmResponse<MediaServiceCollection>
  >;

  /**
   * Synchronizes storage account keys for a storage account associated with the Media Service account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Mediaservices_SyncStorageKeys")
  syncStorageKeys is MediaServiceOps.ActionSync<
    MediaService,
    SyncStorageKeysInput,
    OkResponse
  >;

  /**
   * List all the media edge policies associated with the Media Services account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Mediaservices_ListEdgePolicies")
  listEdgePolicies is MediaServiceOps.ActionSync<
    MediaService,
    ListEdgePoliciesInput,
    ArmResponse<EdgePolicies>
  >;

  /**
   * Get a live event operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{operationId}")
  @operationId("LiveEvents_AsyncOperation")
  asyncOperation is MediaServiceOps.ActionSync<
    MediaService,
    void,
    ArmResponse<AsyncOperationResult>,
    Parameters = {
      /**
       * The ID of an ongoing async operation.
       */
      @minLength(1)
      @path
      operationId: string;
    }
  >;

  /**
   * Get a Live Output operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{operationId}")
  @operationId("LiveOutputs_AsyncOperation")
  liveOutputsAsyncOperation is MediaServiceOps.ActionSync<
    MediaService,
    void,
    ArmResponse<AsyncOperationResult>,
    Parameters = {
      /**
       * The ID of an ongoing async operation.
       */
      @minLength(1)
      @path
      operationId: string;
    }
  >;

  /**
   * Get a streaming endpoint operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{operationId}")
  @operationId("StreamingEndpoints_AsyncOperation")
  streamingEndpointsAsyncOperation is MediaServiceOps.ActionSync<
    MediaService,
    void,
    ArmResponse<AsyncOperationResult>,
    Parameters = {
      /**
       * The ID of an ongoing async operation.
       */
      @minLength(1)
      @path
      operationId: string;
    }
  >;
}
@armResourceOperations
interface MediaServicesOperationResultOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** locations */
        @path @segment("locations") locationName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = MediaService,
        KeyName = "operationId",
        SegmentName = "mediaServicesOperationResults",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface MediaServicesOperationResults {
  /**
   * Get media service operation result.
   */
  get is MediaServicesOperationResultOps.Read<
    MediaService,
    Response = ArmResponse<MediaService> | AcceptedResponse
  >;
}

@@doc(MediaService.name, "The Media Services account name.");
@@doc(MediaService.properties, "The resource properties.");
@@doc(MediaServices.createOrUpdate::parameters.resource,
  "The request parameters"
);
@@doc(MediaServices.update::parameters.properties, "The request parameters");
@@doc(MediaServices.syncStorageKeys::parameters.body, "The request parameters");
@@doc(MediaServices.listEdgePolicies::parameters.body,
  "The request parameters"
);
