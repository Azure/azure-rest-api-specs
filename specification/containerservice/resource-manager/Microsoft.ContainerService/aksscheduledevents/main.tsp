import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * The Container Service Scheduled Events data model.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "This sibling project intentionally emits the schema-only Azure Resource Notifications / Azure Resource Graph / Event Grid contract for Microsoft.ContainerService/managedClusters/scheduledEvents. The contract is consumed as notification and resource graph payload schema and has no customer-callable ARM operations."
@armProviderNamespace
@service(#{ title: "ContainerServiceClient" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.ContainerService;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2026-06-01 API version.
   */
  v2026_06_01: "2026-06-01",
}

/**
 * Scheduled event for a managed cluster. ARM resource type: Microsoft.ContainerService/managedClusters/scheduledEvents.
 */
model ScheduledEvent
  is Azure.ResourceManager.ProxyResource<ScheduledEventProperties> {
  ...ResourceNameParameter<
    Resource = ScheduledEvent,
    KeyName = "scheduledEventName",
    SegmentName = "scheduledEvents",
    NamePattern = "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"
  >;
}

@@doc(ScheduledEvent.properties, "Properties for the scheduled event.");

/**
 * The status of the event.
 */
union EventStatus {
  string,

  /**
   * The event is scheduled.
   */
  Scheduled: "Scheduled",

  /**
   * The event has started.
   */
  Started: "Started",

  /**
   * The event completed.
   */
  Completed: "Completed",

  /**
   * The event was cancelled.
   */
  Cancelled: "Cancelled",

  /**
   * The event failed.
   */
  Failed: "Failed",
}

/**
 * The kind of resource impacted by the scheduled event.
 */
union ScheduledEventResourceType {
  string,

  /**
   * The event applies to a managed cluster.
   */
  ManagedCluster: "ManagedCluster",

  /**
   * The event applies to an agent pool.
   */
  AgentPool: "AgentPool",
}

/**
 * Properties for a scheduled event.
 *
 * Timestamp property names intentionally preserve the existing wire contract; all timestamp values are UTC date-time values.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This type is a read-only notification payload with no ARM create or update operations, so it has no provisioning lifecycle and no provisioningState to report."
model ScheduledEventProperties {
  /**
   * Human-readable summary of the scheduled event.
   */
  description?: string;

  /**
   * Unique ID of the scheduled event, represented as a GUID string.
   */
  eventId?: string;

  /**
   * AKS component or workflow that raised the scheduled event.
   */
  eventSource?: string;

  /**
   * Current lifecycle state of the scheduled event.
   */
  eventStatus?: EventStatus;

  /**
   * Free-form human-readable details about why the event was raised or what it represents.
   */
  eventDetails?: string;

  /**
   * The time the event is scheduled to start.
   */
  scheduledTime?: utcDateTime;

  /**
   * The time the event actually started.
   */
  startTime?: utcDateTime;

  /**
   * The last time the state of the event was updated.
   */
  lastUpdateTime?: utcDateTime;

  /**
   * The list of resources impacted by the event.
   */
  resources?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/managedClusters";
    },
    {
      type: "Microsoft.ContainerService/managedClusters/agentPools";
    }
  ]>[];

  /**
   * Whether the event applies to the managed cluster itself or to one of its agent pools.
   */
  resourceType?: ScheduledEventResourceType;
}
