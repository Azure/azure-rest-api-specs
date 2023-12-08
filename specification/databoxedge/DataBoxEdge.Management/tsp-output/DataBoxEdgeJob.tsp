import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataBoxEdge;
@doc("A device job.")
@parentResource(DataBoxEdgeDevice)
model DataBoxEdgeJob is ProxyResource<JobProperties> {
  @doc("The job name.")
  @path
  @key("name")
  @segment("jobs")
  name: string;

  @doc("The current status of the job.")
  @visibility("read")
  status?: JobStatus;

  @doc("The UTC date and time at which the job started.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The UTC date and time at which the job completed.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The percentage of the job that is complete.")
  @visibility("read")
  percentComplete?: int32;

  @doc("The error details.")
  @visibility("read")
  error?: JobErrorDetails;
}

@armResourceOperations
interface DataBoxEdgeJobs {
  @doc("Gets the details of a specified job on a Data Box Edge/Data Box Gateway device.")
  get is ArmResourceRead<DataBoxEdgeJob>;
}
