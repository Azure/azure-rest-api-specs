import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StreamAnalytics;
/**
 * A streaming job object, containing all information associated with the named streaming job.
 */
@subscriptionResource
model StreamingJob
  is Azure.ResourceManager.TrackedResource<StreamingJobProperties> {
  ...ResourceNameParameter<
    Resource = StreamingJob,
    KeyName = "jobName",
    SegmentName = "streamingjobs",
    NamePattern = ""
  >;

  /**
   * Describes the system-assigned managed identity assigned to this job that can be used to authenticate with inputs and outputs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Identity;
}

@armResourceOperations
interface StreamingJobs {
  /**
   * Gets details about the specified streaming job.
   */
  get is ArmResourceRead<
    StreamingJob,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
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
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
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
    },
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates an existing streaming job. This can be used to partially update (ie. update one or two properties) a streaming job without affecting the rest the job definition.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    StreamingJob,
    PatchModel = StreamingJob,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    StreamingJob,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all of the streaming jobs in the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    StreamingJob,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
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
  list is ArmListBySubscription<
    StreamingJob,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * The $expand OData query parameter. This is a comma-separated list of additional streaming job properties to include in the response, beyond the default set returned when this parameter is absent. The default set is all streaming job properties other than 'inputs', 'transformation', 'outputs', and 'functions'.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Starts a streaming job. Once a job is started it will start processing input events and produce output.
   */
  start is ArmResourceActionAsync<
    StreamingJob,
    {
      /**
       * Parameters applicable to a start streaming job operation.
       */
      @bodyRoot
      startJobParameters?: StartStreamingJobParameters;
    },
    OkResponse,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Stops a running streaming job. This will cause a running streaming job to stop processing input events and producing output.
   */
  stop is ArmResourceActionAsync<
    StreamingJob,
    void,
    OkResponse,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Scales a streaming job when the job is running.
   */
  scale is ArmResourceActionAsync<
    StreamingJob,
    {
      /**
       * Parameters applicable to a scale streaming job operation.
       */
      @bodyRoot
      scaleJobParameters?: ScaleStreamingJobParameters;
    },
    OkResponse,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(StreamingJob.name, "The name of the streaming job.");
@@doc(StreamingJob.properties,
  "The properties that are associated with a streaming job.  Required on PUT (CreateOrReplace) requests."
);
@@doc(StreamingJobs.createOrReplace::parameters.resource,
  "The definition of the streaming job that will be used to create a new streaming job or replace the existing one."
);
@@doc(StreamingJobs.update::parameters.properties,
  "A streaming job object. The properties specified here will overwrite the corresponding properties in the existing streaming job (ie. Those properties will be updated). Any properties that are set to null here will mean that the corresponding property in the existing input will remain the same and not change as a result of this PATCH operation."
);
