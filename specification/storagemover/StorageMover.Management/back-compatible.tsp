import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.StorageMover;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StorageMoverUpdateParameters.properties,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AgentUpdateParameters.properties,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProjectUpdateParameters.properties,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(JobDefinitionUpdateParameters.properties,
  "!javascript"
);

@@clientName(StorageMovers.createOrUpdate::parameters.resource, "storageMover");
@@clientName(StorageMovers.update::parameters.properties, "storageMover");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StorageMover.properties,
  "!javascript"
);

@@clientName(Agents.createOrUpdate::parameters.resource, "agent");
@@clientName(Agents.update::parameters.properties, "agent");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Agent.properties,
  "!javascript"
);

@@clientName(Endpoints.createOrUpdate::parameters.resource,
  "endpoint",
  "!csharp"
);
@@clientName(Endpoints.update::parameters.properties, "endpoint", "!csharp");

@@clientName(Projects.createOrUpdate::parameters.resource, "project");
@@clientName(Projects.update::parameters.properties, "project");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Project.properties,
  "!javascript"
);

@@clientName(JobDefinitions.createOrUpdate::parameters.resource,
  "jobDefinition"
);
@@clientName(JobDefinitions.update::parameters.properties, "jobDefinition");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(JobDefinition.properties,
  "!javascript"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(JobRun.properties,
  "!javascript"
);

@@clientName(Connections.createOrUpdate::parameters.resource,
  "connection",
  "!csharp"
);
