import "@typespec/versioning";
import "./common.tsp";
import "./ResourcesExample.tsp";
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
@example(MicrosoftResourceNotificationsResourcesCreatedOrUpdatedExample)
model ResourceNotificationsResourceManagementCreatedOrUpdatedEventData
  extends ResourceNotificationsResourceUpdatedEventData {}

/**
Schema of the Data property of an EventGridEvent for a
Microsoft.ResourceNotifications.Resources.Deleted event.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftResourceNotificationsResourcesDeletedExample)
model ResourceNotificationsResourceManagementDeletedEventData
  extends ResourceNotificationsResourceDeletedEventData {}
