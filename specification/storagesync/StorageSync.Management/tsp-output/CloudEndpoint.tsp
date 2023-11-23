import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SyncGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

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
  preBackup is ArmResourceActionAsync<CloudEndpoint, BackupRequest, {}>;
  @doc("Post Backup a given CloudEndpoint.")
  postBackup is ArmResourceActionAsync<
    CloudEndpoint,
    BackupRequest,
    PostBackupResponse
  >;
  @doc("Pre Restore a given CloudEndpoint.")
  preRestore is ArmResourceActionAsync<CloudEndpoint, PreRestoreRequest, {}>;
  @doc("Restore Heartbeat a given CloudEndpoint.")
  restoreheartbeat is ArmResourceActionSync<CloudEndpoint, {}, {}>;
  @doc("Post Restore a given CloudEndpoint.")
  postRestore is ArmResourceActionAsync<CloudEndpoint, PostRestoreRequest, {}>;
  @doc("Triggers detection of changes performed on Azure File share connected to the specified Azure File Sync Cloud Endpoint.")
  triggerChangeDetection is ArmResourceActionAsync<
    CloudEndpoint,
    TriggerChangeDetectionParameters,
    {}
  >;
  @doc("Get the AFS file share metadata signing certificate public keys.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/afsShareMetadataCertificatePublicKeys")
  @get
  AfsShareMetadataCertificatePublicKeys is Azure.Core.Foundations.Operation<
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
