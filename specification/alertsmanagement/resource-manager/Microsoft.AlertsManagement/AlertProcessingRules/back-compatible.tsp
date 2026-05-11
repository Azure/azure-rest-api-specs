import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AlertsManagement;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PatchObject.properties);

@@clientName(AlertProcessingRules.createOrUpdate::parameters.resource,
  "alertProcessingRule"
);
@@clientName(AlertProcessingRules.update::parameters.properties,
  "alertProcessingRulePatch"
);
