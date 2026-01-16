import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.Attestation;

@@clientName(Microsoft.Attestation,
  "AttestationManagementClient",
  "javascript"
);
@@clientName(Microsoft.Attestation, "AttestationManagementClient", "python");

@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);
@@clientName(PrivateEndpointConnection,
  "AttestationPrivateEndpointConnection",
  "csharp"
);
@@clientName(AttestationProviderListResult,
  "AttestationProviderCreateOrUpdateContent",
  "csharp"
);
@@alternateType(StatusResult.attestUri, url, "csharp");
