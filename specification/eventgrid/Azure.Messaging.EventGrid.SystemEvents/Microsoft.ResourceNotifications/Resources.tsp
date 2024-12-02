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
Microsoft.ResourceNotifications.Resources.CreatedOrUpdated event.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model ResourceNotificationsResourceManagementCreatedOrUpdatedEventData
  extends ResourceNotificationsResourceUpdatedEventData {}

/**
Schema of the Data property of an EventGridEvent for a
Microsoft.ResourceNotifications.Resources.Deleted event.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model ResourceNotificationsResourceManagementDeletedEventData
  extends ResourceNotificationsResourceDeletedEventData {}
