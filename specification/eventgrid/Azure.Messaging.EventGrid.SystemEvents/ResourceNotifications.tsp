@doc("""
Describes the schema of the Health Resources events published to Azure Event
Grid. This corresponds to the Data property of an EventGridEvent.
""")
namespace Microsoft.EventGrid.SystemEvents;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.ResourceNotifications.HealthResources.AvailabilityStatusChanged
event.
""")
model ResourceNotificationsHealthResourcesAvailabilityStatusChangedEventData
  extends ResourceNotificationsResourceUpdatedEventData {}

/** Describes the schema of the common properties across all ARN system topic events */
model ResourceNotificationsResourceUpdatedEventData {
  /** resourceInfo details for update event */
  @projectedName("json", "resourceInfo")
  resourceDetails?: ResourceNotificationsResourceUpdatedDetails;

  /** details about operational info */
  @projectedName("json", "operationalInfo")
  operationalDetails?: ResourceNotificationsOperationalDetails;

  /** api version of the resource properties bag */
  apiVersion?: string;
}

@doc("""
Describes the schema of the properties under resource info which are common
across all ARN system topic events
""")
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
  tags?: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "The type of properties is object with additionalProperties object"
  /** properties in the payload of the resource for which the event is being emitted */
  properties?: Record<unknown>;
}

/** details of operational info */
model ResourceNotificationsOperationalDetails {
  /** Date and Time when resource was updated */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resourceEventTime?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.ResourceNotifications.HealthResources.ResourceAnnotated event.
""")
model ResourceNotificationsHealthResourcesAnnotatedEventData
  extends ResourceNotificationsResourceUpdatedEventData {}

// Resources.json

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.ResourceNotifications.Resources.CreatedOrUpdated event.
""")
model ResourceNotificationsResourceManagementCreatedOrUpdatedEventData
  extends ResourceNotificationsResourceUpdatedEventData {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.ResourceNotifications.Resources.Deleted event.
""")
model ResourceNotificationsResourceManagementDeletedEventData
  extends ResourceNotificationsResourceDeletedEventData {}

@doc("""
Describes the schema of the common properties across all ARN system topic
delete events
""")
model ResourceNotificationsResourceDeletedEventData {
  /** resourceInfo details for delete event */
  @projectedName("json", "resourceInfo")
  resourceDetails?: ResourceNotificationsResourceDeletedDetails;

  /** details about operational info */
  @projectedName("json", "operationalInfo")
  operationalDetails?: ResourceNotificationsOperationalDetails;
}

@doc("""
Describes the schema of the properties under resource info which are common
across all ARN system topic delete events
""")
model ResourceNotificationsResourceDeletedDetails {
  /** id of the resource for which the event is being emitted */
  id?: string;

  /** name of the resource for which the event is being emitted */
  name?: string;

  /** the type of the resource for which the event is being emitted */
  type?: string;
}
