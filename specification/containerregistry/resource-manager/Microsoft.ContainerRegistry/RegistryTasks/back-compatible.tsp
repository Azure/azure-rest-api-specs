import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ContainerRegistry;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AgentPoolUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TaskRunUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TaskUpdateParameters.properties);

@@clientName(AgentPools.create::parameters.resource, "agentPool");
@@clientName(AgentPools.update::parameters.properties, "updateParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AgentPool.properties);

@@clientName(Runs.update::parameters.properties, "runUpdateParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Run.properties);

@@clientName(TaskRuns.create::parameters.resource, "taskRun");
@@clientName(TaskRuns.update::parameters.properties, "updateParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TaskRun.properties);

@@clientName(Tasks.create::parameters.resource, "taskCreateParameters");
@@clientName(Tasks.update::parameters.properties, "taskUpdateParameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Task.properties);

@@clientLocation(RegistriesOperationGroup.scheduleRun, "Registries");
@@clientLocation(RegistriesOperationGroup.getBuildSourceUploadUrl,
  "Registries"
);

@@clientName(RegistriesOperationGroup.scheduleRun::parameters.body, "runRequest");
