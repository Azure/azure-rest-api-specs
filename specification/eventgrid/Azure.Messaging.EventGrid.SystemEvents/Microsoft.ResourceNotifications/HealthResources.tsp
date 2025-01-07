import "@typespec/versioning";
import "./common.tsp";
using TypeSpec.Versioning;
/**
Describes the schema of the Health Resources events published to Azure Event
Grid. This corresponds to the Data property of an EventGridEvent.
*/
namespace Microsoft.EventGrid.SystemEvents;

/**
Schema of the Data property of an EventGridEvent for a
Microsoft.ResourceNotifications.HealthResources.AvailabilityStatusChanged
event.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model ResourceNotificationsHealthResourcesAvailabilityStatusChangedEventData
  extends ResourceNotificationsResourceUpdatedEventData {}

/**
Schema of the Data property of an EventGridEvent for a
Microsoft.ResourceNotifications.HealthResources.ResourceAnnotated event.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model ResourceNotificationsHealthResourcesAnnotatedEventData
  extends ResourceNotificationsResourceUpdatedEventData {}
