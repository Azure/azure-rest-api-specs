import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ContainerRegistry;

// Flatten properties for backward compatibility
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AgentPool.properties,
  "autorest,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Run.properties,
  "autorest,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Task.properties,
  "autorest,python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(TaskRun.properties,
  "autorest,python"
);

@@clientName(AgentPools.create::parameters.resource, "agentPool");
@@clientName(AgentPools.update::parameters.properties, "updateParameters");

@@clientName(Runs.update::parameters.properties, "runUpdateParameters");

@@clientName(TaskRuns.create::parameters.resource, "taskRun");
@@clientName(TaskRuns.update::parameters.properties, "updateParameters");

@@clientName(Tasks.create::parameters.resource, "taskCreateParameters");
@@clientName(Tasks.update::parameters.properties, "taskUpdateParameters");

@@clientName(Registries.scheduleRun::parameters.body, "runRequest");

@@clientName(Architecture.`386`, "ThreeHundredEightySix", "go");
@@clientName(Architecture.`386`, "THREE_HUNDRED_EIGHTY_SIX", "python");

// C# client naming: avoid suffixes "Request", "Parameters", "Definition" (AZC0030/AZC0031)
@@clientName(AuthInfoUpdateParameters, "AuthInfoUpdateContent", "csharp");
@@clientName(BaseImageTriggerUpdateParameters,
  "BaseImageTriggerUpdateContent",
  "csharp"
);
@@clientName(DockerBuildRequest, "DockerBuildContent", "csharp");
@@clientName(DockerBuildStepUpdateParameters,
  "DockerBuildStepUpdateContent",
  "csharp"
);
@@clientName(EncodedTaskRunRequest, "EncodedTaskRunContent", "csharp");
@@clientName(EncodedTaskStepUpdateParameters,
  "EncodedTaskStepUpdateContent",
  "csharp"
);
@@clientName(FileTaskRunRequest, "FileTaskRunContent", "csharp");
@@clientName(FileTaskStepUpdateParameters,
  "FileTaskStepUpdateContent",
  "csharp"
);
@@clientName(PlatformUpdateParameters, "PlatformUpdateContent", "csharp");
@@clientName(SourceTriggerUpdateParameters,
  "SourceTriggerUpdateContent",
  "csharp"
);
@@clientName(SourceUpdateParameters, "SourceUpdateContent", "csharp");
@@clientName(SourceUploadDefinition, "SourceUploadResult", "csharp");
@@clientName(TaskRunRequest, "TaskRunContent", "csharp");
@@clientName(TaskStepUpdateParameters, "TaskStepUpdateContent", "csharp");
@@clientName(TimerTriggerUpdateParameters,
  "TimerTriggerUpdateContent",
  "csharp"
);
@@clientName(TriggerUpdateParameters, "TriggerUpdateContent", "csharp");
