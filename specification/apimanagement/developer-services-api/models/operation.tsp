import "./example.tsp";

namespace DeveloperServicesApi.Models;

@doc("API operation details.")
model Operation {
  @doc("Operation identifier.")
  id: string;

  @doc("Operation name.")
  name: string;

  @doc("Operation description.")
  description: string;

  @doc("Operation method.")
  method: Method;

  @doc("Operation URL template.")
  urlTemplate: string;

  @doc("Operation URL template parameters.")
  templateParameters: Parameter[];

  @doc("Operation request details.")
  request: Request;

  @doc("Operation responses.")
  responses: Response[];

  @doc("Operation tags.")
  tags: Tag[];
}

@doc("API operation method.")
model Parameter {
  @doc("Parameter name.")
  name?: string;

  @doc("Parameter description.")
  description?: string;

  @doc("Parameter type.")
  type?: string;

  @doc("Specifies whether parameter is required or not.")
  required?: boolean;

  @doc("Parameter default value.")
  defaultValue?: string;

  @doc("Parameter values.")
  values?: string[];

  @doc("Parameter schema identifier.")
  schemaId?: string;

  @doc("Parameter type name.")
  typeName?: string;

  @doc("Example definition")
  examples?: ExampleObject;
}

@doc("Operation request description.")
model Request {
  @doc("Request description.")
  description?: string;

  @doc("Collection of operation request query parameters.")
  queryParameters?: Parameter[];

  @doc("Collection of operation request headers.")
  headers?: Parameter[];

  @doc("Collection of operation request representations.")
  representations?: Representation[];
}

@doc("Operation response description.")
model Response {
  @doc("Operation response status code.")
  statusCode?: int32;

  @doc("Operation response description.")
  description?: string;

  @doc("Collection of operation response headers.")
  headers?: Parameter[];

  @doc("Collection of operation response representations.")
  representations?: Representation[];
}

@doc("Operation request representation.")
model Representation {
  @doc("Representation content type.")
  contentType?: string;

  @doc("Example definition")
  examples?: ExampleObject;

  @doc("Schema identifier. Applicable only if 'contentType' value is neither 'application/x-www-form-urlencoded' nor 'multipart/form-data'.")
  schemaId?: string;

  @doc("Type name defined by the schema. Applicable only if 'contentType' value is neither 'application/x-www-form-urlencoded' nor 'multipart/form-data'.")
  typeName?: string;

  @doc("Collection of form parameters. Required if 'contentType' value is either 'application/x-www-form-urlencoded' or 'multipart/form-data'.")
  formParameters?: Parameter[];
}
