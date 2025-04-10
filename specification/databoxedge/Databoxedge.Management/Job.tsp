import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * A device job.
 */
@parentResource(DataBoxEdgeDevice)
model Job is Azure.ResourceManager.ProxyResource<JobProperties> {
  ...ResourceNameParameter<
    Resource = Job,
    KeyName = "name",
    SegmentName = "jobs",
    NamePattern = ""
  >;

  /**
   * The current status of the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  status?: JobStatus;

  /**
   * The UTC date and time at which the job started.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The UTC date and time at which the job completed.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The percentage of the job that is complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  /**
   * The error details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  error?: JobErrorDetails;
}

@armResourceOperations
interface JobOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = DataBoxEdgeDevice,
          KeyName = "deviceName",
          SegmentName = "dataBoxEdgeDevices",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = Job,
        KeyName = "name",
        SegmentName = "jobs",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Jobs {
  /**
   * Gets the details of a specified job on a Data Box Edge/Data Box Gateway device.
   */
  get is JobOps.Read<Job>;
}
@armResourceOperations
interface OperationsStatusOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = DataBoxEdgeDevice,
          KeyName = "deviceName",
          SegmentName = "dataBoxEdgeDevices",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = Job,
        KeyName = "name",
        SegmentName = "operationsStatus",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface OperationsStatus {
  /**
   * Gets the details of a specified job on a Data Box Edge/Data Box Gateway device.
   */
  get is OperationsStatusOps.Read<Job>;
}

@@doc(Job.name, "The job name.");
@@doc(Job.properties, "The properties of the job.");
