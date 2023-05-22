import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;
using TypeSpec.Versioning;

@useDependency(Azure.Core.Versions.v1_0_Preview_2)
namespace DeveloperServicesApi.Models;

//API response for 200 with content
alias ApiResponse<T> = T | ErrorResponse;

@doc("List operations' default parameters.")
model DefaultListQueryParameters {
  ...SkipQueryParameter;
  ...TopQueryParameter;
  ...FilterQueryParameter;
}

@doc("Name value pair object.")
model NameValuePair {
  @doc("Name of the property.")
  name: string;

  @doc("Value of the property.")
  value: string;
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
