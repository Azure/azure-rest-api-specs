import "@typespec/rest";

using TypeSpec.Http;

namespace DeveloperServicesAPI.Models;

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
  @doc("Number of element to skip.")
  @query
  skip?: int32;

  @doc("Number of element to take from the top.")
  @query
  @maxValue(100)
  top?: int32;

  @doc("OData filter query option.")
  @query
  filter?: string;
}

@error
@doc("Error response object.")
model ErrorResponse {
  @doc("Error itself.")
  error: Error;
}

@doc("Error.")
model Error {
  @doc("Error code.")
  code: string;

  @doc("Error message.")
  message: string;

  @doc("Error details if exists.")
  details?: string;
}

model NameValuePair {
  name: string;
  value: string;
}

model UserParams {
  @path userId: string;
}
