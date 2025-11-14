import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Authorization;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PolicyAssignmentUpdate.properties);

@@clientName(PolicyAssignments.create::parameters.resource, "parameters");
@@clientName(PolicyAssignments.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PolicyAssignment.properties);

@@clientName(PolicyDefinitions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(PolicyDefinitions.createOrUpdateAtManagementGroup::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PolicyDefinition.properties);

@@clientName(PolicyDefinitionVersions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(PolicyDefinitionVersions.createOrUpdateAtManagementGroup::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PolicyDefinitionVersion.properties);

@@clientName(PolicySetDefinitions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(PolicySetDefinitions.createOrUpdateAtManagementGroup::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PolicySetDefinition.properties);

@@clientName(PolicySetDefinitionVersions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(PolicySetDefinitionVersions.createOrUpdateAtManagementGroup::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PolicySetDefinitionVersion.properties);

@@clientLocation(PolicyDefinitionVersionsOperationGroup.listAllBuiltins,
  PolicyDefinitionVersions
);
@@clientLocation(PolicyDefinitionVersionsOperationGroup.listAllAtManagementGroup,
  PolicyDefinitionVersions
);
@@clientLocation(PolicyDefinitionVersionsOperationGroup.listAll,
  PolicyDefinitionVersions
);

@@clientLocation(PolicySetDefinitionVersionsOperationGroup.listAllBuiltins,
  PolicySetDefinitionVersions
);
@@clientLocation(PolicySetDefinitionVersionsOperationGroup.listAllAtManagementGroup,
  PolicySetDefinitionVersions
);
@@clientLocation(PolicySetDefinitionVersionsOperationGroup.listAll,
  PolicySetDefinitionVersions
);

@@clientLocation(PolicyTokensOperationGroup.acquire, "PolicyTokens");
@@clientLocation(PolicyTokensOperationGroup.acquireAtManagementGroup,
  "PolicyTokens"
);
@@clientName(PolicyTokensOperationGroup.acquire::parameters.body, "parameters");
