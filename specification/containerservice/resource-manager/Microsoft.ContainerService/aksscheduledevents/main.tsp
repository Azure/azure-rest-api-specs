import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

/**
 * The Container Service Scheduled Events data model.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "This project intentionally emits a schema-only proxy resource contract for Azure Resource Notifications with no customer-callable ARM operations."
@armProviderNamespace
@service(#{ title: "ContainerServiceClient" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Preserves the existing scheduledEvents swagger x-ms-enum metadata."
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Keeps the enum inline to preserve the existing scheduledEvents swagger shape."
  @extension("x-ms-enum", #{ name: "eventStatus", modelAsString: true })
  eventStatus?:
    | "Scheduled"
    | "Started"
    | "Completed"
    | "Cancelled"
    | "Failed"
    | string;

  /**
   * The details of the event.
   */
  eventDetails?: string;

  /**
   * The time of the event is scheduled to start.
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Preserves the existing scheduledEvents swagger x-ms-enum metadata."
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Keeps the enum inline to preserve the existing scheduledEvents swagger shape."
  @extension("x-ms-enum", #{ name: "ResourceType", modelAsString: true })
  resourceType?: "ManagedCluster" | "AgentPool" | string;
}
