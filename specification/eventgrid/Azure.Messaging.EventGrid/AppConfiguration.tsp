@doc("Describes the schema of the Azure App Configuration events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent.")
namespace Microsoft.EventGrid;
// need to figure out an alternative to this method --- should we pass in docstring here or should we just copy/paste and see what happens
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.AppConfiguration.KeyValueModified event.")
model AppConfigurationKeyValueModifiedEventData {
  @doc("The key used to identify the key-value that was modified.")
  key?: string;

  @doc("The label, if any, used to identify the key-value that was modified.")
  label?: string;

  @doc("The etag representing the new state of the key-value.")
  etag?: string;

  @doc("The sync token representing the server state after the event.")
  syncToken?: string;
}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.AppConfiguration.KeyValueDeleted event.")
model AppConfigurationKeyValueDeletedEventData {
  @doc("The key used to identify the key-value that was deleted.")
  key?: string;

  @doc("The label, if any, used to identify the key-value that was deleted.")
  label?: string;

  @doc("The etag representing the key-value that was deleted.")
  etag?: string;

  @doc("The sync token representing the server state after the event.")
  syncToken?: string;
}

@doc("Schema of common properties of snapshot events")
model AppConfigurationSnapshotEventData {
  @doc("The name of the snapshot.")
  name?: string;

  @doc("The etag representing the new state of the snapshot.")
  @friendlyName("ETag")
  etag?: string;

  @doc("The sync token representing the server state after the event.")
  syncToken?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.AppConfiguration.SnapshotCreated event.
""")
model AppConfigurationSnapshotCreatedEventData
  extends AppConfigurationSnapshotEventData {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.AppConfiguration.SnapshotModified event.
""")
model AppConfigurationSnapshotModifiedEventData
  extends AppConfigurationSnapshotEventData {}
