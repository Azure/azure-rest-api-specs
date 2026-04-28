import "@azure-tools/typespec-client-generator-core";
import "../Common/main.tsp";

using Azure.ClientGenerator.Core;
using LegacySettingsAPI;
using Common;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CloudError.error);

@@clientName(AutoProvisioningSettings.create::parameters.resource, "setting");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AutoProvisioningSetting.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Compliance.properties);

@@clientName(InformationProtectionPolicies.createOrUpdate::parameters.resource,
  "informationProtectionPolicy"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(InformationProtectionPolicy.properties);

@@clientName(WorkspaceSettings.create::parameters.resource, "workspaceSetting");
@@clientName(WorkspaceSettings.update::parameters.properties,
  "workspaceSetting"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WorkspaceSetting.properties);
