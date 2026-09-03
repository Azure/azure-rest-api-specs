import "./CommonAssessmentPropertiesEnums.tsp";

using Azure.Core;

@doc("Scope of the assessment.")
model Scope {
  @doc("The scope type")
  scopeType?: ScopeType;

  @doc("The server group Azure resource id.")
  serverGroupId?: armResourceIdentifier;

  @doc("The ARG query.")
  azureResourceGraphQuery?: string;
}
