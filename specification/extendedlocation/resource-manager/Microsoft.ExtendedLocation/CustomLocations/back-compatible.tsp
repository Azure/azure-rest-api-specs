import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ExtendedLocation;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(customLocationOperation.display);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(patchableCustomLocations.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EnabledResourceType.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ResourceSyncRulePropertiesSelector.matchExpressions);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(patchableResourceSyncRule.properties);

@@clientName(CustomLocations.createOrUpdate::parameters.resource, "parameters");
@@clientName(CustomLocations.update::parameters.properties, "parameters");
@@clientName(CustomLocations.findTargetResourceGroup::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(customLocation.properties);

@@clientName(ResourceSyncRules.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ResourceSyncRules.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(resourceSyncRule.properties);

@@clientLocation(Operations.list, "CustomLocations");
@@clientName(Operations.list, "ListOperations");
