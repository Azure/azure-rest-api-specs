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

union CustomRuleConditionType {
  Ip: "Ip",
  Geo: "Geo",
  String: "String",
  Exists: "Exists",
  string,
}

@doc("Defines a custom rule condition")
@discriminator("conditionType")
model CustomRuleCondition {
  @doc("Defines the operation type")
  conditionType: CustomRuleConditionType;

  @doc("Whether this is negate the condition. Default is false")
  negateCondition?: boolean = false;
}

@doc("Defines a custom rule condition of type Ip")
model IpMatchCondition extends CustomRuleCondition {
  @doc("Defines the operation type")
  conditionType: CustomRuleConditionType.Ip;

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
  conditionType: CustomRuleConditionType.Geo;

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
  conditionType: CustomRuleConditionType.String;

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
  conditionType: CustomRuleConditionType.Exists;

  @doc("Variable to match against")
  matchVariable: ExistsOperatorVariable;

  @doc("This condition is met if the matchValue is one of the matchVariable's keys")
  @minLength(MinExistsMatchConditionMatchValueLength)
  @maxLength(MaxExistsMatchConditionMatchValueLength)
  matchValue: string;
}

@doc("Defines the operator variables for the Ip match operation")
union IpOperatorVariable {
  string,

  @doc("The client IP address")
  ClientAddr: "ClientAddr",
  // SocketAddr, // Only for AFD
}

@doc("Defines the operator variables for the Geo match operation")
union GeoOperatorVariable {
  string,

  @doc("The client IP address")
  ClientAddr: "ClientAddr",
  // SocketAddr, // Only for AFD
  // RequestHeader, // Only for AppGW. TODO - will be added if it's a parity requirement
}

@doc("Defines the operator variable that requires a selector")
union WithSelectorOperatorVariable {
  string,

  @doc("Request header")
  RequestHeader: "RequestHeader",

  @doc("Post arguments")
  PostArgs: "PostArgs",

  @doc("Request cookies")
  RequestCookies: "RequestCookies",
}

@doc("Defines the supported operator variables for string, size and number operations")
union StringSizeNumberOperatorVariable {
  string,
  WithSelectorOperatorVariable,

  @doc("Query string")
  QueryString: "QueryString",

  @doc("Request method")
  RequestMethod: "RequestMethod",

  @doc("Request URI")
  RequestUri: "RequestUri",

  @doc("Request body")
  RequestBody: "RequestBody",
}

// enum StringNumberOperatorVariable {
//   ...StringSizeNumberOperatorVariable,
// }

// enum SizeOperatorVariable {
//   ...StringSizeNumberOperatorVariable,
// }

@doc("Defines the supported operator variables for string operations")
union StringOperatorVariable {
  string,
  StringSizeNumberOperatorVariable,
}

@doc("Defines the supported operator variables for an operation of type Exists")
union ExistsOperatorVariable {
  string,
  WithSelectorOperatorVariable,
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
union StringOperator {
  string,

  @doc("Performs an ordinal (case-sensitive and culture-insensitive) comparison")
  Equals_: "Equals", // Changes the generated name and prevents error CS0108, in which Equal hides inherited member of 'ValueType.Equals(object?)'

  @doc("checks whether a string contains a sequence of characters")
  Contains: "Contains",

  @doc("Checks whether a string starts with a specified string")
  StartsWith: "StartsWith", // TODO - change to StartsWith so it would be consistent with managedRules.tsp ExclusionSelectorMatchOperator

  @doc("Checks whether a string ends with a specified string")
  EndsWith: "EndsWith",

  @doc("Regex match")
  Regex: "Regex",

  @doc("Geographic match")
  GeoMatch: "GeoMatch",
}

@doc("Describes the override action to be applied when custom rule matches")
union CustomRuleActionType {
  string,

  @doc("Allow the request")
  Allow: "Allow",

  @doc("Block the request")
  Block: "Block",

  @doc("Allow the request and log it")
  Log: "Log",

  @doc("Redirect the request")
  Redirect: "Redirect", // Assuming AppGW supports this
}

@doc("Transforms that can be applied before matching")
union TransformType {
  string,

  @doc("Converts the string to uppercase")
  Uppercase: "Uppercase",

  @doc("Converts the string to lowercase")
  Lowercase: "Lowercase",

  @doc("Trims the string")
  Trim: "Trim",

  @doc("Performs URL decoding")
  UrlDecode: "UrlDecode",

  @doc("Performs URL encoding")
  UrlEncode: "UrlEncode",

  @doc("Removes nulls")
  RemoveNulls: "RemoveNulls",

  @doc("Performs HTML entity decoding")
  HtmlEntityDecode: "HtmlEntityDecode",
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
