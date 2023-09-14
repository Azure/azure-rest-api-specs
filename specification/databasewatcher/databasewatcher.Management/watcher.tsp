import "@typespec/rest";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-providerhub";
import "./sqlDbSingleDatabaseTarget.tsp";
import "./sqlDbElasticPoolTarget.tsp";
import "./sqlMiTarget.tsp";
import "./sqlVmTarget.tsp";
import "./privateConnection.tsp";

@service({
  title: "Microsoft.DatabaseWatcher",
})
@versioned(Microsoft.DatabaseWatcher.Versions)
@armProviderNamespace
namespace Microsoft.DatabaseWatcher;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Versions info.")
enum Versions {
  @doc("The 2023-03-01-preview version.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_03_01_preview: "2023-03-01-preview",

  @doc("The 2023-09-01-preview version.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_09_01_preview: "2023-09-01-preview",
}
@doc("The DatabaseWatcherProviderHub resource.")
model Watcher is TrackedResource<WatcherProperties> {
  @doc("The database watcher name.")
  @key("watcherName")
  @pattern("^[a-zA-Z0-9]{1}[a-zA-Z0-9-_]{3,60}$")
  @path
  @segment("watchers")
  name: string;

  ...ManagedServiceIdentity;
}

@doc("The RP specific properties of the resource.")
model WatcherProperties {
  @doc("The data store for collected monitoring data.")
  datastore?: Datastore;

  @doc("The monitoring collection status of the watcher.")
  @visibility("read")
  status?: WatcherStatus;

  @visibility("read")
  @doc("The provisioning state of the resource watcher.")
  provisioningState?: DatabaseWatcherProvisioningState;
}

@doc("The properties of a data store.")
model Datastore {
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning"
  @removed(Versions.v2023_09_01_preview)
  @doc("The ARM ResourceId of an Azure Data Explorer database.")
  adxDatabaseResourceId: string;

  @added(Versions.v2023_09_01_preview)
  @doc("The ARM ResourceId of an Azure Data Explorer cluster.")
  adxClusterResourceId?: string;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning"
  @removed(Versions.v2023_09_01_preview)
  @doc("The Kusto cluster URI.")
  adxClusterUri: string;

  @added(Versions.v2023_09_01_preview)
  @doc("The Kusto cluster display name.")
  kustoClusterDisplayName?: string;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning"
  @added(Versions.v2023_09_01_preview)
  @doc("The Kusto cluster URI.")
  kustoClusterUri: string;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning"
  @added(Versions.v2023_09_01_preview)
  @doc("The Kusto data ingestion URI.")
  kustoDataIngestionUri: string;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning"
  @added(Versions.v2023_09_01_preview)
  @doc("The name of a Kusto database.")
  kustoDatabaseName: string;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning"
  @added(Versions.v2023_09_01_preview)
  @doc("The Kusto management URL.")
  kustoManagementUrl: string;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning"
  @added(Versions.v2023_09_01_preview)
  @doc("The type of a Kusto offering.")
  kustoOfferingType: KustoOfferingType;
}

@added(Versions.v2023_09_01_preview)
@doc("The type of Kusto offering.")
enum KustoOfferingType {
  @doc("The Azure Data Explorer cluster Kusto offering.")
  adx,

  @doc("The free Azure Data Explorer cluster Kusto offering.")
  free,

  @doc("The Fabric Real-Time Analytics Kusto offering.")
  fabric,
}

// Currently ProviderHub library for TypeSpec does not support
// async Patch from using TrackedResourceOperations. Instead we need to
// implement the interface manually. This looks to be recommendation so far:
// https://stackoverflow.microsoft.com/questions/350795/350952#350952.
@armResourceOperations
interface Watchers {
  get is ArmResourceRead<Watcher>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Watcher>;
  update is ArmResourcePatchAsync<Watcher, WatcherProperties>;
  delete is ArmResourceDeleteAsync<Watcher>;
  listByResourceGroup is ArmResourceListByParent<Watcher>;
  listBySubscription is ArmListBySubscription<Watcher>;

  @doc("The action to start monitoring all targets configured for a database watcher.")
  @action
  @post
  @armResourceAction(Watcher)
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  start(
    ...ResourceInstanceParameters<Watcher>,
  ): ArmAcceptedResponse | ArmResponse<Watcher> | ErrorResponse;

  @doc("The action to stop monitoring all targets configured for a database watcher.")
  @action
  @post
  @armResourceAction(Watcher)
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  stop(
    ...ResourceInstanceParameters<Watcher>,
  ): ArmAcceptedResponse | ArmResponse<Watcher> | ErrorResponse;
}

@parentResource(Watcher)
model Target is ProxyResource<TargetProperties> {
  @doc("The target resource name.")
  @key("targetName")
  @pattern("^[a-zA-Z0-9]{1}[a-zA-Z0-9-_]{3,60}$")
  @segment("targets")
  @path
  name: string;
}

@added(Versions.v2023_09_01_preview)
@parentResource(Watcher)
model PrivateConnection is ProxyResource<PrivateConnectionProperties> {
  @doc("The private connection resource name.")
  @key("privateConnectionName")
  @pattern("^[a-zA-Z0-9]{1}[a-zA-Z0-9-_.]{0,62}[a-zA-Z0-9_]{1}$")
  @segment("privateConnections")
  @path
  name: string;
}

@doc("The monitoring collection status of a watcher.")
enum WatcherStatus {
  @doc("Denotes the watcher is in a starting state.")
  Starting,

  @doc("Denotes the watcher is in a running state.")
  Running,

  @doc("Denotes the watcher is in a stopping state.")
  Stopping,

  @doc("Denotes the watcher is in a stopped state.")
  Stopped,

  @doc("Denotes the watcher is in a deleting state.")
  Deleting,
}

@doc("The status of the last provisioning operation performed on the resource.")
enum DatabaseWatcherProvisioningState {
  ...ResourceProvisioningState,
}
