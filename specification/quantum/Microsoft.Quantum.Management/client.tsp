import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Quantum;
using Azure.Core;
using Azure.ResourceManager.Foundations;

@@clientName(UsableStatus, "WorkspaceUsableStatus", "csharp");
@@clientName(WorkspaceResourceProperties.apiKeyEnabled,
  "IsApiKeyEnabled",
  "csharp"
);
@@clientName(ApiKey, "WorkspaceApiKey", "csharp");
@@clientName(ApiKeys, "WorkspaceApiKeys", "csharp");
@@clientName(CheckNameAvailabilityRequest,
  "WorkspaceNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityRequest.type, "ResourceType", "csharp");
@@alternateType(CheckNameAvailabilityRequest.type, armResourceType, "csharp");
@@clientName(CheckNameAvailabilityResponse,
  "WorkspaceNameAvailabilityResult",
  "csharp"
);
@@clientName(CheckNameAvailabilityResponse.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(Workspaces.checkNameAvailability,
  "CheckWorkspaceNameAvailability",
  "csharp"
);
@@clientName(Workspaces.listKeys, "GetKeysWorkspace", "csharp");
@@clientName(Workspaces.regenerateKeys, "RegenerateKeysWorkspace", "csharp");
@@clientName(Workspaces.regenerateKeys::parameters.body,
  "keySpecification",
  "csharp"
);
@@clientName(KeyType, "WorkspaceKeyType", "csharp");
@@clientName(ListKeysResult, "WorkspaceKeyListResult", "csharp");
@@clientName(ListKeysResult.apiKeyEnabled, "IsApiKeyEnabled", "csharp");
@@clientName(PricingDimension, "ProviderPricingDimension", "csharp");
@@clientName(WorkspaceProvisioningStatus,
  "ProviderProvisioningStatus",
  "csharp"
);
@@clientName(ProviderStatus, "QuantumProvisioningStatus", "csharp");
@@clientName(ProviderPropertiesAad, "ProviderAadInfo", "csharp");
@@clientName(ProviderPropertiesManagedApplication,
  "ProviderApplicationInfo",
  "csharp"
);
@@clientName(SkuDescription, "ProviderSkuDescription", "csharp");
@@alternateType(SkuDescription.restrictedAccessUri, url, "csharp");
@@clientName(TargetDescription, "ProviderTargetDescription", "csharp");
@@clientName(PricingDetail, "QuantumPricingDetail", "csharp");
@@clientName(Provider, "QuantumProvider", "csharp");
@@alternateType(Provider.instanceUri, url, "csharp");
@@clientName(ProviderDescription, "QuantumProviderDescription", "csharp");
@@clientName(ProviderProperties, "QuantumProviderProperties", "csharp");
@@clientName(QuotaDimension, "QuantumQuotaDimension", "csharp");
@@clientName(WorkspaceKind, "QuantumWorkspaceKind", "csharp");
@@clientName(QuotaAllocations, "QuantumQuotaAllocations", "csharp");
@@alternateType(ProviderPropertiesAad.tenantId, uuid, "csharp");
@@alternateType(WorkspaceResourceProperties.endpointUri, url, "csharp");
@@alternateType(QuantumSuiteOfferProperties.quotas, azureLocation, "csharp");
