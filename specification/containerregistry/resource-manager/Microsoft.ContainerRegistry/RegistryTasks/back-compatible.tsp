import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ContainerRegistry;

@@clientName(AgentPools.create::parameters.resource, "agentPool");
@@clientName(AgentPools.update::parameters.properties, "updateParameters");

@@clientName(Runs.update::parameters.properties, "runUpdateParameters");

@@clientName(TaskRuns.create::parameters.resource, "taskRun");
@@clientName(TaskRuns.update::parameters.properties, "updateParameters");

@@clientName(Tasks.create::parameters.resource, "taskCreateParameters");
@@clientName(Tasks.update::parameters.properties, "taskUpdateParameters");

@@clientLocation(RegistriesOperationGroup.scheduleRun, "Registries");
@@clientLocation(RegistriesOperationGroup.getBuildSourceUploadUrl,
  "Registries"
);

@@clientName(RegistriesOperationGroup.scheduleRun::parameters.body,
  "runRequest"
);
