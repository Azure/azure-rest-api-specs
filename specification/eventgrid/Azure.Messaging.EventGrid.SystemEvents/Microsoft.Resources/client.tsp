import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.ResourceWriteSuccessEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ResourceWriteSuccessEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceWriteFailureEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ResourceWriteFailureEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceWriteCancelEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ResourceWriteCancelEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceDeleteSuccessEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ResourceDeleteSuccessEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceDeleteFailureEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ResourceDeleteFailureEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceDeleteCancelEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ResourceDeleteCancelEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceActionSuccessEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ResourceActionSuccessEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceActionFailureEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ResourceActionFailureEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceActionCancelEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.ResourceActionCancelEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceHttpRequest, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ResourceHttpRequest, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceAuthorization, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ResourceAuthorization, Access.public);
//Enums
