import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AlertsManagement;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PatchObject.properties);

@@clientName(AlertProcessingRules.createOrUpdate::parameters.resource,
  "alertProcessingRule"
);
@@clientName(AlertProcessingRules.update::parameters.properties,
  "alertProcessingRulePatch"
);
