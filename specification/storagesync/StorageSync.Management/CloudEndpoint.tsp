import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
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
  get is ArmResourceRead<CloudEndpoint, Error = StorageSyncError>;

  /**
   * Create a new CloudEndpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @put
  create is ArmCreateOperation<
    ResourceInstanceParameters<
      CloudEndpoint,
      DefaultBaseParameters<CloudEndpoint>
    >,
    CloudEndpointCreateParameters,
    Response = ArmResourceUpdatedResponse<CloudEndpoint> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    ErrorResponse = StorageSyncError
  >;

  /**
   * Delete a given CloudEndpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    CloudEndpoint,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = StorageSyncError
  >;

  /**
   * Get a CloudEndpoint List.
   */
  listBySyncGroup is ArmResourceListByParent<
    CloudEndpoint,
    Response = ArmResponse<CloudEndpointArray>,
    Error = StorageSyncError
  >;

  /**
   * Pre Backup a given CloudEndpoint.
   */
  @action("prebackup")
  preBackup is ArmResourceActionAsync<
    CloudEndpoint,
    BackupRequest,
    OkResponse,
    Error = StorageSyncError
  >;

  /**
   * Post Backup a given CloudEndpoint.
   */
  @action("postbackup")
  postBackup is ArmResourceActionAsync<
    CloudEndpoint,
    BackupRequest,
    PostBackupResponse,
    Error = StorageSyncError
  >;

  /**
   * Pre Restore a given CloudEndpoint.
   */
  @action("prerestore")
  preRestore is ArmResourceActionAsync<
    CloudEndpoint,
    PreRestoreRequest,
    OkResponse,
    Error = StorageSyncError
  >;

  /**
   * Restore Heartbeat a given CloudEndpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CloudEndpoints_restoreheartbeat")
  restoreheartbeat is ArmResourceActionSync<
    CloudEndpoint,
    void,
    OkResponse,
    Error = StorageSyncError
  >;

  /**
   * Post Restore a given CloudEndpoint.
   */
  @action("postrestore")
  postRestore is ArmResourceActionAsync<
    CloudEndpoint,
    PostRestoreRequest,
    OkResponse,
    Error = StorageSyncError
  >;

  /**
   * Triggers detection of changes performed on Azure File share connected to the specified Azure File Sync Cloud Endpoint.
   */
  triggerChangeDetection is ArmResourceActionAsync<
    CloudEndpoint,
    TriggerChangeDetectionParameters,
    OkResponse,
    Error = StorageSyncError
  >;

  /**
   * Get the AFS file share metadata signing certificate public keys.
   */
  @get
  afsShareMetadataCertificatePublicKeys is ArmResourceActionSync<
    CloudEndpoint,
    void,
    ArmResponse<CloudEndpointAfsShareMetadataCertificatePublicKeys>,
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
