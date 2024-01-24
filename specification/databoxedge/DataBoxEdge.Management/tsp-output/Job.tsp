import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * A device job.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DataBoxEdgeDevice)
@Azure.ResourceManager.Private.armResourceInternal(JobProperties)
@includeInapplicableMetadataInPayload(false)
model Job extends ProxyResourceBase {
  /**
   * The job name.
   */
  @path
  @key("name")
  @segment("jobs")
  name: string;

  /**
   * The current status of the job.
   */
  @visibility("read")
  status?: JobStatus;

  /**
   * The UTC date and time at which the job started.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The UTC date and time at which the job completed.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The percentage of the job that is complete.
   */
  @visibility("read")
  percentComplete?: int32;

  /**
   * The error details.
   */
  @visibility("read")
  error?: JobErrorDetails;

  /**
   * The properties of the job.
   */
  @extension("x-ms-client-flatten", true)
  properties?: JobProperties;
}

@armResourceOperations
interface Jobs {
  /**
   * Gets the details of a specified job on a Data Box Edge/Data Box Gateway device.
   */
  get is ArmResourceRead<Job>;
}
