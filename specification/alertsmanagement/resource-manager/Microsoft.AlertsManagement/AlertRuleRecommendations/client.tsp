import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AlertsManagement;

@@clientName(Microsoft.AlertsManagement,
  "AlertRuleRecommendationsMgmtClient",
  "python"
);
@@clientName(Microsoft.AlertsManagement,
  "AlertRuleRecommendationsManagementClient",
  "javascript"
);

// C# customizations: keep the operations on the original interface so the synthetic
// "AlertRuleRecommendations" operation group does not collide with the C# namespace
// (which would otherwise cause the generator to emit `Azure.ResourceManager._AlertRuleRecommendations`).
@@clientLocation(AlertRuleRecommendationsOperationGroup.listByResource,
  AlertRuleRecommendationsOperationGroup,
  "csharp"
);
@@clientLocation(AlertRuleRecommendationsOperationGroup.listByTargetType,
  AlertRuleRecommendationsOperationGroup,
  "csharp"
);

// common-types v3 types Resource.id as `string`; map to armResourceIdentifier so the C#
// generator emits ResourceIdentifier compatible with the ResourceData base class.
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
