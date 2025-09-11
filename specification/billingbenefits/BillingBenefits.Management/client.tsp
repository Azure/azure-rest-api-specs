import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.BillingBenefits;

// go
@@clientLocation(Microsoft.BillingBenefits.validatePurchase, "RP", "go");
@@clientName(Microsoft.BillingBenefits.ResourceSku, "SKU", "go");

// java
@@clientLocation(Microsoft.BillingBenefits.validatePurchase,
  "ResourceProviders",
  "java"
);

// csharp
@@clientName(ReservationOrderAliasResponse,
  "BillingBenefitsReservationOrderAlias",
  "csharp"
);
@@alternateType(ReservationOrderAliasResponseProperties.billingScopeId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ReservationOrderAliasResponseProperties.reservationOrderId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(ReservationOrderAliasResponseProperties.renew,
  "IsRenewed",
  "csharp"
);
@@alternateType(ReservationOrderAliasRequestProperties.billingScopeId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(ReservationOrderAliasResponseProperties.renew,
  "IsRenewed",
  "csharp"
);
@@alternateType(ReservationOrderAliasRequestProperties.billingScopeId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(ReservationOrderAliasRequestProperties.renew, "IsRenew", "csharp");
@@clientName(AppliedScopeProperties,
  "BillingBenefitsAppliedScopeProperties",
  "csharp"
);
@@alternateType(AppliedScopeProperties.managementGroupId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(AppliedScopeProperties.subscriptionId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(AppliedScopeProperties.resourceGroupId,
  armResourceIdentifier,
  "csharp"
);
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
@@alternateType(SavingsPlanModelProperties.billingAccountId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(SavingsPlanModelProperties.billingProfileId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(SavingsPlanModelProperties.billingScopeId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(SavingsPlanModelProperties.effectiveDateTime,
  "EffectOn",
  "csharp"
);
@@clientName(SavingsPlanModelProperties.expiryDateTime, "ExpireOn", "csharp");
@@clientName(SavingsPlanModelProperties.renew, "IsRenewed", "csharp");
@@clientName(Commitment, "BillingBenefitsCommitment", "csharp");
@@clientName(CommitmentGrain, "BillingBenefitsCommitmentGrain", "csharp");
@@clientName(ExtendedStatusInfo, "BillingBenefitsExtendedStatusInfo", "csharp");
@@clientName(Utilization, "BillingBenefitsSavingsPlanUtilization", "csharp");
@@clientName(UtilizationAggregates,
  "BillingBenefitsSavingsPlanUtilizationAggregate",
  "csharp"
);
@@clientName(PurchaseRequest, "BillingBenefitsPurchaseContent", "csharp");
@@alternateType(PurchaseRequestProperties.billingScopeId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(PurchaseRequestProperties.effectiveDateTime, "EffectOn", "csharp");
@@clientName(PurchaseRequestProperties.renew, "IsRenewed", "csharp");
@@clientName(SavingsPlanValidResponseProperty,
  "SavingsPlanValidateResult",
  "csharp"
);
@@clientName(SavingsPlanValidResponseProperty.valid, "IsValid", "csharp");
@@clientName(SavingsPlanOrderAliasModel,
  "BillingBenefitsSavingsPlanOrderAlias",
  "csharp"
);
@@alternateType(SavingsPlanOrderAliasProperties.billingScopeId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(SavingsPlanOrderModel,
  "BillingBenefitsSavingsPlanOrder",
  "csharp"
);
@@alternateType(SavingsPlanOrderModelProperties.billingAccountId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(SavingsPlanOrderModelProperties.billingProfileId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(SavingsPlanOrderModelProperties.expiryDateTime,
  "ExpireOn",
  "csharp"
);
@@clientName(RoleAssignmentEntity,
  "BillingBenefitsRoleAssignmentEntity",
  "csharp"
);
@@alternateType(RoleAssignmentEntity.id, armResourceIdentifier, "csharp");
@@alternateType(RoleAssignmentEntityProperties.roleDefinitionId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(RoleAssignmentEntityProperties.scope,
  armResourceIdentifier,
  "csharp"
);
@@clientName(Price, "BillingBenefitsPrice", "csharp");
@@clientName(PaymentDetail, "SavingsPlanOrderPaymentDetail", "csharp");
@@clientName(PaymentDetail.paymentDate, "PayOn", "csharp");
@@clientName(PaymentStatus, "BillingBenefitsPaymentStatus", "csharp");
@@clientName(SavingsPlanUpdateRequestProperties,
  "BillingBenefitsSavingsPlanPatchProperties",
  "csharp"
);
@@clientName(SavingsPlanUpdateRequestProperties.renew, "IsRenewed", "csharp");
@@clientName(SavingsPlanOperationGroup.listAll, "GetBillingBenefitsSavingsPlans", "csharp");
