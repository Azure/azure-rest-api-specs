import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Attestation;

@@clientName(JsonWebKey.x5c, "x5C");

@@clientName(AttestationProviders.create::parameters.resource,
  "creationParams"
);
@@clientName(AttestationProviders.update::parameters.properties,
  "updateParams"
);
@@clientLocation(AttestationProviders.listByProvider, "PrivateLinkResources");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AttestationProvider.properties);

@@clientName(PrivateEndpointConnections.create::parameters.resource,
  "properties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientLocation(AttestationProvidersOperationGroup.listDefault,
  AttestationProviders
);
@@clientLocation(AttestationProvidersOperationGroup.getDefaultByLocation,
  AttestationProviders
);
