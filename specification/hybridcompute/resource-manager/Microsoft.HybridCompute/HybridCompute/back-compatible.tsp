import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HybridCompute;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LicenseUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LicenseUpdateProperties.licenseDetails);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OSProfileWindowsConfiguration.patchSettings);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OSProfileLinuxConfiguration.patchSettings);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LicenseProfileMachineInstanceView.softwareAssurance);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LicenseProfileMachineInstanceView.productProfile);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MachineUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LicenseProfileProperties.softwareAssurance);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LicenseProfileProperties.esuProfile);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LicenseProfileProperties.productProfile);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LicenseProfileUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LicenseProfileUpdateProperties.softwareAssurance);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LicenseProfileUpdateProperties.esuProfile);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LicenseProfileUpdateProperties.productProfile);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MachineExtensionUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(GatewayUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SettingsProperties.gatewayProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ProvisioningIssue.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AccessRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(HybridIdentityMetadata.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkConfiguration.properties);

@@clientName(Licenses.createOrUpdate::parameters.resource, "parameters");
@@clientName(Licenses.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(License.properties);

@@clientName(Machines.createOrUpdate::parameters.resource, "parameters");
@@clientName(Machines.update::parameters.properties, "parameters");
@@clientName(Machines.installPatches::parameters.body, "installPatchesInput");
@@clientLocation(Machines.upgradeExtensions, "", "!javascript");
@@clientLocation(Machines.upgradeExtensions,
  "Microsoft.HybridCompute",
  "javascript"
);
@@clientName(Machines.upgradeExtensions::parameters.body,
  "extensionUpgradeParameters"
);
@@clientName(Machines.setupExtensions::parameters.body, "extensions");
@@clientLocation(Machines.networkProfileGet, "NetworkProfile");
@@clientName(Machines.networkProfileGet, "Get");
@@clientLocation(Machines.getValidationDetailsForMachine, "PrivateLinkScopes");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Machine.properties);

@@clientName(MachineExtensions.createOrUpdate::parameters.resource,
  "extensionParameters"
);
@@clientName(MachineExtensions.update::parameters.properties,
  "extensionParameters"
);

@@clientName(LicenseProfiles.createOrUpdate::parameters.resource, "parameters");
@@clientName(LicenseProfiles.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(LicenseProfile.properties);

@@clientLocation(ExtensionValues.get, "ExtensionMetadata");
@@clientLocation(ExtensionValues.list, "ExtensionMetadata");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExtensionValue.properties);

@@clientLocation(ExtensionValueV2s.get, "ExtensionMetadataV2");
@@clientLocation(ExtensionValueV2s.list, "ExtensionMetadataV2");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExtensionValueV2.properties);

@@clientName(MachineRunCommands.createOrUpdate::parameters.resource,
  "runCommandProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MachineRunCommand.properties);

@@clientName(Gateways.createOrUpdate::parameters.resource, "parameters");
@@clientName(Gateways.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Gateway.properties);

@@clientLocation(SettingsOperationGroup.get, "Settings");
@@clientLocation(SettingsOperationGroup.update, "Settings");
@@clientName(SettingsOperationGroup.update::parameters.resource, "parameters");
@@clientLocation(SettingsOperationGroup.patch, "Settings");
@@clientName(SettingsOperationGroup.patch::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Settings.properties);

@@clientLocation(HybridComputePrivateLinkScopes.get, "PrivateLinkScopes");
@@clientLocation(HybridComputePrivateLinkScopes.createOrUpdate,
  "PrivateLinkScopes"
);
@@clientName(HybridComputePrivateLinkScopes.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(HybridComputePrivateLinkScopes.updateTags,
  "PrivateLinkScopes"
);
@@clientName(HybridComputePrivateLinkScopes.updateTags::parameters.properties,
  "PrivateLinkScopeTags"
);
@@clientLocation(HybridComputePrivateLinkScopes.delete, "PrivateLinkScopes");
@@clientLocation(HybridComputePrivateLinkScopes.listByResourceGroup,
  "PrivateLinkScopes"
);
@@clientLocation(HybridComputePrivateLinkScopes.list, "PrivateLinkScopes");

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NetworkSecurityPerimeterConfiguration.properties);

@@clientLocation(LicensesOperationGroup.validateLicense, Licenses);

@@clientLocation(ExtensionTypeOperationGroup.list, "ExtensionType");

@@clientLocation(ExtensionPublisherOperationGroup.list, "ExtensionPublisher");

@@clientLocation(PrivateLinkScopesOperationGroup.getValidationDetails,
  "PrivateLinkScopes"
);
@@clientLocation(Machines.listByMachines, "HybridIdentityMetadata");
@@clientLocation(Machines.getHybridIdentityMetadata, "HybridIdentityMetadata");
@@clientName(Machines.getHybridIdentityMetadata, "Get");
@@clientName(LicensesOperationGroup.validateLicense::parameters.body,
  "parameters"
);
@@clientName(NetworkConfigurationsOperationGroup.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(NetworkConfigurationsOperationGroup.update::parameters.properties,
  "parameters"
);
@@clientName(MachineRunCommands.update::parameters.properties,
  "runCommandProperties"
);
@@clientLocation(AgentVersionsOperationGroup.list, "AgentVersion");
@@clientLocation(AgentVersionsOperationGroup.get, "AgentVersion");
@@clientLocation(NetworkConfigurationsOperationGroup.get,
  "NetworkConfigurations"
);
@@clientLocation(NetworkConfigurationsOperationGroup.createOrUpdate,
  "NetworkConfigurations"
);
@@clientLocation(NetworkConfigurationsOperationGroup.update,
  "NetworkConfigurations"
);
