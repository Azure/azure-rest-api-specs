import "./managedRules.tsp";

using OpenAPI;

namespace Microsoft.AppSecurity;

@doc("Defines managed rules customization (including exclusions and overrides)")
model ManagedRulesCustomization {
  @doc("List of exclusions to be applied to the managed rules inspection. If not specified, then no exclusions are applied")
  @extension("x-ms-identifiers", ["name"])
  exclusions?: ManagedRulesExclusion[] = #[];

  @doc("List of managed rule set overrides. If not specified, then no overrides are applied")
  @extension("x-ms-identifiers", ["ruleSetType", "ruleSetVersion"])
  overrides?: ManagedRuleSetOverride[] = #[];
}

@doc("Enable exclusion of variables based on conditions from managed rules inspection")
model ManagedRulesExclusion {
  @doc("The name of the exclusion")
  name: string;

  @doc("The exclusion conditions")
  @extension("x-ms-identifiers", [])
  conditions: ExclusionCondition[];

  @doc("The scope of the exclusion. If not specified, then the exclusion is applied to all managed rules")
  @extension("x-ms-identifiers", ["ruleSetType", "ruleSetVersion"])
  scope?: ManagedRuleSetScope[] = #[];
}

@doc("Defines a condition for the exclusion")
model ExclusionCondition {
  @doc("The variable to be excluded")
  matchVariable: ExclusionMatchVariable;

  @doc("When matchVariable is a collection, operate on the selector to specify which elements in the collection this exclusion applies to")
  selectorMatchOperator: ExclusionSelectorMatchOperator;

  @doc("When matchVariable is a collection, operator used to specify which elements in the collection this exclusion applies to")
  selector?: string;
}

@doc("Defines a managed rule set scope, which can be the entire rule set or a subset of rules within it")
model ManagedRuleSetScope {
  ...ManagedRuleSetId;

  @doc("Exclusion scope. If not specified, then the exclusion is applied to the entire rule set")
  @extension("x-ms-identifiers", ["ruleGroupName"])
  @maxItems(100)
  ruleGroups?: RuleGroupScope[] = #[];
}

@doc("Defines a rule group scope, which can be the entire rule group or a subset of rule within it")
model RuleGroupScope {
  @doc("Relevant rule group name")
  ruleGroupName: string;

  @doc("Relevant rules within the specified rule group. If not specified, the scope is the entire rule group")
  @maxItems(100)
  rules?: string[] = #[];
}

@doc("Defines a managed rule set override")
model ManagedRuleSetOverride {
  ...ManagedRuleSetId;

  @doc("Rule group level overrides")
  @extension("x-ms-identifiers", ["ruleGroupName"])
  ruleGroupOverrides?: RuleGroupOverride[] = #[];
}

// TODO - in the current model a RuleGroupOverride without groupOverride or rules is valid. We need to make sure at least one of them is valid.
@doc("Defines a managed rule group override setting")
model RuleGroupOverride {
  @doc("The managed rule group to override")
  @minLength(1)
  @maxLength(128)
  ruleGroupName: string;

  @doc("Rule group level override")
  groupOverride?: StateAndActionOverride;

  @doc("List of rule level overrides")
  @extension("x-ms-identifiers", ["ruleId"])
  @maxItems(100)
  rules?: RuleOverride[] = #[];
}

@doc("Defines a managed rule or rule group override")
model StateAndActionOverride {
  @doc("The state of the managed rule or rule group")
  state: EnabledState;

  @doc("Overrides the action to be applied when a rule matches")
  action?: ManagedRuleActionType;
}

@doc("Defines a managed rule group override setting")
model RuleOverride {
  @doc("Identifier for the managed rule")
  ruleId: string;

  ...StateAndActionOverride;
}

@doc("Comparison operators variants that can be used with Exclusion variables when defining an Exclusion")
union ExclusionSelectorMatchOperator {
  string,

  @doc("Performs an ordinal (case-sensitive and culture-insensitive) comparison")
  Equals_: "Equals", // Changes the generated name and prevents error CS0108, in which Equal hides inherited member of 'ValueType.Equals(object?)'

  @doc("Checks whether a string contains a sequence of characters")
  Contains: "Contains",

  @doc("Checks whether a string starts with a specified string")
  StartsWith: "StartsWith",

  @doc("Checks whether a string ends with a specified string")
  EndsWith: "EndsWith",

  @doc("Equals any")
  EqualsAny: "EqualsAny",
}

@doc("Variable variants that can be excluded when defining an Exclusion")
union ExclusionMatchVariable {
  string,

  @doc("The request header")
  RequestHeaderNames: "RequestHeaderNames",

  @doc("The request cookie")
  RequestCookieNames: "RequestCookieNames",

  @doc("The request argument")
  RequestArgNames: "RequestArgNames",

  @doc("The request header keys")
  RequestHeaderKeys: "RequestHeaderKeys",

  @doc("The request header value")
  RequestHeaderValues: "RequestHeaderValues",

  @doc("The request cookie keys")
  RequestCookieKeys: "RequestCookieKeys",

  @doc("The request cookie values")
  RequestCookieValues: "RequestCookieValues",

  @doc("The request argument keys")
  RequestArgKeys: "RequestArgKeys",

  @doc("The request argument values")
  RequestArgValues: "RequestArgValues",
}

@doc("Supported action that can be applied if a rule matches")
union ManagedRuleActionType {
  string,

  @doc("Anomaly scoring action")
  AnomalyScoring: "AnomalyScoring",

  @doc("Allow the request")
  Allow: "Allow",

  @doc("Block the request")
  Block: "Block",

  @doc("Log the request and allow it")
  Log: "Log",

  @doc("Redirect the request")
  Redirect: "Redirect", // TODO - this is not valid for appGW
}
