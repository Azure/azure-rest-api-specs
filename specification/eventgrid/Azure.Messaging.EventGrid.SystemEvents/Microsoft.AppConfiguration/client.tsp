import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.AppConfigurationKeyValueModifiedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.AppConfigurationKeyValueModifiedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.AppConfigurationKeyValueDeletedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.AppConfigurationKeyValueDeletedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.AppConfigurationSnapshotEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.AppConfigurationSnapshotEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.AppConfigurationSnapshotCreatedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.AppConfigurationSnapshotCreatedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.AppConfigurationSnapshotModifiedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.AppConfigurationSnapshotModifiedEventData,
  Access.public
);
//Enums
