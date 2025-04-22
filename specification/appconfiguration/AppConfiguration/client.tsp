import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using AzureAppConfiguration;

namespace SdkCustomizations;

// Python specific customizations
@@clientName(KeyValueFields, "ConfigurationSettingFields", "python");
@@clientName(CompositionType, "SnapshotComposition", "python");
@@access(putKeyValue, Access.internal, "python");
@@access(updateSnapshot, Access.internal, "python");
@@access(SnapshotUpdateParameters, Access.public, "python");

// Java specific customizations
// Hide models
@@access(SnapshotUpdateParameters, Access.internal, "java");

// Rename model names
@@clientName(KeyValueFilter, "ConfigurationSettingsFilter", "java");
@@clientName(Snapshot, "ConfigurationSnapshot", "java");
@@clientName(Label, "SettingLabel", "java");
@@clientName(SnapshotStatus, "ConfigurationSnapshotStatus", "java");
@@clientName(CompositionType, "SnapshotComposition", "java");
@@clientName(LabelFields, "SettingLabelFields", "java");
@@clientName(KeyValueFields, "SettingFields", "java");
// Rename method names
@@clientName(KeyValueFields.locked, "isReadOnly", "java");
@@clientName(SnapshotFields.composition_type, "snapshotComposition", "java");
@@clientName(SnapshotFields.created, "createdAt", "java");
@@clientName(SnapshotFields.expires, "expiresAt", "java");
@@clientName(SnapshotFields.size, "sizeInBytes", "java");
@@clientName(SnapshotFields.items_count, "itemCount", "java");
@@clientName(Snapshot.compositionType, "snapshotComposition", "java");
@@clientName(Snapshot.created, "createdAt", "java");
@@clientName(Snapshot.expires, "expiresAt", "java");
@@clientName(Snapshot.size, "sizeInBytes", "java");
@@clientName(Snapshot.itemsCount, "itemCount", "java");
@@clientName(Snapshot.etag, "eTag", "java");
