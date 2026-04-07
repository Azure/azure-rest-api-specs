import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using microsoft.insights;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServiceDiagnosticSettingsResource.properties);
