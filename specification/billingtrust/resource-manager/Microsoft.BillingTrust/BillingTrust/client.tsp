import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.BillingTrust;
using Azure.ClientGenerator.Core;

@@clientName(ProvisioningState, "BillingTrustProvisioningState", "csharp");
@@clientName(Microsoft.BillingTrust, "BillingTrustMgmtClient", "python");
@@clientName(Assessment, "BillingTrustAssessment", "csharp");
@@clientName(Rule, "BillingTrustRule", "csharp");
@@clientName(
  AssessmentProperties,
  "BillingTrustAssessmentProperties",
  "csharp"
);
@@clientName(AssessmentState, "BillingTrustAssessmentState", "csharp");
@@clientName(AssessmentType, "BillingTrustAssessmentType", "csharp");
@@clientName(RuleProperties, "BillingTrustRuleProperties", "csharp");
@@clientName(RuleState, "BillingTrustRuleState", "csharp");
@@clientName(ExternalId, "BillingTrustExternalId", "csharp");
@@clientName(SoldTo, "BillingTrustSoldTo", "csharp");
@@clientName(TaxId, "BillingTrustTaxId", "csharp");
@@clientName(TaxIdStatus, "BillingTrustTaxIdStatus", "csharp");
@@clientName(
  RegistrationNumber,
  "BillingTrustRegistrationNumber",
  "csharp"
);
@@clientName(
  RegistrationRequirement,
  "BillingTrustRegistrationRequirement",
  "csharp"
);
@@clientName(DomainEntry, "BillingTrustDomainEntry", "csharp");
@@clientName(DomainEntryState, "BillingTrustDomainEntryState", "csharp");
@@clientName(
  InitialRuleValueBase,
  "BillingTrustInitialRuleValueBase",
  "csharp"
);
@@clientName(
  GenerateUploadTokenResponse,
  "GenerateUploadTokenResult",
  "csharp"
);
