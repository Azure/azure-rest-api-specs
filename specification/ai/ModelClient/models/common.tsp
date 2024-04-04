import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ModelClient;

@doc("Defines the service behavior when extra parameters are passed in the request payload.")
union ExtraParameters {
  string,

  @doc("The service should error when it sees extra parameters in the request payload. This is the default behavior if the service.")
  error: "error",

  @doc("The service should ignore extra parameters in the request payload. They will not be passed to the back-end AI model.")
  ignore: "ignore",

  @doc("The service should pass extra parameters to the back-end AI model.")
  allow: "allow",
}

alias AdditionalRequestHeaders = {
  @doc("Controls what happens if extra parameters are passed in the request payload.")
  @header("extra-parameters")
  extra_parameters?: ExtraParameters;

  @doc("""
  Name of the deployment to which you would like to route the request. Relevant only to Model-as-a-Platform (MaaP) deployments.
  Typically used when you want to target a test environment instead of production environment.
  """)
  @header("azureml-model-deployment")
  model_deployment?: string;
};

alias CapacityAlias = {
  @doc("Indicates whether your capacity has been affected by the usage amount (token count) reported here.")
  capacity_type: CapacityType;
};

@doc("Whether your capacity has been affected by the usage amount (token count) reported here.")
union CapacityType {
  string,

  @doc("Your capacity has been affected by the usage amount (token count) reported here.")
  error: "usage",

  @doc("Your capacity has not been affected by the usage amount (token count) reported here.")
  ignore: "fixed",
}

alias ExtraRequestParameters = {
  @doc("""
  Extra parameters (in the form of string key-value pairs) that are not in the standard request payload.
  They will be passed to the service as-is in the root of the JSON request payload.
  How the service handles these extra parameters depends on the value of the `extra-parameters`
  HTTP request header.
  """)
  extras?: Record<string>;
};
