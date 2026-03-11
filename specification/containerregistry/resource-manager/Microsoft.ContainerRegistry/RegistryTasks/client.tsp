import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
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

// C# client naming: fix enum value casing
@@clientName(SecretObjectType.Vaultsecret, "VaultSecret", "csharp");
@@clientName(SourceTriggerEvent.pullrequest, "PullRequest", "csharp");

// C# client naming: property renames
@@clientName(AuthInfo.expiresIn, "ExpiresInSeconds", "csharp");
@@clientName(AuthInfoUpdateParameters.expiresIn, "ExpiresInSeconds", "csharp");
@@clientName(DockerBuildRequest.noCache, "IsCacheDisabled", "csharp");
@@clientName(DockerBuildStep.noCache, "IsCacheDisabled", "csharp");
@@clientName(DockerBuildStepUpdateParameters.noCache,
  "IsCacheDisabled",
  "csharp"
);
@@clientName(RunProperties.createTime, "CreatedOn", "csharp");
@@clientName(RunFilter.createTime, "CreatedOn", "csharp");

// C# type correctness
@@alternateType(AgentPoolProperties.virtualNetworkSubnetResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(TaskRun.location, azureLocation, "csharp");
@@alternateType(SourceProperties.repositoryUrl, url, "csharp");
@@alternateType(SourceTriggerDescriptor.repositoryUrl, url, "csharp");
