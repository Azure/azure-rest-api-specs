import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.StreamAnalytics;
@doc("A streaming job object, containing all information associated with the named streaming job.")
model StreamingJob is TrackedResource<StreamingJobProperties> {
  @doc("The name of the streaming job.")
  @path
  @key("jobName")
  @segment("streamingjobs")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface StreamingJobs {
  @doc("Gets details about the specified streaming job.")
  get is ArmResourceRead<
    StreamingJob,
    {
      ...BaseParameters<StreamingJob>;

      @doc("The $expand OData query parameter. This is a comma-separated list of additional streaming job properties to include in the response, beyond the default set returned when this parameter is absent. The default set is all streaming job properties other than 'inputs', 'transformation', 'outputs', and 'functions'.")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Creates a streaming job or replaces an already existing streaming job.")
  createOrReplace is ArmResourceCreateOrUpdateAsync<
    StreamingJob,
    {
      ...BaseParameters<StreamingJob>;

      @doc("The ETag of the streaming job. Omit this value to always overwrite the current record set. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;

      @doc("Set to '*' to allow a new streaming job to be created, but to prevent updating an existing record set. Other values will result in a 412 Pre-condition Failed response.")
      @header
      IfNoneMatch?: string;
    }
  >;
  @doc("Updates an existing streaming job. This can be used to partially update (ie. update one or two properties) a streaming job without affecting the rest the job definition.")
  update is ArmResourcePatchSync<
    StreamingJob,
    StreamingJobProperties,
    {
      ...BaseParameters<StreamingJob>;

      @doc("The ETag of the streaming job. Omit this value to always overwrite the current record set. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.")
      @header
      IfMatch?: string;
    }
  >;
  @doc("Deletes a streaming job.")
  delete is ArmResourceDeleteAsync<StreamingJob>;
  @doc("Lists all of the streaming jobs in the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<
    StreamingJob,
    {
      ...BaseParameters<StreamingJob>;

      @doc("The $expand OData query parameter. This is a comma-separated list of additional streaming job properties to include in the response, beyond the default set returned when this parameter is absent. The default set is all streaming job properties other than 'inputs', 'transformation', 'outputs', and 'functions'.")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Lists all of the streaming jobs in the given subscription.")
  list is ArmListBySubscription<StreamingJob>;
  @doc("Starts a streaming job. Once a job is started it will start processing input events and produce output.")
  start is ArmResourceActionAsync<
    StreamingJob,
    StartStreamingJobParameters,
    {}
  >;
  @doc("Stops a running streaming job. This will cause a running streaming job to stop processing input events and producing output.")
  stop is ArmResourceActionAsync<StreamingJob, {}, {}>;
  @doc("Scales a streaming job when the job is running.")
  scale is ArmResourceActionNoResponseContentAsync<
    StreamingJob,
    ScaleStreamingJobParameters
  >;
}
