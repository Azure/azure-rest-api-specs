import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.StorageMover;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageMoverUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AgentUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProjectUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(JobDefinitionUpdateParameters.properties);

@@clientName(StorageMovers.createOrUpdate::parameters.resource, "storageMover");
@@clientName(StorageMovers.update::parameters.properties, "storageMover");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageMover.properties);

@@clientName(Agents.createOrUpdate::parameters.resource, "agent");
@@clientName(Agents.update::parameters.properties, "agent");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Agent.properties);

@@clientName(Endpoints.createOrUpdate::parameters.resource, "endpoint");
@@clientName(Endpoints.update::parameters.properties, "endpoint");

@@clientName(Projects.createOrUpdate::parameters.resource, "project");
@@clientName(Projects.update::parameters.properties, "project");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Project.properties);

@@clientName(JobDefinitions.createOrUpdate::parameters.resource,
  "jobDefinition"
);
@@clientName(JobDefinitions.update::parameters.properties, "jobDefinition");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(JobDefinition.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(JobRun.properties);
