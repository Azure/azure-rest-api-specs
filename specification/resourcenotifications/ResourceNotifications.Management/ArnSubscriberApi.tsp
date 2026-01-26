import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.ResourceNotifications;

// Scope discriminator for resource subscriptions
union ScopeKind {
  string,

  /** Tenant scope */
  tenant: "tenant",

  /** Cloud scope */
  cloud: "cloud",
}

/** Base properties for scope configuration */
@discriminator("kind")
model Scope {
  /** The kind of scope */
  kind: ScopeKind;
}

/** Tenant scope configuration */
model TenantScope extends Scope {
  /** The discriminator for tenant scope */
  kind: "tenant";

  /** The tenant ID populated by API after validation (from Aux token) */
  @visibility(Lifecycle.Read)
  tenantId: string;

  /** The service principal populated by API after validation (from Aux token) */
  @visibility(Lifecycle.Read)
  servicePrincipal: string;
}

/** Cloud scope configuration */
model CloudScope extends Scope {
  /** The discriminator for cloud scope */
  kind: "cloud";

  /** The provider namespace populated by caller */
  providerNamespace: string;

  /** The application ID extracted from request, checked against manifest */
  @visibility(Lifecycle.Read)
  appId: string;
}

/** Partitioning configuration kind discriminator */
union PartitioningConfigurationKind {
  string,

  /** ARN location partitioning */
  arnLocation: "arnLocation",
}

/** Base properties for partitioning configuration */
@discriminator("kind")
model PartitioningConfiguration {
  /** The kind of partitioning configuration */
  kind: PartitioningConfigurationKind;
}

/** Partition definition */
model Partition {
  /** The name of the partition */
  name: string;

  /** The regions for this partition */
  regions: string[];
}

/** ARN location partitioning configuration */
model ArnLocationPartitioningConfiguration extends PartitioningConfiguration {
  /** The discriminator for ARN location partitioning */
  kind: "arnLocation";

  /** The partitions list */
  partitions: Partition[];
}

/** Available options for resource subscriptions */
union SubscriptionOptions {
  string,

  /** Enables delivery of periodic snapshots */
  enablePeriodicSnapshots: "enablePeriodicSnapshots",

  /** Enables delivery of writes and deletes */
  enableDeltas: "enableDeltas",
}

/** Properties of a resource subscription */
model ResourceSubscriptionProperties {
  /** The query to execute - only one table can be targeted at a time */
  query: string;

  /** The scope for the execution of the filter */
  scope: Scope;

  /** Defines how to partition the event stream. Supported kind: arnLocation */
  partitioningConfiguration?: PartitioningConfiguration;

  /** Optional configuration options */
  @visibility(Lifecycle.Read)
  options?: SubscriptionOptions[];

  /** The status of the last operation */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** The resource provisioning state */
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  string,
}

/** Resource subscription for Azure Resource Notifications */
@resource("resourceSubscriptions")
model ResourceSubscription
  is Azure.ResourceManager.TrackedResource<ResourceSubscriptionProperties> {
  /** The name of the resource subscription */
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @key("subscriptionRuleName")
  @segment("resourceSubscriptions")
  @path
  name: string;
}

/** Resource subscription properties for update operations (excludes discriminated unions) */
model ResourceSubscriptionUpdateProperties {
  /** The query to execute - only one table can be targeted at a time */
  query?: string;
}

/** Operations for Resource Subscriptions */
@armResourceOperations
interface ResourceSubscriptions {
  /** Gets a resource subscription */
  get is ArmResourceRead<ResourceSubscription>;

  /** Creates or updates a resource subscription */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "This is a valid final state for a PUT operation"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ResourceSubscription,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Updates a resource subscription (supports tags and property updates) */
  @OpenAPI.extension(
    "x-ms-examples",
    #{
      `Update a resource subscription`: #{
        $ref: "./examples/ResourceSubscriptions_Update.json",
      },
    }
  )
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchSync<
    ResourceSubscription,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ResourceSubscription,
      ResourceSubscriptionUpdateProperties
    >
  >;

  /** Deletes a resource subscription */
  delete is ArmResourceDeleteSync<ResourceSubscription>;

  /** Lists all resource subscriptions in a resource group */
  @OpenAPI.extension(
    "x-ms-examples",
    #{
      `List all resource subscriptions in a resource group`: #{
        $ref: "./examples/ResourceSubscriptions_List.json",
      },
    }
  )
  listByResourceGroup is ArmResourceListByParent<ResourceSubscription>;

  /** Lists all resource subscriptions in a subscription */
  @OpenAPI.extension(
    "x-ms-examples",
    #{
      `List all resource subscriptions in a subscription`: #{
        $ref: "./examples/ResourceSubscriptions_List.json",
      },
    }
  )
  listBySubscription is ArmListBySubscription<ResourceSubscription>;
}

// Destination Models

/** Destination kind discriminator */
union DestinationKind {
  string,

  /** Fabric table destination */
  fabricTable: "fabricTable",

  /** Storage account destination */
  storageAccount: "storageAccount",
}

/** Available destination options */
union DestinationOptions {
  string,

  /** Enables delivery of the initial snapshot */
  enableInitialSnapshot: "enableInitialSnapshot",
}

/** Base properties for destination configuration */
@discriminator("kind")
model DestinationProperties {
  /** The kind of destination */
  kind: DestinationKind;

  /** The status of the last operation */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Fabric endpoint configuration */
model FabricEndpoint {
  /** The workspace ID */
  workspaceId: string;

  /** The database ID */
  databaseId: string;
}

/** Fabric table destination properties */
model FabricTableDestinationProperties extends DestinationProperties {
  /** The discriminator for fabric table destination */
  kind: "fabricTable";

  /** The output schema - readonly for now, will provide a way for 1P to set to fabric1P */
  @visibility(Lifecycle.Read)
  outputSchema: string;

  /** The output encoding - readonly and not configurable */
  @visibility(Lifecycle.Read)
  outputEncoding: string;

  /** The fabric endpoint configuration */
  endpoint: FabricEndpoint;

  /** Optional destination configuration options */
  @visibility(Lifecycle.Read)
  options?: DestinationOptions[];
}

/** Storage account endpoint */
model StorageAccountEndpoint {
  /** The storage account endpoint URL */
  url: string;
}

/** Path policy kind discriminator */
union PathPolicyKind {
  string,

  /** Time and scope range hash path policy */
  timeAndScopeRangeHash: "timeAndScopeRangeHash",
}

/** Base properties for path policy configuration */
@discriminator("kind")
model PathPolicy {
  /** The kind of path policy */
  kind: PathPolicyKind;
}

/** Time and scope range hash path policy */
model TimeAndScopeRangeHashPathPolicy extends PathPolicy {
  /** The discriminator for time and scope range hash path policy */
  kind: "timeAndScopeRangeHash";

  /** The time source */
  timeSource: string;

  /** The scope */
  scope: string;

  /** The number of scope buckets */
  scopeBuckets: int32;

  /** The path template following the pattern: year={yyyy},month={mm},day={dd}/hour={hh}/tenantBucket={scopeBucket} */
  pathTemplate: string;
}

/** Batching policy kind discriminator */
union BatchingPolicyKind {
  string,

  /** Min count max delay batching policy */
  minCountMaxDelay: "minCountMaxDelay",
}

/** Base properties for batching policy configuration */
@discriminator("kind")
model BatchingPolicy {
  /** The kind of batching policy */
  kind: BatchingPolicyKind;
}

/** Min count max delay batching policy */
model MinCountMaxDelayBatchingPolicy extends BatchingPolicy {
  /** The discriminator for min count max delay batching policy */
  kind: "minCountMaxDelay";

  /** Minimum number of resources */
  minResources: string;

  /** Maximum delay */
  maxDelay: string;
}

/** Storage account destination properties */
model StorageAccountDestinationProperties extends DestinationProperties {
  /** The discriminator for storage account destination */
  kind: "storageAccount";

  /** Which partitions go to this destination */
  partitions: string[];

  /** Incoming notifications are mapped to a path based on the path policy */
  pathPolicy: PathPolicy;

  /** Notifications for the same path are batched following the batching policy */
  batchingPolicy?: BatchingPolicy;

  /** The schema to use for the delivered notifications - read-only, must be "firstParty" for now */
  @visibility(Lifecycle.Read)
  outputSchema?: string;

  /** Format for the output - read-only, must be "parquet" for now */
  @visibility(Lifecycle.Read)
  outputEncoding?: string;

  /** Storage container to store the data */
  endpointContainer: string;

  /** How to deliver to the endpoints below: round-robin spreads load over all endpoints, failover delivers to the first available */
  endpointDeliveryMode: string;

  /** Set of endpoints to use */
  @OpenAPI.extension("x-ms-identifiers", #[])
  endpoints: StorageAccountEndpoint[];
}

/** Destination resource for Azure Resource Notifications */
@resource("destinations")
@parentResource(ResourceSubscription)
model Destination
  is Azure.ResourceManager.ProxyResource<DestinationProperties> {
  /** The name of the destination */
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @key("destinationName")
  @segment("destinations")
  @path
  name: string;
}

/** Operations for Destinations */
@armResourceOperations
interface Destinations {
  /** Gets a destination */
  @operationId("ResourceSubscriptionDestinations_Get")
  get is ArmResourceRead<Destination>;

  /** Creates or updates a destination */
  @operationId("ResourceSubscriptionDestinations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Destination>;

  /** Deletes a destination */
  @operationId("ResourceSubscriptionDestinations_Delete")
  delete is ArmResourceDeleteSync<Destination>;

  /** Lists all destinations for a resource subscription */
  @OpenAPI.extension(
    "x-ms-examples",
    #{
      `List all destinations for a resource subscription`: #{
        $ref: "./examples/ResourceSubscriptionDestinations_List.json",
      },
    }
  )
  @operationId("ResourceSubscriptionDestinations_List")
  list is ArmResourceListByParent<Destination>;
}
