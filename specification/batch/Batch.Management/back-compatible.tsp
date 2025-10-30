import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.Batch;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(BatchAccountCreateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(BatchAccountUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientLocation(ApplicationPackages.get, "ApplicationPackage");
@@clientLocation(ApplicationPackages.create, "ApplicationPackage");
@@clientName(ApplicationPackages.create::parameters.resource, "parameters");
@@clientLocation(ApplicationPackages.delete, "ApplicationPackage");
@@clientLocation(ApplicationPackages.list, "ApplicationPackage");
@@clientLocation(ApplicationPackages.activate, "ApplicationPackage");
@@clientName(ApplicationPackages.activate::parameters.body, "parameters");
@@flattenProperty(ApplicationPackage.properties);

@@clientLocation(Applications.get, "Application");
@@clientLocation(Applications.create, "Application");
@@clientName(Applications.create::parameters.resource, "parameters");
@@clientLocation(Applications.update, "Application");
@@clientName(Applications.update::parameters.properties, "parameters");
@@clientLocation(Applications.delete, "Application");
@@clientLocation(Applications.list, "Application");
@@flattenProperty(Application.properties);

@@clientLocation(Certificates.get, "Certificate");
@@clientLocation(Certificates.create, "Certificate");
@@clientName(Certificates.create::parameters.resource, "parameters");
@@clientLocation(Certificates.update, "Certificate");
@@clientName(Certificates.update::parameters.properties, "parameters");
@@clientLocation(Certificates.delete, "Certificate");
@@clientLocation(Certificates.listByBatchAccount, "Certificate");
@@clientLocation(Certificates.cancelDeletion, "Certificate");
@@flattenProperty(Certificate.properties);

@@clientLocation(DetectorResponses.getDetector, "BatchAccount");
@@clientLocation(DetectorResponses.listDetectors, "BatchAccount");
@@flattenProperty(DetectorResponse.properties);

@@clientLocation(PrivateLinkResources.get, "PrivateLinkResource");
@@clientLocation(PrivateLinkResources.listByBatchAccount,
  "PrivateLinkResource"
);
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
@@doc(Operations.list,
  "Lists available operations for the Microsoft.Batch provider"
);
@@summary(Certificates.listByBatchAccount,
  "Lists all of the certificates in the specified account."
);
@@summary(Certificates.get,
  "Gets information about the specified certificate."
);
@@summary(Certificates.create,
  "Creates a new certificate inside the specified account."
);
@@summary(Certificates.update,
  "Updates the properties of an existing certificate."
);
@@summary(Certificates.delete, "Deletes the specified certificate.");
@@summary(Certificates.cancelDeletion,
  "Cancels a failed deletion of a certificate from the specified account."
);
@@summary(BatchAccounts.getKeys,
  "Gets the account keys for the specified Batch account."
);
@@summary(BatchAccounts.regenerateKey,
  "Regenerates the specified account key for the Batch account."
);
@@summary(Pools.stopResize, "Stops an ongoing resize operation on the pool.");
