import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace ModelClient;

@doc("Defines the service behavior when unknown parameters are passed as extra properties in the request payload.")
enum UnknownParameters {
  @doc("The service should error when it sees unknown parameters in the request payload. This is the default behavior if the service.")
  error: "error",

  @doc("The service should ignore unknown parameters in the request payload. They will not be passed to the back-end AI model.")
  ignore: "ignore",

  @doc("The service should pass unknown parameters to the back-end AI model.")
  allow: "allow",
}

alias AdditionalRequestHeaders = {
  @doc("Controls what happens if unknown parameters are passed as extra properties in the request payload.")
  @header("unknown-parameters")
  unknownParameters?: UnknownParameters;

  @doc("""
  Name of the deployment to which you would like to route the request. Relevant only to Model-as-a-Platform (MaaP) deployments.
  Typically used when you want to target a test environment instead of production environment.
  """)
  @header("azureml-model-deployment")
  modelDeployment?: string;
};
