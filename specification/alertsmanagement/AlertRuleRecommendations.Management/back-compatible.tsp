import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AlertRuleRecommendationsClient;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AlertRuleRecommendationResource.properties);

@@clientName(RuleArmTemplate.$schema, "schema");

@@clientLocation(AlertRuleRecommendationsOperationGroup.listByResource,
  "AlertRuleRecommendations"
);
@@clientLocation(AlertRuleRecommendationsOperationGroup.listByTargetType,
  "AlertRuleRecommendations"
);
