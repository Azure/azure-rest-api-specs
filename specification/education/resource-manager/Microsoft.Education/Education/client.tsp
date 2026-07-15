import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.ResourceManager;
using Microsoft.Education;

@@clientName(
  Microsoft.Education,
  "EducationManagementClient",
  "python,javascript"
);
@@visibility(
  Azure.ResourceManager.CommonTypes.OperationListResult.nextLink,
  Lifecycle.Read
);
@@visibility(
  Azure.ResourceManager.CommonTypes.OperationListResult.value,
  Lifecycle.Read
);
@@clientLocation(redeemInvitationCode, "ManagementClient", "go");

@@clientName(Amount, "EducationAmount", "csharp");

@@alternateType(LabProperties.maxStudentCount, int32, "csharp");
@@alternateType(InviteCodeGenerateRequest.maxStudentCount, int32, "csharp");

// C# management SDK customizations for the Education onboarding.
// common-types v3 types.json models Resource.id as a plain string; map it to
// armResourceIdentifier so generated ResourceData ctors take a ResourceIdentifier.
@@alternateType(CommonTypes.Resource.id, armResourceIdentifier, "csharp");
// Rename models whose names collide with reserved Azure SDK suffixes (AZC0030/AZC0033).
@@clientName(
  InviteCodeGenerateRequest,
  "EducationInviteCodeGenerateContent",
  "csharp"
);
@@clientName(RedeemRequest, "EducationRedeemContent", "csharp");
@@clientName(CommonTypes.Operation, "EducationOperationInfo", "csharp");
// The provider operations-list method is ARM infrastructure; make the whole operation
// internal so its method and envelope models stay off the public surface instead of
// redefining common-types operation models publicly.
@@access(Microsoft.Education.Operations.list, Access.internal, "csharp");

@@clientName(GrantType, "EducationGrantType", "csharp");
@@clientName(GrantStatus, "EducationGrantStatus", "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "workaround: avoid "
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  LabProperties.totalBudget,
  "!csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  LabProperties.totalAllocatedBudget,
  "!csharp"
);
