import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AlertsManagement;

@@clientName(
  Microsoft.AlertsManagement,
  "AlertRuleRecommendationsMgmtClient",
  "python"
);
@@clientName(
  Microsoft.AlertsManagement,
  "AlertRuleRecommendationsManagementClient",
  "javascript"
);

// C# customizations: keep the operations on the original interface so the synthetic
// "AlertRuleRecommendations" operation group does not collide with the C# namespace
// (which would otherwise cause the generator to emit `Azure.ResourceManager._AlertRuleRecommendations`).
@@clientLocation(
  AlertRuleRecommendationsOperationGroup.listByResource,
  AlertRuleRecommendationsOperationGroup,
  "csharp"
);
@@clientLocation(
  AlertRuleRecommendationsOperationGroup.listByTargetType,
  AlertRuleRecommendationsOperationGroup,
  "csharp"
);

// common-types v3 types Resource.id as `string`; map to armResourceIdentifier so the C#
// generator emits ResourceIdentifier compatible with the ResourceData base class.
@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// C# customizations: rename overly-generic operation names to add resource context so
// the public extension method names follow the ARM convention `Get<Resource>(...)`.
@@clientName(
  AlertRuleRecommendationsOperationGroup.listByResource,
  "getAlertRuleRecommendations",
  "csharp"
);
@@clientName(
  AlertRuleRecommendationsOperationGroup.listByTargetType,
  "getAlertRuleRecommendationsByTargetType",
  "csharp"
);

// C# customizations: rename overly-generic model name to add resource context.
@@clientName(RuleArmTemplate, "AlertRuleRecommendationArmTemplate", "csharp");

// C# customizations: drop the "Resource" suffix on this body model. The mgmt InheritanceCheck
// test fails for any public type ending with "Resource" that does not derive from ArmResource;
// AlertRuleRecommendationResource is a list-response model, not an ARM resource.
@@clientName(
  AlertRuleRecommendationResource,
  "AlertRuleRecommendation",
  "csharp"
);
