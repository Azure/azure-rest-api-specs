import "@typespec/versioning";

using TypeSpec.Versioning;

/** Describes the schema of the Azure App Service events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents {
  // /** sku of app service plan. */
  /** Detail of action on the app. */
  model AppEventTypeDetail {
    /** Type of action of the operation. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    action: AppAction;
  }

  const MicrosoftWebAppUpdatedExample: WebAppUpdatedEventData = #{
    appEventTypeDetail: #{ action: "Stopped" },
    name: "{site-name}",
    clientRequestId: "64a5e0aa-7cee-4ff1-9093-b9197b820014",
    correlationRequestId: "25bb36a5-8f6c-4f04-b615-e9a0ee045756",
    requestId: "f2e8eb3f-b190-42de-b99e-6acefe587374",
    address: "/websystems/WebSites/web/subscriptions/{subscription-id}/webspaces/{webspace}/sites/{site-name}/stop",
    verb: "POST",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Web.AppUpdated event. */
  @example(MicrosoftWebAppUpdatedExample)
  model WebAppUpdatedEventData {
    ...WebAppBaseEventData;
  }

  const MicrosoftWebBackupOperationStartedExample: WebBackupOperationStartedEventData = #{
    appEventTypeDetail: #{ action: "Started" },
    name: "{site-name}",
    clientRequestId: "None",
    correlationRequestId: "None",
    requestId: "292f499d-04ee-4066-994d-c2df57b99198",
    address: "None",
    verb: "None",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Web.BackupOperationStarted event. */
  @example(MicrosoftWebBackupOperationStartedExample)
  model WebBackupOperationStartedEventData {
    ...WebAppBaseEventData;
  }

  const MicrosoftWebBackupOperationCompletedExample: WebBackupOperationCompletedEventData = #{
    appEventTypeDetail: #{ action: "Started" },
    name: "{site-name}",
    clientRequestId: "None",
    correlationRequestId: "None",
    requestId: "292f499d-04ee-4066-994d-c2df57b99198",
    address: "None",
    verb: "None",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Web.BackupOperationCompleted event. */
  @example(MicrosoftWebBackupOperationCompletedExample)
  model WebBackupOperationCompletedEventData {
    ...WebAppBaseEventData;
  }

  const MicrosoftWebBackupOperationFailedExample: WebBackupOperationFailedEventData = #{
    appEventTypeDetail: #{ action: "Started" },
    name: "{site-name}",
    clientRequestId: "None",
    correlationRequestId: "None",
    requestId: "292f499d-04ee-4066-994d-c2df57b99198",
    address: "None",
    verb: "None",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Web.BackupOperationFailed event. */
  @example(MicrosoftWebBackupOperationFailedExample)
  model WebBackupOperationFailedEventData {
    ...WebAppBaseEventData;
  }

  const MicrosoftWebRestoreOperationStartedExample: WebRestoreOperationStartedEventData = #{
    appEventTypeDetail: #{ action: "Started" },
    name: "{site-name}",
    clientRequestId: "None",
    correlationRequestId: "None",
    requestId: "292f499d-04ee-4066-994d-c2df57b99198",
    address: "None",
    verb: "POST",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Web.RestoreOperationStarted event. */
  @example(MicrosoftWebRestoreOperationStartedExample)
  model WebRestoreOperationStartedEventData {
    ...WebAppBaseEventData;
  }

  const MicrosoftWebRestoreOperationCompletedExample: WebRestoreOperationCompletedEventData = #{
    appEventTypeDetail: #{ action: "Started" },
    name: "{site-name}",
    clientRequestId: "None",
    correlationRequestId: "None",
    requestId: "292f499d-04ee-4066-994d-c2df57b99198",
    address: "None",
    verb: "POST",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Web.RestoreOperationCompleted event. */
  @example(MicrosoftWebRestoreOperationCompletedExample)
  model WebRestoreOperationCompletedEventData {
    ...WebAppBaseEventData;
  }

  const MicrosoftWebRestoreOperationFailedExample: WebRestoreOperationFailedEventData = #{
    appEventTypeDetail: #{ action: "Started" },
    name: "{site-name}",
    clientRequestId: "None",
    correlationRequestId: "None",
    requestId: "292f499d-04ee-4066-994d-c2df57b99198",
    address: "None",
    verb: "POST",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Web.RestoreOperationFailed event. */
  @example(MicrosoftWebRestoreOperationFailedExample)
  model WebRestoreOperationFailedEventData {
    ...WebAppBaseEventData;
  }

  // TODO source slot and target slot are not required in the schema
  const MicrosoftWebSlotSwapStartedExample: WebSlotSwapStartedEventData = #{
    appEventTypeDetail: null,
    name: "{site-name}",
    clientRequestId: "922f4841-20d9-4dd6-8c5b-23f0d85e5592",
    correlationRequestId: "9ac46505-2b8a-4e06-834c-05ffbe2e8c3a",
    requestId: "765117aa-eaf8-4bd2-a644-1dbf69c7b0fd",
    address: "/websystems/WebSites/web/subscriptions/{subscription-id}/webspaces/{webspace}/sites/{site-name}/slots?Command=SWAP&targetSlot=production",
    verb: "POST",
    // sourceSlot: "staging",
    // targetSlot: "production",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Web.SlotSwapStarted event. */
  @example(MicrosoftWebSlotSwapStartedExample)
  model WebSlotSwapStartedEventData {
    ...WebAppBaseEventData;
  }

  // TODO source slot and target slot are not required in the schema
  const MicrosoftWebSlotSwapCompletedExample: WebSlotSwapCompletedEventData = #{
    appEventTypeDetail: null,
    name: "{site-name}",
    clientRequestId: "922f4841-20d9-4dd6-8c5b-23f0d85e5592",
    correlationRequestId: "9ac46505-2b8a-4e06-834c-05ffbe2e8c3a",
    requestId: "765117aa-eaf8-4bd2-a644-1dbf69c7b0fd",
    address: "/websystems/WebSites/web/subscriptions/{subscription-id}/webspaces/{webspace}/sites/{site-name}/slots?Command=SWAP&targetSlot=production",
    verb: "POST",
    // sourceSlot: "staging",
    // targetSlot: "production",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Web.SlotSwapCompleted event. */
  @example(MicrosoftWebSlotSwapCompletedExample)
  model WebSlotSwapCompletedEventData {
    ...WebAppBaseEventData;
  }

  // TODO source slot and target slot are not required in the schema
  const MicrosoftWebSlotSwapFailedExample: WebSlotSwapFailedEventData = #{
    appEventTypeDetail: null,
    name: "{site-name}",
    clientRequestId: "922f4841-20d9-4dd6-8c5b-23f0d85e5592",
    correlationRequestId: "9ac46505-2b8a-4e06-834c-05ffbe2e8c3a",
    requestId: "765117aa-eaf8-4bd2-a644-1dbf69c7b0fd",
    address: "/websystems/WebSites/web/subscriptions/{subscription-id}/webspaces/{webspace}/sites/{site-name}/slots?Command=SWAP&targetSlot=production",
    verb: "POST",
    // sourceSlot: "staging",
    // targetSlot: "production",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Web.SlotSwapFailed event. */
  @example(MicrosoftWebSlotSwapFailedExample)
  model WebSlotSwapFailedEventData {
    ...WebAppBaseEventData;
  }

  // TODO source slot and target slot are not required in the schema
  const MicrosoftWebSlotSwapWithPreviewStartedExample: WebSlotSwapWithPreviewStartedEventData = #{
    appEventTypeDetail: null,
    name: "{site-name}",
    clientRequestId: "922f4841-20d9-4dd6-8c5b-23f0d85e5592",
    correlationRequestId: "9ac46505-2b8a-4e06-834c-05ffbe2e8c3a",
    requestId: "765117aa-eaf8-4bd2-a644-1dbf69c7b0fd",
    address: "/websystems/WebSites/web/subscriptions/{subscription-id}/webspaces/{webspace}/sites/{site-name}/slots?Command=SWAP&targetSlot=production",
    verb: "POST",
    // sourceSlot: "staging",
    // targetSlot: "production",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Web.SlotSwapWithPreviewStarted event. */
  @example(MicrosoftWebSlotSwapWithPreviewStartedExample)
  model WebSlotSwapWithPreviewStartedEventData {
    ...WebAppBaseEventData;
  }

  // TODO source slot and target slot are not required in the schema
  const MicrosoftWebSlotSwapWithPreviewCancelledExample: WebSlotSwapWithPreviewCancelledEventData = #{
    appEventTypeDetail: null,
    name: "{site-name}",
    clientRequestId: "922f4841-20d9-4dd6-8c5b-23f0d85e5592",
    correlationRequestId: "9ac46505-2b8a-4e06-834c-05ffbe2e8c3a",
    requestId: "765117aa-eaf8-4bd2-a644-1dbf69c7b0fd",
    address: "/websystems/WebSites/web/subscriptions/{subscription-id}/webspaces/{webspace}/sites/{site-name}/slots?Command=SWAP&targetSlot=production",
    verb: "POST",
    // sourceSlot: "staging",
    // targetSlot: "production",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Web.SlotSwapWithPreviewCancelled event. */
  @example(MicrosoftWebSlotSwapWithPreviewCancelledExample)
  model WebSlotSwapWithPreviewCancelledEventData {
    ...WebAppBaseEventData;
  }

  const MicrosoftWebAppServicePlanUpdatedExample: WebAppServicePlanUpdatedEventData = #{
    appServicePlanEventTypeDetail: #{
      stampKind: "Public",
      action: "Updated",
      status: "Started",
    },
    sku: #{
      name: "P1v2",
      tier: "PremiumV2",
      size: "P1v2",
      family: "Pv2",
      capacity: "1",
    },
    clientRequestId: "8f880321-a991-45c7-b743-6ff63fe4c004",
    correlationRequestId: "1995c3be-ba7f-4ccf-94af-516df637ec8a",
    requestId: "b973a8e6-6949-4783-b44c-ac778be831bb",
    address: "/websystems/WebSites/serverfarms/subscriptions/{subscription-id}/webspaces/{webspace-id}/serverfarms/{plan-name}/async",
    verb: "PUT",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Web.AppServicePlanUpdated event. */
  @example(MicrosoftWebAppServicePlanUpdatedExample)
  model WebAppServicePlanUpdatedEventData {
    /** Detail of action on the app service plan. */
    appServicePlanEventTypeDetail: AppServicePlanEventTypeDetail;

    /** sku of app service plan. */
    sku: WebAppServicePlanUpdatedEventDataSku;

    /** name of the app service plan that had this event. */
    name?: string;

    /** The client request id generated by the app service for the app service plan API operation that triggered this event. */
    clientRequestId?: string;

    /** The correlation request id generated by the app service for the app service plan API operation that triggered this event. */
    correlationRequestId?: string;

    /** The request id generated by the app service for the app service plan API operation that triggered this event. */
    requestId?: string;

    /** HTTP request URL of this operation. */
    address?: string;

    /** HTTP verb of this operation. */
    verb?: string;
  }

  /** Type of action of the operation */
  union AppAction {
    /** Web app was restarted. */
    "Restarted",

    /** Web app was stopped. */
    "Stopped",

    /** There was an operation to change app setting on the web app. */
    "ChangedAppSettings",

    /** The job has started. */
    "Started",

    /** The job has completed. */
    "Completed",

    /** The job has failed to complete. */
    "Failed",

    string,
  }

  /** Kind of environment where app service plan is. */
  union StampKind {
    /** App Service Plan is running on a public stamp. */
    "Public",

    /** App Service Plan is running on an App Service Environment V1. */
    "AseV1",

    /** App Service Plan is running on an App Service Environment V2. */
    "AseV2",

    string,
  }

  /** Type of action on the app service plan. */
  union AppServicePlanAction {
    /** App Service plan is being updated. */
    "Updated",

    string,
  }

  /** Detail of action on the app service plan. */
  model AppServicePlanEventTypeDetail {
    /** Kind of environment where app service plan is. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    stampKind: StampKind;

    /** Type of action on the app service plan. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    action: AppServicePlanAction;

    /** Asynchronous operation status of the operation on the app service plan. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    status: AsyncStatus;
  }

  /** Asynchronous operation status of the operation on the app service plan. */
  union AsyncStatus {
    /** Async operation has started. */
    "Started",

    /** Async operation has completed. */
    "Completed",

    /** Async operation failed to complete. */
    "Failed",

    string,
  }

  alias WebAppBaseEventData = {
    /** Detail of action on the app. */
    appEventTypeDetail: AppEventTypeDetail | null;

    /** name of the web site that had this event. */
    name?: string;

    /** The client request id generated by the app service for the site API operation that triggered this event. */
    clientRequestId?: string;

    /** The correlation request id generated by the app service for the site API operation that triggered this event. */
    correlationRequestId?: string;

    /** The request id generated by the app service for the site API operation that triggered this event. */
    requestId?: string;

    /** HTTP request URL of this operation. */
    address?: string;

    /** HTTP verb of this operation. */
    verb?: string;
  };

  /** sku of app service plan. */
  model WebAppServicePlanUpdatedEventDataSku {
    /** name of app service plan sku. */
    name?: string;

    /** tier of app service plan sku. */
    tier?: string;

    /** size of app service plan sku. */
    size?: string;

    /** family of app service plan sku. */
    family?: string;

    /** capacity of app service plan sku. */
    capacity?: string;
  }
}
