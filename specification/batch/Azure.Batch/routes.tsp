import "@typespec/versioning";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

namespace Azure.Batch;

// Templates

interface Ops {
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
  @access(Access.internal, "java")
  @get ListOperation<TFilter, TResponse> is Azure.Core.RpcOperation<
    BatchCommonListHeaders & TFilter,
    BatchResponseHeaders & TResponse,
    NoFilter,
    BatchError
  >;

  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
  @access(Access.internal, "java")
  @get ReadOperation<
    TPathParams extends TypeSpec.Reflection.Model,
    TResource
  > is Azure.Core.RpcOperation<
    BatchClientRequestHeaders & TPathParams,
    BatchResponseHeaders & TResource,
    NoFilter,
    BatchError
  >;

  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
  @access(Access.internal, "java")
  @delete DeleteOperation<
    TFilter,
    TResponse extends TypeSpec.Reflection.Model
  > is Azure.Core.RpcOperation<
    BatchClientRequestHeaders & TFilter,
    TResponse,
    NoFilter,
    BatchError
  >;

  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
  @access(Access.internal, "java")
  @post CreateOperation<TResource, TResponse> is RpcOperation<
    BatchClientRequestHeaders & MinimalMetadata & TResource,
    BatchResponseHeaders & Created<TResponse>,
    NoFilter,
    BatchError
  >;

  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
  @access(Access.internal, "java")
  @patch UpdateOperation<TResource, TResponse> is RpcOperation<
    BatchClientRequestHeaders & MinimalMetadata & TResource,
    BatchResponseHeaders & TResponse,
    NoFilter,
    BatchError
  >;

  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
  @access(Access.internal, "java")
  @put ReplaceOperation<TResource, TResponse> is RpcOperation<
    BatchClientRequestHeaders & MinimalMetadata & TResource,
    BatchResponseHeaders & TResponse,
    NoFilter,
    BatchError
  >;

  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
  @access(Access.internal, "java")
  @head ResourceInfoOperation<TResource, TResponse> is RpcOperation<
    BatchClientRequestHeaders & TResource,
    BatchResponseHeaders & TResponse,
    NoFilter,
    BatchError
  >;

  #suppress "@azure-tools/typespec-azure-core/no-error-status-codes" "Azure REST API guidelines recommend using 'default' error response for all error cases. Avoid defining custom 4xx or 5xx error cases."
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
  @doc("New rpc operation allowing multiple repsonses")
  @Foundations.Private.needsRoute
  @access(Access.internal, "java")
  @head ResourceInfoOperationWithAdditionalResponse<
    TParams extends TypeSpec.Reflection.Model,
    TResponse extends TypeSpec.Reflection.Model,
    TAdditionalResponse extends {} = {}
  > is Foundations.Operation<
    TParams,
    TResponse | TAdditionalResponse,
    NoFilter,
    BatchError
  >;

  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
  @access(Access.internal, "java")
  @post PostOperation<TResource, TResponse> is RpcOperation<
    BatchClientRequestHeaders & TResource,
    BatchResponseHeaders & TResponse,
    NoFilter,
    BatchError
  >;
}

alias NoFilter = {};
alias MinimalMetadata = {
  @doc("Type of content")
  @header("content-type")
  contentType: "application/json; odata=minimalmetadata";
};

alias Created<T> = {
  @doc("A process exit code.")
  @statusCode
  code: "201";

  @header("DataServiceId")
  @doc("The OData ID of the resource to which the request applied.")
  dataServiceId: string;

  ...T;
};

// Interfaces ////////////////////

#suppress "@azure-tools/typespec-azure-core/no-response-body" "The body of non-204 responses should not be empty."
#suppress "@azure-tools/typespec-azure-core/no-error-status-codes" "Azure REST API guidelines recommend using 'default' error response for all error cases. Avoid defining custom 4xx or 5xx error cases."
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Operations defined using BatchOperation should not have path parameters."
#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Operation 'Exists' should be defined using a signature from the Azure.Core namespace."
#suppress "@azure-tools/typespec-azure-core/rpc-operation-request-body" "BatchOperation with '@get' cannot have a body."
interface Batch {
  @summary("Lists all of the applications available in the specified Account.")
  @doc("""
This operation returns only Applications and versions that are available for
use on Compute Nodes; that is, that can be used in an Package reference. For
administrator information about applications and versions that are not yet
available to Compute Nodes, use the Azure portal or the Azure Resource Manager
API.
""")
  @route("/applications")
  @projectedName("java", "listApplicationsInternal")
  listApplications is Ops.ListOperation<{}, BatchApplicationListResult>;

  @summary("Gets information about the specified Application.")
  @doc("""
This operation returns only Applications and versions that are available for
use on Compute Nodes; that is, that can be used in an Package reference. For
administrator information about Applications and versions that are not yet
available to Compute Nodes, use the Azure portal or the Azure Resource Manager
API.
""")
  @route("/applications/{applicationId}")
  @projectedName("java", "getApplicationInternal")
  getApplication is Ops.ReadOperation<
    {
      @doc("The ID of the Application")
      @path
      applicationId: string;
    },
    BatchApplication
  >;

  @summary("""
Lists the usage metrics, aggregated by Pool across individual time intervals,
for the specified Account.
""")
  @doc("""
If you do not specify a $filter clause including a poolId, the response
includes all Pools that existed in the Account in the time range of the
returned aggregation intervals. If you do not specify a $filter clause
including a startTime or endTime these filters default to the start and end
times of the last aggregation interval currently available; that is, only the
last aggregation interval is returned.
""")
  @route("/poolusagemetrics")
  @projectedName("java", "listPoolUsageMetricsInternal")
  listPoolUsageMetrics is Ops.ListOperation<
    {
      @doc("""
    The earliest time from which to include metrics. This must be at least two and
    a half hours before the current time. If not specified this defaults to the
    start time of the last aggregation interval currently available.
    """)
      @query
      starttime?: utcDateTime;

      @doc("""
    The latest time from which to include metrics. This must be at least two hours
    before the current time. If not specified this defaults to the end time of the
    last aggregation interval currently available.
    """)
      @query
      endtime?: utcDateTime;

      @doc("""
    An OData $filter clause. For more information on constructing this filter, see
    https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-account-usage-metrics.
    """)
      @query
      @projectedName("client", "filter")
      $filter?: string;
    },
    BatchPoolListUsageMetricsResult
  >;

  @summary("Creates a Pool to the specified Account.")
  @doc("""
When naming Pools, avoid including sensitive information such as user names or
secret project names. This information may appear in telemetry logs accessible
to Microsoft Support engineers.
""")
  @route("/pools")
  @projectedName("java", "createPoolInternal")
  createPool is Ops.CreateOperation<
    {
      @body
      @doc("The Pool to be created.")
      pool: BatchPoolCreateParameters;
    },
    {}
  >;

  @summary("Lists all of the Pools in the specified Account.")
  @doc("Lists all of the Pools in the specified Account.")
  @route("/pools")
  @projectedName("java", "listPoolsInternal")
  listPools is Ops.ListOperation<
    {
      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-pools.
""")
      @query
      @projectedName("client", "filter")
      $filter?: string;

      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "select")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "expand")
      $expand?: string[];
    },
    BatchPoolListResult
  >;

  @summary("Deletes a Pool from the specified Account.")
  @doc("""
When you request that a Pool be deleted, the following actions occur: the Pool
state is set to deleting; any ongoing resize operation on the Pool are stopped;
the Batch service starts resizing the Pool to zero Compute Nodes; any Tasks
running on existing Compute Nodes are terminated and requeued (as if a resize
Pool operation had been requested with the default requeue option); finally,
the Pool is removed from the system. Because running Tasks are requeued, the
user can rerun these Tasks by updating their Job to target a different Pool.
The Tasks can then run on the new Pool. If you want to override the requeue
behavior, then you should call resize Pool explicitly to shrink the Pool to
zero size before deleting the Pool. If you call an Update, Patch or Delete API
on a Pool in the deleting state, it will fail with HTTP status code 409 with
error code PoolBeingDeleted.
""")
  @route("/pools/{poolId}")
  @projectedName("java", "deletePoolInternal")
  deletePool is Ops.DeleteOperation<BatchPoolHeaders, DeleteResponseHeaders>;

  @doc("Gets basic properties of a Pool.")
  @route("/pools/{poolId}")
  @projectedName("java", "poolExistsInternal")
  poolExists is Ops.ResourceInfoOperationWithAdditionalResponse<
    BatchClientRequestHeaders & BatchPoolHeaders,
    PoolDoesNotExistResponseHeaders,
    PoolDoesExistResponseHeaders
  >;

  @doc("Gets information about the specified Pool.")
  @route("/pools/{poolId}")
  @projectedName("java", "getPoolInternal")
  getPool is Ops.ReadOperation<
    BatchPoolHeaders & {
      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "select")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "expand")
      $expand?: string[];
    },
    BatchPool
  >;

  @summary("Updates the properties of the specified Pool.")
  @doc("""
This only replaces the Pool properties specified in the request. For example,
if the Pool has a StartTask associated with it, and a request does not specify
a StartTask element, then the Pool keeps the existing StartTask.
""")
  @route("/pools/{poolId}")
  @projectedName("java", "updatePoolInternal")
  updatePool is Ops.UpdateOperation<
    BatchPoolHeaders & {
      @doc("The pool properties to update.")
      @body
      pool: BatchPoolUpdateParameters;
    },
    RequestSuccesResponseHeaders
  >;

  @summary("Disables automatic scaling for a Pool.")
  @doc("Disables automatic scaling for a Pool.")
  @route("/pools/{poolId}/disableautoscale")
  @projectedName("java", "disablePoolAutoScaleInternal")
  disablePoolAutoScale is Ops.PostOperation<
    {
      @doc("The ID of the Pool on which to disable automatic scaling.")
      @path
      poolId: string;
    },
    {
      @doc("A process exit code.")
      @statusCode
      code: "200";

      @doc("The OData ID of the resource to which the request applied.")
      @header("DataServiceId")
      dataServiceId: string;
    }
  >;

  @summary("Enables automatic scaling for a Pool.")
  @doc("""
You cannot enable automatic scaling on a Pool if a resize operation is in
progress on the Pool. If automatic scaling of the Pool is currently disabled,
you must specify a valid autoscale formula as part of the request. If automatic
scaling of the Pool is already enabled, you may specify a new autoscale formula
and/or a new evaluation interval. You cannot call this API for the same Pool
more than once every 30 seconds.
""")
  @route("/pools/{poolId}/enableautoscale")
  @projectedName("java", "enablePoolAutoScaleInternal")
  enablePoolAutoScale is Ops.PostOperation<
    BatchPoolHeaders & {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The options to use for enabling automatic scaling.")
      @body
      parameters: BatchPoolEnableAutoScaleParameters;
    },
    {
      @doc("A process exit code.")
      @statusCode
      code: "200";

      @doc("The OData ID of the resource to which the request applied.")
      @header("DataServiceId")
      dataServiceId: string;
    }
  >;

  @summary("Gets the result of evaluating an automatic scaling formula on the Pool.")
  @doc("""
This API is primarily for validating an autoscale formula, as it simply returns
the result without applying the formula to the Pool. The Pool must have auto
scaling enabled in order to evaluate a formula.
""")
  @route("/pools/{poolId}/evaluateautoscale")
  @projectedName("java", "evaluatePoolAutoScaleInternal")
  evaluatePoolAutoScale is Ops.PostOperation<
    {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Pool on which to evaluate the automatic scaling formula.")
      @path
      poolId: string;

      @doc("The options to use for evaluating the automatic scaling formula.")
      @body
      parameters: BatchPoolEvaluateAutoScaleParameters;
    },
    AutoScaleRun & {
      @doc("A process exit code.")
      @statusCode
      code: "200";

      @doc("The OData ID of the resource to which the request applied.")
      @header("DataServiceId")
      dataServiceId: string;
    }
  >;

  @summary("Changes the number of Compute Nodes that are assigned to a Pool.")
  @doc("""
You can only resize a Pool when its allocation state is steady. If the Pool is
already resizing, the request fails with status code 409. When you resize a
Pool, the Pool's allocation state changes from steady to resizing. You cannot
resize Pools which are configured for automatic scaling. If you try to do this,
the Batch service returns an error 409. If you resize a Pool downwards, the
Batch service chooses which Compute Nodes to remove. To remove specific Compute
Nodes, use the Pool remove Compute Nodes API instead.
""")
  @route("/pools/{poolId}/resize")
  @projectedName("java", "resizePoolInternal")
  resizePool is Ops.PostOperation<
    BatchPoolHeaders & {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The options to use for resizing the pool.")
      @body
      parameters: BatchPoolResizeParameters;
    },
    AcceptedProcessingResponseHeaders
  >;

  @summary("Stops an ongoing resize operation on the Pool.")
  @doc("""
This does not restore the Pool to its previous state before the resize
operation: it only stops any further changes being made, and the Pool maintains
its current state. After stopping, the Pool stabilizes at the number of Compute
Nodes it was at when the stop operation was done. During the stop operation,
the Pool allocation state changes first to stopping and then to steady. A
resize operation need not be an explicit resize Pool request; this API can also
be used to halt the initial sizing of the Pool when it is created.
""")
  @route("/pools/{poolId}/stopresize")
  @projectedName("java", "stopPoolResizeInternal")
  stopPoolResize is Ops.PostOperation<
    BatchPoolHeaders,
    AcceptedProcessingResponseHeaders
  >;

  @summary("Updates the properties of the specified Pool.")
  @doc("""
This fully replaces all the updatable properties of the Pool. For example, if
the Pool has a StartTask associated with it and if StartTask is not specified
with this request, then the Batch service will remove the existing StartTask.
""")
  @route("/pools/{poolId}/updateproperties")
  @projectedName("java", "replacePoolPropertiesInternal")
  replacePoolProperties is Ops.PostOperation<
    {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Pool to update.")
      @path
      poolId: string;

      @doc("The options to use for replacing properties on the pool.")
      @body
      pool: BatchPoolReplaceParameters;
    },
    NoContentSuccesResponseHeaders
  >;

  @summary("Removes Compute Nodes from the specified Pool.")
  @doc("""
This operation can only run when the allocation state of the Pool is steady.
When this operation runs, the allocation state changes from steady to resizing.
Each request may remove up to 100 nodes.
""")
  @route("/pools/{poolId}/removenodes")
  @projectedName("java", "removeNodesInternal")
  removeNodes is Ops.PostOperation<
    BatchPoolHeaders & {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The options to use for removing the node.")
      @body
      parameters: BatchNodeRemoveParameters;
    },
    AcceptedProcessingResponseHeaders
  >;

  @summary("Lists all Virtual Machine Images supported by the Azure Batch service.")
  @doc("Lists all Virtual Machine Images supported by the Azure Batch service.")
  @route("/supportedimages")
  @projectedName("java", "listSupportedImagesInternal")
  listSupportedImages is Ops.ListOperation<
    {
      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-support-images.
""")
      @query
      @projectedName("client", "filter")
      $filter?: string;
    },
    BatchAccountListSupportedImagesResult
  >;

  @doc("""
Gets the number of Compute Nodes in each state, grouped by Pool. Note that the
numbers returned may not always be up to date. If you need exact node counts,
use a list query.
""")
  @route("/nodecounts")
  @projectedName("java", "listPoolNodeCountsInternal")
  listPoolNodeCounts is Ops.ListOperation<
    {
      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-support-images.
""")
      @query
      @projectedName("client", "filter")
      $filter?: string;
    },
    BatchPoolNodeCountsListResult
  >;

  @summary("Deletes a Job.")
  @doc("""
Deleting a Job also deletes all Tasks that are part of that Job, and all Job
statistics. This also overrides the retention period for Task data; that is, if
the Job contains Tasks which are still retained on Compute Nodes, the Batch
services deletes those Tasks' working directories and all their contents.  When
a Delete Job request is received, the Batch service sets the Job to the
deleting state. All update operations on a Job that is in deleting state will
fail with status code 409 (Conflict), with additional information indicating
that the Job is being deleted.
""")
  @route("/jobs/{jobId}")
  @projectedName("java", "deleteJobInternal")
  deleteJob is Ops.DeleteOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job to delete.")
      @path
      jobId: string;
    },
    DeleteResponseHeaders
  >;

  @summary("Gets information about the specified Job.")
  @doc("Gets information about the specified Job.")
  @route("/jobs/{jobId}")
  @projectedName("java", "getJobInternal")
  getJob is Ops.ReadOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job.")
      @path
      jobId: string;

      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "select")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "expand")
      $expand?: string[];
    },
    BatchJob
  >;

  @summary("Updates the properties of the specified Job.")
  @doc("""
This replaces only the Job properties specified in the request. For example, if
the Job has constraints, and a request does not specify the constraints
element, then the Job keeps the existing constraints.
""")
  @route("/jobs/{jobId}")
  @projectedName("java", "updateJobInternal")
  updateJob is Ops.UpdateOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job whose properties you want to update.")
      @path
      jobId: string;

      @doc("The options to use for updating the Job.")
      @body
      job: BatchJobUpdateParameters;
    },
    RequestSuccesResponseHeaders
  >;

  @summary("Updates the properties of the specified Job.")
  @doc("""
This fully replaces all the updatable properties of the Job. For example, if
the Job has constraints associated with it and if constraints is not specified
with this request, then the Batch service will remove the existing constraints.
""")
  @route("/jobs/{jobId}")
  @projectedName("java", "replaceJobInternal")
  replaceJob is Ops.ReplaceOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job whose properties you want to update.")
      @path
      jobId: string;

      @doc("A job with updated properties")
      @body
      job: BatchJob;
    },
    RequestSuccesResponseHeaders
  >;

  @summary("Disables the specified Job, preventing new Tasks from running.")
  @doc("""
The Batch Service immediately moves the Job to the disabling state. Batch then
uses the disableTasks parameter to determine what to do with the currently
running Tasks of the Job. The Job remains in the disabling state until the
disable operation is completed and all Tasks have been dealt with according to
the disableTasks option; the Job then moves to the disabled state. No new Tasks
are started under the Job until it moves back to active state. If you try to
disable a Job that is in any state other than active, disabling, or disabled,
the request fails with status code 409.
""")
  @route("/jobs/{jobId}/disable")
  @projectedName("java", "disableJobInternal")
  disableJob is Ops.PostOperation<
    BatchMatchHeaders & {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Job to disable.")
      @path
      jobId: string;

      @doc("The options to use for disabling the Job.")
      @body
      parameters: BatchJobDisableParameters;
    },
    AcceptedProcessingResponseHeaders
  >;

  @summary("Enables the specified Job, allowing new Tasks to run.")
  @doc("""
When you call this API, the Batch service sets a disabled Job to the enabling
state. After the this operation is completed, the Job moves to the active
state, and scheduling of new Tasks under the Job resumes. The Batch service
does not allow a Task to remain in the active state for more than 180 days.
Therefore, if you enable a Job containing active Tasks which were added more
than 180 days ago, those Tasks will not run.
""")
  @route("/jobs/{jobId}/enable")
  @projectedName("java", "enableJobInternal")
  enableJob is Ops.PostOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job to enable.")
      @path
      jobId: string;
    },
    AcceptedProcessingResponseHeaders
  >;

  @summary("Terminates the specified Job, marking it as completed.")
  @doc("""
When a Terminate Job request is received, the Batch service sets the Job to the
terminating state. The Batch service then terminates any running Tasks
associated with the Job and runs any required Job release Tasks. Then the Job
moves into the completed state. If there are any Tasks in the Job in the active
state, they will remain in the active state. Once a Job is terminated, new
Tasks cannot be added and any remaining active Tasks will not be scheduled.
""")
  @route("/jobs/{jobId}/terminate")
  @projectedName("java", "terminateJobInternal")
  terminateJob is Ops.PostOperation<
    BatchMatchHeaders & {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Job to terminate.")
      @path
      jobId: string;

      @doc("The options to use for terminating the Job.")
      @body
      parameters?: BatchJobTerminateParameters;
    },
    AcceptedProcessingResponseHeaders
  >;

  @summary("Creates a Job to the specified Account.")
  @doc("""
The Batch service supports two ways to control the work done as part of a Job.
In the first approach, the user specifies a Job Manager Task. The Batch service
launches this Task when it is ready to start the Job. The Job Manager Task
controls all other Tasks that run under this Job, by using the Task APIs. In
the second approach, the user directly controls the execution of Tasks under an
active Job, by using the Task APIs. Also note: when naming Jobs, avoid
including sensitive information such as user names or secret project names.
This information may appear in telemetry logs accessible to Microsoft Support
engineers.
""")
  @route("/jobs")
  @projectedName("java", "createJobInternal")
  createJob is Ops.CreateOperation<
    {
      @doc("The Job to be created.")
      @body
      job: BatchJobCreateParameters;
    },
    {}
  >;

  @summary("Lists all of the Jobs in the specified Account.")
  @doc("Lists all of the Jobs in the specified Account.")
  @route("/jobs")
  @projectedName("java", "listJobsInternal")
  listJobs is Ops.ListOperation<
    {
      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-jobs.
""")
      @query
      @projectedName("client", "filter")
      $filter?: string;

      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "select")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "expand")
      $expand?: string[];
    },
    BatchJobListResult
  >;

  @summary("Lists the Jobs that have been created under the specified Job Schedule.")
  @doc("Lists the Jobs that have been created under the specified Job Schedule.")
  @route("/jobschedules/{jobScheduleId}/jobs")
  @projectedName("java", "listJobsFromScheduleInternal")
  listJobsFromSchedule is Ops.ListOperation<
    {
      @doc("The ID of the Job Schedule from which you want to get a list of Jobs.")
      @path
      jobScheduleId: string;

      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-jobs-in-a-job-schedule.
""")
      @query
      @projectedName("client", "filter")
      $filter?: string;

      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "select")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "expand")
      $expand?: string[];
    },
    BatchJobListResult
  >;

  @summary("""
Lists the execution status of the Job Preparation and Job Release Task for the
specified Job across the Compute Nodes where the Job has run.
""")
  @doc("""
This API returns the Job Preparation and Job Release Task status on all Compute
Nodes that have run the Job Preparation or Job Release Task. This includes
Compute Nodes which have since been removed from the Pool. If this API is
invoked on a Job which has no Job Preparation or Job Release Task, the Batch
service returns HTTP status code 409 (Conflict) with an error code of
JobPreparationTaskNotSpecified.
""")
  @route("/jobs/{jobId}/jobpreparationandreleasetaskstatus")
  @projectedName("java", "listJobPreparationAndReleaseTaskStatusInternal")
  listJobPreparationAndReleaseTaskStatus is Ops.ListOperation<
    {
      @doc("The ID of the Job.")
      @path
      jobId: string;

      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-job-preparation-and-release-status.
""")
      @query
      @projectedName("client", "filter")
      $filter?: string;

      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "select")
      $select?: string[];
    },
    BatchJobPreparationAndReleaseTaskStatusListResult
  >;

  @summary("Gets the Task counts for the specified Job.")
  @doc("""
Task counts provide a count of the Tasks by active, running or completed Task
state, and a count of Tasks which succeeded or failed. Tasks in the preparing
state are counted as running. Note that the numbers returned may not always be
up to date. If you need exact task counts, use a list query.
""")
  @route("/jobs/{jobId}/taskcounts")
  @projectedName("java", "getJobTaskCountsInternal")
  getJobTaskCounts is Ops.ReadOperation<
    {
      @doc("The ID of the Job.")
      @path
      jobId: string;
    },
    BatchTaskCountsResult
  >;

  #deprecated "Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead."
  @summary("Creates a Certificate to the specified Account.")
  @doc("Creates a Certificate to the specified Account.")
  @route("/certificates")
  @projectedName("java", "createCertificateInternal")
  createCertificate is Ops.CreateOperation<
    {
      @doc("The Certificate to be created.")
      @body
      certificate: BatchCertificate;
    },
    {}
  >;

  #deprecated "Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead."
  @summary("Lists all of the Certificates that have been added to the specified Account.")
  @doc("Lists all of the Certificates that have been added to the specified Account.")
  @route("/certificates")
  @projectedName("java", "listCertificatesInternal")
  listCertificates is Ops.ListOperation<
    {
      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-certificates.
""")
      @query
      @projectedName("client", "filter")
      $filter?: string;

      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "select")
      $select?: string[];
    },
    BatchCertificateListResult
  >;

  #deprecated "Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead."
  @summary("Cancels a failed deletion of a Certificate from the specified Account.")
  @doc("""
If you try to delete a Certificate that is being used by a Pool or Compute
Node, the status of the Certificate changes to deleteFailed. If you decide that
you want to continue using the Certificate, you can use this operation to set
the status of the Certificate back to active. If you intend to delete the
Certificate, you do not need to run this operation after the deletion failed.
You must make sure that the Certificate is not being used by any resources, and
then you can try again to delete the Certificate.
""")
  @route("/certificates(thumbprintAlgorithm={thumbprintAlgorithm},thumbprint={thumbprint})/canceldelete")
  @projectedName("java", "cancelCertificateDeletionInternal")
  cancelCertificateDeletion is Ops.PostOperation<
    {
      @doc("The algorithm used to derive the thumbprint parameter. This must be sha1.")
      @path
      thumbprintAlgorithm: string;

      @doc("The thumbprint of the Certificate being deleted.")
      @path
      thumbprint: string;
    },
    NoContentSuccesResponseHeaders
  >;

  #deprecated "Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead."
  @summary("Deletes a Certificate from the specified Account.")
  @doc("""
You cannot delete a Certificate if a resource (Pool or Compute Node) is using
it. Before you can delete a Certificate, you must therefore make sure that the
Certificate is not associated with any existing Pools, the Certificate is not
installed on any Nodes (even if you remove a Certificate from a Pool, it is not
removed from existing Compute Nodes in that Pool until they restart), and no
running Tasks depend on the Certificate. If you try to delete a Certificate
that is in use, the deletion fails. The Certificate status changes to
deleteFailed. You can use Cancel Delete Certificate to set the status back to
active if you decide that you want to continue using the Certificate.
""")
  @route("/certificates(thumbprintAlgorithm={thumbprintAlgorithm},thumbprint={thumbprint})")
  @projectedName("java", "deleteCertificateInternal")
  deleteCertificate is Ops.DeleteOperation<
    {
      @doc("The algorithm used to derive the thumbprint parameter. This must be sha1.")
      @path
      thumbprintAlgorithm: string;

      @doc("The thumbprint of the Certificate to be deleted.")
      @path
      thumbprint: string;
    },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "202";
    }
  >;

  #deprecated "Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead."
  @doc("Gets information about the specified Certificate.")
  @route("/certificates(thumbprintAlgorithm={thumbprintAlgorithm},thumbprint={thumbprint})")
  @projectedName("java", "getCertificateInternal")
  getCertificate is Ops.ReadOperation<
    {
      @doc("The algorithm used to derive the thumbprint parameter. This must be sha1.")
      @path
      thumbprintAlgorithm: string;

      @doc("The thumbprint of the Certificate to get.")
      @path
      thumbprint: string;

      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "select")
      $select?: string[];
    },
    BatchCertificate
  >;

  @summary("Checks the specified Job Schedule exists.")
  @doc("Checks the specified Job Schedule exists.")
  @route("/jobschedules/{jobScheduleId}")
  @projectedName("java", "jobScheduleExistsInternal")
  jobScheduleExists is Ops.ResourceInfoOperationWithAdditionalResponse<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("The ID of the Job Schedule which you want to check.")
        @path
        jobScheduleId: string;
      },
    JobScheduleDoesExistResponseHeaders,
    JobScheduleDoesNotExistResponseHeaders
  >;

  @summary("Deletes a Job Schedule from the specified Account.")
  @doc("""
When you delete a Job Schedule, this also deletes all Jobs and Tasks under that
schedule. When Tasks are deleted, all the files in their working directories on
the Compute Nodes are also deleted (the retention period is ignored). The Job
Schedule statistics are no longer accessible once the Job Schedule is deleted,
though they are still counted towards Account lifetime statistics.
""")
  @route("/jobschedules/{jobScheduleId}")
  @projectedName("java", "deleteJobScheduleInternal")
  deleteJobSchedule is Ops.DeleteOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job Schedule to delete.")
      @path
      jobScheduleId: string;
    },
    DeleteResponseHeaders
  >;

  @doc("Gets information about the specified Job Schedule.")
  @route("/jobschedules/{jobScheduleId}")
  @projectedName("java", "getJobScheduleInternal")
  getJobSchedule is Ops.ReadOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job Schedule to get.")
      @path
      jobScheduleId: string;

      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "select")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "expand")
      $expand?: string[];
    },
    BatchJobSchedule
  >;

  @summary("Updates the properties of the specified Job Schedule.")
  @doc("""
This replaces only the Job Schedule properties specified in the request. For
example, if the schedule property is not specified with this request, then the
Batch service will keep the existing schedule. Changes to a Job Schedule only
impact Jobs created by the schedule after the update has taken place; currently
running Jobs are unaffected.
""")
  @route("/jobschedules/{jobScheduleId}")
  @projectedName("java", "updateJobScheduleInternal")
  updateJobSchedule is Ops.UpdateOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job Schedule to update.")
      @path
      jobScheduleId: string;

      @doc("The options to use for updating the Job Schedule.")
      @body
      jobSchedule: BatchJobScheduleUpdateParameters;
    },
    RequestSuccesResponseHeaders
  >;

  @summary("Updates the properties of the specified Job Schedule.")
  @doc("""
This fully replaces all the updatable properties of the Job Schedule. For
example, if the schedule property is not specified with this request, then the
Batch service will remove the existing schedule. Changes to a Job Schedule only
impact Jobs created by the schedule after the update has taken place; currently
running Jobs are unaffected.
""")
  @route("/jobschedules/{jobScheduleId}")
  @projectedName("java", "replaceJobScheduleInternal")
  replaceJobSchedule is Ops.ReplaceOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job Schedule to update.")
      @path
      jobScheduleId: string;

      @doc("A Job Schedule with updated properties")
      @body
      jobSchedule: BatchJobSchedule;
    },
    RequestSuccesResponseHeaders
  >;

  @summary("Disables a Job Schedule.")
  @doc("No new Jobs will be created until the Job Schedule is enabled again.")
  @route("/jobschedules/{jobScheduleId}/disable")
  @projectedName("java", "disableJobScheduleInternal")
  disableJobSchedule is Ops.PostOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job Schedule to disable.")
      @path
      jobScheduleId: string;
    },
    NoContentSuccesResponseHeaders
  >;

  @summary("Enables a Job Schedule.")
  @doc("Enables a Job Schedule.")
  @route("/jobschedules/{jobScheduleId}/enable")
  @projectedName("java", "enableJobScheduleInternal")
  enableJobSchedule is Ops.PostOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job Schedule to enable.")
      @path
      jobScheduleId: string;
    },
    NoContentSuccesResponseHeaders
  >;

  @summary("Terminates a Job Schedule.")
  @doc("Terminates a Job Schedule.")
  @route("/jobschedules/{jobScheduleId}/terminate")
  @projectedName("java", "terminateJobScheduleInternal")
  terminateJobSchedule is Ops.PostOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job Schedule to terminates.")
      @path
      jobScheduleId: string;
    },
    AcceptedProcessingResponseHeaders
  >;

  @summary("Creates a Job Schedule to the specified Account.")
  @doc("Creates a Job Schedule to the specified Account.")
  @route("/jobschedules")
  @projectedName("java", "createJobScheduleInternal")
  createJobSchedule is Ops.CreateOperation<
    {
      @doc("The Job Schedule to be created.")
      @body
      jobSchedule: BatchJobScheduleCreateParameters;
    },
    {}
  >;

  @summary("Lists all of the Job Schedules in the specified Account.")
  @doc("Lists all of the Job Schedules in the specified Account.")
  @route("/jobschedules")
  @projectedName("java", "listJobSchedulesInternal")
  listJobSchedules is Ops.ListOperation<
    {
      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-job-schedules.
""")
      @query
      @projectedName("client", "filter")
      $filter?: string;

      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "select")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "expand")
      $expand?: string[];
    },
    BatchJobScheduleListResult
  >;

  @summary("Creates a Task to the specified Job.")
  @doc("""
The maximum lifetime of a Task from addition to completion is 180 days. If a
Task has not completed within 180 days of being added it will be terminated by
the Batch service and left in whatever state it was in at that time.
""")
  @route("/jobs/{jobId}/tasks")
  @projectedName("java", "createTaskInternal")
  createTask is Ops.CreateOperation<
    {
      @doc("The ID of the Job to which the Task is to be created.")
      @path
      jobId: string;

      @doc("The Task to be created.")
      @body
      task: BatchTaskCreateParameters;
    },
    {}
  >;

  @summary("Lists all of the Tasks that are associated with the specified Job.")
  @doc("""
For multi-instance Tasks, information such as affinityId, executionInfo and
nodeInfo refer to the primary Task. Use the list subtasks API to retrieve
information about subtasks.
""")
  @route("/jobs/{jobId}/tasks")
  @projectedName("java", "listTasksInternal")
  listTasks is Ops.ListOperation<
    {
      @doc("The ID of the Job.")
      @path
      jobId: string;

      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-tasks.
""")
      @query
      @projectedName("client", "filter")
      $filter?: string;

      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "select")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "expand")
      $expand?: string[];
    },
    BatchTaskListResult
  >;

  @summary("Adds a collection of Tasks to the specified Job.")
  @doc("""
Note that each Task must have a unique ID. The Batch service may not return the
results for each Task in the same order the Tasks were submitted in this
request. If the server times out or the connection is closed during the
request, the request may have been partially or fully processed, or not at all.
In such cases, the user should re-issue the request. Note that it is up to the
user to correctly handle failures when re-issuing a request. For example, you
should use the same Task IDs during a retry so that if the prior operation
succeeded, the retry will not create extra Tasks unexpectedly. If the response
contains any Tasks which failed to add, a client can retry the request. In a
retry, it is most efficient to resubmit only Tasks that failed to add, and to
omit Tasks that were successfully added on the first attempt. The maximum
lifetime of a Task from addition to completion is 180 days. If a Task has not
completed within 180 days of being added it will be terminated by the Batch
service and left in whatever state it was in at that time.
""")
  @route("/jobs/{jobId}/addtaskcollection")
  @projectedName("java", "createTaskCollectionInternal")
  createTaskCollection is Ops.PostOperation<
    {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Job to which the Task collection is to be added.")
      @path
      jobId: string;

      @doc("The Tasks to be added.")
      @body
      taskCollection: BatchTaskCollection;
    },
    BatchTaskAddCollectionResult
  >;

  @summary("Deletes a Task from the specified Job.")
  @doc("""
When a Task is deleted, all of the files in its directory on the Compute Node
where it ran are also deleted (regardless of the retention time). For
multi-instance Tasks, the delete Task operation applies synchronously to the
primary task; subtasks and their files are then deleted asynchronously in the
background.
""")
  @route("/jobs/{jobId}/tasks/{taskId}")
  @projectedName("java", "deleteTaskInternal")
  deleteTask is Ops.DeleteOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job from which to delete the Task.")
      @path
      jobId: string;

      @doc("The ID of the Task to delete.")
      @path
      taskId: string;
    },
    BatchClientResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "200";
    }
  >;

  @summary("Gets information about the specified Task.")
  @doc("""
For multi-instance Tasks, information such as affinityId, executionInfo and
nodeInfo refer to the primary Task. Use the list subtasks API to retrieve
information about subtasks.
""")
  @route("/jobs/{jobId}/tasks/{taskId}")
  @projectedName("java", "getTaskInternal")
  getTask is Ops.ReadOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job that contains the Task.")
      @path
      jobId: string;

      @doc("The ID of the Task to get information about.")
      @path
      taskId: string;

      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "select")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "expand")
      $expand?: string[];
    },
    BatchTask & {
      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      dataServiceId: string;
    }
  >;

  @doc("Updates the properties of the specified Task.")
  @route("/jobs/{jobId}/tasks/{taskId}")
  @projectedName("java", "replaceTaskInternal")
  replaceTask is Ops.ReplaceOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job containing the Task.")
      @path
      jobId: string;

      @doc("The ID of the Task to update.")
      @path
      taskId: string;

      @doc("The Task to update.")
      @body
      task: BatchTask;
    },
    RequestSuccesResponseHeaders
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "GET operations that return single objects should start with 'get'"
  @summary("""
Lists all of the subtasks that are associated with the specified multi-instance
Task.
""")
  @doc("If the Task is not a multi-instance Task then this returns an empty collection.")
  @route("/jobs/{jobId}/tasks/{taskId}/subtasksinfo")
  @projectedName("java", "listSubTasksInternal")
  listSubTasks is Ops.ReadOperation<
    {
      @doc("The ID of the Job.")
      @path
      jobId: string;

      @doc("The ID of the Task.")
      @path
      taskId: string;

      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "select")
      $select?: string[];
    },
    BatchTaskListSubtasksResult
  >;

  @summary("Terminates the specified Task.")
  @doc("""
When the Task has been terminated, it moves to the completed state. For
multi-instance Tasks, the terminate Task operation applies synchronously to the
primary task; subtasks are then terminated asynchronously in the background.
""")
  @route("/jobs/{jobId}/tasks/{taskId}/terminate")
  @projectedName("java", "terminateTaskInternal")
  terminateTask is Ops.PostOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job containing the Task.")
      @path
      jobId: string;

      @doc("The ID of the Task to terminate.")
      @path
      taskId: string;
    },
    {
      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      dataServiceId: string;
    }
  >;

  @summary("""
Reactivates a Task, allowing it to run again even if its retry count has been
exhausted.
""")
  @doc("""
Reactivation makes a Task eligible to be retried again up to its maximum retry
count. The Task's state is changed to active. As the Task is no longer in the
completed state, any previous exit code or failure information is no longer
available after reactivation. Each time a Task is reactivated, its retry count
is reset to 0. Reactivation will fail for Tasks that are not completed or that
previously completed successfully (with an exit code of 0). Additionally, it
will fail if the Job has completed (or is terminating or deleting).
""")
  @route("/jobs/{jobId}/tasks/{taskId}/reactivate")
  @projectedName("java", "reactivateTaskInternal")
  reactivateTask is Ops.PostOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job containing the Task.")
      @path
      jobId: string;

      @doc("The ID of the Task to reactivate.")
      @path
      taskId: string;
    },
    {
      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      dataServiceId: string;
    }
  >;

  @summary("Deletes the specified Task file from the Compute Node where the Task ran.")
  @doc("Deletes the specified Task file from the Compute Node where the Task ran.")
  @route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
  @projectedName("java", "deleteTaskFileInternal")
  deleteTaskFile is Ops.DeleteOperation<
    BatchTaskFileClientPathParameters & {
      @doc("""
Whether to delete children of a directory. If the filePath parameter represents
a directory instead of a file, you can set recursive to true to delete the
directory and all of the files and subdirectories in it. If recursive is false
then the directory must be empty or deletion will fail.
""")
      @query
      recursive?: boolean;
    },
    BatchClientResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "200";
    }
  >;

  @doc("Returns the content of the specified Task file.")
  @route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
  @projectedName("java", "getTaskFileInternal")
  getTaskFile is Ops.ReadOperation<
    BatchTaskFileClientPathParameters &
      BatchModifiedSinceHeaders & {
        @doc("""
The byte range to be retrieved. The default is to retrieve the entire file. The
format is bytes=startRange-endRange.
""")
        @header
        `ocp-range`?: string;
      },
    FileResponse & {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/octet-stream";

      @body
      @doc("A response containing the file content.")
      file: bytes;
    }
  >;

  @doc("Gets the properties of the specified Task file.")
  @route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
  @projectedName("java", "getTaskFilePropertiesInternal")
  getTaskFileProperties is Ops.ResourceInfoOperation<
    BatchTaskFileClientPathParameters & BatchModifiedSinceHeaders,
    FileResponse
  >;

  @summary("Lists the files in a Task's directory on its Compute Node.")
  @doc("Lists the files in a Task's directory on its Compute Node.")
  @route("/jobs/{jobId}/tasks/{taskId}/files")
  @projectedName("java", "listTaskFilesInternal")
  listTaskFiles is Ops.ListOperation<
    {
      @doc("The ID of the Job that contains the Task.")
      @path
      jobId: string;

      @doc("The ID of the Task whose files you want to list.")
      @path
      taskId: string;

      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-task-files.
""")
      @query
      @projectedName("client", "filter")
      $filter?: string;

      @doc("""
Whether to list children of the Task directory. This parameter can be used in
combination with the filter parameter to list specific type of files.
""")
      @query
      recursive?: boolean;
    },
    BatchNodeFileListResult
  >;

  @summary("Adds a user Account to the specified Compute Node.")
  @doc("""
You can add a user Account to a Compute Node only when it is in the idle or
running state.
""")
  @route("/pools/{poolId}/nodes/{nodeId}/users")
  @projectedName("java", "createNodeUserInternal")
  createNodeUser is Ops.CreateOperation<
    {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the machine on which you want to create a user Account.")
      @path
      nodeId: string;

      @doc("The options to use for creating the user.")
      @body
      user: BatchNodeUserCreateParameters;
    },
    {}
  >;

  @summary("Deletes a user Account from the specified Compute Node.")
  @doc("""
You can delete a user Account to a Compute Node only when it is in the idle or
running state.
""")
  @route("/pools/{poolId}/nodes/{nodeId}/users/{userName}")
  @projectedName("java", "deleteNodeUserInternal")
  deleteNodeUser is Ops.DeleteOperation<
    {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the machine on which you want to delete a user Account.")
      @path
      nodeId: string;

      @doc("The name of the user Account to delete.")
      @path
      userName: string;
    },
    BatchClientResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "200";
    }
  >;

  @summary("""
Updates the password and expiration time of a user Account on the specified Compute Node.
""")
  @doc("""
This operation replaces of all the updatable properties of the Account. For
example, if the expiryTime element is not specified, the current value is
replaced with the default value, not left unmodified. You can update a user
Account on a Compute Node only when it is in the idle or running state.
""")
  @route("/pools/{poolId}/nodes/{nodeId}/users/{userName}")
  @projectedName("java", "replaceNodeUserInternal")
  replaceNodeUser is Ops.ReplaceOperation<
    {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the machine on which you want to update a user Account.")
      @path
      nodeId: string;

      @doc("The name of the user Account to update.")
      @path
      userName: string;

      @doc("The options to use for updating the user.")
      @body
      parameters: BatchNodeUserUpdateParameters;
    },
    RequestSuccesResponseHeaders
  >;

  @summary("Gets information about the specified Compute Node.")
  @doc("Gets information about the specified Compute Node.")
  @route("/pools/{poolId}/nodes/{nodeId}")
  @projectedName("java", "getNodeInternal")
  getNode is Ops.ReadOperation<
    {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node that you want to get information about.")
      @path
      nodeId: string;

      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "select")
      $select?: string[];
    },
    BatchNode
  >;

  @summary("Restarts the specified Compute Node.")
  @doc("You can restart a Compute Node only if it is in an idle or running state.")
  @route("/pools/{poolId}/nodes/{nodeId}/reboot")
  @projectedName("java", "rebootNodeInternal")
  rebootNode is Ops.PostOperation<
    {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node that you want to restart.")
      @path
      nodeId: string;

      @doc("The options to use for rebooting the Compute Node.")
      @body
      parameters?: BatchNodeRebootParameters;
    },
    AcceptedProcessingResponseHeaders
  >;

  @summary("Reinstalls the operating system on the specified Compute Node.")
  @doc("""
You can reinstall the operating system on a Compute Node only if it is in an
idle or running state. This API can be invoked only on Pools created with the
cloud service configuration property.
""")
  @route("/pools/{poolId}/nodes/{nodeId}/reimage")
  @projectedName("java", "reimageNodeInternal")
  reimageNode is Ops.PostOperation<
    {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node that you want to restart.")
      @path
      nodeId: string;

      @doc("The options to use for reimaging the Compute Node.")
      @body
      parameters?: BatchNodeReimageParameters;
    },
    AcceptedProcessingResponseHeaders
  >;

  @summary("Disables Task scheduling on the specified Compute Node.")
  @doc("""
You can disable Task scheduling on a Compute Node only if its current
scheduling state is enabled.
""")
  @route("/pools/{poolId}/nodes/{nodeId}/disablescheduling")
  @projectedName("java", "disableNodeSchedulingInternal")
  disableNodeScheduling is Ops.PostOperation<
    {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node on which you want to disable Task scheduling.")
      @path
      nodeId: string;

      @doc("The options to use for disabling scheduling on the Compute Node.")
      @body
      parameters?: BatchNodeDisableSchedulingParameters;
    },
    RequestSuccesResponseHeaders
  >;

  @summary("Enables Task scheduling on the specified Compute Node.")
  @doc("""
You can enable Task scheduling on a Compute Node only if its current scheduling
state is disabled
""")
  @route("/pools/{poolId}/nodes/{nodeId}/enablescheduling")
  @projectedName("java", "enableNodeSchedulingInternal")
  enableNodeScheduling is Ops.PostOperation<
    {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node on which you want to enable Task scheduling.")
      @path
      nodeId: string;
    },
    RequestSuccesResponseHeaders
  >;

  @summary("Gets the settings required for remote login to a Compute Node.")
  @doc("""
Before you can remotely login to a Compute Node using the remote login
settings, you must create a user Account on the Compute Node. This API can be
invoked only on Pools created with the virtual machine configuration property.
For Pools created with a cloud service configuration, see the GetRemoteDesktop
API.
""")
  @route("/pools/{poolId}/nodes/{nodeId}/remoteloginsettings")
  @projectedName("java", "getNodeRemoteLoginSettingsInternal")
  getNodeRemoteLoginSettings is Ops.ReadOperation<
    {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node for which to obtain the remote login settings.")
      @path
      nodeId: string;
    },
    BatchNodeRemoteLoginSettings
  >;

  @summary("Gets the Remote Desktop Protocol file for the specified Compute Node.")
  @doc("""
Before you can access a Compute Node by using the RDP file, you must create a
user Account on the Compute Node. This API can only be invoked on Pools created
with a cloud service configuration. For Pools created with a virtual machine
configuration, see the GetRemoteLoginSettings API.
""")
  @route("/pools/{poolId}/nodes/{nodeId}/rdp")
  @projectedName("java", "getNodeRemoteDesktopFileInternal")
  getNodeRemoteDesktopFile is Ops.ReadOperation<
    {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("""
The ID of the Compute Node for which you want to get the Remote Desktop
Protocol file.
""")
      @path
      nodeId: string;
    },
    {
      @body
      @doc("A response containing the file content.")
      file: bytes;
    }
  >;

  @summary("""
Upload Azure Batch service log files from the specified Compute Node to Azure
Blob Storage.
""")
  @doc("""
This is for gathering Azure Batch service log files in an automated fashion
from Compute Nodes if you are experiencing an error and wish to escalate to
Azure support. The Azure Batch service log files should be shared with Azure
support to aid in debugging issues with the Batch service.
""")
  @route("/pools/{poolId}/nodes/{nodeId}/uploadbatchservicelogs")
  @projectedName("java", "uploadNodeLogsInternal")
  uploadNodeLogs is Ops.PostOperation<
    {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("""
The ID of the Compute Node for which you want to get the Remote Desktop
Protocol file.
""")
      @path
      nodeId: string;

      @doc("The Azure Batch service log files upload options.")
      @body
      parameters: UploadBatchServiceLogsParameters;
    },
    UploadBatchServiceLogsResult
  >;

  @summary("Lists the Compute Nodes in the specified Pool.")
  @doc("Lists the Compute Nodes in the specified Pool.")
  @route("/pools/{poolId}/nodes")
  @projectedName("java", "listNodesInternal")
  listNodes is Ops.ListOperation<
    {
      @doc("The ID of the Pool from which you want to list Compute Nodes.")
      @path
      poolId: string;

      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-nodes-in-a-pool.
""")
      @query
      @projectedName("client", "filter")
      $filter?: string;

      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "select")
      $select?: string[];
    },
    BatchNodeListResult
  >;

  @summary("Gets information about the specified Compute Node Extension.")
  @doc("Gets information about the specified Compute Node Extension.")
  @route("/pools/{poolId}/nodes/{nodeId}/extensions/{extensionName}")
  @projectedName("java", "getNodeExtensionInternal")
  getNodeExtension is Ops.ReadOperation<
    {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node that contains the extensions.")
      @path
      nodeId: string;

      @doc("""
The name of the Compute Node Extension that you want to get information about.
""")
      @path
      extensionName: string;

      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "select")
      $select?: string[];
    },
    BatchNodeVMExtension
  >;

  @summary("Lists the Compute Nodes Extensions in the specified Pool.")
  @doc("Lists the Compute Nodes Extensions in the specified Pool.")
  @route("/pools/{poolId}/nodes/{nodeId}/extensions")
  @projectedName("java", "listNodeExtensionsInternal")
  listNodeExtensions is Ops.ListOperation<
    {
      @doc("The ID of the Pool that contains Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node that you want to list extensions.")
      @path
      nodeId: string;

      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      @projectedName("client", "select")
      $select?: string[];
    },
    BatchNodeVMExtensionListResult
  >;

  @summary("Deletes the specified file from the Compute Node.")
  @doc("Deletes the specified file from the Compute Node.")
  @route("/pools/{poolId}/nodes/{nodeId}/files/{filePath}")
  @projectedName("java", "deleteNodeFileInternal")
  deleteNodeFile is Ops.DeleteOperation<
    BatchNodeFileClientPathParameters & {
      @doc("""
Whether to delete children of a directory. If the filePath parameter represents
a directory instead of a file, you can set recursive to true to delete the
directory and all of the files and subdirectories in it. If recursive is false
then the directory must be empty or deletion will fail.
""")
      @query
      recursive?: boolean;
    },
    BatchClientResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "200";
    }
  >;

  @doc("Returns the content of the specified Compute Node file.")
  @route("/pools/{poolId}/nodes/{nodeId}/files/{filePath}")
  @projectedName("java", "getNodeFileInternal")
  getNodeFile is Ops.ReadOperation<
    BatchNodeFileClientPathParameters &
      BatchModifiedSinceHeaders & {
        @doc("""
The byte range to be retrieved. The default is to retrieve the entire file. The
format is bytes=startRange-endRange.
""")
        @header
        `ocp-range`?: string;
      },
    FileResponse & {
      @body
      @doc("A response containing the file content.")
      file: bytes;
    }
  >;

  @doc("Gets the properties of the specified Compute Node file.")
  @route("/pools/{poolId}/nodes/{nodeId}/files/{filePath}")
  @projectedName("java", "getNodeFilePropertiesInternal")
  getNodeFileProperties is Ops.ResourceInfoOperation<
    BatchNodeFileClientPathParameters & BatchModifiedSinceHeaders,
    FileResponse
  >;

  @summary("Lists all of the files in Task directories on the specified Compute Node.")
  @doc("Lists all of the files in Task directories on the specified Compute Node.")
  @route("/pools/{poolId}/nodes/{nodeId}/files")
  @projectedName("java", "listNodeFilesInternal")
  listNodeFiles is Ops.ListOperation<
    {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node whose files you want to list.")
      @path
      nodeId: string;

      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-compute-node-files.
""")
      @query
      @projectedName("client", "filter")
      $filter?: string;

      @doc("Whether to list children of a directory.")
      @query
      recursive?: boolean;
    },
    BatchNodeFileListResult
  >;
}

// headers ////////////////////

alias AcceptedProcessingResponseHeaders = {
  @doc("A process exit code.")
  @statusCode
  code: "202";

  @doc("The OData ID of the resource to which the request applied.")
  @header("DataServiceId")
  dataServiceId: string;
};

alias NoContentSuccesResponseHeaders = {
  @doc("A process exit code.")
  @statusCode
  code: "204";

  @doc("The OData ID of the resource to which the request applied.")
  @header("DataServiceId")
  dataServiceId: string;
};

alias RequestSuccesResponseHeaders = {
  @doc("A process exit code.")
  @statusCode
  code: "200";

  @header("DataServiceId")
  @doc("The OData ID of the resource to which the request applied.")
  dataServiceId: string;
};

alias FileResponse = {
  @doc("A process exit code.")
  @statusCode
  code: "200";

  @header("ocp-creation-time")
  @doc("The file creation time.")
  @encode(DateTimeKnownEncoding.rfc7231)
  ocpcreationtime?: utcDateTime;

  @header("ocp-batch-file-isdirectory")
  @doc("Whether the object represents a directory.")
  ocpbatchfileisdirectory: boolean;

  @header("ocp-batch-file-url")
  @doc("The URL of the file.")
  ocpbatchfileurl: string;

  @header("ocp-batch-file-mode")
  @doc("The file mode attribute in octal format.")
  ocpbatchfilemode: string;

  @header("Content-Length")
  @doc("The length of the file.")
  contentLength: int64;
};

alias BatchPoolHeaders = {
  ...BatchMatchHeaders;

  @doc("The ID of the Pool to get.")
  @path
  poolId: string;
};

alias BatchMatchHeaders = {
  ...BatchModifiedSinceHeaders;

  @doc("""
An ETag value associated with the version of the resource known to the client.
The operation will be performed only if the resource's current ETag on the
service exactly matches the value specified by the client.
""")
  @header("If-Match")
  @projectedName("python", "if__match")
  ifMatch?: string;

  @doc("""
An ETag value associated with the version of the resource known to the client.
The operation will be performed only if the resource's current ETag on the
service does not match the value specified by the client.
""")
  @header("If-None-Match")
  @projectedName("python", "if_none_match")
  ifNoneMatch?: string;
};

alias BatchModifiedSinceHeaders = {
  @doc("""
A timestamp indicating the last modified time of the resource known to the
client. The operation will be performed only if the resource on the service has
been modified since the specified time.
""")
  @header("If-Modified-Since")
  @encode(DateTimeKnownEncoding.rfc7231)
  @projectedName("python", "if_modified_since")
  ifModifiedSince?: utcDateTime;

  @doc("""
A timestamp indicating the last modified time of the resource known to the
client. The operation will be performed only if the resource on the service has
not been modified since the specified time.
""")
  @header("If-Unmodified-Since")
  @encode(DateTimeKnownEncoding.rfc7231)
  @projectedName("python", "if_unmodified_since")
  ifUnmodifiedSince?: utcDateTime;
};

// This is the standard set of headers that most of batch apis return
alias BatchResponseHeaders = BatchClientResponseHeaders &
  BatchEtagResponseHeaders;

alias BatchEtagResponseHeaders = {
  @doc("The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Modified-Since, If-Unmodified-Since, If-Match or If-None-Match headers.")
  @header("ETag")
  @projectedName("python", "etag")
  etag?: string;

  @doc("The time at which the resource was last modified.")
  @header("Last-Modified")
  @encode(DateTimeKnownEncoding.rfc7231)
  lastmodified?: utcDateTime;
};

alias BatchClientResponseHeaders = {
  @doc("The client-request-id provided by the client during the request. This will be returned only if the return-client-request-id parameter was set to true.")
  @header("client-request-id")
  clientrequestid?: string;

  @doc("A unique identifier for the request that was made to the Batch service. If a request is consistently failing and you have verified that the request is properly formulated, you may use this value to report the error to Microsoft. In your report, include the value of this request ID, the approximate time that the request was made, the Batch Account against which the request was made, and the region that Account resides in.")
  @header("request-id")
  requestid?: string;
};

alias PoolDoesExistResponseHeaders = {
  ...BatchResponseHeaders;

  @doc("A process exit code.")
  @statusCode
  code: "200";
};

alias PoolDoesNotExistResponseHeaders = {
  @doc("A process exit code.")
  @statusCode
  code: "404";
};

alias JobScheduleDoesExistResponseHeaders = {
  ...BatchResponseHeaders;

  @doc("A response containing headers related to the Job Schedule, if it exists.")
  @statusCode
  code: "200";
};

alias JobScheduleDoesNotExistResponseHeaders = {
  @doc("The Job Schedule does not exist.")
  @statusCode
  code: "404";
};

alias DeleteResponseHeaders = {
  @doc("A process exit code.")
  @statusCode
  code: "202";

  @doc("The client-request-id provided by the client during the request. This will be returned only if the return-client-request-id parameter was set to true.")
  @header("client-request-id")
  clientrequestid?: string;

  @doc("A unique identifier for the request that was made to the Batch service. If a request is consistently failing and you have verified that the request is properly formulated, you may use this value to report the error to Microsoft. In your report, include the value of this request ID, the approximate time that the request was made, the Batch Account against which the request was made, and the region that Account resides in.")
  @header("request-id")
  requestid?: string;
};

alias BatchCommonListHeaders = {
  ...BatchClientRequestHeaders;

  @doc("""
The maximum number of items to return in the response. A maximum of 1000
applications can be returned.
""")
  @query
  @minValue(1)
  @maxValue(1000)
  maxresults?: int32 = 1000;
};

alias BatchNodeFileClientPathParameters = {
  @doc("The ID of the Pool that contains the Compute Node.")
  @path
  poolId: string;

  @doc("The ID of the Compute Node from which you want to delete the file.")
  @path
  nodeId: string;

  @doc("The path to the file or directory that you want to delete.")
  @path
  filePath: string;
};

alias BatchTaskFileClientPathParameters = {
  @doc("The ID of the Job that contains the Task.")
  @path
  jobId: string;

  @doc("The ID of the Task whose file you want to retrieve.")
  @path
  taskId: string;

  @doc("The path to the Task file that you want to get the content of.")
  @path
  filePath: string;
};

alias BatchClientRequestHeaders = {
  @doc("""
Sets the maximum time that the server can spend processing the request,
in seconds. The default is 30 seconds.
""")
  @query
  @projectedName("client", "timeOutInSeconds")
  timeOut?: int32 = 30;

  @doc("""
The caller-generated request identity, in the form of a GUID with no decoration
such as curly braces, e.g. 9C4D50EE-2D56-4CD3-8152-34347DC9F2B0.
""")
  @header("client-request-id")
  clientrequestid?: string;

  @doc("Whether the server should return the client-request-id in the response.")
  @header("return-client-request-id")
  returnclientrequestid?: boolean = false;

  @doc("""
The time the request was issued. Client libraries typically set this to the
current system clock time; set it explicitly if you are calling the REST API
directly.
""")
  @header("ocp-date")
  @encode(DateTimeKnownEncoding.rfc7231)
  ocpdate?: utcDateTime;
};
