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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model ResourceNotificationsContainerServiceEventResourcesScheduledEventData
  extends ResourceNotificationsResourceUpdatedEventData {}
