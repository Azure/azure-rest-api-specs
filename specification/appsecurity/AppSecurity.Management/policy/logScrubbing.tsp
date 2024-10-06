using OpenAPI;

namespace Microsoft.AppSecurity;

alias MinScrubbingRuleSelectorLength = 1;
alias MaxScrubbingRuleSelectorLength = 128;
alias MaxScrubbingRulesCount = 100;

@doc("Supported variable types for scrubbing rules")
union ScrubbingRuleMatchVariable {
  string,

  @doc("The request headers to be scrubbed")
  RequestHeaderNames: "RequestHeaderNames",

  @doc("The request cookies to be scrubbed")
  RequestCookieNames: "RequestCookieNames",

  @doc("The request arguments to be scrubbed")
  RequestArgNames: "RequestArgNames",

  @doc("The request post arguments to be scrubbed")
  RequestPostArgNames: "RequestPostArgNames",

  @doc("The request JSON arguments to be scrubbed")
  RequestJSONArgNames: "RequestJSONArgNames",

  @doc("The request IP address")
  RequestIPAddress: "RequestIPAddress",
}

@doc("Supported operators for scrubbing rules")
union ScrubbingRuleSelectorMatchOperator {
  string,

  @doc("Equals operator")
  Equals_: "Equals", // Changes the generated name and prevents error CS0108, in which Equal hides inherited member of 'ValueType.Equals(object?)'

  @doc("Equals any operator")
  EqualsAny: "EqualsAny",
}

@doc("Allow certain variables to be scrubbed on WAF logs")
model ScrubbingRule {
  @doc("Defines the state of log scrubbing rule. Default value is Enabled")
  state?: EnabledState = EnabledState.Enabled;

  @doc("The variable to be scrubbed from the logs")
  matchVariable: ScrubbingRuleMatchVariable;

  @doc("When matchVariable is a collection, operate on the selector to specify which elements in the collection this rule applies to")
  selectorMatchOperator: ScrubbingRuleSelectorMatchOperator;

  @doc("When matchVariable is a collection, operator used to specify which elements in the collection this rule applies to")
  @minLength(MinScrubbingRuleSelectorLength)
  @maxLength(MaxScrubbingRuleSelectorLength)
  selector: string;
}

@doc("Log scrubbing configuration, to allow certain variables to be scrubbed on WAF logs")
model LogScrubbing {
  @doc("The state of the log scrubbing config. Default value is Enabled")
  state?: EnabledState = EnabledState.Enabled;

  @doc("The rules that are applied to the logs for scrubbing")
  @extension("x-ms-identifiers", [])
  @maxItems(MaxScrubbingRulesCount)
  scrubbingRules: ScrubbingRule[];
}
