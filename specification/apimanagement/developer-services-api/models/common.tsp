import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Foundations;
using TypeSpec.Versioning;

@useDependency(Azure.Core.Versions.v1_0_Preview_2)
namespace DeveloperServicesApi.Models;

//API response for 200 with content
alias ApiResponse<T> = T | ErrorResponse;

//API response for 201 with content
alias CreatedApiResponse<T> = Created<T> | ErrorResponse;

@doc("Collection object for listing operations.")
model Collection<T> {
  @doc("Relative URL to next page of collection.")
  nextLink: string;

  @doc("Collection itself.")
  value: T[];
}

model Created<T> {
  @statusCode statusCode: 201;
  @body body: T;
}

@doc("List operations' default parameters.")
model ListParams {
  ...SkipQueryParameter;
  ...TopQueryParameter;
  ...FilterQueryParameter;
}

@error
@doc("Error response object.")
model ErrorResponse {
  @doc("Error.")
  error: Error;
}

@doc("Name value pair object.")
model NameValuePair {
  @doc("Name of the property.")
  name: string;

  @doc("Value of the property.")
  value: string;
}

@doc("User resources default parameters.")
model UserParams {
  @doc("The user identifier.")
  @path
  userId: string;
}

model TypedBody<BodyType, ContentType> {
  @body body: BodyType;
  @header contentType: ContentType;
}

alias ContentTypes =
  | "application/json"
  | "application/vnd.sun.wadl+xml"
  | "application/wsdl+xml"
  | "application/vnd.swagger.doc+json"
  | "application/vnd.oai.openapi"
  | "application/vnd.oai.openapi+json";
