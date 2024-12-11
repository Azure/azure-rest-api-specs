import "@typespec/versioning";
import "./common.tsp";
using TypeSpec.Versioning;

/**
Describes the schema of the Container Service events published to Azure 
Event Grid. This corresponds to the Data property of an EventGridEvent. 
*/
namespace Microsoft.EventGrid.SystemEvents;

/**
Schema of the Data property of an event grid event for a Microsoft.ResourceNotifications.ContainerServiceEventResources.ScheduledEventEmitted preview event.
*/
const MicrosoftResourceNotificationsContainerServiceEventResourcesScheduledEventEmittedExample: ResourceNotificationsContainerServiceEventResourcesScheduledEventData = #{
  resourceInfo: #{
    id: "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.ContainerService/managedClusters/{managedcluster-name}/scheduledEvents/{event-id}",
    name: "{event-id}",
    type: "Microsoft.ContainerService/managedClusters/scheduledEvents",
    properties: #{
      description: "ScheduledEvents",
      eventId: "bbe82027-0444-4f73-897a-0bbfe3af66f1",
      eventSource: "AutoUprader",
      eventStatus: "Started",
      eventDetails: "Start to upgrade security vhd",
      scheduledTime: utcDateTime.fromISO("2024-04-16T22:17:12.103268606Z"),
      startTime: utcDateTime.fromISO("0001-01-01T00:00:00.0000000Z"),
      lastUpdateTime: utcDateTime.fromISO("0001-01-01T00:00:00.0000000Z"),
      resources: #[
        "/subscriptions/{subscription-id}/resourcegroups/{rg-name}/providers/Microsoft.ContainerService/managedClusters/{managedcluster-name}"
      ],
      resourceType: "ManagedCluster",
    },
  },
  operationalInfo: #{
    resourceEventTime: utcDateTime.fromISO("2024-04-16T22:17:12.1032748"),
  },
  apiVersion: "2023-11-02-preview",
};
/** Schema of the Data property of an event grid event for a Microsoft.ResourceNotifications.ContainerServiceEventResources.ScheduledEventEmitted preview event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(
  MicrosoftResourceNotificationsContainerServiceEventResourcesScheduledEventEmittedExample
)
model ResourceNotificationsContainerServiceEventResourcesScheduledEventData
  extends ResourceNotificationsResourceUpdatedEventData {}
