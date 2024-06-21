import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.DataBox.DataBoxCopyStartedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.DataBox.DataBoxCopyStartedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.DataBox.DataBoxCopyCompletedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.DataBox.DataBoxCopyCompletedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.DataBox.DataBoxOrderCompletedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.DataBox.DataBoxOrderCompletedEventData,
  Access.public
);
//Enums
@@usage(Microsoft.EventGrid.SystemEvents.DataBox.DataBoxStageName, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.DataBox.DataBoxStageName, Access.public);
