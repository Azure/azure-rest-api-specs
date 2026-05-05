import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.Batch;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "brownfield service"
@@flattenProperty(BatchAccountCreateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "brownfield service"
@@flattenProperty(BatchAccountUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "brownfield service"
@@flattenProperty(CertificateCreateOrUpdateParameters.properties);

@@clientName(ContainerRegistry.username, "userName");

@@clientLocation(BatchAccounts.get, "BatchAccount");
@@clientLocation(BatchAccounts.create, "BatchAccount");
@@clientName(BatchAccounts.create::parameters.resource, "parameters");
@@clientLocation(BatchAccounts.update, "BatchAccount");
@@clientName(BatchAccounts.update::parameters.properties, "parameters");
@@clientLocation(BatchAccounts.delete, "BatchAccount");
@@clientLocation(BatchAccounts.listByResourceGroup, "BatchAccount");
@@clientLocation(BatchAccounts.list, "BatchAccount");
@@clientLocation(BatchAccounts.synchronizeAutoStorageKeys, "BatchAccount");
@@clientLocation(BatchAccounts.regenerateKey, "BatchAccount");
@@clientName(BatchAccounts.regenerateKey::parameters.body, "parameters");
@@clientLocation(BatchAccounts.getKeys, "BatchAccount");
@@clientLocation(BatchAccounts.listOutboundNetworkDependenciesEndpoints,
  "BatchAccount"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "brownfield service"
@@flattenProperty(BatchAccount.properties);

@@clientLocation(PrivateEndpointConnections.get, "PrivateEndpointConnection");
@@clientLocation(PrivateEndpointConnections.update,
  "PrivateEndpointConnection"
);
@@clientName(PrivateEndpointConnections.update::parameters.properties,
  "parameters"
);
@@clientLocation(PrivateEndpointConnections.delete,
  "PrivateEndpointConnection"
);
@@clientLocation(PrivateEndpointConnections.listByBatchAccount,
  "PrivateEndpointConnection"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "brownfield service"
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientLocation(ApplicationPackages.get, "ApplicationPackage");
@@clientLocation(ApplicationPackages.create, "ApplicationPackage");
@@clientName(ApplicationPackages.create::parameters.resource, "parameters");
@@clientLocation(ApplicationPackages.delete, "ApplicationPackage");
@@clientLocation(ApplicationPackages.list, "ApplicationPackage");
@@clientLocation(ApplicationPackages.activate, "ApplicationPackage");
@@clientName(ApplicationPackages.activate::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "brownfield service"
@@flattenProperty(ApplicationPackage.properties);

@@clientLocation(Applications.get, "Application");
@@clientLocation(Applications.create, "Application");
@@clientName(Applications.create::parameters.resource, "parameters");
@@clientLocation(Applications.update, "Application");
@@clientName(Applications.update::parameters.properties, "parameters");
@@clientLocation(Applications.delete, "Application");
@@clientLocation(Applications.list, "Application");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "brownfield service"
@@flattenProperty(Application.properties);

@@clientLocation(Certificates.get, "Certificate");
@@clientLocation(Certificates.create, "Certificate");
@@clientName(Certificates.create::parameters.resource, "parameters");
@@clientLocation(Certificates.update, "Certificate");
@@clientName(Certificates.update::parameters.properties, "parameters");
@@clientLocation(Certificates.delete, "Certificate");
@@clientLocation(Certificates.listByBatchAccount, "Certificate");
@@clientLocation(Certificates.cancelDeletion, "Certificate");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "brownfield service"
@@flattenProperty(Certificate.properties);

@@clientLocation(DetectorResponses.getDetector, "BatchAccount");
@@clientLocation(DetectorResponses.listDetectors, "BatchAccount");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "brownfield service"
@@flattenProperty(DetectorResponse.properties);

@@clientLocation(PrivateLinkResources.get, "PrivateLinkResource");
@@clientLocation(PrivateLinkResources.listByBatchAccount,
  "PrivateLinkResource"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "brownfield service"
@@flattenProperty(PrivateLinkResource.properties);

@@clientLocation(Pools.get, "Pool");
@@clientLocation(Pools.create, "Pool");
@@clientName(Pools.create::parameters.resource, "parameters");
@@clientLocation(Pools.update, "Pool");
@@clientName(Pools.update::parameters.properties, "parameters");
@@clientLocation(Pools.delete, "Pool");
@@clientLocation(Pools.listByBatchAccount, "Pool");
@@clientLocation(Pools.disableAutoScale, "Pool");
@@clientLocation(Pools.stopResize, "Pool");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "brownfield service"
@@flattenProperty(Pool.properties);

@@clientLocation(NetworkSecurityPerimeterConfigurations.getConfiguration,
  "NetworkSecurityPerimeter"
);
@@clientLocation(NetworkSecurityPerimeterConfigurations.listConfigurations,
  "NetworkSecurityPerimeter"
);
@@clientLocation(NetworkSecurityPerimeterConfigurations.reconcileConfiguration,
  "NetworkSecurityPerimeter"
);

@@clientLocation(LocationOperationGroup.getQuotas, "Location");
@@clientLocation(LocationOperationGroup.listSupportedVirtualMachineSkus,
  "Location"
);
@@clientLocation(LocationOperationGroup.checkNameAvailability, "Location");
@@clientName(LocationOperationGroup.checkNameAvailability::parameters.body,
  "parameters"
);
@@alternateType(DiffDiskSettings.placement, "CacheDisk", "go");
@@alternateType(CheckNameAvailabilityParameters.type,
  "Microsoft.Batch/batchAccounts",
  "go"
);
@@alternateType(IPRule.action, "Allow", "go");

/**
 *  The subscription resource ID for an access rule.
 */
model AccessRulePropertiesSubscriptionsItem {
  /** The fully qualified Azure resource ID of the subscription e.g. ('/subscriptions/00000000-0000-0000-0000-000000000000') */
  id?: Azure.Core.armResourceIdentifier;
}
@@alternateType(Azure.ResourceManager.CommonTypes.AccessRuleProperties.subscriptions,
  AccessRulePropertiesSubscriptionsItem[],
  "go"
);
