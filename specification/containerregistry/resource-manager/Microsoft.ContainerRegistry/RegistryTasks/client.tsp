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
@@clientName(AuthInfoUpdateParameters,
  "ContainerRegistryTaskAuthInfoUpdateContent",
  "csharp"
);
@@clientName(BaseImageTriggerUpdateParameters,
  "ContainerRegistryTaskBaseImageTriggerUpdateContent",
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
@@clientName(PlatformUpdateParameters,
  "ContainerRegistryTaskPlatformUpdateContent",
  "csharp"
);
@@clientName(RunRequest, "RunContent", "csharp");
@@clientName(SourceTriggerUpdateParameters,
  "ContainerRegistryTaskSourceTriggerUpdateContent",
  "csharp"
);
@@clientName(SourceUpdateParameters,
  "ContainerRegistryTaskSourceUpdateContent",
  "csharp"
);
@@clientName(SourceUploadDefinition,
  "ContainerRegistryTaskSourceUploadResult",
  "csharp"
);
@@clientName(TaskRunRequest, "TaskRunContent", "csharp");
@@clientName(TaskStepUpdateParameters, "TaskStepUpdateContent", "csharp");
@@clientName(TimerTriggerUpdateParameters,
  "ContainerRegistryTaskTimerTriggerUpdateContent",
  "csharp"
);
@@clientName(TriggerUpdateParameters,
  "ContainerRegistryTaskTriggerUpdateContent",
  "csharp"
);

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

// Property rename: 2-letter acronym "OS" must be uppercase (not "Os")
@@clientName(AgentPoolProperties.os, "OS", "csharp");
@@clientName(PlatformProperties.os, "OS", "csharp");
@@clientName(PlatformUpdateParameters.os, "OS", "csharp");

// Property rename: integer duration properties must include units in the name
@@clientName(TaskProperties.timeout, "TimeoutInSeconds", "csharp");
@@clientName(TaskPropertiesUpdateParameters.timeout,
  "TimeoutInSeconds",
  "csharp"
);
@@clientName(DockerBuildRequest.timeout, "TimeoutInSeconds", "csharp");
@@clientName(FileTaskRunRequest.timeout, "TimeoutInSeconds", "csharp");
@@clientName(EncodedTaskRunRequest.timeout, "TimeoutInSeconds", "csharp");

// Property rename: DateTimeOffset properties must end with "On"
@@clientName(ImageUpdateTrigger.timestamp, "OccurredOn", "csharp");

// C# namespace fix: interface Tasks conflicts with last namespace segment "Tasks"
@@clientName(Tasks, "ContainerRegistryTaskRestClient", "csharp");

// C# client naming: prefix generic names with service context
@@clientName(AuthInfo, "ContainerRegistryTaskAuthInfo", "csharp");
@@clientName(IdentityProperties,
  "ContainerRegistryTaskIdentityProperties",
  "csharp"
);
@@clientName(UserIdentityProperties,
  "ContainerRegistryTaskUserIdentityProperties",
  "csharp"
);
@@clientName(PlatformProperties,
  "ContainerRegistryTaskPlatformProperties",
  "csharp"
);
@@clientName(SourceControlType,
  "ContainerRegistryTaskSourceControlType",
  "csharp"
);
@@clientName(SourceRegistryLoginMode,
  "ContainerRegistryTaskSourceRegistryLoginMode",
  "csharp"
);
@@clientName(SourceRegistryCredentials,
  "ContainerRegistryTaskSourceRegistryCredentials",
  "csharp"
);
@@clientName(SourceProperties,
  "ContainerRegistryTaskSourceProperties",
  "csharp"
);
@@clientName(SourceTrigger, "ContainerRegistryTaskSourceTrigger", "csharp");
@@clientName(SourceTriggerDescriptor,
  "ContainerRegistryTaskSourceTriggerDescriptor",
  "csharp"
);
@@clientName(SourceTriggerEvent,
  "ContainerRegistryTaskSourceTriggerEvent",
  "csharp"
);
@@clientName(CustomRegistryCredentials,
  "ContainerRegistryTaskCustomRegistryCredentials",
  "csharp"
);
@@clientName(BaseImageDependency,
  "ContainerRegistryTaskBaseImageDependency",
  "csharp"
);
@@clientName(BaseImageDependencyType,
  "ContainerRegistryTaskBaseImageDependencyType",
  "csharp"
);
@@clientName(BaseImageTrigger,
  "ContainerRegistryTaskBaseImageTrigger",
  "csharp"
);
@@clientName(BaseImageTriggerType,
  "ContainerRegistryTaskBaseImageTriggerType",
  "csharp"
);
@@clientName(ImageDescriptor, "ContainerRegistryTaskImageDescriptor", "csharp");
@@clientName(ImageUpdateTrigger,
  "ContainerRegistryTaskImageUpdateTrigger",
  "csharp"
);
@@clientName(TriggerProperties,
  "ContainerRegistryTaskTriggerProperties",
  "csharp"
);
@@clientName(TimerTrigger, "ContainerRegistryTaskTimerTrigger", "csharp");
@@clientName(TimerTriggerDescriptor,
  "ContainerRegistryTaskTimerTriggerDescriptor",
  "csharp"
);
@@clientName(OverrideTaskStepProperties,
  "ContainerRegistryTaskOverrideStepProperties",
  "csharp"
);
@@clientName(UpdateTriggerPayloadType,
  "ContainerRegistryTaskUpdateTriggerPayloadType",
  "csharp"
);
@@clientName(RunGetLogResult, "ContainerRegistryTaskRunLogResult", "csharp");
@@clientName(ResourceIdentityType,
  "ContainerRegistryTaskResourceIdentityType",
  "csharp"
);

// C# enum member rename: identifiers cannot start with a digit
@@clientName(Architecture.`386`, "X386", "csharp");
