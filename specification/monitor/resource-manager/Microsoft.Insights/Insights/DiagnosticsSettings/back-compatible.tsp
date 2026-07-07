import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Insights;

@@clientLocation(DiagnosticSettingsResources.get, "DiagnosticSettings");
@@clientLocation(DiagnosticSettingsResources.createOrUpdate,
  "DiagnosticSettings"
);
@@clientName(DiagnosticSettingsResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(DiagnosticSettingsResources.delete, "DiagnosticSettings");
@@clientLocation(DiagnosticSettingsResources.list, "DiagnosticSettings");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DiagnosticSettingsResource.properties);

@@clientLocation(DiagnosticSettingsCategoryResources.get,
  "DiagnosticSettingsCategory"
);
@@clientLocation(DiagnosticSettingsCategoryResources.list,
  "DiagnosticSettingsCategory"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DiagnosticSettingsCategoryResource.properties);
