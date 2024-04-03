import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../main.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;

@doc("Indicates whether operation status is running, completed, canceled or failed.")
@lroStatus
union OperationStatusValue {
  string,

  @doc("Operation is in progress")
  Running: "Running",

  @doc("Operation is completed with success")
  @lroSucceeded
  Completed: "Completed",

  @doc("Operation was canceled")
  Canceled: "Canceled",

  @doc("Operation failed")
  Failed: "Failed",
}

@doc("The current status of an async operation")
@resource("operationstatuses")
@parentResource(Project)
model OperationStatus {
  @doc("Fully qualified ID for the operation status.")
  @key("operationId")
  @visibility("read")
  id: string;

  @doc("The operation id name")
  name?: string;

  @doc("Provisioning state of the resource.")
  status: OperationStatusValue;

  @doc("The id of the resource.")
  resourceId?: string;

  @doc("The start time of the operation")
  startTime?: utcDateTime;

  @doc("The end time of the operation")
  endTime?: utcDateTime;

  @doc("Percent of the operation that is complete")
  @minValue(0.0)
  @maxValue(100.0)
  percentComplete?: float64;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "there is no build in type to describe object"
  @doc("Custom operation properties, populated only for a successful operation.")
  properties?: unknown;

  @doc("Operation Error message")
  error?: Azure.Core.Foundations.Error;
}

@doc("Project details.")
@resource("projects")
model Project {
  @key("projectName")
  @doc("Name of the project")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility("read")
  name: string;

  @doc("Description of the project.")
  description?: string;

  @doc("""
When specified, indicates the maximum number of Dev Boxes a single user can
create across all pools in the project.
""")
  @minValue(0)
  maxDevBoxesPerUser?: int32;
}

@doc("Project user")
@resource("users")
@parentResource(Project)
model User {
  @key("userId")
  @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context")
  @minLength(2)
  @maxLength(36)
  @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$|^me$")
  @visibility("read")
  userId: string;
}
