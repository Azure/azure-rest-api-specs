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
@@clientName(StorageTasksOperationGroup.previewActions,
  "PreviewActions",
  "csharp"
);

// we add this model in this namespace in order to replace some models with this model via alternateType decorator
namespace Azure.ResourceManager.Models {
  /** represents a reference to an existing resource by its id */
  model SubResource {
    /** the id */
    id?: armResourceIdentifier;
  }
}

@@alternateType(Microsoft.StorageActions.StorageTaskAssignmentsListResult.value,
  Azure.ResourceManager.Models.SubResource[],
  "csharp"
);
@@alternateType(TrackedResource.location, azureLocation, "csharp");
