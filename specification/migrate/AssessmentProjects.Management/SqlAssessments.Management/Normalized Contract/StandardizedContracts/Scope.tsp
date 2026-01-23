import "./CommonAssessmentPropertiesEnums.tsp";

@doc("Scope of the assessment.")
model Scope {
  @doc("The scope type")
  scopeType?: ScopeType;

  @doc("The server group arm id.")
  serverGroupId?: string;

  @doc("The ARG query.")
  azureResourceGraphQuery?: string;
}
