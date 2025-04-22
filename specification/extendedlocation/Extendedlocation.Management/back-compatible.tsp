import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ExtendedLocation;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CustomLocationOperation.display);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PatchableCustomLocations.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EnabledResourceType.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ResourceSyncRulePropertiesSelector.matchExpressions);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PatchableResourceSyncRule.properties);

@@clientName(CustomLocations.createOrUpdate::parameters.resource, "parameters");
@@clientName(CustomLocations.update::parameters.properties, "parameters");
@@clientName(CustomLocations.findTargetResourceGroup::parameters.body,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CustomLocation.properties);

@@clientName(ResourceSyncRules.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ResourceSyncRules.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ResourceSyncRule.properties);
#suppress "@azure-tools/typespec-azure-core/no-openapi"
@@OpenAPI.extension(CustomLocations.update::parameters.properties,
  "x-ms-client-flatten",
  true
);
@@OpenAPI.extension(ResourceSyncRules.update::parameters.properties,
  "x-ms-client-flatten",
  true
);
