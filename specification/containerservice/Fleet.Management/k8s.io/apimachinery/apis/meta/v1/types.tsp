namespace K8s.ApiMachinery.Apis.Meta.V1;

@doc("A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects.")
model LabelSelector {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Records is the most semantically correct choice for this use-case"
  @doc("matchLabels is a map of {key,value} pairs.")
  matchLabels?: Record<string>;

  @doc("matchExpressions is a list of label selector requirements. The requirements are ANDed.")
  @OpenAPI.extension("x-ms-identifiers", [])
  matchExpressions?: LabelSelectorRequirement[];
}

@doc("A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.")
model LabelSelectorRequirement {
  @doc("key is the label key that the selector applies to.")
  key: string;

  @doc("operator represents a key's relationship to a set of values.")
  operator: LabelSelectorOperator;

  @doc("values is an array of string values to be compared using the operator.")
  values?: string[];
}

@doc("A label selector operator is the set of operators that can be used in a selector requirement.")
union LabelSelectorOperator {
  @doc("In validates whether the key is in the list of values.")
  In: "In",

  @doc("NotIn validates whether the key is not in the list of values.")
  NotIn: "NotIn",

  @doc("Exists validates the existence of the key.")
  Exists: "Exists",

  @doc("DoesNotExists validates the absence of the key.")
  DoesNotExist: "DoesNotExist",

  string,
}
