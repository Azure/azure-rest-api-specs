using OpenAPI;

namespace Microsoft.AppSecurity;

alias MinRuleSetTypeLength = 1;
alias MaxRuleSetTypeLength = 30;
alias MinRuleSetVersionLength = 1;
alias MaxRuleSetVersionLength = 20;

@doc("Managed rule set definition")
model ManagedRuleSet {
  @doc("The state of the rule set. Default is Enabled")
  state?: EnabledState = EnabledState.Enabled;

  ...ManagedRuleSetId;
}

@doc("Defines a managed rule set identifier")
model ManagedRuleSetId {
  @doc("Defines the type of the rule set")
  @minLength(MinRuleSetTypeLength)
  @maxLength(MaxRuleSetTypeLength)
  ruleSetType: string;

  @doc("Defines the version of the rule set")
  @minLength(MinRuleSetVersionLength)
  @maxLength(MaxRuleSetVersionLength)
  ruleSetVersion: string;
}
