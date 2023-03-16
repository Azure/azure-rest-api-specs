import "@typespec/rest";

using TypeSpec.Http;

namespace DeveloperServicesAPI.Models;

@doc("Collection object for listing operations.")
model Collection<T> {
  nextLink: string;
  value: T[];
}

model ListParams {
  @query skip?: int32;
  @query @maxValue(100) top?: int32;
  @query filter?: string;
}

@error
@doc("Error response.")
model ErrorResponse {
  error: Error;
}

@doc("Error.")
model Error {
  code: string;
  message: string;
  details?: string;
}
