import "./CommonAssessmentPropertiesEnums.tsp";

#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
@doc("Scope of the assessment.")
model Scope {
  @doc("The scope type")
  scopeType?: ScopeType;

  @doc("The server group arm id.")
  serverGroupId?: string;

  @doc("The ARG query.")
  azureResourceGraphQuery?: string;
}
