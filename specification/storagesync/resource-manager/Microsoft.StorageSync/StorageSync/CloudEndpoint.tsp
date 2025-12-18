import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./SyncGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageSync;
/**
 * Cloud Endpoint object.
 */
@parentResource(SyncGroup)
model CloudEndpoint
  is Azure.ResourceManager.ProxyResource<CloudEndpointProperties> {
  ...ResourceNameParameter<
    Resource = CloudEndpoint,
    KeyName = "cloudEndpointName",
    SegmentName = "cloudEndpoints",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CloudEndpoints {
  /**
   * Get a given CloudEndpoint.
   */
  get is ArmResourceRead<
    CloudEndpoint,
    Response = CloudEndpoint & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    },
    Error = StorageSyncError
  >;

  /**
   * Create a new CloudEndpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  @Azure.Core.useFinalStateVia("location")
  create is Legacy.CreateOrReplaceAsync<
    CloudEndpoint,
    CloudEndpointCreateParameters,
    Response = (ArmResourceUpdatedResponse<CloudEndpoint> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }) | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = CloudEndpoint> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("Request id")
      requestId?: string;
    }),
    Error = StorageSyncError
  >;

  /**
   * Delete a given CloudEndpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("location")
  delete is ArmResourceDeleteWithoutOkAsync<
    CloudEndpoint,
    Response = (ArmDeletedResponse & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }) | (ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("Request id")
      requestId?: string;
    }) | ArmDeletedNoContentResponse,
    Error = StorageSyncError
  >;

  /**
   * Get a CloudEndpoint List.
   */
  listBySyncGroup is ArmResourceListByParent<
    CloudEndpoint,
    Response = ArmResponse<CloudEndpointArray> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    },
    Error = StorageSyncError
  >;

  /**
   * Pre Backup a given CloudEndpoint.
   */
  @action("prebackup")
  preBackup is ArmResourceActionSync<
    CloudEndpoint,
    BackupRequest,
    Response = (OkResponse & {
      @header("Location")
      @doc("Operation Status Location URI")
      location?: string;

      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }) | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }),
    Error = StorageSyncError
  >;

  /**
   * Post Backup a given CloudEndpoint.
   */
  @action("postbackup")
  postBackup is ArmResourceActionSync<
    CloudEndpoint,
    BackupRequest,
    (PostBackupResponse & {
      @header("Location")
      @doc("Operation Status Location URI")
      location?: string;

      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }) | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = PostBackupResponse> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }),
    Error = StorageSyncError
  >;

  /**
   * Pre Restore a given CloudEndpoint.
   */
  @action("prerestore")
  preRestore is ArmResourceActionSync<
    CloudEndpoint,
    PreRestoreRequest,
    OkResponse | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }),
    Error = StorageSyncError
  >;

  /**
   * Restore Heartbeat a given CloudEndpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("CloudEndpoints_restoreheartbeat")
  restoreheartbeat is ArmResourceActionSync<
    CloudEndpoint,
    void,
    OkResponse & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    },
    Error = StorageSyncError
  >;

  /**
   * Post Restore a given CloudEndpoint.
   */
  @action("postrestore")
  postRestore is ArmResourceActionSync<
    CloudEndpoint,
    PostRestoreRequest,
    OkResponse | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }),
    Error = StorageSyncError
  >;

  /**
   * Triggers detection of changes performed on Azure File share connected to the specified Azure File Sync Cloud Endpoint.
   */
  triggerChangeDetection is ArmResourceActionSync<
    CloudEndpoint,
    TriggerChangeDetectionParameters,
    OkResponse | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    }),
    Error = StorageSyncError
  >;

  /**
   * Get the AFS file share metadata signing certificate public keys.
   */
  @get
  afsShareMetadataCertificatePublicKeys is ArmResourceActionSync<
    CloudEndpoint,
    void,
    ArmResponse<CloudEndpointAfsShareMetadataCertificatePublicKeys> & {
      @header("x-ms-correlation-request-id")
      @doc("correlation request id.")
      correlationRequestId?: string;

      @header("x-ms-request-id")
      @doc("request id.")
      requestId?: string;
    },
    Error = StorageSyncError
  >;
}

@@doc(CloudEndpoint.name, "Name of Cloud Endpoint object.");
@@doc(CloudEndpoint.properties, "Cloud Endpoint properties.");
@@doc(CloudEndpoints.create::parameters.resource,
  "Body of Cloud Endpoint resource."
);
@@doc(CloudEndpoints.preBackup::parameters.body, "Body of Backup request.");
@@doc(CloudEndpoints.postBackup::parameters.body, "Body of Backup request.");
@@doc(CloudEndpoints.preRestore::parameters.body,
  "Body of Cloud Endpoint object."
);
@@doc(CloudEndpoints.postRestore::parameters.body,
  "Body of Cloud Endpoint object."
);
@@doc(CloudEndpoints.triggerChangeDetection::parameters.body,
  "Trigger Change Detection Action parameters."
);
