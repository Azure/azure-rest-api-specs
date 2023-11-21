import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace MicrosoftStorageSync;

interface OperationsOperations {
  @doc("Lists all of the available Storage Sync Rest API operations.")
  @route("/providers/Microsoft.StorageSync/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationEntityListResult>;
}

interface StorageSyncServicesOperations {
  @doc("Check the give namespace name availability.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StorageSync/locations/{locationName}/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The desired region for the name check.")
      @path
      locationName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("Parameters to check availability of the given namespace name")
      @body
      parameters: CheckNameAvailabilityParameters;
    },
    CheckNameAvailabilityResult
  >;

  @doc("Create a new StorageSyncService.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("Storage Sync Service resource name.")
      @body
      parameters: StorageSyncServiceCreateParameters;
    },
    StorageSyncService | void
  >;

  @doc("Get a given StorageSyncService.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;
    },
    StorageSyncService
  >;

  @doc("Patch a given StorageSyncService.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("Storage Sync Service resource.")
      @body
      parameters: StorageSyncServiceUpdateParameters;
    },
    StorageSyncService | void
  >;

  @doc("Delete a given StorageSyncService.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;
    },
    void
  >;

  @doc("Get a StorageSyncService list by Resource group name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    StorageSyncServiceArray
  >;

  @doc("Get a StorageSyncService list by subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.StorageSync/storageSyncServices")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    StorageSyncServiceArray
  >;
}

interface PrivateLinkResourcesOperations {
  @doc("""
Gets the private link resources that need to be created for a storage sync
service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/privateLinkResources")
  @get
  ListByStorageSyncService is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the storage sync service name within the specified resource group.")
      @path
      storageSyncServiceName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    PrivateLinkResourceListResult
  >;
}

interface PrivateEndpointConnectionsOperations {
  @doc("""
Gets the specified private endpoint connection associated with the storage sync
service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the storage sync service name within the specified resource group.")
      @path
      storageSyncServiceName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;
    },
    PrivateEndpointConnection
  >;

  @doc("""
Update the state of specified private endpoint connection associated with the
storage sync service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the storage sync service name within the specified resource group.")
      @path
      storageSyncServiceName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;

      @doc("The private endpoint connection properties.")
      @body
      properties: PrivateEndpointConnection;
    },
    PrivateEndpointConnection | void
  >;

  @doc("""
Deletes the specified private endpoint connection associated with the storage
sync service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the storage sync service name within the specified resource group.")
      @path
      storageSyncServiceName: string;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the private endpoint connection associated with the Azure resource")
      @path
      privateEndpointConnectionName: string;
    },
    void
  >;

  @doc("Get a PrivateEndpointConnection List.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/privateEndpointConnections")
  @get
  ListByStorageSyncService is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;
    },
    PrivateEndpointConnectionListResult
  >;
}

interface SyncGroupsOperations {
  @doc("Get a SyncGroup List.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups")
  @get
  ListByStorageSyncService is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;
    },
    SyncGroupArray
  >;

  @doc("Create a new SyncGroup.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("Name of Sync Group resource.")
      @path
      syncGroupName: string;

      @doc("Sync Group Body")
      @body
      parameters: SyncGroupCreateParameters;
    },
    SyncGroup
  >;

  @doc("Get a given SyncGroup.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("Name of Sync Group resource.")
      @path
      syncGroupName: string;
    },
    SyncGroup
  >;

  @doc("Delete a given SyncGroup.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("Name of Sync Group resource.")
      @path
      syncGroupName: string;
    },
    void
  >;
}

interface CloudEndpointsOperations {
  @doc("Create a new CloudEndpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
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

      @doc("Body of Cloud Endpoint resource.")
      @body
      parameters: CloudEndpointCreateParameters;
    },
    CloudEndpoint | void
  >;

  @doc("Get a given CloudEndpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
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
    CloudEndpoint
  >;

  @doc("Delete a given CloudEndpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
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
    void
  >;

  @doc("Get a CloudEndpoint List.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints")
  @get
  ListBySyncGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("Name of Sync Group resource.")
      @path
      syncGroupName: string;
    },
    CloudEndpointArray
  >;

  @doc("Pre Backup a given CloudEndpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/prebackup")
  @post
  PreBackup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
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

      @doc("Body of Backup request.")
      @body
      parameters: BackupRequest;
    },
    void
  >;

  @doc("Post Backup a given CloudEndpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/postbackup")
  @post
  PostBackup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
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

      @doc("Body of Backup request.")
      @body
      parameters: BackupRequest;
    },
    PostBackupResponse | void
  >;

  @doc("Pre Restore a given CloudEndpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/prerestore")
  @post
  PreRestore is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
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

      @doc("Body of Cloud Endpoint object.")
      @body
      parameters: PreRestoreRequest;
    },
    void
  >;

  @doc("Restore Heartbeat a given CloudEndpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/restoreheartbeat")
  @post
  restoreheartbeat is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
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
    void
  >;

  @doc("Post Restore a given CloudEndpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/postrestore")
  @post
  PostRestore is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
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

      @doc("Body of Cloud Endpoint object.")
      @body
      parameters: PostRestoreRequest;
    },
    void
  >;

  @doc("""
Triggers detection of changes performed on Azure File share connected to the
specified Azure File Sync Cloud Endpoint.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/triggerChangeDetection")
  @post
  TriggerChangeDetection is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
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

      @doc("Trigger Change Detection Action parameters.")
      @body
      parameters: TriggerChangeDetectionParameters;
    },
    void
  >;

  @doc("Get the AFS file share metadata signing certificate public keys.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/cloudEndpoints/{cloudEndpointName}/afsShareMetadataCertificatePublicKeys")
  @get
  AfsShareMetadataCertificatePublicKeys is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
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

interface ServerEndpointsOperations {
  @doc("Create a new ServerEndpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints/{serverEndpointName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("Name of Sync Group resource.")
      @path
      syncGroupName: string;

      @doc("Name of Server Endpoint object.")
      @path
      serverEndpointName: string;

      @doc("Body of Server Endpoint object.")
      @body
      parameters: ServerEndpointCreateParameters;
    },
    ServerEndpoint | void
  >;

  @doc("Patch a given ServerEndpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints/{serverEndpointName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("Name of Sync Group resource.")
      @path
      syncGroupName: string;

      @doc("Name of Server Endpoint object.")
      @path
      serverEndpointName: string;

      @doc("Any of the properties applicable in PUT request.")
      @body
      parameters: ServerEndpointUpdateParameters;
    },
    ServerEndpoint | void
  >;

  @doc("Get a ServerEndpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints/{serverEndpointName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("Name of Sync Group resource.")
      @path
      syncGroupName: string;

      @doc("Name of Server Endpoint object.")
      @path
      serverEndpointName: string;
    },
    ServerEndpoint
  >;

  @doc("Delete a given ServerEndpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints/{serverEndpointName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("Name of Sync Group resource.")
      @path
      syncGroupName: string;

      @doc("Name of Server Endpoint object.")
      @path
      serverEndpointName: string;
    },
    void
  >;

  @doc("Get a ServerEndpoint list.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints")
  @get
  ListBySyncGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("Name of Sync Group resource.")
      @path
      syncGroupName: string;
    },
    ServerEndpointArray
  >;

  @doc("Recall a server endpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/syncGroups/{syncGroupName}/serverEndpoints/{serverEndpointName}/recallAction")
  @post
  recallAction is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("Name of Sync Group resource.")
      @path
      syncGroupName: string;

      @doc("Name of Server Endpoint object.")
      @path
      serverEndpointName: string;

      @doc("Body of Recall Action object.")
      @body
      parameters: RecallActionParameters;
    },
    void
  >;
}

interface RegisteredServersOperations {
  @doc("Get a given registered server list.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/registeredServers")
  @get
  ListByStorageSyncService is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;
    },
    RegisteredServerArray
  >;

  @doc("Get a given registered server.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/registeredServers/{serverId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("GUID identifying the on-premises server.")
      @path
      serverId: string;
    },
    RegisteredServer
  >;

  @doc("Add a new registered server.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/registeredServers/{serverId}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("GUID identifying the on-premises server.")
      @path
      serverId: string;

      @doc("Body of Registered Server object.")
      @body
      parameters: RegisteredServerCreateParameters;
    },
    RegisteredServer | void
  >;

  @doc("Delete the given registered server.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/registeredServers/{serverId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("GUID identifying the on-premises server.")
      @path
      serverId: string;
    },
    void
  >;

  @doc("Triggers Server certificate rollover.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/registeredServers/{serverId}/triggerRollover")
  @post
  triggerRollover is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("Server Id")
      @path
      serverId: string;

      @doc("Body of Trigger Rollover request.")
      @body
      parameters: TriggerRolloverRequest;
    },
    void
  >;
}

interface WorkflowsOperations {
  @doc("Get a Workflow List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/workflows")
  @get
  ListByStorageSyncService is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;
    },
    WorkflowArray
  >;

  @doc("Get Workflows resource")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/workflows/{workflowId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("workflow Id")
      @path
      workflowId: string;
    },
    Workflow
  >;

  @doc("Abort the given workflow.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/storageSyncServices/{storageSyncServiceName}/workflows/{workflowId}/abort")
  @post
  Abort is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Name of Storage Sync Service resource.")
      @path
      storageSyncServiceName: string;

      @doc("workflow Id")
      @path
      workflowId: string;
    },
    void
  >;
}

interface OperationStatusOperations {
  @doc("Get Operation status")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.StorageSync/locations/{locationName}/workflows/{workflowId}/operations/{operationId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The desired region to obtain information from.")
      @path
      locationName: string;

      @doc("workflow Id")
      @path
      workflowId: string;

      @doc("operation Id")
      @path
      operationId: string;
    },
    OperationStatus
  >;
}

@doc("Get Operation status")
// FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
// Problematic names: [LocationOperationStatus]
@route("/subscriptions/{subscriptionId}/providers/Microsoft.StorageSync/locations/{locationName}/operations/{operationId}")
@get
op LocationOperationStatus is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription.")
    @path
    subscriptionId: string;

    @doc("The desired region to obtain information from.")
    @path
    locationName: string;

    @doc("operation Id")
    @path
    operationId: string;
  },
  LocationOperationStatus
>;
