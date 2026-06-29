import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ServiceDiagnosticsSettingsApi;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServiceDiagnosticSettingsResourcePatch.properties);

@@clientLocation(
  ServiceDiagnosticSettingsResources.get,
  "ServiceDiagnosticSettings",
  "!javascript"
);
@@clientLocation(
  ServiceDiagnosticSettingsResources.get,
  "DiagnosticSettings",
  "javascript"
);
@@clientLocation(
  ServiceDiagnosticSettingsResources.createOrUpdate,
  "ServiceDiagnosticSettings",
  "!javascript"
);
@@clientLocation(
  ServiceDiagnosticSettingsResources.createOrUpdate,
  "DiagnosticSettings",
  "javascript"
);
@@clientName(
  ServiceDiagnosticSettingsResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(
  ServiceDiagnosticSettingsResources.update,
  "ServiceDiagnosticSettings",
  "!javascript"
);
@@clientLocation(
  ServiceDiagnosticSettingsResources.update,
  "DiagnosticSettings",
  "javascript"
);
@@clientName(
  ServiceDiagnosticSettingsResources.update::parameters.properties,
  "serviceDiagnosticSettingsResource"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ServiceDiagnosticSettingsResource.properties);
