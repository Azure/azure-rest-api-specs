using OpenAPI;
using TypeSpec.Rest;

namespace Microsoft.AppSecurity;

alias MinIpMatchConditionMatchValueCount = 1;
alias MaxIpMatchConditionMatchValueCount = 600;
alias MinGeoMatchConditionMatchValueCount = 1;
alias MaxGeoMatchConditionMatchValueCount = 100;
alias MinMatchVariableSelectorLength = 1;
alias MaxMatchVariableSelectorLength = 128;
alias MinStringMatchConditionMatchValueCount = 1;
alias MaxStringMatchConditionMatchValueCount = 10;
alias MaxMatchConditionTransformationsCount = 20;
alias MinExistsMatchConditionMatchValueLength = 0;
alias MaxExistsMatchConditionMatchValueLength = 1024;

@doc("Defines a custom rule condition")
@discriminator("conditionType")
model CustomRuleCondition {
  @doc("Whether this is negate the condition. Default is false")
  negateCondition?: boolean = false;
}

@doc("Defines a custom rule condition of type Ip")
model IpMatchCondition extends CustomRuleCondition {
  @doc("Defines the operation type")
  conditionType: "Ip";

  @doc("Variable to match against")
  matchVariable: IpOperatorVariable;

  // As for now, we only support explicit IpLists
  // @doc("IP list fully qualified resource ID")
  // matchValue: IpListResourceId;

  @doc("A list of mutually disjoint IP addresses or CIDR ranges (IPv4 or IPv6)")
  @minItems(MinIpMatchConditionMatchValueCount)
  @maxItems(MaxIpMatchConditionMatchValueCount)
  matchValue: string[];
}

@doc("Defines a custom rule condition of type Geo")
model GeoMatchCondition extends CustomRuleCondition {
  @doc("Defines the operation type")
  conditionType: "Geo";

  @doc("Variable to match against")
  matchVariable: GeoOperatorVariable;

  // TODO - needed only if RequestHeader is a possible match variable
  // @doc("Match against a specific key from RequestHeader. Default is null")
  // matchVariableSelector?: string;

  // As for now, we only support explicit GeoLists
  // @doc("Geo list fully qualified resource ID")
  // matchValue: GeoListResourceId;

  @doc("List of countries or regions")
  @minItems(MinGeoMatchConditionMatchValueCount)
  @maxItems(MaxGeoMatchConditionMatchValueCount)
  matchValue: string[];
}

@doc("Defines a custom rule condition of type String")
model StringMatchCondition extends CustomRuleCondition {
  @doc("Defines the operation type")
  conditionType: "String";

  @doc("String operator to use when matching with the match values")
  operator: StringOperator;

  @doc("Variable to match against")
  matchVariable: StringOperatorVariable;

  @doc("Match against a specific key from RequestHeader, PostArgs and RequestCookies. Default is Null") // TODO - generate this doc according to WithSelectorOperatorVariable
  @minLength(MinMatchVariableSelectorLength)
  @maxLength(MaxMatchVariableSelectorLength)
  matchVariableSelector?: string;

  @doc("The condition is met if any of the values match the variable with the given operator")
  @minItems(MinStringMatchConditionMatchValueCount)
  @maxItems(MaxStringMatchConditionMatchValueCount)
  matchValue: string[]; //TODO - restrict maxLength

  @doc("Describes what transforms applied before matching")
  @maxItems(MaxMatchConditionTransformationsCount)
  transformations?: TransformType[];
}

// TODO - add number match condition, although currently it is not included in the feature subset.
// SizeMatchCondition isn't included in the feature subset.
// @doc("Defines a custom rule size condition")
// model SizeMatchCondition extends CustomRuleCondition {
//   @doc("Defines the operation type")
//   conditionType: "Size";

//   @doc("Size operator to use when matching with the match value")
//   operator: SizeOrNumberOperator;

//   @doc("Variable to match against")
//   matchVariable: SizeOperatorVariable;

//   @doc("Match against a specific key from RequestHeader, PostArgs and RequestCookies. Default is Null")
//   matchVariableSelector?: string;

//   @doc("If this value match the variable with the given operator, this condition is met")
//   @minValue(0)
//   matchValue: int64;

//   @doc("Describes what transforms applied before matching")
//   transformations?: TransformType[];
// }

@doc("Defines a custom rule condition of type Exists")
model ExistsMatchCondition extends CustomRuleCondition {
  @doc("Defines the operation type")
  conditionType: "Exists";

  @doc("Variable to match against")
  matchVariable: ExistsOperatorVariable;

  @doc("This condition is met if the matchValue is one of the matchVariable's keys")
  @minLength(MinExistsMatchConditionMatchValueLength)
  @maxLength(MaxExistsMatchConditionMatchValueLength)
  matchValue: string;
}

@doc("Defines the operator variables for the Ip match operation")
enum IpOperatorVariable {
  @doc("The client IP address")
  ClientAddr,
  // SocketAddr, // Only for AFD
}

@doc("Defines the operator variables for the Geo match operation")
enum GeoOperatorVariable {
  @doc("The client IP address")
  ClientAddr,
  // SocketAddr, // Only for AFD
  // RequestHeader, // Only for AppGW. TODO - will be added if it's a parity requirement
}

@doc("Defines the operator variable that requires a selector")
enum WithSelectorOperatorVariable {
  @doc("Request header")
  RequestHeader,

  @doc("Post arguments")
  PostArgs,

  @doc("Request cookies")
  RequestCookies,
}

@doc("Defines the supported operator variables for string, size and number operations")
enum StringSizeNumberOperatorVariable {
  @doc("Query string")
  QueryString,

  @doc("Request method")
  RequestMethod,

  @doc("Request URI")
  RequestUri,

  @doc("Request body")
  RequestBody,

  ...WithSelectorOperatorVariable,
}

// enum StringNumberOperatorVariable {
//   ...StringSizeNumberOperatorVariable,
// }

// enum SizeOperatorVariable {
//   ...StringSizeNumberOperatorVariable,
// }

@doc("Defines the supported operator variables for string operations")
enum StringOperatorVariable {
  ...StringSizeNumberOperatorVariable,
}

@doc("Defines the supported operator variables for an operation of type Exists")
enum ExistsOperatorVariable {
  ...WithSelectorOperatorVariable,
}

//TODO - no Equal?
// @doc("Operators that can be applied in conditions of type Size or Number")
// enum SizeOrNumberOperator {
//   LessThan,
//   GreaterThan,
//   LessThanOrEqual,
//   GreaterThanOrEqual,
// }

@doc("Operators that can be applied in conditions of type String")
enum StringOperator {
  @doc("Performs an ordinal (case-sensitive and culture-insensitive) comparison")
  Equals_: "Equals", // Changes the generated name and prevents error CS0108, in which Equal hides inherited member of 'ValueType.Equals(object?)'

  @doc("checks whether a string contains a sequence of characters")
  Contains,

  @doc("Checks whether a string starts with a specified string")
  StartsWith, // TODO - change to StartsWith so it would be consistent with managedRules.tsp ExclusionSelectorMatchOperator

  @doc("Checks whether a string ends with a specified string")
  EndsWith,

  @doc("Regex match")
  Regex,

  @doc("Geographic match")
  GeoMatch,
}

@doc("Describes the override action to be applied when custom rule matches")
enum CustomRuleActionType {
  @doc("Allow the request")
  Allow,

  @doc("Block the request")
  Block,

  @doc("Allow the request and log it")
  Log,

  @doc("Redirect the request")
  Redirect, // Assuming AppGW supports this
}

@doc("Transforms that can be applied before matching")
enum TransformType {
  @doc("Converts the string to uppercase")
  Uppercase,

  @doc("Converts the string to lowercase")
  Lowercase,

  @doc("Trims the string")
  Trim,

  @doc("Performs URL decoding")
  UrlDecode,

  @doc("Performs URL encoding")
  UrlEncode,

  @doc("Removes nulls")
  RemoveNulls,

  @doc("Performs HTML entity decoding")
  HtmlEntityDecode,
}

// Currently not in use
// If we want to add this defintion, we need to add PROPFIND, PROPPATCH and MKCOL to custom-words.txt
// enum RequestMethodType {
//   OPTIONS,
//   GET,
//   HEAD,
//   POST,
//   PUT,
//   DELETE,
//   PROPFIND,
//   PROPPATCH,
//   MKCOL,
//   COPY,
//   MOVE,
//   LOCK,
//   UNLOCK,
//   PROFILE,
//   PATCH,
// }
