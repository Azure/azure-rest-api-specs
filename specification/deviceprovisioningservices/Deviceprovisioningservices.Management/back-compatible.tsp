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
