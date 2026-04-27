import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.BillingBenefits;

// go
@@clientLocation(BenefitOperationGroup.validate, "RP", "go");
@@clientName(Microsoft.BillingBenefits.ResourceSku, "SKU", "go");
@@clientName(Microsoft.BillingBenefits.ManagedServiceIdentity,
  "ServiceManagedIdentity",
  "go"
);
@@clientName(Microsoft.BillingBenefits.ManagedServiceIdentityType,
  "ServiceManagedIdentityType",
  "go"
);

// java
@@clientLocation(BenefitOperationGroup.validate, "ResourceProviders", "java");
@@clientName(Microsoft.BillingBenefits.ManagedServiceIdentity,
  "ServiceManagedIdentity",
  "java"
);
@@clientName(Microsoft.BillingBenefits.ManagedServiceIdentityType,
  "ServiceManagedIdentityType",
  "java"
);

// python
@@clientName(Microsoft.BillingBenefits.ManagedServiceIdentity,
  "ServiceManagedIdentity",
  "python"
);
@@clientName(Microsoft.BillingBenefits.ManagedServiceIdentityType,
  "ServiceManagedIdentityType",
  "python"
);

// csharp
@@clientName(Microsoft.BillingBenefits.ManagedServiceIdentity,
  "BillingBenefitsManagedServiceIdentity",
  "csharp"
);
@@clientName(Microsoft.BillingBenefits.ManagedServiceIdentityType,
  "BillingBenefitsManagedServiceIdentityType",
  "csharp"
);
@@clientName(ReservationOrderAliasResponse,
  "BillingBenefitsReservationOrderAlias",
  "csharp"
);
@@clientName(AppliedScopeProperties,
  "BillingBenefitsAppliedScopeProperties",
  "csharp"
);
@@clientName(AppliedScopeType, "BillingBenefitsAppliedScopeType", "csharp");
@@clientName(BillingPlan, "BillingBenefitsBillingPlan", "csharp");
@@clientName(ProvisioningState, "BillingBenefitsProvisioningState", "csharp");
@@clientName(InstanceFlexibility,
  "BillingBenefitsInstanceFlexibility",
  "csharp"
);
@@clientName(ReservedResourceType,
  "BillingBenefitsReservedResourceType",
  "csharp"
);
@@clientName(Term, "BillingBenefitsTerm", "csharp");
@@clientName(SavingsPlanModel, "BillingBenefitsSavingsPlan", "csharp");
@@clientName(Commitment, "BillingBenefitsCommitment", "csharp");
@@clientName(CommitmentGrain, "BillingBenefitsCommitmentGrain", "csharp");
@@clientName(ExtendedStatusInfo, "BillingBenefitsExtendedStatusInfo", "csharp");
@@clientName(Utilization, "BillingBenefitsSavingsPlanUtilization", "csharp");
@@clientName(UtilizationAggregates,
  "BillingBenefitsSavingsPlanUtilizationAggregate",
  "csharp"
);
@@clientName(PurchaseRequest, "BillingBenefitsPurchaseContent", "csharp");
@@clientName(SavingsPlanValidResponseProperty,
  "SavingsPlanValidateResult",
  "csharp"
);
@@clientName(SavingsPlanOrderAliasModel,
  "BillingBenefitsSavingsPlanOrderAlias",
  "csharp"
);
@@clientName(SavingsPlanOrderModel,
  "BillingBenefitsSavingsPlanOrder",
  "csharp"
);
@@clientName(RoleAssignmentEntity,
  "BillingBenefitsRoleAssignmentEntity",
  "csharp"
);
@@clientName(Price, "BillingBenefitsPrice", "csharp");
@@clientName(PaymentDetail, "SavingsPlanOrderPaymentDetail", "csharp");
@@clientName(PaymentStatus, "BillingBenefitsPaymentStatus", "csharp");
@@clientName(SavingsPlanUpdateRequest, "SavingsPlanUpdateContent", "csharp");
@@clientName(SavingsPlanUpdateValidateRequest,
  "SavingsPlanUpdateValidateContent",
  "csharp"
);
@@clientName(SavingsPlanPurchaseValidateRequest,
  "SavingsPlanPurchaseValidateContent",
  "csharp"
);
@@clientName(ReservationOrderAliasRequest,
  "ReservationOrderAliasContent",
  "csharp"
);
@@clientName(DiscountPatchRequest, "DiscountPatchContent", "csharp");
@@clientName(SavingsPlanUpdateRequestProperties,
  "BillingBenefitsSavingsPlanPatchProperties",
  "csharp"
);
@@clientName(ReservationOrderAliasResponseProperties.renew,
  "IsRenewed",
  "csharp"
);
@@clientName(ReservationOrderAliasRequestProperties.renew,
  "IsRenewed",
  "csharp"
);
@@clientName(SavingsPlanModelProperties.effectiveDateTime,
  "EffectOn",
  "csharp"
);
@@clientName(SavingsPlanModelProperties.expiryDateTime, "ExpireOn", "csharp");
@@clientName(SavingsPlanModelProperties.renew, "IsRenewed", "csharp");
@@clientName(PurchaseRequestProperties.effectiveDateTime, "EffectOn", "csharp");
@@clientName(PurchaseRequestProperties.renew, "IsRenewed", "csharp");
@@clientName(SavingsPlanValidResponseProperty.valid, "IsValid", "csharp");
@@clientName(SavingsPlanOrderModelProperties.expiryDateTime,
  "ExpireOn",
  "csharp"
);
@@clientName(PaymentDetail.paymentDate, "PayOn", "csharp");
@@clientName(SavingsPlanUpdateRequestProperties.renew, "IsRenewed", "csharp");
@@clientName(SavingsPlanOrderAliasProperties.renew, "IsRenewed", "csharp");
@@clientName(BenefitValidateResponseProperty.valid, "IsValid", "csharp");
@@clientName(SellerResourceListRequestProperties.contributors,
  "IncludeContributors",
  "csharp"
);
@@clientName(SellerResourceListRequestProperties.milestones,
  "IncludeMilestones",
  "csharp"
);
@@clientName(MaccModelProperties.allowContributors,
  "IsAllowContributors",
  "csharp"
);
@@clientName(MaccPatchRequestProperties.allowContributors,
  "IsAllowContributors",
  "csharp"
);
@@clientName(DiscountProperties, "BillingBenefitsDiscountProperties", "csharp");
@@clientName(ConditionalCreditProperties,
  "BillingBenefitsConditionalCreditProperties",
  "csharp"
);
@@alternateType(ReservationOrderAliasResponseProperties.billingScopeId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ReservationOrderAliasResponseProperties.reservationOrderId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ReservationOrderAliasRequestProperties.billingScopeId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AppliedScopeProperties.managementGroupId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AppliedScopeProperties.subscriptionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AppliedScopeProperties.resourceGroupId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(SavingsPlanModelProperties.billingAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(SavingsPlanModelProperties.billingProfileId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(SavingsPlanModelProperties.billingScopeId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(PurchaseRequestProperties.billingScopeId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(SavingsPlanOrderModelProperties.billingAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(SavingsPlanOrderModelProperties.billingProfileId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(RoleAssignmentEntity.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(RoleAssignmentEntityProperties.roleDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(RoleAssignmentEntityProperties.scope,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@clientName(ReservedResourceType.CosmosDb, "CosmosDB", "csharp");
@@clientName(ReservedResourceType.MariaDb, "MariaDB", "csharp");
@@clientName(ReservedResourceType.AVS, "Avs", "csharp");
@@clientName(ReservationOrderAliasRequest,
  "BillingBenefitsReservationOrderAliasCreateOrUpdateContent",
  "csharp"
);
@@clientName(SavingsPlanOperationGroup.listAll,
  "GetBillingBenefitsSavingsPlans",
  "csharp"
);
@@alternateType(ReservationOrderAliasResponse.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(SavingsPlanOrderAliasProperties.billingScopeId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(SavingsPlanOrderAliasProperties.savingsPlanOrderId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(SavingsPlanOrderModelProperties.billingScopeId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@usage(SavingsPlanModelProperties, Usage.input | Usage.output, "csharp");
@@usage(SavingsPlanModel, Usage.input | Usage.output, "csharp");
@@usage(ReservationOrderAliasRequest, Usage.input | Usage.output, "csharp");
@@usage(ReservationOrderAliasRequestProperties,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(PaymentDetail, Usage.input | Usage.output, "csharp");
@@usage(BillingPlanInformation, Usage.input | Usage.output, "csharp");
@@usage(ReservationOrderAliasResponse, Usage.input | Usage.output, "csharp");
@@usage(SavingsPlanOrderModel, Usage.input | Usage.output, "csharp");

@@alternateType(AppliedScopeProperties.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(ReservationOrderAliasRequest.location,
  Azure.Core.azureLocation,
  "csharp"
);

// python: client name mitigation
@@clientName(Microsoft.BillingBenefits, "BillingBenefitsMgmtClient", "python");

// python: enum value naming mitigations
@@clientName(BillingPlan.P1M, "P1_M", "python");
@@clientName(Term.P1Y, "P1_Y", "python");
@@clientName(Term.P3Y, "P3_Y", "python");
@@clientName(Term.P5Y, "P5_Y", "python");

@@clientName(DiscountsOperationGroup.scopeList,
  "listDiscountByScope",
  "csharp"
);
@@clientName(ConditionalCreditsOperationGroup.scopeList,
  "listConditionalCreditByScope",
  "csharp"
);
