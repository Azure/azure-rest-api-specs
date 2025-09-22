import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Batch;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BatchAccountCreateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BatchAccountUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientLocation(ApplicationPackages.get, "ApplicationPackage");
@@clientLocation(ApplicationPackages.create, "ApplicationPackage");
@@clientName(ApplicationPackages.create::parameters.resource, "parameters");
@@clientLocation(ApplicationPackages.delete, "ApplicationPackage");
@@clientLocation(ApplicationPackages.list, "ApplicationPackage");
@@clientLocation(ApplicationPackages.activate, "ApplicationPackage");
@@clientName(ApplicationPackages.activate::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApplicationPackage.properties);

@@clientLocation(Applications.get, "Application");
@@clientLocation(Applications.create, "Application");
@@clientName(Applications.create::parameters.resource, "parameters");
@@clientLocation(Applications.update, "Application");
@@clientName(Applications.update::parameters.properties, "parameters");
@@clientLocation(Applications.delete, "Application");
@@clientLocation(Applications.list, "Application");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Application.properties);

@@clientLocation(Certificates.get, "Certificate");
@@clientLocation(Certificates.create, "Certificate");
@@clientName(Certificates.create::parameters.resource, "parameters");
@@clientLocation(Certificates.update, "Certificate");
@@clientName(Certificates.update::parameters.properties, "parameters");
@@clientLocation(Certificates.delete, "Certificate");
@@clientLocation(Certificates.listByBatchAccount, "Certificate");
@@clientLocation(Certificates.cancelDeletion, "Certificate");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Certificate.properties);

@@clientLocation(DetectorResponses.getDetector, "BatchAccount");
@@clientLocation(DetectorResponses.listDetectors, "BatchAccount");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DetectorResponse.properties);

@@clientLocation(PrivateLinkResources.get, "PrivateLinkResource");
@@clientLocation(PrivateLinkResources.listByBatchAccount,
  "PrivateLinkResource"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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
