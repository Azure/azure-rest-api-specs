import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace PurviewDataCatalog;

@error
@doc("error NotFoundError.")
model NotFoundError {
  @doc("The error code.")
  code: "Not Found";

  @doc("The error message.")
  message: "The requested resource was not found.";
}
@doc("error BadRequestError.")
model BadRequestError {
  @doc("The error code.")
  code: "Bad Request";

  @doc("The error message.")
  message: "The request is invalid.";
}
@doc("error UnauthorizedError.")
model UnauthorizedError {
  @doc("The error code.")
  code: "Unauthorized";

  @doc("The error message.")
  message: "Authentication is required and has failed or has not yet been provided.";
}
@doc("error ForbiddenError.")
model ForbiddenError {
  @doc("The error code.")
  code: "Forbidden";

  @doc("The error message.")
  message: "You do not have permission to access the requested resource.";
}
@doc("error InternalServerError.")
model InternalServerError {
  @doc("The error code.")
  code: "Internal Server Error";

  @doc("The error message.")
  message: "An unexpected error occurred on the server.";
}
@doc("error ServiceUnavailableError.")
model ServiceUnavailableError {
  @doc("The error code.")
  code: "Service Unavailable";

  @doc("The error message.")
  message: "The service is currently unavailable. Please try again later.";
}
@doc("error ConflictError.")
model ConflictError {
  @doc("The error code.")
  code: "Conflict";

  @doc("The error message.")
  message: "The request could not be completed due to a conflict with the current state of the resource.";
}
@doc("error TooManyRequestsError.")
model TooManyRequestsError {
  @doc("The error code.")
  code: "Too Many Requests";

  @doc("The error message.")
  message: "You have exceeded the rate limit for this resource. Please try again later.";
}
@doc("error NotImplementedError.")
model NotImplementedError {
  @doc("The error code.")
  code: "Not Implemented";

  @doc("The error message.")
  message: "The requested operation is not implemented.";
}
@doc("error GatewayTimeoutError.")
model GatewayTimeoutError {
  @doc("The error code.")
  code: "Gateway Timeout";

  @doc("The error message.")
  message: "The server did not receive a timely response from the upstream server.";
}
