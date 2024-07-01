import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.AppConfiguration.AppConfigurationKeyValueModifiedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.AppConfiguration.AppConfigurationKeyValueModifiedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.AppConfiguration.AppConfigurationKeyValueDeletedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.AppConfiguration.AppConfigurationKeyValueDeletedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.AppConfiguration.AppConfigurationSnapshotEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.AppConfiguration.AppConfigurationSnapshotEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.AppConfiguration.AppConfigurationSnapshotCreatedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.AppConfiguration.AppConfigurationSnapshotCreatedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.AppConfiguration.AppConfigurationSnapshotModifiedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.AppConfiguration.AppConfigurationSnapshotModifiedEventData,
  Access.public
);
//Enums
