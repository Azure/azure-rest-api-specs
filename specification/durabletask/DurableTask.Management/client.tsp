import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DurableTask;

@@clientNamespace(Microsoft.DurableTask,
  "com.azure.resourcemanager.durabletask",
  "java"
);
@@clientName(Microsoft.DurableTask, "DurableTaskMgmtClient", "python");
@@clientName(Microsoft.DurableTask, "DurableTaskManagementClient", "java");

// csharp
@@clientName(Scheduler, "DurableTaskScheduler", "csharp");
@@clientName(SchedulerProperties, "DurableTaskSchedulerProperties", "csharp");
@@clientName(TaskHub, "DurableTaskHub", "csharp");
@@clientName(TaskHubProperties, "DurableTaskHubProperties", "csharp");
@@clientName(ProvisioningState, "DurableTaskProvisioningState", "csharp");
@@clientName(SchedulerUpdate, "DurableTaskSchedulerPatch", "csharp");
@@clientName(SchedulerPropertiesUpdate,
  "DurableTaskSchedulerPatchProperties",
  "csharp"
);
@@clientName(SchedulerSku, "DurableTaskSchedulerSku", "csharp");
@@clientName(SchedulerSkuName, "DurableTaskSchedulerSkuName", "csharp");
@@clientName(SchedulerSkuUpdate, "DurableTaskSchedulerSkuUpdate", "csharp");
@@clientName(RedundancyState, "DurableTaskResourceRedundancyState", "csharp");
@@clientName(PurgeableOrchestrationState,
  "DurableTaskPurgeableOrchestrationState",
  "csharp"
);
@@clientName(RetentionPolicyDetails,
  "DurableTaskRetentionPolicyDetails",
  "csharp"
);
@@clientName(RetentionPolicy, "DurableTaskRetentionPolicy", "csharp");
@@clientName(RetentionPolicyProperties,
  "DurableTaskRetentionPolicyProperties",
  "csharp"
);
@@clientName(SchedulerProperties.ipAllowlist, "IPAllowlist", "csharp");
@@clientName(SchedulerPropertiesUpdate.ipAllowlist, "IPAllowlist", "csharp");
