import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Insights;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(LogProfileResourcePatch.properties);

@@clientLocation(LogProfileResources.get, "LogProfiles");
@@clientLocation(LogProfileResources.createOrUpdate, "LogProfiles");
@@clientName(LogProfileResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(LogProfileResources.update, "LogProfiles");
@@clientName(LogProfileResources.update::parameters.properties,
  "logProfilesResource"
);
@@clientLocation(LogProfileResources.delete, "LogProfiles");
@@clientLocation(LogProfileResources.list, "LogProfiles");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(LogProfileResource.properties);
