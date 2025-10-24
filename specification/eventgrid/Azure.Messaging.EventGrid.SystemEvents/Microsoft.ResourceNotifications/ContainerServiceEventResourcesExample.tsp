import "./ContainerServiceEventResources.tsp";
namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftResourceNotificationsContainerServiceEventResourcesScheduledEventEmittedExample: ResourceNotificationsContainerServiceEventResourcesScheduledEventData = #{
  resourceInfo: #{
    id: "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.ContainerService/managedClusters/{managedcluster-name}/scheduledEvents/{event-id}",
    name: "{event-id}",
    type: "Microsoft.ContainerService/managedClusters/scheduledEvents",
    properties: #{
      description: "ScheduledEvents",
      eventId: "bbe82027-0444-4f73-897a-0bbfe3af66f1",
      eventSource: "AutoUpgrader",
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
