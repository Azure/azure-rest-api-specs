import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../service.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenter;

op DevCenterBaseResponse<
  TParams extends TypeSpec.Reflection.Model,
  TResponse,
  Traits extends TypeSpec.Reflection.Model = {}
> is Azure.Core.Foundations.Operation<TParams, TResponse, Traits, CloudError>;

@doc("An error response from the service.")
model CloudErrorBody {
  @doc("""
An identifier for the error. Codes are invariant and are intended to be
consumed programmatically.
""")
  code: string;

  @doc("""
A message describing the error, intended to be suitable for display in a user
interface.
""")
  message: string;

  @doc("""
The target of the particular error. For example, the name of the property in
error.
""")
  target?: string;

  @doc("A list of additional details about the error.")
  details?: CloudErrorBody[];
}


@doc("An error response from the service.")
@error
model CloudError {
  @doc("Error body")
  error: CloudErrorBody;

  @header("x-ms-error-code")
  @doc("String error code indicating what went wrong.")
  errorCode?: string;
}

@doc("Operation Error message")
model OperationStatusError {
  @doc("The error code.")
  code?: string;

  @doc("The error message.")
  message?: string;
}


@doc("The current status of an async operation")
model OperationStatus {
  @doc("Fully qualified ID for the operation status.")
  id?: string;

  @doc("The operation id name")
  name?: string;

  @doc("Provisioning state of the resource.")
  status: string;

  @doc("The id of the resource.")
  resourceId?: string;

  @doc("The start time of the operation")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The end time of the operation")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Percent of the operation that is complete")
  percentComplete?: float32;

  @doc("Custom operation properties, populated only for a successful operation.")
  properties?: unknown;

  @doc("Operation Error message")
  error?: OperationStatusError;
}

@doc("Project details.")
@resource("projects")
model Project {
  @key("projectName")
  @visibility("read")
  @doc("Name of the project")
  name: string;

  @doc("Description of the project.")
  description?: string;

  @doc("""
When specified, indicates the maximum number of Dev Boxes a single user can
create across all pools in the project.
""")
  maxDevBoxesPerUser?: int32;
}
