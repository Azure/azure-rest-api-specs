namespace Meta.V1;

@doc("A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects.")
model LabelSelector {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Records is the most semantically correct choice for this use-case"
  @doc("matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.")
  matchLabels?: Record<string>;

  @doc("matchExpressions is a list of label selector requirements. The requirements are ANDed.")
  matchExpressions?: LabelSelectorRequirement[];
}

@doc("A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.")
model LabelSelectorRequirement {
  @doc("key is the label key that the selector applies to.")
  key: string;

  @doc("operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.")
  operator: LabelSelectorOperator;

  @doc("values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.")
  values?: string[];
}

@doc("A label selector operator is the set of operators that can be used in a selector requirement.")
union LabelSelectorOperator {
  @doc("LabelSelectorOperator In")
  In: "In",

  @doc("LabelSelectorOperator NotIn")
  NotIn: "NotIn",

  @doc("LabelSelectorOperator Exists")
  Exists: "Exists",

  @doc("LabelSelectorOperator DoesNotExist")
  DoesNotExist: "DoesNotExist",

  string,
}

