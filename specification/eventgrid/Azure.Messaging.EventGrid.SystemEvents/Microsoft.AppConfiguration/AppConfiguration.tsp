import "@typespec/versioning";
using TypeSpec.Versioning;
/** Describes the schema of the Azure App Configuration events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;
// need to figure out an alternative to this method --- should we pass in docstring here or should we just copy/paste and see what happens
/** Schema of the Data property of an EventGridEvent for a Microsoft.AppConfiguration.KeyValueModified event. */
model AppConfigurationKeyValueModifiedEventData {
  /** The key used to identify the key-value that was modified. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  key: string;

  /** The label, if any, used to identify the key-value that was modified. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  label: string;

  /** The etag representing the new state of the key-value. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  etag: string;

  /** The sync token representing the server state after the event. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  syncToken: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.AppConfiguration.KeyValueDeleted event. */
model AppConfigurationKeyValueDeletedEventData {
  /** The key used to identify the key-value that was deleted. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  key: string;

  /** The label, if any, used to identify the key-value that was deleted. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  label: string;

  /** The etag representing the key-value that was deleted. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  etag: string;

  /** The sync token representing the server state after the event. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  syncToken: string;
}

/** Schema of common properties of snapshot events */
model AppConfigurationSnapshotEventData {
  /** The name of the snapshot. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  name: string;

  /** The etag representing the new state of the snapshot. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  etag: string;

  /** The sync token representing the server state after the event. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  syncToken: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.AppConfiguration.SnapshotCreated event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AppConfigurationSnapshotCreatedEventData
  extends AppConfigurationSnapshotEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.AppConfiguration.SnapshotModified event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AppConfigurationSnapshotModifiedEventData
  extends AppConfigurationSnapshotEventData {}
