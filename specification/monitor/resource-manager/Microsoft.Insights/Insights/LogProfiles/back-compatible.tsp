import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.LogProfiles;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LogProfileResource.properties);
