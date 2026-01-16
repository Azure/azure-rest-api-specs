import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Http;
using Azure.ClientGenerator.Core;
using Microsoft.KeyVault;
using Azure.Core;

@@clientName(KeyAttributes.nbf, "NotBefore");
@@clientName(KeyAttributes.exp, "Expires");

@@clientName(ManagedHsmKeyAttributes.nbf, "NotBefore");
@@clientName(ManagedHsmKeyAttributes.exp, "Expires");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnectionItem.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateLinkResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MhsmPrivateEndpointConnectionItem.properties
);

@@clientName(Error.innererror, "innerError");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MhsmPrivateLinkResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Operation.properties);
@@clientName(Operation.properties, "operationProperties");

@@clientName(Attributes.nbf, "NotBefore");
@@clientName(Attributes.exp, "Expires");

@@clientName(Keys.createIfNotExist::parameters.resource, "parameters");
@@clientLocation(KeyOperationGroup.getVersion, Keys);
@@clientLocation(KeyOperationGroup.listVersions, Keys);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Key.properties);

@@clientName(ManagedHsmKeys.createIfNotExist::parameters.resource,
  "parameters"
);
@@clientLocation(ManagedHsmKeyOperationGroup.getVersion, ManagedHsmKeys);
@@clientLocation(ManagedHsmKeyOperationGroup.listVersions, ManagedHsmKeys);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ManagedHsmKey.properties);

@@clientName(Vaults.createOrUpdate::parameters.resource, "parameters");
@@clientName(Vaults.update::parameters.properties, "parameters");
@@clientName(Vaults.updateAccessPolicy::parameters.resource, "parameters");
@@clientLocation(Vaults.listByVault, "PrivateLinkResources");

@@clientLocation(DeletedVaults.getDeleted, Vaults);
@@clientLocation(DeletedVaults.purgeDeleted, Vaults);

@@clientName(PrivateEndpointConnections.put::parameters.resource, "properties");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties
);

@@clientName(ManagedHsms.createOrUpdate::parameters.resource, "parameters");
@@clientName(ManagedHsms.update::parameters.properties, "parameters");
@@clientLocation(ManagedHsms.listByMHSMResource,
  "MHSMPrivateLinkResources",
  "!csharp,!java"
);
@@clientLocation(ManagedHsms.listByResource, "MHSMRegions", "!csharp,!java");

@@clientLocation(MhsmPrivateEndpointConnections.get,
  "MHSMPrivateEndpointConnections",
  "!csharp,!java"
);
@@clientLocation(MhsmPrivateEndpointConnections.put,
  "MHSMPrivateEndpointConnections",
  "!csharp,!java"
);
@@clientName(MhsmPrivateEndpointConnections.put::parameters.resource,
  "properties"
);
@@clientLocation(MhsmPrivateEndpointConnections.delete,
  "MHSMPrivateEndpointConnections",
  "!csharp,!java"
);
@@clientLocation(MhsmPrivateEndpointConnections.listByResource,
  "MHSMPrivateEndpointConnections",
  "!csharp,!java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MhsmPrivateEndpointConnection.properties
);

@@clientLocation(DeletedManagedHsms.getDeleted, ManagedHsms);
@@clientLocation(DeletedManagedHsms.purgeDeleted, ManagedHsms);

@@clientName(Secrets.createOrUpdate::parameters.resource, "parameters");
@@clientName(Secrets.update::parameters.properties, "parameters");

@@clientLocation(VaultsOperationGroup.listDeleted, Vaults);
@@clientLocation(VaultsOperationGroup.list, Vaults);
@@clientLocation(VaultsOperationGroup.checkNameAvailability, Vaults);

@@clientLocation(ManagedHsmsOperationGroup.listDeleted, ManagedHsms);
@@clientLocation(ManagedHsmsOperationGroup.checkMhsmNameAvailability,
  ManagedHsms
);
@@clientName(ManagedHsmsOperationGroup.checkMhsmNameAvailability::parameters.body,
  "mhsmName"
);
@@clientName(VaultsOperationGroup.checkNameAvailability::parameters.body,
  "vaultName"
);
@@clientName(MhsmPrivateEndpointConnection,
  "MHSMPrivateEndpointConnection",
  "!java"
);
@@clientName(MhsmPrivateLinkResource, "MHSMPrivateLinkResource", "!java");
@@clientName(MhsmPrivateLinkResourceListResult,
  "MHSMPrivateLinkResourceListResult",
  "!java"
);
@@clientName(MhsmRegionsListResult, "MHSMRegionsListResult", "!java");
@@clientName(MhsmPrivateEndpointConnectionProperties,
  "MHSMPrivateEndpointConnectionProperties",
  "!java"
);
@@clientName(MhsmPrivateEndpoint, "MHSMPrivateEndpoint", "!java");
@@clientName(MhsmPrivateLinkServiceConnectionState,
  "MHSMPrivateLinkServiceConnectionState",
  "!java"
);
@@clientName(MhsmPrivateEndpointConnectionItem,
  "MHSMPrivateEndpointConnectionItem",
  "!java"
);
@@clientName(MhsmNetworkRuleSet, "MHSMNetworkRuleSet", "!java");
@@clientName(MhsmGeoReplicatedRegion, "MHSMGeoReplicatedRegion", "!java");
@@clientName(MhsmVirtualNetworkRule, "MHSMVirtualNetworkRule", "!java");
@@clientName(MhsmipRule, "MHSMIPRule", "!java");
@@clientName(MhsmPrivateLinkResourceProperties,
  "MHSMPrivateLinkResourceProperties",
  "!java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Operation.properties);
@@clientName(Operation.properties, "OperationProperties");

@@Azure.ResourceManager.identifiers(MhsmRegionsListResult.value, #["name"]);

@@clientName(Azure.ResourceManager.CommonTypes.createdByType,
  "IdentityType",
  "python"
);
@@clientName(VaultListResult, "ResourceListResult");
@@clientName(MhsmServiceTagRule, "MHSMServiceTagRule", "!java,!csharp");

@@clientName(JsonWebKeyCurveName.`P-256`, "P256", "python");
@@clientName(JsonWebKeyCurveName.`P-384`, "P384", "python");
@@clientName(JsonWebKeyCurveName.`P-521`, "P521", "python");
@@clientName(JsonWebKeyCurveName.`P-256K`, "P256_K", "python");

@@clientName(JsonWebKeyType.`EC-HSM`, "EC_HSM", "python");
@@clientName(JsonWebKeyType.`RSA-HSM`, "RSA_HSM", "python");

// Override the order of path parameters
#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op VaultsGetDeletedCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path provider: "Microsoft.ThisWillBeReplaced",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path subscriptionId: uuid,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path vaultName: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path location: azureLocation,
): DeletedVault;

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op VaultsPurgeDeletedCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path provider: "Microsoft.ThisWillBeReplaced",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path subscriptionId: uuid,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path vaultName: string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path location: azureLocation,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @body body: void,
): void;

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op ManagedHsmsGetDeletedCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  subscriptionId: uuid,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  location: azureLocation,
): DeletedManagedHsm;

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op ManagedHsmsPurgeDeletedCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("api-version")
  apiVersion: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  subscriptionId: uuid,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  location: azureLocation,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @body
  body: void,
): void;

@@override(DeletedVaults.getDeleted,
  VaultsGetDeletedCustomized,
  "python,go,java,javascript"
);
@@override(DeletedVaults.purgeDeleted,
  VaultsPurgeDeletedCustomized,
  "python,go,java,javascript"
);
@@override(DeletedManagedHsms.getDeleted,
  ManagedHsmsGetDeletedCustomized,
  "python,go,java,javascript"
);
@@override(DeletedManagedHsms.purgeDeleted,
  ManagedHsmsPurgeDeletedCustomized,
  "python,go,java,javascript"
);
