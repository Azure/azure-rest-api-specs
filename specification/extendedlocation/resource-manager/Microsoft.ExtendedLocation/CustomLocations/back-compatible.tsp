import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ExtendedLocation;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(customLocationOperation.display);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(patchableCustomLocations.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EnabledResourceType.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ResourceSyncRulePropertiesSelector.matchExpressions);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(patchableResourceSyncRule.properties);

@@clientName(CustomLocations.createOrUpdate::parameters.resource, "parameters");
@@clientName(CustomLocations.update::parameters.properties, "parameters");
@@clientName(CustomLocations.findTargetResourceGroup::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(customLocation.properties);

@@clientName(ResourceSyncRules.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ResourceSyncRules.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(resourceSyncRule.properties);

@@clientLocation(Operations.list, "CustomLocations");
@@clientName(Operations.list, "ListOperations");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CustomLocations.update::parameters.properties);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ResourceSyncRules.update::parameters.properties);
