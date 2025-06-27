import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Devices;

@@clientName(CertificateResponses.createOrUpdate::parameters.resource,
  "certificateDescription"
);
@@clientName(CertificateResponses.verifyCertificate::parameters.body,
  "request"
);

@@clientName(ProvisioningServiceDescriptions.createOrUpdate::parameters.resource,
  "iotDpsDescription"
);
@@clientName(ProvisioningServiceDescriptions.update::parameters.properties,
  "ProvisioningServiceTags"
);

@@clientName(PrivateEndpointConnections.createOrUpdatePrivateEndpointConnection::parameters.resource,
  "privateEndpointConnection"
);

@@clientName(IotDpsResourceOperationGroup.checkProvisioningServiceNameAvailability::parameters.body,
  "arguments"
);

// @@clientLocation decorators for operations with custom @operationId
// These ensure consistent operationId generation in the output

// CertificateResponses interface operations
@@clientLocation(CertificateResponses.get, "DpsCertificate");
@@clientLocation(CertificateResponses.createOrUpdate, "DpsCertificate");
@@clientLocation(CertificateResponses.delete, "DpsCertificate");
@@clientLocation(CertificateResponses.list, "DpsCertificate");
@@clientLocation(CertificateResponses.generateVerificationCode,
  "DpsCertificate"
);
@@clientLocation(CertificateResponses.verifyCertificate, "DpsCertificate");

// GroupIdInformations interface operations
@@clientLocation(GroupIdInformations.getPrivateLinkResources, "IotDpsResource");
@@clientLocation(GroupIdInformations.listPrivateLinkResources,
  "IotDpsResource"
);

// PrivateEndpointConnections interface operations
@@clientLocation(PrivateEndpointConnections.getPrivateEndpointConnection,
  "IotDpsResource"
);
@@clientLocation(PrivateEndpointConnections.createOrUpdatePrivateEndpointConnection,
  "IotDpsResource"
);
@@clientLocation(PrivateEndpointConnections.deletePrivateEndpointConnection,
  "IotDpsResource"
);
@@clientLocation(PrivateEndpointConnections.listPrivateEndpointConnections,
  "IotDpsResource"
);

// ProvisioningServiceDescriptions interface operations
@@clientLocation(ProvisioningServiceDescriptions.get, "IotDpsResource");
@@clientLocation(ProvisioningServiceDescriptions.createOrUpdate,
  "IotDpsResource"
);
@@clientLocation(ProvisioningServiceDescriptions.update, "IotDpsResource");
@@clientLocation(ProvisioningServiceDescriptions.delete, "IotDpsResource");
@@clientLocation(ProvisioningServiceDescriptions.listByResourceGroup,
  "IotDpsResource"
);
@@clientLocation(ProvisioningServiceDescriptions.listBySubscription,
  "IotDpsResource"
);
@@clientLocation(ProvisioningServiceDescriptions.listValidSkus,
  "IotDpsResource"
);
@@clientLocation(ProvisioningServiceDescriptions.listKeys, "IotDpsResource");
@@clientLocation(ProvisioningServiceDescriptions.listKeysForKeyName,
  "IotDpsResource"
);

// ProvisioningServiceDescriptionOperations interface operations
@@clientLocation(ProvisioningServiceDescriptionOperations.getOperationResult,
  "IotDpsResource"
);

// IotDpsResourceOperationGroup interface operations
@@clientLocation(IotDpsResourceOperationGroup.checkProvisioningServiceNameAvailability,
  "IotDpsResource"
);
