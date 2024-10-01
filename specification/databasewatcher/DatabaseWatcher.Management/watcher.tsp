import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./alertRuleResources.tsp";
import "./sqlDbDatabaseTarget.tsp";
import "./sqlDbElasticPoolTarget.tsp";
import "./sqlMiTarget.tsp";
import "./sqlVmTarget.tsp";
import "./sharedPrivateLinkResource.tsp";

#suppress "@azure-tools/typespec-azure-resource-manager/arm-common-types-version" "Using invalid versions of ManagedIdentity"
@service({
  title: "Microsoft.DatabaseWatcher",
})
@versioned(Microsoft.DatabaseWatcher.Versions)
@armProviderNamespace
namespace Microsoft.DatabaseWatcher;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Versions info.")
enum Versions {
  @doc("The 2023-09-01-preview version.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_09_01_preview: "2023-09-01-preview",

  @doc("The 2024-07-17-preview version.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_07_19_preview: "2024-07-19-preview",
}
@doc("The DatabaseWatcherProviderHub resource.")
model Watcher is TrackedResource<WatcherProperties> {
  @doc("The database watcher name.")
  @key("watcherName")
  @pattern("^[a-zA-Z0-9]{1}[a-zA-Z0-9-_]{3,60}$")
  @path
  @segment("watchers")
  name: string;

  ...Legacy.ManagedServiceIdentityV4Property;
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

  @doc("The resource ID of a user-assigned managed identity that will be assigned to a new alert rule.")
  @added(Versions.v2024_07_19_preview)
  defaultAlertRuleIdentityResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

@doc("The properties of a data store.")
model Datastore {
  @doc("The Azure ResourceId of an Azure Data Explorer cluster.")
  adxClusterResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.Kusto/clusters";
    }
  ]>;

  @doc("The Kusto cluster display name.")
  kustoClusterDisplayName?: string;

  @doc("The Kusto cluster URI.")
  kustoClusterUri: string;

  @doc("The Kusto data ingestion URI.")
  kustoDataIngestionUri: string;

  @doc("The name of a Kusto database.")
  kustoDatabaseName: string;

  @doc("The Kusto management URL.")
  kustoManagementUrl: string;

  @doc("The type of a Kusto offering.")
  kustoOfferingType: KustoOfferingType;
}

@doc("The type of Kusto offering.")
union KustoOfferingType {
  string,

  @doc("The Azure Data Explorer cluster Kusto offering.")
  adx: "adx",

  @doc("The free Azure Data Explorer cluster Kusto offering.")
  free: "free",

  @doc("The Fabric Real-Time Analytics Kusto offering.")
  fabric: "fabric",
}

// Currently ProviderHub library for TypeSpec does not support
// async Patch from using TrackedResourceOperations. Instead we need to
// implement the interface manually. This looks to be recommendation so far:
// https://stackoverflow.microsoft.com/questions/350795/350952#350952.
@armResourceOperations
interface Watchers {
  get is ArmResourceRead<Watcher>;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Watcher,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  update is ArmCustomPatchAsync<
    Watcher,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Watcher,
      WatcherProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Watcher>;
  listByResourceGroup is ArmResourceListByParent<Watcher>;
  listBySubscription is ArmListBySubscription<Watcher>;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
  @doc("The action to start monitoring all targets configured for a database watcher.")
  @action
  @post
  @armResourceAction(Watcher)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  start(
    ...ResourceInstanceParameters<Watcher>,
  ): ArmAcceptedLroResponse | ArmResponse<Watcher> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
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
  ): ArmAcceptedLroResponse | ArmResponse<Watcher> | ErrorResponse;
}

@doc("The monitoring collection status of a watcher.")
union WatcherStatus {
  string,

  @doc("Denotes the watcher is in a starting state.")
  Starting: "Starting",

  @doc("Denotes the watcher is in a running state.")
  Running: "Running",

  @doc("Denotes the watcher is in a stopping state.")
  Stopping: "Stopping",

  @doc("Denotes the watcher is in a stopped state.")
  Stopped: "Stopped",

  @doc("Denotes the watcher is in a deleting state.")
  Deleting: "Deleting",
}

@doc("The status of the last provisioning operation performed on the resource.")
union DatabaseWatcherProvisioningState {
  string,
  ResourceProvisioningState,
}
