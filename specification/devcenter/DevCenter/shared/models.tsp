import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../service.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;


@doc("Indicates whether operation status is running, completed, canceled or failed.")
@lroStatus
@projectedName("csharp", "DevCenterOperationStatus")
@projectedName("java", "DevCenterOperationStatus")
@projectedName("python", "OperationStatus")
enum OperationStatusValue {
  @doc("Operation is in progress")
  Running,

  @doc("Operation is completed with success")
  @lroSucceeded
  Completed,

  @doc("Operation was canceled")
  Canceled,

  @doc("Operation failed")
  Failed,
}

@doc("The current status of an async operation")
@projectedName("csharp", "DevCenterOperationDetails")
@projectedName("java", "DevCenterOperationDetails")
@projectedName("python", "OperationDetails")
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
  startTime?: utcDateTime;

  @doc("The end time of the operation")
  endTime?: utcDateTime;

  @doc("Percent of the operation that is complete")
  @minValue(0.0)
  @maxValue(100.0)
  percentComplete?: float32;

  @doc("Custom operation properties, populated only for a successful operation.")
  properties?: bytes;

  @doc("Operation Error message")
  error?: Azure.Core.Foundations.Error;
}

@doc("Project details.")
@resource("projects")
@projectedName("csharp", "DevCenterProject")
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
