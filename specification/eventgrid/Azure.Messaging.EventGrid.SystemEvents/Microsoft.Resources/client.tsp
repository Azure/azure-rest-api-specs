import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.Resources.ResourceWriteSuccessEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Resources.ResourceWriteSuccessEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Resources.ResourceWriteFailureEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Resources.ResourceWriteFailureEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Resources.ResourceWriteCancelEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Resources.ResourceWriteCancelEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Resources.ResourceDeleteSuccessEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Resources.ResourceDeleteSuccessEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Resources.ResourceDeleteFailureEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Resources.ResourceDeleteFailureEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Resources.ResourceDeleteCancelEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Resources.ResourceDeleteCancelEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Resources.ResourceActionSuccessEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Resources.ResourceActionSuccessEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Resources.ResourceActionFailureEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Resources.ResourceActionFailureEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Resources.ResourceActionCancelEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Resources.ResourceActionCancelEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Resources.ResourceHttpRequest, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.Resources.ResourceHttpRequest, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.Resources.ResourceAuthorization, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.Resources.ResourceAuthorization, Access.public);
//Enums
