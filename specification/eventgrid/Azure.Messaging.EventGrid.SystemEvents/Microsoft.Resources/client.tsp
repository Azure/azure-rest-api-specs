import "@azure-tools/typespec-client-generator-core"; 
 
using Azure.ClientGenerator.Core; 
//Models 
@@usage(Microsoft.EventGrid.SystemEvents.ResourceWriteSuccessData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ResourceWriteSuccessData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceWriteFailureData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ResourceWriteFailureData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceWriteCancelData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ResourceWriteCancelData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceDeleteSuccessData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ResourceDeleteSuccessData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceDeleteFailureData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ResourceDeleteFailureData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceDeleteCancelData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ResourceDeleteCancelData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceActionSuccessData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ResourceActionSuccessData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceActionFailureData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ResourceActionFailureData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceActionCancelData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ResourceActionCancelData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceHttpRequest, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ResourceHttpRequest, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ResourceAuthorization, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ResourceAuthorization, Access.public);
//Enums 
