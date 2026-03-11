import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.ContainerRegistry;

@@clientName(Microsoft.ContainerRegistry,
  "ContainerRegistryTasksManagementClient",
  "javascript"
);

@@clientName(Architecture.`386`, "ThreeHundredEightySix", "javascript");
@@clientName(Architecture.`386`, "X86_386", "java");

@@clientName(Microsoft.ContainerRegistry,
  "ContainerRegistryTasksMgmtClient",
  "python"
);

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
@@clientName(RunRequest, "RunContent", "csharp");
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

// C# client naming: prefix generic names with service context
@@clientName(Credentials, "ContainerRegistryTaskCredentials", "csharp");
@@clientName(Argument, "ContainerRegistryTaskArgument", "csharp");
@@clientName(OS, "ContainerRegistryTaskOS", "csharp");
@@clientName(Architecture, "ContainerRegistryTaskArchitecture", "csharp");
@@clientName(Variant, "ContainerRegistryTaskVariant", "csharp");
@@clientName(ProvisioningState,
  "ContainerRegistryTaskProvisioningState",
  "csharp"
);
@@clientName(SetValue, "ContainerRegistryTaskSetValue", "csharp");
@@clientName(SecretObject, "ContainerRegistryTaskSecretObject", "csharp");
@@clientName(SecretObjectType,
  "ContainerRegistryTaskSecretObjectType",
  "csharp"
);
@@clientName(TokenType, "ContainerRegistryTaskTokenType", "csharp");
@@clientName(RunType, "ContainerRegistryTaskRunType", "csharp");
@@clientName(RunStatus, "ContainerRegistryTaskRunStatus", "csharp");
@@clientName(TaskStatus, "ContainerRegistryTaskStatus", "csharp");
@@clientName(TriggerStatus, "ContainerRegistryTaskTriggerStatus", "csharp");
