import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CloudError.error);

@@clientLocation(GetSensitivitySettingsResponses.get, "SensitivitySettings");
@@clientLocation(GetSensitivitySettingsResponses.createOrUpdate,
  "SensitivitySettings"
);
@@clientName(GetSensitivitySettingsResponses.createOrUpdate::parameters.resource,
  "sensitivitySettings"
);
@@clientLocation(GetSensitivitySettingsResponses.list, "SensitivitySettings");
