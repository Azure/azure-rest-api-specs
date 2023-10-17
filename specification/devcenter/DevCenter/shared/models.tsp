import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../service.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;


@doc("Operation Error message")
model OperationStatusError {
  @doc("The error code.")
  code?: string;

  @doc("The error message.")
  message?: string;
}

@lroStatus
enum OperationStatusValue {
  Running,
  @lroSucceeded
  Completed,
  Canceled,
  Failed,
}

@doc("The current status of an async operation")
model OperationStatus {
  @doc("Fully qualified ID for the operation status.")
  id?: string;

  @doc("The operation id name")
  name?: string;

  @doc("Provisioning state of the resource.")
  status: OperationStatusValue;

  @doc("The id of the resource.")
  resourceId?: string;

  @doc("The start time of the operation")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The end time of the operation")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  // FIXME: check if this is a float or int
  @doc("Percent of the operation that is complete")
  @minValue(0.0)
  @maxValue(100.0)
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
  @minValue(0)
  maxDevBoxesPerUser?: int32;
}
