/** Describes the schema of the Azure App Configuration events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;
// need to figure out an alternative to this method --- should we pass in docstring here or should we just copy/paste and see what happens
/** Schema of the Data property of an EventGridEvent for a Microsoft.AppConfiguration.KeyValueModified event. */
model AppConfigurationKeyValueModifiedEventData {
  /** The key used to identify the key-value that was modified. */
  key?: string;

  /** The label, if any, used to identify the key-value that was modified. */
  label?: string;

  /** The etag representing the new state of the key-value. */
  etag?: string;

  /** The sync token representing the server state after the event. */
  syncToken?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.AppConfiguration.KeyValueDeleted event. */
model AppConfigurationKeyValueDeletedEventData {
  /** The key used to identify the key-value that was deleted. */
  key?: string;

  /** The label, if any, used to identify the key-value that was deleted. */
  label?: string;

  /** The etag representing the key-value that was deleted. */
  etag?: string;

  /** The sync token representing the server state after the event. */
  syncToken?: string;
}

/** Schema of common properties of snapshot events */
model AppConfigurationSnapshotEventData {
  /** The name of the snapshot. */
  name?: string;

  /** The etag representing the new state of the snapshot. */
  etag?: string;

  /** The sync token representing the server state after the event. */
  syncToken?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.AppConfiguration.SnapshotCreated event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AppConfigurationSnapshotCreatedEventData
  extends AppConfigurationSnapshotEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.AppConfiguration.SnapshotModified event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AppConfigurationSnapshotModifiedEventData
  extends AppConfigurationSnapshotEventData {}
