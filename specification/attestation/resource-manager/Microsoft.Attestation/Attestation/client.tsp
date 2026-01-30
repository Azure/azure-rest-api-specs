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

// csharp configurations
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);
@@clientName(PrivateEndpointConnection,
  "AttestationPrivateEndpointConnection",
  "csharp"
);
@@clientName(AttestationServiceCreationParams,
  "AttestationProviderCreateOrUpdateContent",
  "csharp"
);
@@alternateType(AttestationServiceCreationParams.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(AttestationServicePatchSpecificParams,
  "AttestationProviderPatchProperties",
  "csharp"
);
@@clientName(JsonWebKey, "AttestationJsonWebKey", "csharp");
@@clientName(PublicNetworkAccessType,
  "AttestationPublicNetworkAccessType",
  "csharp"
);
@@clientName(AttestationProvidersOperationGroup.listDefault,
  "GetDefaultAttestationProvider",
  "csharp"
);
@@clientName(AttestationProvidersOperationGroup.getDefaultByLocation,
  "GetDefaultAttestationProviderByLocation",
  "csharp"
);
@@alternateType(StatusResult.attestUri, url, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(AttestationProviders.listByResourceGroup,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(AttestationProviders.list,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(AttestationProviders.listByProvider,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(AttestationProvidersOperationGroup.listDefault,
  "csharp"
);
@@usage(AttestationProvider, Usage.input, "csharp");
