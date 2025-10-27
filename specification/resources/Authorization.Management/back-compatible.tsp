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
@@clientLocation(PolicyDefinitionOperationGroup.getBuiltIn, PolicyDefinitions);
@@clientLocation(PolicyDefinitionOperationGroup.listBuiltIn, PolicyDefinitions);
@@clientLocation(PolicyDefinitionOperationGroup.getAtManagementGroup,
  PolicyDefinitions
);
@@clientLocation(PolicyDefinitionOperationGroup.createOrUpdateAtManagementGroup,
  PolicyDefinitions
);
@@clientName(PolicyDefinitionOperationGroup.createOrUpdateAtManagementGroup::parameters.resource,
  "parameters"
);
@@clientLocation(PolicyDefinitionOperationGroup.deleteAtManagementGroup,
  PolicyDefinitions
);
@@clientLocation(PolicyDefinitionOperationGroup.listByManagementGroup,
  PolicyDefinitions
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PolicyDefinition.properties);

@@clientName(PolicyDefinitionVersions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(PolicyDefinitionVersionOperationGroup.getBuiltIn,
  PolicyDefinitionVersions
);
@@clientLocation(PolicyDefinitionVersionOperationGroup.listBuiltIn,
  PolicyDefinitionVersions
);
@@clientLocation(PolicyDefinitionVersionOperationGroup.getAtManagementGroup,
  PolicyDefinitionVersions
);
@@clientLocation(PolicyDefinitionVersionOperationGroup.createOrUpdateAtManagementGroup,
  PolicyDefinitionVersions
);
@@clientName(PolicyDefinitionVersionOperationGroup.createOrUpdateAtManagementGroup::parameters.resource,
  "parameters"
);
@@clientLocation(PolicyDefinitionVersionOperationGroup.deleteAtManagementGroup,
  PolicyDefinitionVersions
);
@@clientLocation(PolicyDefinitionVersionOperationGroup.listByManagementGroup,
  PolicyDefinitionVersions
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PolicyDefinitionVersion.properties);

@@clientName(PolicySetDefinitions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(PolicySetDefinitionOperationGroup.getBuiltIn,
  PolicySetDefinitions
);
@@clientLocation(PolicySetDefinitionOperationGroup.listBuiltIn,
  PolicySetDefinitions
);
@@clientLocation(PolicySetDefinitionOperationGroup.getAtManagementGroup,
  PolicySetDefinitions
);
@@clientLocation(PolicySetDefinitionOperationGroup.createOrUpdateAtManagementGroup,
  PolicySetDefinitions
);
@@clientName(PolicySetDefinitionOperationGroup.createOrUpdateAtManagementGroup::parameters.resource,
  "parameters"
);
@@clientLocation(PolicySetDefinitionOperationGroup.deleteAtManagementGroup,
  PolicySetDefinitions
);
@@clientLocation(PolicySetDefinitionOperationGroup.listByManagementGroup,
  PolicySetDefinitions
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PolicySetDefinition.properties);

@@clientName(PolicySetDefinitionVersions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(PolicySetDefinitionVersionOperationGroup.getBuiltIn,
  PolicySetDefinitionVersions
);
@@clientLocation(PolicySetDefinitionVersionOperationGroup.listBuiltIn,
  PolicySetDefinitionVersions
);
@@clientLocation(PolicySetDefinitionVersionOperationGroup.getAtManagementGroup,
  PolicySetDefinitionVersions
);
@@clientLocation(PolicySetDefinitionVersionOperationGroup.createOrUpdateAtManagementGroup,
  PolicySetDefinitionVersions
);
@@clientName(PolicySetDefinitionVersionOperationGroup.createOrUpdateAtManagementGroup::parameters.resource,
  "parameters"
);
@@clientLocation(PolicySetDefinitionVersionOperationGroup.deleteAtManagementGroup,
  PolicySetDefinitionVersions
);
@@clientLocation(PolicySetDefinitionVersionOperationGroup.listByManagementGroup,
  PolicySetDefinitionVersions
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
