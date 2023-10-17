namespace DataApi.Models;

@doc("API definition")
model ApiDefinition {
  @doc("The name of the API definition.")
  @maxLength(50)
  title: string;

  @doc("The description of the API definition.")
  @maxLength(1000)
  description: string;

  @doc("The API specification details.")
  specification?: ApiSpecification;
}

@doc("API specification")
model ApiSpecification {
  @doc("API specification name, e.g. 'swagger' or 'openapi'.")
  name: string;

  @doc("API specification version, e.g. '3.0.1'.")
  version: string;
}