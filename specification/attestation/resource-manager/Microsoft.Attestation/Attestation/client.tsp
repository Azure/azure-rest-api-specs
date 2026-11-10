import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.Attestation;

@@clientName(
  Microsoft.Attestation,
  "AttestationManagementClient",
  "javascript"
);
@@clientName(Microsoft.Attestation, "AttestationManagementClient", "python");
@@clientName(JsonWebKey, "JSONWebKey", "python");
@@clientName(JsonWebKeySet, "JSONWebKeySet", "python");

// csharp configurations
// Preserve the ARM name constraint in provisioning metadata without changing the generated Swagger.
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Name constraints for provisioning"
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "Name constraints for provisioning"
@@clientOption(
  AttestationProvider,
  "resource-name-constraint",
  #{ minLength: 3, maxLength: 24, pattern: "^[a-zA-Z0-9-]{3,24}$" },
  "csharp"
);
@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Azure.ResourceManager.CommonTypes.PrivateEndpoint.id,
  armResourceIdentifier,
  "csharp"
);
@@clientName(
  PrivateEndpointConnection,
  "AttestationPrivateEndpointConnection",
  "csharp"
);
@@clientName(
  AttestationServiceCreationParams,
  "AttestationProviderCreateOrUpdateContent",
  "csharp"
);
@@alternateType(
  AttestationServiceCreationParams.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(
  AttestationServicePatchSpecificParams,
  "AttestationProviderPatchProperties",
  "csharp"
);
@@clientName(JsonWebKey, "AttestationJsonWebKey", "csharp");
@@clientName(
  PublicNetworkAccessType,
  "AttestationPublicNetworkAccessType",
  "csharp"
);
@@clientName(
  AttestationProvidersOperationGroup.listDefault,
  "GetDefaultAttestationProvider",
  "csharp"
);
@@clientName(
  AttestationProvidersOperationGroup.getDefaultByLocation,
  "GetDefaultAttestationProviderByLocation",
  "csharp"
);
@@clientName(
  AttestationProviders.listByProvider,
  "GetPrivateLinkResources",
  "csharp"
);
@@alternateType(StatusResult.attestUri, url, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  AttestationProviders.listByResourceGroup,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  AttestationProviders.list,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  AttestationProviders.listByProvider,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  AttestationProvidersOperationGroup.listDefault,
  "csharp"
);
@@usage(AttestationProvider, Usage.input, "csharp");
