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

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AttestationProvider.properties
);

@@clientName(PrivateEndpointConnections.create::parameters.resource,
  "properties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties
);

@@clientLocation(AttestationProvidersOperationGroup.listDefault,
  AttestationProviders
);
@@clientLocation(AttestationProvidersOperationGroup.getDefaultByLocation,
  AttestationProviders
);
