import "@typespec/versioning";
import "./common.tsp";
using TypeSpec.Versioning;
/**
Describes the schema of the Health Resources events published to Azure Event
Grid. This corresponds to the Data property of an EventGridEvent.
*/
namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftResourceNotificationsHealthResourcesAvailabilityStatusChangedExample: ResourceNotificationsHealthResourcesAvailabilityStatusChangedEventData = #{
  resourceInfo: #{
    id: "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.Compute/virtualMachines/{vm-name}/providers/Microsoft.ResourceHealth/availabilityStatuses/{event-id}",
    name: "{event-id}",
    type: "Microsoft.ResourceHealth/availabilityStatuses",
    properties: #{
      targetResourceId: "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.Compute/virtualMachines/{vm-name}",
      targetResourceType: "Microsoft.Compute/virtualMachines",
      occurredTime: utcDateTime.fromISO("2023-07-24T19:20:37.9245071Z"),
      previousAvailabilityState: "Unavailable",
      availabilityState: "Available",
    },
  },
  operationalInfo: #{
    resourceEventTime: utcDateTime.fromISO("2023-07-24T19:20:37.9245071Z"),
  },
  apiVersion: "2023-12-01",
};
/**
Schema of the Data property of an EventGridEvent for a
Microsoft.ResourceNotifications.HealthResources.AvailabilityStatusChanged
event.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(
  MicrosoftResourceNotificationsHealthResourcesAvailabilityStatusChangedExample
)
model ResourceNotificationsHealthResourcesAvailabilityStatusChangedEventData
  extends ResourceNotificationsResourceUpdatedEventData {}

const MicrosoftResourceNotificationsHealthResourcesResourceAnnotatedExample: ResourceNotificationsHealthResourcesAnnotatedEventData = #{
  resourceInfo: #{
    id: "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.Compute/virtualMachines/{vm-name}/providers/Microsoft.ResourceHealth/resourceAnnotations/{event-id}",
    name: "{event-id}",
    type: "Microsoft.ResourceHealth/resourceAnnotations",
    properties: #{
      targetResourceId: "/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.Compute/virtualMachines/{vm-name}",
      targetResourceType: "Microsoft.Compute/virtualMachines",
      occurredTime: utcDateTime.fromISO("2023-07-24T19:20:37.9245071Z"),
      annotationName: "VirtualMachineDeallocationInitiated",
      reason: "Stopping and deallocating",
      summary: "This virtual machine is stopped and deallocated as requested by an authorized user or process.",
      context: "Customer Initiated",
      category: "Not Applicable",
    },
  },
  operationalInfo: #{
    resourceEventTime: utcDateTime.fromISO("2023-07-24T19:20:37.9245071Z"),
  },
  apiVersion: "2022-08-01",
};

/**
Schema of the Data property of an EventGridEvent for a
Microsoft.ResourceNotifications.HealthResources.ResourceAnnotated event.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftResourceNotificationsHealthResourcesResourceAnnotatedExample)
model ResourceNotificationsHealthResourcesAnnotatedEventData
  extends ResourceNotificationsResourceUpdatedEventData {}
