import "./matchCondition.tsp";

using OpenAPI;
using TypeSpec.Rest;

namespace Microsoft.AppSecurity;

alias MinCustomRuleNameLength = 1;
alias MaxCustomRuleNameLength = 128;
alias CustomRuleNamePattern = "^[a-zA-Z][a-zA-Z0-9]*$";
// Min-Max = 0-65535 is basically an int16, but it is not supported in Azure resource manager
alias MinCustomRulePriority = 0;
alias MaxCustomRulePriority = 65535;
alias MinCustomRuleConditionsCount = 1;
alias MaxCustomRuleConditionsCount = 10;
alias RateLimitMinThreshold = 1;

union CustomRuleType {
  MatchBased: "MatchBased",
  RateBased: "RateBased",
  string,
}

@doc("Defines a custom rule")
@discriminator("ruleType")
model CustomRule {
  @doc("Defines the rule type")
  ruleType: CustomRuleType;

  @doc("The name of the rule")
  @minLength(MinCustomRuleNameLength)
  @maxLength(MaxCustomRuleNameLength)
  @pattern(CustomRuleNamePattern)
  name: string;

  @doc("The state of the custom rule. Default is Enabled")
  state?: EnabledState = EnabledState.Enabled;

  @doc("Describes what action to be applied when rule matches")
  action: CustomRuleActionType;

  @doc("Describes priority of the rule. Rules with a lower value will be evaluated before rules with a higher value")
  @minValue(MinCustomRulePriority) // Assuming AppGW "100" doesn't exist anymore
  @maxValue(MaxCustomRulePriority)
  priority: int32;

  // TODO - move this inside the specific custom rule type <https://msazure.visualstudio.com/One/_backlogs/backlog/DDoS%20ILDC/Features/?workitem=24659181>
  // Use the following doc for RateBased custom rule
  // @doc("The list of conditions that must be met for an incoming request to be included in the rate calculation")
  @doc("A list of conditions that must be met for the actions to be executed")
  @extension("x-ms-identifiers", [])
  @minItems(MinCustomRuleConditionsCount)
  @maxItems(MaxCustomRuleConditionsCount)
  matchConditions: CustomRuleCondition[];
}

@doc("User defined rule to execute an action if conditions are met on an incoming request")
model MatchCustomRule extends CustomRule {
  @doc("Defines the rule type")
  ruleType: CustomRuleType.MatchBased;
}

@doc("User defined rule that is triggered by the rate of incoming requests")
model RateBasedCustomRule extends CustomRule {
  @doc("Defines the rule type")
  ruleType: CustomRuleType.RateBased;

  @doc("Configures a rate limit mechanism for the rule")
  rateLimit: RateLimit;
}

@doc("Describes the rate limit configuration of a rate limit custom rule")
model RateLimit {
  @doc("The time duration for which the rate limit threshold is enforced. Default value is 1 minute.")
  durationInMinutes: DurationInMinutes = DurationInMinutes.One;

  @doc("If the total number of requests exceeds this threshold during a rate limit duration, the rate limit action will be invoked")
  @minValue(RateLimitMinThreshold)
  threshold: int32;

  @doc("Group requests based on their type and apply rate limits to each group independently. Default is ClientAddr based grouping")
  groupBy: RateLimitGroupByType = RateLimitGroupByType.ClientAddr;
}

@doc("Defines the available grouping options for rate limiting")
union RateLimitGroupByType {
  string,

  @doc("Grouping based on client address")
  ClientAddr: "ClientAddr",

  @doc("Grouping is based on the geographic location of the request")
  GeoLocation: "GeoLocation",

  @doc("No grouping is being done. Rate limit is global")
  None: "None",
}

@doc("Duration over which rate limit policy will be applied, for rate based rules.")
union DurationInMinutes {
  int32,

  @doc("One minute")
  One: 1,

  @doc("Five minutes")
  Five: 5,
}
