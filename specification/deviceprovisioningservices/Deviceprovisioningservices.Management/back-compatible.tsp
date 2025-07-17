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
@@clientLocation(CertificateResponses.get, "DpsCertificate", "!csharp");
@@clientLocation(CertificateResponses.createOrUpdate,
  "DpsCertificate",
  "!csharp"
);
@@clientLocation(CertificateResponses.delete, "DpsCertificate", "!csharp");
@@clientLocation(CertificateResponses.list, "DpsCertificate", "!csharp");
@@clientLocation(CertificateResponses.generateVerificationCode,
  "DpsCertificate",
  "!csharp"
);
@@clientLocation(CertificateResponses.verifyCertificate,
  "DpsCertificate",
  "!csharp"
);

// GroupIdInformations interface operations
@@clientLocation(GroupIdInformations.getPrivateLinkResources,
  "IotDpsResource",
  "!csharp"
);
@@clientLocation(GroupIdInformations.listPrivateLinkResources,
  "IotDpsResource",
  "!csharp"
);

// PrivateEndpointConnections interface operations
@@clientLocation(PrivateEndpointConnections.getPrivateEndpointConnection,
  "IotDpsResource",
  "!csharp"
);
@@clientLocation(PrivateEndpointConnections.createOrUpdatePrivateEndpointConnection,
  "IotDpsResource",
  "!csharp"
);
@@clientLocation(PrivateEndpointConnections.deletePrivateEndpointConnection,
  "IotDpsResource",
  "!csharp"
);
@@clientLocation(PrivateEndpointConnections.listPrivateEndpointConnections,
  "IotDpsResource",
  "!csharp"
);

// ProvisioningServiceDescriptions interface operations
@@clientLocation(ProvisioningServiceDescriptions.get,
  "IotDpsResource",
  "!csharp"
);
@@clientLocation(ProvisioningServiceDescriptions.createOrUpdate,
  "IotDpsResource",
  "!csharp"
);
@@clientLocation(ProvisioningServiceDescriptions.update,
  "IotDpsResource",
  "!csharp"
);
@@clientLocation(ProvisioningServiceDescriptions.delete,
  "IotDpsResource",
  "!csharp"
);
@@clientLocation(ProvisioningServiceDescriptions.listByResourceGroup,
  "IotDpsResource",
  "!csharp"
);
@@clientLocation(ProvisioningServiceDescriptions.listBySubscription,
  "IotDpsResource",
  "!csharp"
);
@@clientLocation(ProvisioningServiceDescriptions.listValidSkus,
  "IotDpsResource",
  "!csharp"
);
@@clientLocation(ProvisioningServiceDescriptions.listKeys,
  "IotDpsResource",
  "!csharp"
);
@@clientLocation(ProvisioningServiceDescriptions.listKeysForKeyName,
  "IotDpsResource",
  "!csharp"
);

// ProvisioningServiceDescriptionOperations interface operations
@@clientLocation(ProvisioningServiceDescriptionOperations.getOperationResult,
  "IotDpsResource"
);

// IotDpsResourceOperationGroup interface operations
@@clientLocation(IotDpsResourceOperationGroup.checkProvisioningServiceNameAvailability,
  "IotDpsResource"
);
