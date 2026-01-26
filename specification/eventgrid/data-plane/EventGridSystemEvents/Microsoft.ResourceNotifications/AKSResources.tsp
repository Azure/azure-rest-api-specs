import "@typespec/versioning";
import "./AKSResourcesExample.tsp";
import "./common.tsp";
using TypeSpec.Versioning;

/**
Describes the schema of the AKS Fleet Resources events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent.
*/
namespace Microsoft.EventGrid.SystemEvents;

/**
Schema of the Data property of an EventGridEvent for a Microsoft.ResourceNotifications.AKSResources.FleetGateCreated event.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftResourceNotificationsAKSResourcesFleetGateCreatedExample)
model ResourceNotificationsAksResourcesFleetGateCreatedEventData
  extends ResourceNotificationsResourceUpdatedEventData {}

/**
Schema of the Data property of an EventGridEvent for a Microsoft.ResourceNotifications.AKSResources.FleetGateUpdated event.
*/
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftResourceNotificationsAKSResourcesFleetGateUpdatedExample)
model ResourceNotificationsAksResourcesFleetGateUpdatedEventData
  extends ResourceNotificationsResourceUpdatedEventData {}

/**
Schema of the Data property of an EventGridEvent for a Microsoft.ResourceNotifications.AKSResources.FleetGateDeleted event.
*/
@example(MicrosoftResourceNotificationsAKSResourcesFleetGateDeletedExample)
model ResourceNotificationsAksResourcesFleetGateDeletedEventData {
  /** resourceInfo details for deleted event */
  resourceInfo: {
    /** id of the resource for which the event is being emitted */
    id: string;

    /** name of the resource for which the event is being emitted */
    name: string;

    /** the type of the resource for which the event is being emitted */
    type: string;

    /** properties in the payload of the resource for which the event is being emitted */
    #suppress "@azure-tools/typespec-azure-core/bad-record-type" "The type of properties is object with additionalProperties object"
    @visibility(Lifecycle.Read)
    properties: Record<unknown>;
  };

  /** details about operational info */
  operationalInfo: ResourceNotificationsOperationalDetails;

  /** api version of the resource properties bag */
  apiVersion: string;
}
