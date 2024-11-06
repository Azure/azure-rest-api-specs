import "@typespec/versioning";
using TypeSpec.Versioning;
/**
Describes the schema of the Health Resources events published to Azure Event
Grid. This corresponds to the Data property of an EventGridEvent.
*/
namespace Microsoft.EventGrid.SystemEvents;

/**
Describes the schema of the properties under resource info which are common
across all ARN system topic events
*/
model ResourceNotificationsResourceUpdatedDetails {
  /** id of the resource for which the event is being emitted */
  id?: string;

  /** name of the resource for which the event is being emitted */
  name?: string;

  /** the type of the resource for which the event is being emitted */
  type?: string;

  /** the location of the resource for which the event is being emitted */
  location?: string;

  /** the tags on the resource for which the event is being emitted */
  tags: Record<string>;

  /** properties in the payload of the resource for which the event is being emitted */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "The type of properties is object with additionalProperties object"
  properties: Record<unknown>;
}

/** details of operational info */
model ResourceNotificationsOperationalDetails {
  /** Date and Time when resource was updated */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @madeRequired(ServiceApiVersions.v2024_01_01)
  resourceEventTime: utcDateTime;
}

/** Describes the schema of the common properties across all ARN system topic events */
model ResourceNotificationsResourceUpdatedEventData {
  /** resourceInfo details for update event */
  resourceInfo: ResourceNotificationsResourceUpdatedDetails;

  /** details about operational info */
  operationalInfo: ResourceNotificationsOperationalDetails;

  /** api version of the resource properties bag */
  apiVersion?: string;
}

/**
Describes the schema of the properties under resource info which are common
across all ARN system topic delete events
*/
model ResourceNotificationsResourceDeletedDetails {
  /** id of the resource for which the event is being emitted */
  id?: string;

  /** name of the resource for which the event is being emitted */
  name?: string;

  /** the type of the resource for which the event is being emitted */
  type?: string;
}

/**
Describes the schema of the common properties across all ARN system topic
delete events
*/
model ResourceNotificationsResourceDeletedEventData {
  /** resourceInfo details for delete event */
  resourceInfo: ResourceNotificationsResourceDeletedDetails;

  /** details about operational info */
  operationalInfo: ResourceNotificationsOperationalDetails;
}
