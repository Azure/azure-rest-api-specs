import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Insights;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServiceDiagnosticSettingsResourcePatch.properties);

@@clientLocation(ServiceDiagnosticSettingsResources.get,
  "ServiceDiagnosticSettings"
);
@@clientLocation(ServiceDiagnosticSettingsResources.createOrUpdate,
  "ServiceDiagnosticSettings"
);
@@clientName(ServiceDiagnosticSettingsResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ServiceDiagnosticSettingsResources.update,
  "ServiceDiagnosticSettings"
);
@@clientName(ServiceDiagnosticSettingsResources.update::parameters.properties,
  "serviceDiagnosticSettingsResource"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServiceDiagnosticSettingsResource.properties);
