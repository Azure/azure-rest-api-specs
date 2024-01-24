import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StreamAnalytics;
/**
 * A streaming job object, containing all information associated with the named streaming job.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(StreamingJobProperties)
@includeInapplicableMetadataInPayload(false)
model StreamingJob extends TrackedResource {
  /**
   * The name of the streaming job.
   */
  @path
  @key("jobName")
  @segment("streamingjobs")
  name: string;

  /**
   * Describes the managed identity assigned to this job that can be used to authenticate with inputs and outputs.
   */
  identity?: Identity;

  /**
   * The properties that are associated with a streaming job.  Required on PUT (CreateOrReplace) requests.
   */
  @extension("x-ms-client-flatten", true)
  properties?: StreamingJobProperties;
}

@armResourceOperations
interface StreamingJobs {
  /**
   * Gets details about the specified streaming job.
   */
  get is ArmResourceRead<
    StreamingJob,
    {
      ...BaseParameters<StreamingJob>;

      /**
       * The $expand OData query parameter. This is a comma-separated list of additional streaming job properties to include in the response, beyond the default set returned when this parameter is absent. The default set is all streaming job properties other than 'inputs', 'transformation', 'outputs', and 'functions'.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Creates a streaming job or replaces an already existing streaming job.
   */
  createOrReplace is ArmResourceCreateOrReplaceAsync<
    StreamingJob,
    {
      ...BaseParameters<StreamingJob>;

      /**
       * The ETag of the streaming job. Omit this value to always overwrite the current record set. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      IfMatch?: string;

      /**
       * Set to '*' to allow a new streaming job to be created, but to prevent updating an existing record set. Other values will result in a 412 Pre-condition Failed response.
       */
      @header
      IfNoneMatch?: string;
    }
  >;

  /**
   * Updates an existing streaming job. This can be used to partially update (ie. update one or two properties) a streaming job without affecting the rest the job definition.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    StreamingJob,
    StreamingJob,
    {
      ...BaseParameters<StreamingJob>;

      /**
       * The ETag of the streaming job. Omit this value to always overwrite the current record set. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      IfMatch?: string;
    }
  >;

  /**
   * Deletes a streaming job.
   */
  delete is ArmResourceDeleteAsync<StreamingJob>;

  /**
   * Lists all of the streaming jobs in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StreamingJobs_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    StreamingJob,
    {
      ...BaseParameters<StreamingJob>;

      /**
       * The $expand OData query parameter. This is a comma-separated list of additional streaming job properties to include in the response, beyond the default set returned when this parameter is absent. The default set is all streaming job properties other than 'inputs', 'transformation', 'outputs', and 'functions'.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Lists all of the streaming jobs in the given subscription.
   */
  list is ArmListBySubscription<StreamingJob>;

  /**
   * Starts a streaming job. Once a job is started it will start processing input events and produce output.
   */
  start is ArmResourceActionAsync<
    StreamingJob,
    StartStreamingJobParameters,
    void
  >;

  /**
   * Stops a running streaming job. This will cause a running streaming job to stop processing input events and producing output.
   */
  stop is ArmResourceActionAsync<StreamingJob, void, void>;

  /**
   * Scales a streaming job when the job is running.
   */
  scale is ArmResourceActionNoResponseContentAsync<
    StreamingJob,
    ScaleStreamingJobParameters
  >;
}

@@projectedName(StreamingJobs.createOrReplace::parameters.resource,
  "json",
  "streamingJob"
);
@@extension(StreamingJobs.createOrReplace::parameters.resource,
  "x-ms-client-name",
  "streamingJob"
);
@@doc(StreamingJobs.createOrReplace::parameters.resource,
  "The definition of the streaming job that will be used to create a new streaming job or replace the existing one."
);
@@projectedName(StreamingJobs.update::parameters.properties,
  "json",
  "streamingJob"
);
@@extension(StreamingJobs.update::parameters.properties,
  "x-ms-client-name",
  "streamingJob"
);
@@doc(StreamingJobs.update::parameters.properties,
  "A streaming job object. The properties specified here will overwrite the corresponding properties in the existing streaming job (ie. Those properties will be updated). Any properties that are set to null here will mean that the corresponding property in the existing input will remain the same and not change as a result of this PATCH operation."
);
@@projectedName(StreamingJobs.start::parameters.body,
  "json",
  "startJobParameters"
);
@@extension(StreamingJobs.start::parameters.body,
  "x-ms-client-name",
  "startJobParameters"
);
@@doc(StreamingJobs.start::parameters.body,
  "Parameters applicable to a start streaming job operation."
);
@@projectedName(StreamingJobs.scale::parameters.body,
  "json",
  "scaleJobParameters"
);
@@extension(StreamingJobs.scale::parameters.body,
  "x-ms-client-name",
  "scaleJobParameters"
);
@@doc(StreamingJobs.scale::parameters.body,
  "Parameters applicable to a scale streaming job operation."
);
