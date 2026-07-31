import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * The Container Service Scheduled Events data model.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "This project intentionally emits a schema-only proxy resource contract for Azure Resource Notifications with no customer-callable ARM operations."
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
 * Scheduled event.
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

@@doc(ScheduledEvent.properties, "Properties for the event.");

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
 * The resource type of the event.
 */
union ResourceType {
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
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Preserves the existing scheduledEvents notification contract; this materialized notification data model does not include provisioningState."
model ScheduledEventProperties {
  /**
   * The description of the event.
   */
  description?: string;

  /**
   * The event id of the event.
   */
  eventId?: string;

  /**
   * The source of the event.
   */
  eventSource?: string;

  /**
   * The status of the event.
   */
  eventStatus?: EventStatus;

  /**
   * The details of the event.
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
   * The resource type of the event.
   */
  resourceType?: ResourceType;
}
