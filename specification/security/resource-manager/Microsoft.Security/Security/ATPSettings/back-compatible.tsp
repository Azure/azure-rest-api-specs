import "@azure-tools/typespec-client-generator-core";
import "../Common/main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Security;
using Common;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CloudError.error);

@@clientLocation(AdvancedThreatProtectionSettings.get,
  "AdvancedThreatProtection"
);
@@clientLocation(AdvancedThreatProtectionSettings.create,
  "AdvancedThreatProtection"
);
@@clientName(AdvancedThreatProtectionSettings.create::parameters.resource,
  "advancedThreatProtectionSetting"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AdvancedThreatProtectionSetting.properties);


