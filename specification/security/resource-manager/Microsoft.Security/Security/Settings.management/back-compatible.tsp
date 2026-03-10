import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Security;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CloudError.error);

@@clientName(AutoProvisioningSettings.create::parameters.resource, "setting");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AutoProvisioningSetting.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Compliance.properties);

@@clientName(InformationProtectionPolicies.createOrUpdate::parameters.resource,
  "informationProtectionPolicy"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(InformationProtectionPolicy.properties);

@@clientName(WorkspaceSettings.create::parameters.resource, "workspaceSetting");
@@clientName(WorkspaceSettings.update::parameters.properties,
  "workspaceSetting"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WorkspaceSetting.properties);
