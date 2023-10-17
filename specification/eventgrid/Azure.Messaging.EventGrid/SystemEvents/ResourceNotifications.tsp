@doc("""
Describes the schema of the Health Resources events published to Azure Event
Grid. This corresponds to the Data property of an EventGridEvent.
""")
namespace EventGrid;


@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.ResourceNotifications.HealthResources.AvailabilityStatusChanged
event.
""")
model ResourceNotificationsHealthResourcesAvailabilityStatusChangedEventData {
  ...ResourceNotificationsResourceUpdatedEventData;
}

@doc("Describes the schema of the common properties across all ARN system topic events")
model ResourceNotificationsResourceUpdatedEventData {
  @doc("resourceInfo details for update event")
  @projectedName("json", "resourceInfo")
  resourceDetails?: ResourceNotificationsResourceUpdatedDetails;

  @doc("details about operational info")
  @projectedName("json", "operationalInfo")
  operationalDetails?: ResourceNotificationsOperationalDetails;

  @doc("api version of the resource properties bag")
  apiVersion?: string;
}

@doc("""
Describes the schema of the properties under resource info which are common
across all ARN system topic events
""")
model ResourceNotificationsResourceUpdatedDetails {
  @doc("id of the resource for which the event is being emitted")
  id?: string;

  @doc("name of the resource for which the event is being emitted")
  name?: string;

  @doc("the type of the resource for which the event is being emitted")
  type?: string;

  @doc("the location of the resource for which the event is being emitted")
  location?: string;

  @doc("the tags on the resource for which the event is being emitted")
  tags?: string;

  @doc("properties in the payload of the resource for which the event is being emitted")
  properties?: Record<unknown>;
}

@doc("details of operational info")
model ResourceNotificationsOperationalDetails {
  @doc("Date and Time when resource was updated")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  resourceEventTime?: utcDateTime;
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.ResourceNotifications.HealthResources.ResourceAnnotated event.
""")
model ResourceNotificationsHealthResourcesAnnotatedEventData {
  ...ResourceNotificationsResourceUpdatedEventData;
}

