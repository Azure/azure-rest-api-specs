import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Sovereign, "SovereignMgmtClient", "python");

// C#: resource model naming (SovereignView / SovereignViewData / SovereignViewCollection)
@@clientName(
  Microsoft.Sovereign.SovereignViewResource,
  "SovereignView",
  "csharp"
);
@@clientName(
  Microsoft.Sovereign.SovereignViewResourcePatch,
  "SovereignViewPatch",
  "csharp"
);
@@clientName(
  Microsoft.Sovereign.SovereignViewResourceProperties,
  "SovereignViewProperties",
  "csharp"
);

// C#: reuse the shared ARM identity type
@@alternateType(
  Microsoft.Sovereign.SovereignViewResource.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  Microsoft.Sovereign.SovereignViewResourcePatch.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);

// C#: name availability
@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
  "SovereignNameAvailabilityContent",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
  "SovereignNameAvailabilityResult",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityReason,
  "SovereignNameUnavailableReason",
  "csharp"
);

// C#: models whose names must not end in "Resource" (reserved for ARM resources)
@@clientName(
  Microsoft.Sovereign.SovereignViewComplianceDetailResource,
  "SovereignViewComplianceDetailResourceInfo",
  "csharp"
);
@@clientName(
  Microsoft.Sovereign.SovereignViewResidencyRemediationResource,
  "SovereignViewResidencyRemediationResourceInfo",
  "csharp"
);

// C#: an empty parentResourceId (standalone resource) is not a valid ResourceIdentifier
@@alternateType(
  Microsoft.Sovereign.SovereignViewComplianceDetailResource.parentResourceId,
  string,
  "csharp"
);

// C#: add Sovereign View context to generic type names; use singular enum names
@@clientName(
  Microsoft.Sovereign.provisioningState,
  "SovereignViewProvisioningState",
  "csharp"
);
@@clientName(
  Microsoft.Sovereign.ComplianceDimension,
  "SovereignViewComplianceDimension",
  "csharp"
);
@@clientName(Microsoft.Sovereign.DataState, "SovereignViewDataState", "csharp");
@@clientName(
  Microsoft.Sovereign.ReportStatus,
  "SovereignViewReportStatus",
  "csharp"
);
@@clientName(
  Microsoft.Sovereign.OperationalStatusRequestMode,
  "SovereignViewOperationalStatusMode",
  "csharp"
);
@@clientName(
  Microsoft.Sovereign.OperationalStatusEvaluationParameter,
  "SovereignViewOperationalStatusEvaluationKind",
  "csharp"
);
@@clientName(
  Microsoft.Sovereign.OperationalStatusStates,
  "SovereignViewOperationalStatusState",
  "csharp"
);
@@clientName(
  Microsoft.Sovereign.ScopeLevelOperationalStatusStates,
  "SovereignViewScopeOperationalStatusState",
  "csharp"
);
@@clientName(
  Microsoft.Sovereign.OperationalStatusUnhealthyReason,
  "SovereignViewOperationalStatusUnhealthyReason",
  "csharp"
);
@@clientName(
  Microsoft.Sovereign.SovereignViewComplianceDetailsFilterOperators,
  "SovereignViewComplianceDetailsFilterOperator",
  "csharp"
);
@@clientName(
  Microsoft.Sovereign.SovereignViewComplianceDetailsSortDirections,
  "SovereignViewComplianceDetailsSortDirection",
  "csharp"
);
@@clientName(
  Microsoft.Sovereign.SovereignViewLinkedResourceEvaluationSource.ARG,
  "AzureResourceGraph",
  "csharp"
);

// C#: DateTimeOffset properties use the "On" suffix
@@clientName(
  Microsoft.Sovereign.ReportStatus.nextAttempt,
  "NextAttemptOn",
  "csharp"
);
@@clientName(
  Microsoft.Sovereign.SovereignViewComplianceSummaryResult.lastEvaluated,
  "LastEvaluatedOn",
  "csharp"
);
@@clientName(
  Microsoft.Sovereign.SovereignViewComplianceDetailsResult.lastEvaluated,
  "LastEvaluatedOn",
  "csharp"
);
