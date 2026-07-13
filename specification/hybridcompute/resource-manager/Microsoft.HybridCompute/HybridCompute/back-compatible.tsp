import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HybridCompute;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(LicenseUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(LicenseUpdateProperties.licenseDetails);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(OSProfileWindowsConfiguration.patchSettings);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(OSProfileLinuxConfiguration.patchSettings);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(LicenseProfileMachineInstanceView.softwareAssurance);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(LicenseProfileMachineInstanceView.productProfile);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(MachineUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(LicenseProfileProperties.softwareAssurance);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(LicenseProfileProperties.esuProfile);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(LicenseProfileProperties.productProfile);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(LicenseProfileUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(LicenseProfileUpdateProperties.softwareAssurance);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(LicenseProfileUpdateProperties.esuProfile);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(LicenseProfileUpdateProperties.productProfile);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(MachineExtensionUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(GatewayUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(SettingsProperties.gatewayProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(ProvisioningIssue.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(AccessRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(HybridIdentityMetadata.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(NetworkConfiguration.properties);

@@clientName(Licenses.createOrUpdate::parameters.resource, "parameters");
@@clientName(Licenses.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(License.properties);

@@clientName(Machines.createOrUpdate::parameters.resource, "parameters");
@@clientName(Machines.update::parameters.properties, "parameters");
@@clientName(Machines.installPatches::parameters.body, "installPatchesInput");
@@clientLocation(Machines.upgradeExtensions, Microsoft.HybridCompute);
@@clientName(
  Machines.upgradeExtensions::parameters.body,
  "extensionUpgradeParameters"
);
@@clientName(Machines.setupExtensions::parameters.body, "extensions");
@@clientLocation(Machines.networkProfileGet, "NetworkProfile", "!javascript");
@@clientLocation(
  Machines.networkProfileGet,
  "NetworkProfileOperations",
  "javascript"
);
@@clientName(Machines.networkProfileGet, "Get");
@@clientLocation(Machines.getValidationDetailsForMachine, "PrivateLinkScopes");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(Machine.properties);

@@clientName(
  MachineExtensions.createOrUpdate::parameters.resource,
  "extensionParameters"
);
@@clientName(
  MachineExtensions.update::parameters.properties,
  "extensionParameters"
);

@@clientName(LicenseProfiles.createOrUpdate::parameters.resource, "parameters");
@@clientName(LicenseProfiles.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(LicenseProfile.properties);

@@clientLocation(ExtensionValues.get, "ExtensionMetadata");
@@clientLocation(ExtensionValues.list, "ExtensionMetadata");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(ExtensionValue.properties);

@@clientLocation(ExtensionValueV2s.get, "ExtensionMetadataV2");
@@clientLocation(ExtensionValueV2s.list, "ExtensionMetadataV2");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(ExtensionValueV2.properties);

@@clientName(
  MachineRunCommands.createOrUpdate::parameters.resource,
  "runCommandProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(MachineRunCommand.properties);

@@clientName(Gateways.createOrUpdate::parameters.resource, "parameters");
@@clientName(Gateways.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(Gateway.properties);

@@clientLocation(SettingsOperationGroup.get, "Settings");
@@clientLocation(SettingsOperationGroup.update, "Settings");
@@clientName(SettingsOperationGroup.update::parameters.resource, "parameters");
@@clientLocation(SettingsOperationGroup.patch, "Settings");
@@clientName(SettingsOperationGroup.patch::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(Settings.properties);

@@clientLocation(HybridComputePrivateLinkScopes.get, "PrivateLinkScopes");
@@clientLocation(
  HybridComputePrivateLinkScopes.createOrUpdate,
  "PrivateLinkScopes"
);
@@clientName(
  HybridComputePrivateLinkScopes.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(
  HybridComputePrivateLinkScopes.updateTags,
  "PrivateLinkScopes"
);
@@clientName(
  HybridComputePrivateLinkScopes.updateTags::parameters.properties,
  "PrivateLinkScopeTags"
);
@@clientLocation(HybridComputePrivateLinkScopes.delete, "PrivateLinkScopes");
@@clientLocation(
  HybridComputePrivateLinkScopes.listByResourceGroup,
  "PrivateLinkScopes"
);
@@clientLocation(HybridComputePrivateLinkScopes.list, "PrivateLinkScopes");

@@clientName(
  PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserved from the original Swagger contract during TypeSpec conversion to avoid breaking existing client SDKs."
@@Legacy.flattenProperty(NetworkSecurityPerimeterConfiguration.properties);

@@clientLocation(LicensesOperationGroup.validateLicense, Licenses);

@@clientLocation(ExtensionTypeOperationGroup.list, "ExtensionType");

@@clientLocation(ExtensionPublisherOperationGroup.list, "ExtensionPublisher");

@@clientLocation(
  PrivateLinkScopesOperationGroup.getValidationDetails,
  "PrivateLinkScopes"
);
@@clientName(
  LicensesOperationGroup.validateLicense::parameters.body,
  "parameters"
);
