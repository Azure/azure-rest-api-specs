import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.StorageActions;

@@clientName(Microsoft.StorageActions, "StorageActionsMgmtClient", "python");
@@clientName(Microsoft.StorageActions,
  "StorageActionsManagementClient",
  "javascript"
);

@@clientName(StorageTaskOperation, "StorageTaskOperationInfo", "csharp");
@@clientName(OnSuccess, "OnSuccessAction", "csharp");
@@clientName(OnFailure, "OnFailureAction", "csharp");
@@clientName(ElseCondition, "StorageTaskElseCondition", "csharp");
@@clientName(IfCondition, "StorageTaskIfCondition", "csharp");
@@clientName(ProvisioningState, "StorageTaskProvisioningState", "csharp");
@@clientName(RunResult, "StorageTaskRunResult", "csharp");
@@clientName(RunStatusEnum, "StorageTaskRunStatus", "csharp");
@@clientName(StorageTaskProperties.enabled, "IsEnabled", "csharp");
@@clientName(StorageTasks.storageTaskAssignmentList,
  "GetStorageTaskAssignments",
  "csharp"
);
@@clientName(StorageTasksOperationGroup.previewActions,
  "PreviewActions",
  "csharp"
);

@@clientName(StorageTasks.storageTaskAssignmentList,
  "list",
  "java,javascript,python,go"
);
