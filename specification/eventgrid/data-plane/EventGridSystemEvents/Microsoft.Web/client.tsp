import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.AppEventTypeDetail,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.AppEventTypeDetail, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.WebAppUpdatedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.WebAppUpdatedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.WebBackupOperationStartedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.WebBackupOperationStartedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.WebBackupOperationCompletedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.WebBackupOperationCompletedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.WebBackupOperationFailedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.WebBackupOperationFailedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.WebRestoreOperationStartedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.WebRestoreOperationStartedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.WebRestoreOperationCompletedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.WebRestoreOperationCompletedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.WebRestoreOperationFailedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.WebRestoreOperationFailedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.WebSlotSwapStartedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.WebSlotSwapStartedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.WebSlotSwapCompletedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.WebSlotSwapCompletedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.WebSlotSwapFailedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.WebSlotSwapFailedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.WebSlotSwapWithPreviewStartedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.WebSlotSwapWithPreviewStartedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.WebSlotSwapWithPreviewCancelledEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.WebSlotSwapWithPreviewCancelledEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.WebAppServicePlanUpdatedEventData,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.WebAppServicePlanUpdatedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.AppServicePlanEventTypeDetail,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.AppServicePlanEventTypeDetail,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.WebAppServicePlanUpdatedEventDataSku,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.WebAppServicePlanUpdatedEventDataSku,
  Access.public
);
//Enums
@@usage(Microsoft.EventGrid.SystemEvents.AppAction, Usage.output | Usage.json);
@@access(Microsoft.EventGrid.SystemEvents.AppAction, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.StampKind, Usage.output | Usage.json);
@@access(Microsoft.EventGrid.SystemEvents.StampKind, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.AppServicePlanAction,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.AppServicePlanAction, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.AsyncStatus,
  Usage.output | Usage.json
);
@@access(Microsoft.EventGrid.SystemEvents.AsyncStatus, Access.public);

//useSystemTextJsonConverter decorators
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.WebAppUpdatedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.WebAppServicePlanUpdatedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.WebBackupOperationCompletedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.WebBackupOperationFailedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.WebBackupOperationStartedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.WebRestoreOperationCompletedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.WebRestoreOperationFailedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.WebRestoreOperationStartedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.WebSlotSwapCompletedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.WebSlotSwapFailedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.WebSlotSwapStartedEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.WebSlotSwapWithPreviewCancelledEventData,
  "csharp"
);
@@useSystemTextJsonConverter(Microsoft.EventGrid.SystemEvents.WebSlotSwapWithPreviewStartedEventData,
  "csharp"
);
