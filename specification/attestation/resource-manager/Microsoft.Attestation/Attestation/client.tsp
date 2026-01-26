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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(AttestationProviders.listByResourceGroup,
  "csharp"
);
