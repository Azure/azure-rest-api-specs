import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.StorageMover;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StorageMoverUpdateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AgentUpdateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProjectUpdateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(JobDefinitionUpdateParameters.properties
);

@@clientName(StorageMovers.createOrUpdate::parameters.resource, "storageMover");
@@clientName(StorageMovers.update::parameters.properties, "storageMover");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StorageMover.properties);

@@clientName(Agents.createOrUpdate::parameters.resource, "agent");
@@clientName(Agents.update::parameters.properties, "agent");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Agent.properties);

@@clientName(Endpoints.createOrUpdate::parameters.resource,
  "endpoint",
  "!csharp"
);
@@clientName(Endpoints.update::parameters.properties, "endpoint", "!csharp");

@@clientName(Projects.createOrUpdate::parameters.resource, "project");
@@clientName(Projects.update::parameters.properties, "project");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Project.properties);

@@clientName(JobDefinitions.createOrUpdate::parameters.resource,
  "jobDefinition"
);
@@clientName(JobDefinitions.update::parameters.properties, "jobDefinition");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(JobDefinition.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(JobRun.properties);

@@clientName(Connections.createOrUpdate::parameters.resource,
  "connection",
  "!csharp"
);
