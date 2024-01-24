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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(SyncGroup)
@Azure.ResourceManager.Private.armResourceInternal(CloudEndpointProperties)
@includeInapplicableMetadataInPayload(false)
model CloudEndpoint extends ProxyResourceBase {
  /**
   * Name of Cloud Endpoint object.
   */
  @path
  @key("cloudEndpointName")
  @segment("cloudEndpoints")
  name: string;

  /**
   * Cloud Endpoint properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CloudEndpointProperties;
}

@armResourceOperations
interface CloudEndpoints {
  /**
   * Get a given CloudEndpoint.
   */
  get is ArmResourceRead<CloudEndpoint>;

  /**
   * Create a new CloudEndpoint.
   */
  create is ArmResourceCreateOrReplaceAsync<CloudEndpoint>;

  /**
   * Delete a given CloudEndpoint.
   */
  delete is ArmResourceDeleteAsync<CloudEndpoint>;

  /**
   * Get a CloudEndpoint List.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CloudEndpoints_ListBySyncGroup")
  listBySyncGroup is ArmResourceListByParent<CloudEndpoint>;

  /**
   * Pre Backup a given CloudEndpoint.
   */
  preBackup is ArmResourceActionAsync<CloudEndpoint, BackupRequest, void>;

  /**
   * Post Backup a given CloudEndpoint.
   */
  postBackup is ArmResourceActionAsync<
    CloudEndpoint,
    BackupRequest,
    PostBackupResponse
  >;

  /**
   * Pre Restore a given CloudEndpoint.
   */
  preRestore is ArmResourceActionAsync<CloudEndpoint, PreRestoreRequest, void>;

  /**
   * Restore Heartbeat a given CloudEndpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CloudEndpoints_restoreheartbeat")
  restoreheartbeat is ArmResourceActionSync<CloudEndpoint, void, void>;

  /**
   * Post Restore a given CloudEndpoint.
   */
  postRestore is ArmResourceActionAsync<
    CloudEndpoint,
    PostRestoreRequest,
    void
  >;

  /**
   * Triggers detection of changes performed on Azure File share connected to the specified Azure File Sync Cloud Endpoint.
   */
  triggerChangeDetection is ArmResourceActionAsync<
    CloudEndpoint,
    TriggerChangeDetectionParameters,
    void
  >;

  /**
   * Get the AFS file share metadata signing certificate public keys.
   */
  // FIXME: CloudEndpoints_AfsShareMetadataCertificatePublicKeys could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/afsShareMetadataCertificatePublicKeys")
  @get
  afsShareMetadataCertificatePublicKeys is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * Name of Storage Sync Service resource.
       */
      @path
      storageSyncServiceName: string;

      /**
       * Name of Sync Group resource.
       */
      @path
      syncGroupName: string;

      /**
       * Name of Cloud Endpoint object.
       */
      @path
      cloudEndpointName: string;
    },
    CloudEndpointAfsShareMetadataCertificatePublicKeys
  >;
}

@@projectedName(CloudEndpoints.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(CloudEndpoints.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(CloudEndpoints.create::parameters.resource,
  "Body of Cloud Endpoint resource."
);
@@projectedName(CloudEndpoints.preBackup::parameters.body,
  "json",
  "parameters"
);
@@extension(CloudEndpoints.preBackup::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(CloudEndpoints.preBackup::parameters.body, "Body of Backup request.");
@@projectedName(CloudEndpoints.postBackup::parameters.body,
  "json",
  "parameters"
);
@@extension(CloudEndpoints.postBackup::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(CloudEndpoints.postBackup::parameters.body, "Body of Backup request.");
@@projectedName(CloudEndpoints.preRestore::parameters.body,
  "json",
  "parameters"
);
@@extension(CloudEndpoints.preRestore::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(CloudEndpoints.preRestore::parameters.body,
  "Body of Cloud Endpoint object."
);
@@projectedName(CloudEndpoints.postRestore::parameters.body,
  "json",
  "parameters"
);
@@extension(CloudEndpoints.postRestore::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(CloudEndpoints.postRestore::parameters.body,
  "Body of Cloud Endpoint object."
);
@@projectedName(CloudEndpoints.triggerChangeDetection::parameters.body,
  "json",
  "parameters"
);
@@extension(CloudEndpoints.triggerChangeDetection::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(CloudEndpoints.triggerChangeDetection::parameters.body,
  "Trigger Change Detection Action parameters."
);
