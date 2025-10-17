import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.StorageMover;
using Azure.Core;

@@clientName(Endpoint, "StorageMoverEndpoint", "csharp");
@@clientName(EndpointBaseUpdateParameters,
  "StorageMoverEndpointPatch",
  "csharp"
);
@@clientName(Project, "StorageMoverProject", "csharp");
@@clientName(Agent, "StorageMoverAgent", "csharp");
@@clientName(AgentPropertiesErrorDetails,
  "StorageMoverAgentPropertiesErrorDetails",
  "csharp"
);
@@clientName(AgentStatus, "StorageMoverAgentStatus", "csharp");
@@clientName(CopyMode, "StorageMoverCopyMode", "csharp");
@@clientName(Credentials, "StorageMoverCredentials", "csharp");
@@clientName(DayOfWeek, "ScheduleDayOfWeek", "csharp");
@@clientName(Minute, "ScheduleMinute", "csharp");
@@clientName(ProvisioningState, "StorageMoverProvisioningState", "csharp");
@@clientName(WeeklyRecurrence, "ScheduleWeeklyRecurrence", "csharp");
@@clientName(Recurrence, "ScheduleRecurrence", "csharp");
@@clientName(Time, "ScheduleTime", "csharp");

@@alternateType(JobDefinitionProperties.agentResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(JobDefinitionProperties.latestJobRunResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(JobDefinitionProperties.sourceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(JobDefinitionProperties.targetResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(JobRunProperties.agentResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(JobRunProperties.sourceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(JobRunProperties.targetResourceId,
  armResourceIdentifier,
  "csharp"
);

@@alternateType(JobRunResourceId.jobRunResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(AzureStorageBlobContainerEndpointProperties.storageAccountResourceId,
  string,
  "csharp"
);
@@clientName(AzureKeyVaultSmbCredentials.passwordUri,
  "PasswordUriString",
  "csharp"
);
@@clientName(AzureKeyVaultSmbCredentials.usernameUri,
  "UsernameUriString",
  "csharp"
);
@@clientName(Minute.`0`, "Zero", "csharp,go,python,javascript");
@@clientName(Minute.`30`, "Thirty", "csharp,go,python,javascript");
@@usage(JobRun, Usage.input, "csharp");
@@usage(JobRunError, Usage.output, "csharp");
@@clientName(Microsoft.StorageMover, "StorageMoverMgmtClient", "python");

// Java SDK migration fixes
@@clientName(AgentProperties.localIPAddress, "localIpAddress", "java");
