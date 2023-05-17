import "@typespec/rest";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-providerhub-controller";
import "./sqlDbSingleDatabaseTarget.tsp";
import "./sqlDbElasticPoolTarget.tsp";
import "./sqlMiTarget.tsp";
import "./sqlVmTarget.tsp";

@service({
  title: "Microsoft.DatabaseWatcher",
  version: "2023-03-01-preview",
})
@Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armProviderNamespace
namespace Microsoft.DatabaseWatcher;

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A DatabaseWatcherProviderHub resource.")
model Watcher is TrackedResource<WatcherProperties> {
  @doc("Database watcher name.")
  @key("watcherName")
  @pattern("^[a-zA-Z0-9]{1}[a-zA-Z0-9-_]{3,60}$")
  @path
  @segment("watchers")
  name: string;
  ...ManagedServiceIdentity;
}

@doc("RP specific properties of the resource.")
model WatcherProperties {
  @doc("A data store for collected monitoring data.")
  datastore?: Datastore;

  @doc("The monitoring collection status of the watcher.")
  status?: WatcherStatus;

  @visibility("read")
  @doc("The provisioning state of the resource watcher.")
  provisioningState?: DatabaseWatcherProvisioningState;
}

@doc("Properties of data store.")
model Datastore {
  @doc("ARM ResourceId of an Azure Data Explorer database.")
  adxDatabaseResourceId: string;

  @doc("URI of an Azure Data Explorer Cluster.")
  adxClusterUri: string;
}

@armResourceOperations
interface Watchers
  extends TrackedResourceOperations<Watcher, WatcherProperties> {
  @doc("Action to start monitoring all targets configured for a given database watcher.")
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
    ...ResourceInstanceParameters<Watcher>
  ): ArmAcceptedResponse | ArmResponse<Watcher> | ErrorResponse;

  @doc("Action to stop monitoring all targets configured for a given database watcher.")
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
    ...ResourceInstanceParameters<Watcher>
  ): ArmAcceptedResponse | ArmResponse<Watcher> | ErrorResponse;
}

@parentResource(Watcher)
model Target is ProxyResource<TargetProperties> {
  @doc("Target resource name.")
  @key("targetName")
  @pattern("^[a-zA-Z0-9]{1}[a-zA-Z0-9-_]{3,60}$")
  @segment("targets")
  @path
  name: string;
}

@doc("The monitoring collection status of the watcher.")
enum WatcherStatus {
  Running,
  Stopped,
}

@doc("The status of the last provisioning operation performed on the resource.")
enum DatabaseWatcherProvisioningState {
  ...ResourceProvisioningState,
  Provisioning,
  Starting,
  Stopping,
  Deleting,
  Accepted,
}
