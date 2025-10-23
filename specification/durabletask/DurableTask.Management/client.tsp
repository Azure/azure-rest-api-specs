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
@@clientName(Scheduler, "Scheduler", "csharp");
@@clientName(SchedulerProperties, "SchedulerProperties", "csharp");
@@clientName(TaskHub, "SchedulerTaskHub", "csharp");
@@clientName(TaskHubProperties, "SchedulerTaskHubProperties", "csharp");
@@clientName(ProvisioningState, "ProvisioningState", "csharp");
@@clientName(SchedulerUpdate, "SchedulerPatch", "csharp");
@@clientName(SchedulerPropertiesUpdate, "SchedulerPatchProperties", "csharp");
@@clientName(SchedulerSku, "SchedulerSku", "csharp");
@@clientName(SchedulerSkuUpdate, "SchedulerSkuUpdate", "csharp");
@@clientName(RedundancyState, "ResourceRedundancyState", "csharp");
@@clientName(PurgeableOrchestrationState,
  "PurgeableOrchestrationState",
  "csharp"
);
@@clientName(RetentionPolicyDetails, "RetentionPolicyDetails", "csharp");
@@clientName(RetentionPolicy, "RetentionPolicy", "csharp");
@@clientName(RetentionPolicyProperties, "RetentionPolicyProperties", "csharp");
