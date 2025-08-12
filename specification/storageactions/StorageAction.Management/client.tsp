import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.ResourceManager.Foundations;
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
@@clientName(StorageTasks.list, "GetStorageTasksReports", "csharp");
// TODO -- we should not need this when https://github.com/Azure/azure-sdk-for-net/issues/51925 is resolved.
@@clientName(StorageTasks.listBySubscription, "GetStorageTasks", "csharp");
@@clientName(StorageTasksOperationGroup.previewActions,
  "PreviewActions",
  "csharp"
);

namespace Azure.ResourceManager.Models {
  model SubResource {}
}

@@alternateType(Microsoft.StorageActions.StorageTaskAssignmentsListResult.value,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
@@alternateType(TrackedResource.location, azureLocation, "csharp");
