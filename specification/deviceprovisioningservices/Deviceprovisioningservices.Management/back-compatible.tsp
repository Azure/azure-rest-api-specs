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

// Add client location decorators for all operations with @operationId
// CertificateResponses interface operations
@@clientLocation(CertificateResponses.get, "DpsCertificate", "Get");
@@clientLocation(CertificateResponses.createOrUpdate,
  "DpsCertificate",
  "CreateOrUpdate"
);
@@clientLocation(CertificateResponses.delete, "DpsCertificate", "Delete");
@@clientLocation(CertificateResponses.list, "DpsCertificate", "List");
@@clientLocation(CertificateResponses.generateVerificationCode,
  "DpsCertificate",
  "GenerateVerificationCode"
);
@@clientLocation(CertificateResponses.verifyCertificate,
  "DpsCertificate",
  "VerifyCertificate"
);

// GroupIdInformations interface operations
@@clientLocation(GroupIdInformations.getPrivateLinkResources,
  "IotDpsResource",
  "GetPrivateLinkResources"
);
@@clientLocation(GroupIdInformations.listPrivateLinkResources,
  "IotDpsResource",
  "ListPrivateLinkResources"
);

// PrivateEndpointConnections interface operations
@@clientLocation(PrivateEndpointConnections.getPrivateEndpointConnection,
  "IotDpsResource",
  "GetPrivateEndpointConnection"
);
@@clientLocation(PrivateEndpointConnections.createOrUpdatePrivateEndpointConnection,
  "IotDpsResource",
  "CreateOrUpdatePrivateEndpointConnection"
);
@@clientLocation(PrivateEndpointConnections.deletePrivateEndpointConnection,
  "IotDpsResource",
  "DeletePrivateEndpointConnection"
);
@@clientLocation(PrivateEndpointConnections.listPrivateEndpointConnections,
  "IotDpsResource",
  "ListPrivateEndpointConnections"
);

// ProvisioningServiceDescriptions interface operations
@@clientLocation(ProvisioningServiceDescriptions.get, "IotDpsResource", "Get");
@@clientLocation(ProvisioningServiceDescriptions.createOrUpdate,
  "IotDpsResource",
  "CreateOrUpdate"
);
@@clientLocation(ProvisioningServiceDescriptions.update,
  "IotDpsResource",
  "Update"
);
@@clientLocation(ProvisioningServiceDescriptions.delete,
  "IotDpsResource",
  "Delete"
);
@@clientLocation(ProvisioningServiceDescriptions.listByResourceGroup,
  "IotDpsResource",
  "ListByResourceGroup"
);
@@clientLocation(ProvisioningServiceDescriptions.listBySubscription,
  "IotDpsResource",
  "ListBySubscription"
);
@@clientLocation(ProvisioningServiceDescriptions.listValidSkus,
  "IotDpsResource",
  "listValidSkus"
);
@@clientLocation(ProvisioningServiceDescriptions.listKeys,
  "IotDpsResource",
  "ListKeys"
);
@@clientLocation(ProvisioningServiceDescriptions.listKeysForKeyName,
  "IotDpsResource",
  "ListKeysForKeyName"
);

// ProvisioningServiceDescriptionOperations interface operations
@@clientLocation(ProvisioningServiceDescriptionOperations.getOperationResult,
  "IotDpsResource",
  "GetOperationResult"
);

// IotDpsResourceOperationGroup interface operations
@@clientLocation(IotDpsResourceOperationGroup.checkProvisioningServiceNameAvailability,
  "IotDpsResource",
  "CheckProvisioningServiceNameAvailability"
);
