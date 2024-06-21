import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
//Models
@@usage(Microsoft.EventGrid.SystemEvents.Web.AppEventTypeDetail, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.Web.AppEventTypeDetail, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.Web.WebAppUpdatedEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.Web.WebAppUpdatedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Web.WebBackupOperationStartedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Web.WebBackupOperationStartedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Web.WebBackupOperationCompletedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Web.WebBackupOperationCompletedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Web.WebBackupOperationFailedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Web.WebBackupOperationFailedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Web.WebRestoreOperationStartedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Web.WebRestoreOperationStartedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Web.WebRestoreOperationCompletedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Web.WebRestoreOperationCompletedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Web.WebRestoreOperationFailedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Web.WebRestoreOperationFailedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Web.WebSlotSwapStartedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Web.WebSlotSwapStartedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Web.WebSlotSwapCompletedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Web.WebSlotSwapCompletedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Web.WebSlotSwapFailedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Web.WebSlotSwapFailedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Web.WebSlotSwapWithPreviewStartedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Web.WebSlotSwapWithPreviewStartedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Web.WebSlotSwapWithPreviewCancelledEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Web.WebSlotSwapWithPreviewCancelledEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Web.WebAppServicePlanUpdatedEventData,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Web.WebAppServicePlanUpdatedEventData,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Web.AppServicePlanEventTypeDetail,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Web.AppServicePlanEventTypeDetail,
  Access.public
);
@@usage(Microsoft.EventGrid.SystemEvents.Web.WebAppServicePlanUpdatedEventDataSku,
  Usage.output
);
@@access(Microsoft.EventGrid.SystemEvents.Web.WebAppServicePlanUpdatedEventDataSku,
  Access.public
);
//Enums
@@usage(Microsoft.EventGrid.SystemEvents.Web.AppAction, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.Web.AppAction, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.Web.StampKind, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.Web.StampKind, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.Web.AppServicePlanAction, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.Web.AppServicePlanAction, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.Web.AsyncStatus, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.Web.AsyncStatus, Access.public);
