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
@doc("Cloud Endpoint object.")
@parentResource(SyncGroup)
model CloudEndpoint is ProxyResource<CloudEndpointProperties> {
  @doc("Name of Cloud Endpoint object.")
  @path
  @key("cloudEndpointName")
  @segment("cloudEndpoints")
  name: string;
}

@armResourceOperations
interface CloudEndpoints {
  @doc("Get a given CloudEndpoint.")
  get is ArmResourceRead<CloudEndpoint>;

  @doc("Create a new CloudEndpoint.")
  create is ArmResourceCreateOrUpdateAsync<CloudEndpoint>;

  @doc("Delete a given CloudEndpoint.")
  delete is ArmResourceDeleteAsync<CloudEndpoint>;

  @doc("Get a CloudEndpoint List.")
  listBySyncGroup is ArmResourceListByParent<CloudEndpoint>;

  @doc("Pre Backup a given CloudEndpoint.")
  preBackup is ArmResourceActionAsync<CloudEndpoint, BackupRequest, void>;

  @doc("Post Backup a given CloudEndpoint.")
  postBackup is ArmResourceActionAsync<
    CloudEndpoint,
    BackupRequest,
    PostBackupResponse
  >;

  @doc("Pre Restore a given CloudEndpoint.")
  preRestore is ArmResourceActionAsync<CloudEndpoint, PreRestoreRequest, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Restore Heartbeat a given CloudEndpoint.")
  @operationId("CloudEndpoints_restoreheartbeat")
  restoreheartbeat is ArmResourceActionSync<CloudEndpoint, void, void>;

  @doc("Post Restore a given CloudEndpoint.")
  postRestore is ArmResourceActionAsync<
    CloudEndpoint,
    PostRestoreRequest,
    void
  >;

  @doc("Triggers detection of changes performed on Azure File share connected to the specified Azure File Sync Cloud Endpoint.")
  triggerChangeDetection is ArmResourceActionAsync<
    CloudEndpoint,
    TriggerChangeDetectionParameters,
    void
  >;

  @doc("Get the AFS file share metadata signing certificate public keys.")
  // FIXME: CloudEndpoints_AfsShareMetadataCertificatePublicKeys could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/afsShareMetadataCertificatePublicKeys")
  @get
  afsShareMetadataCertificatePublicKeys is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("Name of Sync Group resource.")
      @path
      syncGroupName: string;

      @doc("Name of Cloud Endpoint object.")
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
