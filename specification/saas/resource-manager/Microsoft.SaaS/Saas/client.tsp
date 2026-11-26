import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.SaaS;

@@clientName(UnsubscribeOptions, "UnsubscribeConfig", "csharp");
@@clientName(
  SaasPurchaseValidationRequest,
  "SaasPurchaseValidationContent",
  "csharp"
);

@@clientName(SaasProvisioningState, "SaaSProvisioningState", "go");
@@clientName(SaasResourceProperties, "SaaSResourceProperties", "go");
@@clientName(SaasResource, "SaaSResource", "go");
@@clientName(SaasResourceUpdate, "SaaSResourceUpdate", "go");
@@clientName(
  SaasPurchaseValidationProperties,
  "SaaSPurchaseValidationProperties",
  "go"
);
@@clientName(
  SaasPurchaseValidationRequest,
  "SaaSPurchaseValidationRequest",
  "go"
);
@@clientName(SaasTenantResource, "SaaSTenantResource", "go");
@@clientName(SaasTenantResourceUpdate, "SaaSTenantResourceUpdate", "go");
@@clientName(SaasSubscriptionLevel, "SaaSSubscriptionLevel", "go");
@@clientName(SaasSubscriptionLevelGlobal, "SaaSSubscriptionLevelGlobal", "go");
@@clientName(SaasTenantLevel, "SaaSTenantLevel", "go");
@@clientName(SaasOperationStatuses, "SaaSOperationStatuses", "go");
