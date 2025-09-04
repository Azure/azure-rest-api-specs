import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.StorageMover;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageMoverUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AgentUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ProjectUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(JobDefinitionUpdateParameters.properties);

@@clientName(StorageMovers.createOrUpdate::parameters.resource, "storageMover");
@@clientName(StorageMovers.update::parameters.properties, "storageMover");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageMover.properties);

@@clientName(Agents.createOrUpdate::parameters.resource, "agent");
@@clientName(Agents.update::parameters.properties, "agent");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Agent.properties);

@@clientName(Endpoints.createOrUpdate::parameters.resource,
  "endpoint",
  "!csharp"
);
@@clientName(Endpoints.update::parameters.properties, "endpoint", "!csharp");

@@clientName(Projects.createOrUpdate::parameters.resource, "project");
@@clientName(Projects.update::parameters.properties, "project");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Project.properties);

@@clientName(JobDefinitions.createOrUpdate::parameters.resource,
  "jobDefinition"
);
@@clientName(JobDefinitions.update::parameters.properties, "jobDefinition");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(JobDefinition.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(JobRun.properties);
