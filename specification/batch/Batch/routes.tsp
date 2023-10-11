import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

namespace Azure.Batch;

// Templates

/**
 * A remote procedure call (RPC) operation with additional response.
 * @template TParams Object describing the parameters of the operation.
 * @template TResponse Object describing the response of the operation.
 * @template TAdditionalResponse Object describing the response of the operation.
 * @template Traits Object describing the traits of the operation.
 * @template TErrorResponse Error response of the operation. If not specified, the default error response is used.
 */
@doc("New rpc operation allowing multiple repsonses")
@Foundations.Private.needsRoute
op RpcOperationWithAdditionalResponse<
  TParams,
  TResponse extends TypeSpec.Reflection.Model,
  TAdditionalResponse extends {},
  Traits extends {} = {},
  TErrorResponse = Azure.Core.Foundations.ErrorResponse
> is Foundations.Operation<
  TParams &
    Azure.Core.Traits.Private.TraitProperties<
      Traits,
      TraitLocation.Parameters
    >,
  (TResponse &
    Azure.Core.Traits.Private.TraitProperties<
      Traits,
      TraitLocation.Response
    >) | TAdditionalResponse,
  Traits,
  TErrorResponse
>;

// Interfaces ////////////////////

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Operations defined using RpcOperation should not have path parameters."
#suppress "@azure-tools/typespec-azure-core/rpc-operation-request-body" "RPCOperation with '@get' cannot have a body."
interface Applications {
  @summary("Lists all of the applications available in the specified Account.")
  @doc("""
This operation returns only Applications and versions that are available for
use on Compute Nodes; that is, that can be used in an Package reference. For
administrator information about applications and versions that are not yet
available to Compute Nodes, use the Azure portal or the Azure Resource Manager
API.
""")
  
  @route("/applications")
  @get
  listApplications is RpcOperation<
    BatchApplicationListHeaders,
    BatchResponseHeaders & ApplicationListResult,
    {},
    BatchError
  >;

  @summary("Gets information about the specified Application.")
  @doc("""
This operation returns only Applications and versions that are available for
use on Compute Nodes; that is, that can be used in an Package reference. For
administrator information about Applications and versions that are not yet
available to Compute Nodes, use the Azure portal or the Azure Resource Manager
API.
""")
  @route("/applications")
  @get
  getApplication is RpcOperation<
    BatchClientRequestHeaders & {
      @doc("The ID of the Application")
      @path
      applicationId: string;
    },
    BatchResponseHeaders & BatchApplication,
    {},
    BatchError
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Operations defined using RpcOperation should not have path parameters."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Operation 'Exists' should be defined using a signature from the Azure.Core namespace."
#suppress "@azure-tools/typespec-azure-core/rpc-operation-request-body" "RPCOperation with '@get' cannot have a body."
interface Pools {
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
  @get
  listPoolUsageMetrics is RpcOperation<
    BatchApplicationListHeaders & {
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
      $filter?: string;
    },
    BatchResponseHeaders & PoolListUsageMetricsResult,
    {},
    BatchError
  >;

  @summary("Creates a Pool to the specified Account.")
  @doc("""
When naming Pools, avoid including sensitive information such as user names or
secret project names. This information may appear in telemetry logs accessible
to Microsoft Support engineers.
""")
  @route("/pools")
  createPool is RpcOperation<
    BatchClientRequestHeaders & {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @body
      @doc("The Pool to be created.")
      body: BatchPoolCreateOptions;
    },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "201";

      @doc("The OData ID of the resource to which the request applied")
      @header("DataServiceId")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  @summary("Lists all of the Pools in the specified Account.")
  @doc("Lists all of the Pools in the specified Account.")
  @route("/pools")
  @get
  listPools is RpcOperation<
    BatchApplicationListHeaders & {
      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-pools.
""")
      @query
      $filter?: string;

      @doc("An OData $select clause.")
      @query({ format: "csv" })
      $select?: string[];

      @doc("An OData $expand clause.")
      @query({ format: "csv" })
      $expand?: string[];
    },
    BatchResponseHeaders & BatchPoolListResult,
    {},
    BatchError
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
  @delete
  deletePool is RpcOperation<
    BatchClientRequestHeaders & BatchPoolHeaders,
    DeleteResponseHeaders,
    {},
    BatchError
  >;

  @doc("Gets basic properties of a Pool.")
  @route("/pools/{poolId}")
  @head
  poolExists is RpcOperationWithAdditionalResponse<
    BatchClientRequestHeaders & BatchPoolHeaders,
    PoolDoesntExistResponseHeaders,
    PoolDoesExistResponseHeaders,
    {},
    BatchError
  >;

  @doc("Gets information about the specified Pool.")
  @route("/pools/{poolId}")
  @get
  getPool is RpcOperation<
    BatchClientRequestHeaders &
      BatchPoolHeaders & {
        @doc("An OData $select clause.")
        @query({
          format: "csv",
        })
        $select?: string[];

        @doc("An OData $expand clause.")
        @query({
          format: "csv",
        })
        $expand?: string[];
      },
    BatchResponseHeaders & BatchPool,
    {},
    BatchError
  >;

  @summary("Updates the properties of the specified Pool.")
  @doc("""
This only replaces the Pool properties specified in the request. For example,
if the Pool has a StartTask associated with it, and a request does not specify
a StartTask element, then the Pool keeps the existing StartTask.
""")
  @route("/pools/{poolId}")
  @patch
  updatePool is RpcOperation<
    BatchClientRequestHeaders &
      BatchPoolHeaders & {
        @doc("Type of content")
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The pool properties to update.")
        @body
        body: BatchPoolUpdateOptions;
      },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "200";

      @doc("The OData ID of the resource to which the request applied")
      @header("DataServiceId")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  @summary("Disables automatic scaling for a Pool.")
  @doc("Disables automatic scaling for a Pool.")
  @route("/pools/{poolId}/disableautoscale")
  @post
  disablePoolAutoScale is RpcOperation<
    BatchClientRequestHeaders & {
      @doc("The ID of the Pool on which to disable automatic scaling.")
      @path
      poolId: string;
    },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "200";

      @doc("The OData ID of the resource to which the request applied")
      @header("DataServiceId")
      DataServiceId: string;
    },
    {},
    BatchError
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
  @post
  enablePoolAutoScale is RpcOperation<
    BatchClientRequestHeaders &
      BatchPoolHeaders & {
        @doc("Type of content")
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The options to use for enabling automatic scaling.")
        @body
        body: BatchPoolEnableAutoScaleOptions;
      },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "200";

      @doc("The OData ID of the resource to which the request applied")
      @header("DataServiceId")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  @summary("Gets the result of evaluating an automatic scaling formula on the Pool.")
  @doc("""
This API is primarily for validating an autoscale formula, as it simply returns
the result without applying the formula to the Pool. The Pool must have auto
scaling enabled in order to evaluate a formula.
""")
  @route("/pools/{poolId}/evaluateautoscale")
  @post
  evaluatePoolAutoScale is RpcOperation<
    BatchClientRequestHeaders & {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Pool on which to evaluate the automatic scaling formula.")
      @path
      poolId: string;

      @doc("The options to use for evaluating the automatic scaling formula.")
      @body
      body: BatchPoolEvaluateAutoScaleOptions;
    },
    BatchResponseHeaders &
      AutoScaleRun & {
        @doc("A process exit code.")
        @statusCode
        code: "200";

        @doc("The OData ID of the resource to which the request applied")
        @header("DataServiceId")
        DataServiceId: string;
      },
    {},
    BatchError
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
  @post
  resizePool is RpcOperation<
    BatchClientRequestHeaders &
      BatchPoolHeaders & {
        @doc("Type of content")
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The options to use for resizing the pool.")
        @body
        body: BatchPoolResizeOptions;
      },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "202";

      @doc("The OData ID of the resource to which the request applied")
      @header("DataServiceId")
      DataServiceId: string;
    },
    {},
    BatchError
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
  @post
  stopPoolResize is RpcOperation<
    BatchClientRequestHeaders & BatchPoolHeaders,
    PoolStopResizeResponseHeaders,
    {},
    BatchError
  >;

  @summary("Updates the properties of the specified Pool.")
  @doc("""
This fully replaces all the updatable properties of the Pool. For example, if
the Pool has a StartTask associated with it and if StartTask is not specified
with this request, then the Batch service will remove the existing StartTask.
""")
  @route("/pools/{poolId}/updateproperties")
  @post
  replacePoolProperties is RpcOperation<
    BatchClientRequestHeaders & {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Pool to update.")
      @path
      poolId: string;

      @doc("The options to use for replacing properties on the pool.")
      @body
      body: BatchPoolReplaceOptions;
    },
    PoolUpdatePropertiesResponseHeaders,
    {},
    BatchError
  >;

  @summary("Removes Compute Nodes from the specified Pool.")
  @doc("""
This operation can only run when the allocation state of the Pool is steady.
When this operation runs, the allocation state changes from steady to resizing.
Each request may remove up to 100 nodes.
""")
  @route("/pools/{poolId}/removenodes")
  @post
  removeNodes is RpcOperation<
    BatchClientRequestHeaders &
      BatchPoolHeaders & {
        @doc("Type of content")
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The options to use for removing the node.")
        @body
        body: NodeRemoveOptions;
      },
    PoolRemoveNodesResponseHeaders,
    {},
    BatchError
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Operations defined using RpcOperation should not have path parameters."
#suppress "@azure-tools/typespec-azure-core/rpc-operation-request-body" "RPCOperation with '@get' cannot have a body."
interface Accounts {
  @summary("Lists all Virtual Machine Images supported by the Azure Batch service.")
  @doc("Lists all Virtual Machine Images supported by the Azure Batch service.")
  @route("/supportedimages")
  @get
  listSupportedImages(
    ...BatchApplicationListHeaders,

    @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-support-images.
""")
    @query
    $filter?: string
  ): (BatchResponseHeaders & AccountListSupportedImagesResult) | BatchError;

  @doc("""
Gets the number of Compute Nodes in each state, grouped by Pool. Note that the
numbers returned may not always be up to date. If you need exact node counts,
use a list query.
""")
  @route("/nodecounts")
  @get
  listPoolNodeCounts is RpcOperation<
    BatchApplicationListHeaders & {
      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-support-images.
""")
      @query
      $filter?: string;
    },
    BatchClientResponseHeaders & PoolNodeCountsListResult,
    {},
    BatchError
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Operations defined using RpcOperation should not have path parameters."
#suppress "@azure-tools/typespec-azure-core/rpc-operation-request-body" "RPCOperation with '@get' cannot have a body."
interface Jobs {
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
  @delete
  deleteJob is RpcOperation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("The ID of the Job to delete.")
        @path
        jobId: string;
      },
    DeleteResponseHeaders,
    {},
    BatchError
  >;

  @summary("Gets information about the specified Job.")
  @doc("Gets information about the specified Job.")
  @route("/jobs/{jobId}")
  @get
  getJob is RpcOperation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("The ID of the Job.")
        @path
        jobId: string;

        @doc("An OData $select clause.")
        @query({
          format: "csv",
        })
        $select?: string[];

        @doc("An OData $expand clause.")
        @query({
          format: "csv",
        })
        $expand?: string[];
      },
    BatchResponseHeaders & BatchJob,
    {},
    BatchError
  >;

  @summary("Updates the properties of the specified Job.")
  @doc("""
This replaces only the Job properties specified in the request. For example, if
the Job has constraints, and a request does not specify the constraints
element, then the Job keeps the existing constraints.
""")
  @route("/jobs/{jobId}")
  @patch
  updateJob is RpcOperation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("Type of content")
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The ID of the Job whose properties you want to update.")
        @path
        jobId: string;

        @doc("The options to use for updating the Job.")
        @body
        body: BatchJobUpdateOptions;
      },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "200";

      @doc("The OData ID of the resource to which the request applied")
      @header("DataServiceId")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  @summary("Updates the properties of the specified Job.")
  @doc("""
This fully replaces all the updatable properties of the Job. For example, if
the Job has constraints associated with it and if constraints is not specified
with this request, then the Batch service will remove the existing constraints.
""")
  @route("/jobs/{jobId}")
  @put
  replaceJob is RpcOperation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("Type of content")
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The ID of the Job whose properties you want to update.")
        @path
        jobId: string;

        @doc("A job with updated properties")
        @body
        body: BatchJob;
      },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "200";

      @doc("The OData ID of the resource to which the request applied")
      @header("DataServiceId")
      DataServiceId: string;
    },
    {},
    BatchError
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
  @post
  disableJob is RpcOperation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("Type of content")
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The ID of the Job to disable.")
        @path
        jobId: string;

        @doc("The options to use for disabling the Job.")
        @body
        body: BatchJobDisableOptions;
      },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "202";

      @doc("The OData ID of the resource to which the request applied")
      @header("DataServiceId")
      DataServiceId: string;
    },
    {},
    BatchError
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
  @post
  enableJob is RpcOperation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("The ID of the Job to enable.")
        @path
        jobId: string;
      },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "202";

      @doc("The OData ID of the resource to which the request applied")
      @header("DataServiceId")
      DataServiceId: string;
    },
    {},
    BatchError
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
  @post
  terminateJob is RpcOperation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("Type of content")
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The ID of the Job to terminate.")
        @path
        jobId: string;

        @doc("The options to use for terminating the Job.")
        @body
        body?: BatchJobTerminateOptions;
      },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "202";

      @doc("The OData ID of the resource to which the request applied")
      @header("DataServiceId")
      DataServiceId: string;
    },
    {},
    BatchError
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
  @post
  createJob is RpcOperation<
    BatchClientRequestHeaders & {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The Job to be created.")
      @body
      body: BatchJobCreateOptions;
    },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "201";

      @doc("The OData ID of the resource to which the request applied")
      @header("DataServiceId")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  @summary("Lists all of the Jobs in the specified Account.")
  @doc("Lists all of the Jobs in the specified Account.")
  @route("/jobs")
  @get
  listJobs is RpcOperation<
    BatchApplicationListHeaders & {
      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-jobs.
""")
      @query
      $filter?: string;

      @doc("An OData $select clause.")
      @query({ format: "csv" })
      $select?: string[];

      @doc("An OData $expand clause.")
      @query({ format: "csv" })
      $expand?: string[];
    },
    BatchResponseHeaders & BatchJobListResult,
    {},
    BatchError
  >;

  @summary("Lists the Jobs that have been created under the specified Job Schedule.")
  @doc("Lists the Jobs that have been created under the specified Job Schedule.")
  @route("/jobschedules/{jobScheduleId}/jobs")
  @get
  listJobsFromSchedule is RpcOperation<
    BatchApplicationListHeaders & {
      @doc("The ID of the Job Schedule from which you want to get a list of Jobs.")
      @path
      jobScheduleId: string;

      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-jobs-in-a-job-schedule.
""")
      @query
      $filter?: string;

      @doc("An OData $select clause.")
      @query({ format: "csv" })
      $select?: string[];

      @doc("An OData $expand clause.")
      @query({ format: "csv" })
      $expand?: string[];
    },
    BatchResponseHeaders & BatchJobListResult,
    {},
    BatchError
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
  @get
  listJobPreparationAndReleaseTaskStatus(
    ...BatchApplicationListHeaders,

    @doc("The ID of the Job.")
    @path
    jobId: string,

    @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-job-preparation-and-release-status.
""")
    @query
    $filter?: string,

    @doc("An OData $select clause.")
    @query({
      format: "csv",
    })
    $select?: string[]
  ): (BatchResponseHeaders &
    BatchJobListPreparationAndReleaseTaskStatusResult) | BatchError;

  @summary("Gets the Task counts for the specified Job.")
  @doc("""
Task counts provide a count of the Tasks by active, running or completed Task
state, and a count of Tasks which succeeded or failed. Tasks in the preparing
state are counted as running. Note that the numbers returned may not always be
up to date. If you need exact task counts, use a list query.
""")
  @route("/jobs/{jobId}/taskcounts")
  @get
  getJobTaskCounts is RpcOperation<
    BatchClientRequestHeaders & {
      @doc("The ID of the Job.")
      @path
      jobId: string;
    },
    BatchClientResponseHeaders & TaskCountsResult,
    {},
    BatchError
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Operations defined using RpcOperation should not have path parameters."
#suppress "@azure-tools/typespec-azure-core/rpc-operation-request-body" "RPCOperation with '@get' cannot have a body."
interface Certificates {
  #deprecated "Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead."
  @summary("Creates a Certificate to the specified Account.")
  @doc("Creates a Certificate to the specified Account.")
  @route("/certificates")
  @post
  createCertificate is RpcOperation<
    BatchClientRequestHeaders & {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The Certificate to be created.")
      @body
      body: BatchCertificate;
    },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "201";

      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  #deprecated "Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead."
  @summary("Lists all of the Certificates that have been added to the specified Account.")
  @doc("Lists all of the Certificates that have been added to the specified Account.")
  @route("/certificates")
  @get
  listCertificates is RpcOperation<
    BatchApplicationListHeaders & {
      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-certificates.
""")
      @query
      $filter?: string;

      @doc("An OData $select clause.")
      @query({ format: "csv" })
      $select?: string[];
    },
    BatchResponseHeaders & CertificateListResult,
    {},
    BatchError
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
  @post
  cancelCertificateDeletion is RpcOperation<
    BatchClientRequestHeaders & {
      @doc("The algorithm used to derive the thumbprint parameter. This must be sha1.")
      @path
      thumbprintAlgorithm: string;

      @doc("The thumbprint of the Certificate being deleted.")
      @path
      thumbprint: string;
    },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "204";

      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
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
  @delete
  deleteCertificate is RpcOperation<
    BatchClientRequestHeaders & {
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
    },
    {},
    BatchError
  >;

  #deprecated "Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead."
  @doc("Gets information about the specified Certificate.")
  @route("/certificates(thumbprintAlgorithm={thumbprintAlgorithm},thumbprint={thumbprint})")
  @get
  getCertificate is RpcOperation<
    BatchClientRequestHeaders & {
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
      $select?: string[];
    },
    BatchResponseHeaders & BatchCertificate,
    {},
    BatchError
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Operations defined using RpcOperation should not have path parameters."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Operation 'Exists' should be defined using a signature from the Azure.Core namespace."
#suppress "@azure-tools/typespec-azure-core/rpc-operation-request-body" "RPCOperation with '@get' cannot have a body."
interface JobSchedules {
  @summary("Checks the specified Job Schedule exists.")
  @doc("Checks the specified Job Schedule exists.")
  @route("/jobschedules/{jobScheduleId}")
  @head
  jobScheduleExists is RpcOperationWithAdditionalResponse<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("The ID of the Job Schedule which you want to check.")
        @path
        jobScheduleId: string;
      },
    BatchResponseHeaders & {
      @doc("A response containing headers related to the Job Schedule, if it exists.")
      @statusCode
      code: "200";
    },
    {
      @doc("The Job Schedule does not exist.")
      @statusCode
      code: "404";
    },
    {},
    BatchError
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
  @delete
  deleteJobSchedule is RpcOperation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("The ID of the Job Schedule to delete.")
        @path
        jobScheduleId: string;
      },
    DeleteResponseHeaders,
    {},
    BatchError
  >;

  @doc("Gets information about the specified Job Schedule.")
  @route("/jobschedules/{jobScheduleId}")
  @get
  getJobSchedule is RpcOperation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("The ID of the Job Schedule to get.")
        @path
        jobScheduleId: string;

        @doc("An OData $select clause.")
        @query({
          format: "csv",
        })
        $select?: string[];

        @doc("An OData $expand clause.")
        @query({
          format: "csv",
        })
        $expand?: string[];
      },
    BatchResponseHeaders & BatchJobSchedule,
    {},
    BatchError
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
  @patch
  updateJobSchedule is RpcOperation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("Type of content")
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The ID of the Job Schedule to update.")
        @path
        jobScheduleId: string;

        @doc("The options to use for updating the Job Schedule.")
        @body
        body: BatchJobScheduleUpdateOptions;
      },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "200";

      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
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
  @put
  replaceJobSchedule is RpcOperation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("Type of content")
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The ID of the Job Schedule to update.")
        @path
        jobScheduleId: string;

        @doc("A Job Schedule with updated properties")
        @body
        body: BatchJobSchedule;
      },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "200";

      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  @summary("Disables a Job Schedule.")
  @doc("No new Jobs will be created until the Job Schedule is enabled again.")
  @route("/jobschedules/{jobScheduleId}/disable")
  @post
  disableJobSchedule is RpcOperation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("The ID of the Job Schedule to disable.")
        @path
        jobScheduleId: string;
      },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "204";

      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  @summary("Enables a Job Schedule.")
  @doc("Enables a Job Schedule.")
  @route("/jobschedules/{jobScheduleId}/enable")
  @post
  enableJobSchedule is RpcOperation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("The ID of the Job Schedule to enable.")
        @path
        jobScheduleId: string;
      },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "204";

      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  @summary("Terminates a Job Schedule.")
  @doc("Terminates a Job Schedule.")
  @route("/jobschedules/{jobScheduleId}/terminate")
  @post
  terminateJobSchedule is RpcOperation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("The ID of the Job Schedule to terminates.")
        @path
        jobScheduleId: string;
      },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "202";

      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  @summary("Creates a Job Schedule to the specified Account.")
  @doc("Creates a Job Schedule to the specified Account.")
  @route("/jobschedules")
  @post
  createJobSchedule is RpcOperation<
    BatchClientRequestHeaders & {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The Job Schedule to be created.")
      @body
      body: BatchJobScheduleCreateOptions;
    },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "201";

      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  @summary("Lists all of the Job Schedules in the specified Account.")
  @doc("Lists all of the Job Schedules in the specified Account.")
  @route("/jobschedules")
  @get
  listJobSchedules is RpcOperation<
    BatchApplicationListHeaders & {
      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-job-schedules.
""")
      @query
      $filter?: string;

      @doc("An OData $select clause.")
      @query({ format: "csv" })
      $select?: string[];

      @doc("An OData $expand clause.")
      @query({ format: "csv" })
      $expand?: string[];
    },
    BatchResponseHeaders & BatchJobScheduleListResult,
    {},
    BatchError
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Operations defined using RpcOperation should not have path parameters."
#suppress "@azure-tools/typespec-azure-core/rpc-operation-request-body" "RPCOperation with '@get' cannot have a body."
interface Tasks {
  @summary("Creates a Task to the specified Job.")
  @doc("""
The maximum lifetime of a Task from addition to completion is 180 days. If a
Task has not completed within 180 days of being added it will be terminated by
the Batch service and left in whatever state it was in at that time.
""")
  @route("/jobs/{jobId}/tasks")
  @post
  createTask is RpcOperation<
    BatchClientRequestHeaders & {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Job to which the Task is to be created.")
      @path
      jobId: string;

      @doc("The Task to be created.")
      @body
      body: BatchTaskCreateOptions;
    },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "201";

      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  @summary("Lists all of the Tasks that are associated with the specified Job.")
  @doc("""
For multi-instance Tasks, information such as affinityId, executionInfo and
nodeInfo refer to the primary Task. Use the list subtasks API to retrieve
information about subtasks.
""")
  @route("/jobs/{jobId}/tasks")
  @get
  listTasks is RpcOperation<
    BatchApplicationListHeaders & {
      @doc("The ID of the Job.")
      @path
      jobId: string;

      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-tasks.
""")
      @query
      $filter?: string;

      @doc("An OData $select clause.")
      @query({ format: "csv" })
      $select?: string[];

      @doc("An OData $expand clause.")
      @query({ format: "csv" })
      $expand?: string[];
    },
    BatchResponseHeaders & BatchTaskListResult,
    {},
    BatchError
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
  @post
  createTaskCollection is RpcOperation<
    BatchClientRequestHeaders & {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Job to which the Task collection is to be added.")
      @path
      jobId: string;

      @doc("The Tasks to be added.")
      @body
      collection: BatchTaskCollection;
    },
    BatchClientResponseHeaders & TaskAddCollectionResult,
    {},
    BatchError
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
  @delete
  deleteTask is RpcOperation<
    BatchClientRequestHeaders &
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
    },
    {},
    BatchError
  >;

  @summary("Gets information about the specified Task.")
  @doc("""
For multi-instance Tasks, information such as affinityId, executionInfo and
nodeInfo refer to the primary Task. Use the list subtasks API to retrieve
information about subtasks.
""")
  @route("/jobs/{jobId}/tasks/{taskId}")
  @get
  getTask is RpcOperation<
    BatchClientRequestHeaders &
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
        $select?: string[];

        @doc("An OData $expand clause.")
        @query({
          format: "csv",
        })
        $expand?: string[];
      },
    BatchResponseHeaders &
      BatchTask & {
        @header("DataServiceId")
        @doc("The OData ID of the resource to which the request applied.")
        DataServiceId: string;
      },
    {},
    BatchError
  >;

  @doc("Updates the properties of the specified Task.")
  @route("/jobs/{jobId}/tasks/{taskId}")
  @put
  replaceTask is RpcOperation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("Type of content")
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The ID of the Job containing the Task.")
        @path
        jobId: string;

        @doc("The ID of the Task to update.")
        @path
        taskId: string;

        @doc("The Task to update.")
        @body
        body: BatchTask;
      },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "200";

      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "GET operations that return single objects should start with 'get'"
  @summary("""
Lists all of the subtasks that are associated with the specified multi-instance
Task.
""")
  @doc("If the Task is not a multi-instance Task then this returns an empty collection.")
  @route("/jobs/{jobId}/tasks/{taskId}/subtasksinfo")
  @get
  listSubTasks is RpcOperation<
    BatchClientRequestHeaders & {
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
      $select?: string[];
    },
    BatchResponseHeaders & BatchTaskListSubtasksResult,
    {},
    BatchError
  >;

  @summary("Terminates the specified Task.")
  @doc("""
When the Task has been terminated, it moves to the completed state. For
multi-instance Tasks, the terminate Task operation applies synchronously to the
primary task; subtasks are then terminated asynchronously in the background.
""")
  @route("/jobs/{jobId}/tasks/{taskId}/terminate")
  @post
  terminateTask is RpcOperation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("The ID of the Job containing the Task.")
        @path
        jobId: string;

        @doc("The ID of the Task to terminate.")
        @path
        taskId: string;
      },
    BatchResponseHeaders & {
      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
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
  @post
  reactivateTask is RpcOperation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("The ID of the Job containing the Task.")
        @path
        jobId: string;

        @doc("The ID of the Task to reactivate.")
        @path
        taskId: string;
      },
    BatchResponseHeaders & {
      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  @summary("Deletes the specified Task file from the Compute Node where the Task ran.")
  @doc("Deletes the specified Task file from the Compute Node where the Task ran.")
  @route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
  @delete
  deleteTaskFile is RpcOperation<
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
    },
    {},
    BatchError
  >;

  @doc("Returns the content of the specified Task file.")
  @route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
  @get
  getTaskFile is RpcOperation<
    BatchTaskFileClientPathParameters &
      BatchModifiedSinceHeaders & {
        @doc("""
The byte range to be retrieved. The default is to retrieve the entire file. The
format is bytes=startRange-endRange.
""")
        @header
        `ocp-range`?: string;
      },
    BatchResponseHeaders &
      FileResponse & {
        @doc("Type of content")
        @header("content-type")
        contentType: "application/octet-stream";

        @body
        @doc("A response containing the file content.")
        file: bytes;
      },
    {},
    BatchError
  >;

  @doc("Gets the properties of the specified Task file.")
  @route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
  @head
  getTaskFileProperties is RpcOperation<
    BatchTaskFileClientPathParameters & BatchModifiedSinceHeaders,
    BatchResponseHeaders & FileResponse,
    {},
    BatchError
  >;

  @summary("Lists the files in a Task's directory on its Compute Node.")
  @doc("Lists the files in a Task's directory on its Compute Node.")
  @route("/jobs/{jobId}/tasks/{taskId}/files")
  @get
  listTaskFiles is RpcOperation<
    BatchApplicationListHeaders & {
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
      $filter?: string;

      @doc("""
Whether to list children of the Task directory. This parameter can be used in
combination with the filter parameter to list specific type of files.
""")
      @query
      recursive?: boolean;
    },
    BatchResponseHeaders & NodeFileListResult,
    {},
    BatchError
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Operations defined using RpcOperation should not have path parameters."
#suppress "@azure-tools/typespec-azure-core/rpc-operation-request-body" "RPCOperation with '@get' cannot have a body."
interface Nodes {
  @summary("Adds a user Account to the specified Compute Node.")
  @doc("""
You can add a user Account to a Compute Node only when it is in the idle or
running state.
""")
  @route("/pools/{poolId}/nodes/{nodeId}/users")
  @post
  createNodeUser is RpcOperation<
    BatchClientRequestHeaders & {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the machine on which you want to create a user Account.")
      @path
      nodeId: string;

      @doc("The options to use for creating the user.")
      @body
      body: BatchNodeUserCreateOptions;
    },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "201";

      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  @summary("Deletes a user Account from the specified Compute Node.")
  @doc("""
You can delete a user Account to a Compute Node only when it is in the idle or
running state.
""")
  @route("/pools/{poolId}/nodes/{nodeId}/users/{userName}")
  @delete
  deleteNodeUser is RpcOperation<
    BatchClientRequestHeaders & {
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
    },
    {},
    BatchError
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
  @put
  replaceNodeUser is RpcOperation<
    BatchClientRequestHeaders & {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

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
      body: BatchNodeUserUpdateOptions;
    },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "200";

      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  @summary("Gets information about the specified Compute Node.")
  @doc("Gets information about the specified Compute Node.")
  @route("/pools/{poolId}/nodes/{nodeId}")
  @get
  getNode is RpcOperation<
    BatchClientRequestHeaders & {
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
      $select?: string[];
    },
    BatchResponseHeaders & BatchNode,
    {},
    BatchError
  >;

  @summary("Restarts the specified Compute Node.")
  @doc("You can restart a Compute Node only if it is in an idle or running state.")
  @route("/pools/{poolId}/nodes/{nodeId}/reboot")
  @post
  rebootNode is RpcOperation<
    BatchClientRequestHeaders & {
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
      body?: NodeRebootOptions;
    },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "202";

      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  @summary("Reinstalls the operating system on the specified Compute Node.")
  @doc("""
You can reinstall the operating system on a Compute Node only if it is in an
idle or running state. This API can be invoked only on Pools created with the
cloud service configuration property.
""")
  @route("/pools/{poolId}/nodes/{nodeId}/reimage")
  @post
  reimageNode is RpcOperation<
    BatchClientRequestHeaders & {
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
      body?: NodeReimageOptions;
    },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "202";

      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  @summary("Disables Task scheduling on the specified Compute Node.")
  @doc("""
You can disable Task scheduling on a Compute Node only if its current
scheduling state is enabled.
""")
  @route("/pools/{poolId}/nodes/{nodeId}/disablescheduling")
  @post
  disableNodeScheduling is RpcOperation<
    BatchClientRequestHeaders & {
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
      body?: NodeDisableSchedulingOptions;
    },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "200";

      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
  >;

  @summary("Enables Task scheduling on the specified Compute Node.")
  @doc("""
You can enable Task scheduling on a Compute Node only if its current scheduling
state is disabled
""")
  @route("/pools/{poolId}/nodes/{nodeId}/enablescheduling")
  @post
  enableNodeScheduling is RpcOperation<
    BatchClientRequestHeaders & {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node on which you want to enable Task scheduling.")
      @path
      nodeId: string;
    },
    BatchResponseHeaders & {
      @doc("A process exit code.")
      @statusCode
      code: "200";

      @header("DataServiceId")
      @doc("The OData ID of the resource to which the request applied.")
      DataServiceId: string;
    },
    {},
    BatchError
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
  @get
  getNodeRemoteLoginSettings is RpcOperation<
    BatchClientRequestHeaders & {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node for which to obtain the remote login settings.")
      @path
      nodeId: string;
    },
    BatchResponseHeaders & BatchNodeRemoteLoginSettingsResult,
    {},
    BatchError
  >;

  @summary("Gets the Remote Desktop Protocol file for the specified Compute Node.")
  @doc("""
Before you can access a Compute Node by using the RDP file, you must create a
user Account on the Compute Node. This API can only be invoked on Pools created
with a cloud service configuration. For Pools created with a virtual machine
configuration, see the GetRemoteLoginSettings API.
""")
  @route("/pools/{poolId}/nodes/{nodeId}/rdp")
  @get
  getNodeRemoteDesktopFile is RpcOperation<
    BatchClientRequestHeaders & {
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
    BatchResponseHeaders & {
      @body
      @doc("A response containing the file content.")
      file: bytes;
    },
    {},
    BatchError
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
  @post
  uploadNodeLogs is RpcOperation<
    BatchClientRequestHeaders & {
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
      body: UploadBatchServiceLogsOptions;
    },
    BatchClientResponseHeaders & UploadBatchServiceLogsResult,
    {},
    BatchError
  >;

  @summary("Lists the Compute Nodes in the specified Pool.")
  @doc("Lists the Compute Nodes in the specified Pool.")
  @route("/pools/{poolId}/nodes")
  @get
  listNodes is RpcOperation<
    BatchApplicationListHeaders & {
      @doc("The ID of the Pool from which you want to list Compute Nodes.")
      @path
      poolId: string;

      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-nodes-in-a-pool.
""")
      @query
      $filter?: string;

      @doc("An OData $select clause.")
      @query({ format: "csv" })
      $select?: string[];
    },
    BatchResponseHeaders & BatchNodeListResult,
    {},
    BatchError
  >;

  @summary("Gets information about the specified Compute Node Extension.")
  @doc("Gets information about the specified Compute Node Extension.")
  @route("/pools/{poolId}/nodes/{nodeId}/extensions/{extensionName}")
  @get
  getNodeExtension is RpcOperation<
    BatchClientRequestHeaders & {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node that contains the extensions.")
      @path
      nodeId: string;

      @doc("""
The name of the of the Compute Node Extension that you want to get information
about.
""")
      @path
      extensionName: string;

      @doc("An OData $select clause.")
      @query({
        format: "csv",
      })
      $select?: string[];
    },
    BatchResponseHeaders & NodeVMExtension,
    {},
    BatchError
  >;

  @summary("Lists the Compute Nodes Extensions in the specified Pool.")
  @doc("Lists the Compute Nodes Extensions in the specified Pool.")
  @route("/pools/{poolId}/nodes/{nodeId}/extensions")
  @get
  listNodeExtensions(
    ...BatchApplicationListHeaders,

    @doc("The ID of the Pool that contains Compute Node.")
    @path
    poolId: string,

    @doc("The ID of the Compute Node that you want to list extensions.")
    @path
    nodeId: string,

    @doc("An OData $select clause.")
    @query({
      format: "csv",
    })
    $select?: string[]
  ): (BatchResponseHeaders & NodeVMExtensionList) | BatchError;

  @summary("Deletes the specified file from the Compute Node.")
  @doc("Deletes the specified file from the Compute Node.")
  @route("/pools/{poolId}/nodes/{nodeId}/files/{filePath}")
  @delete
  deleteNodeFile is RpcOperation<
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
    },
    {},
    BatchError
  >;

  @doc("Returns the content of the specified Compute Node file.")
  @route("/pools/{poolId}/nodes/{nodeId}/files/{filePath}")
  @get
  getNodeFile is RpcOperation<
    BatchNodeFileClientPathParameters &
      BatchModifiedSinceHeaders & {
        @doc("""
The byte range to be retrieved. The default is to retrieve the entire file. The
format is bytes=startRange-endRange.
""")
        @header
        `ocp-range`?: string;
      },
    BatchResponseHeaders &
      FileResponse & {
        @body
        @doc("A response containing the file content.")
        file: bytes;
      },
    {},
    BatchError
  >;

  @doc("Gets the properties of the specified Compute Node file.")
  @route("/pools/{poolId}/nodes/{nodeId}/files/{filePath}")
  @head
  getNodeFileProperties is RpcOperation<
    BatchNodeFileClientPathParameters & BatchModifiedSinceHeaders,
    BatchResponseHeaders & FileResponse,
    {},
    BatchError
  >;

  @summary("Lists all of the files in Task directories on the specified Compute Node.")
  @doc("Lists all of the files in Task directories on the specified Compute Node.")
  @route("/pools/{poolId}/nodes/{nodeId}/files")
  @get
  listNodeFiles is RpcOperation<
    BatchApplicationListHeaders & {
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
      $filter?: string;

      @doc("Whether to list children of a directory.")
      @query
      recursive?: boolean;
    },
    BatchResponseHeaders & NodeFileListResult,
    {},
    BatchError
  >;
}

// headers ////////////////////

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
@doc("The request to the Batch service was successful.")
model PoolRemoveNodesResponseHeaders {
  ...BatchResponseHeaders;

  @doc("A process exit code.")
  @statusCode
  code: "202";

  @doc("The OData ID of the resource to which the request applied")
  @header("DataServiceId")
  DataServiceId: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
@doc("The request to the Batch service was successful.")
model PoolUpdatePropertiesResponseHeaders {
  ...BatchResponseHeaders;

  @doc("A process exit code.")
  @statusCode
  code: "204";

  @doc("The OData ID of the resource to which the request applied")
  @header("DataServiceId")
  DataServiceId: string;
}

alias PoolStopResizeResponseHeaders = PoolResizeResponseHeaders;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
@doc("The request to the Batch service was successful.")
model PoolResizeResponseHeaders {
  ...BatchResponseHeaders;

  @doc("A process exit code.")
  @statusCode
  code: "202";

  @doc("The OData ID of the resource to which the request applied")
  @header("DataServiceId")
  DataServiceId: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
@doc("Common header values for pool requests")
model FileResponse {
  @doc("A process exit code.")
  @statusCode
  code: "200";

  @header
  @doc("The file creation time.")
  @encode(DateTimeKnownEncoding.rfc7231)
  `ocp-creation-time`?: utcDateTime;

  @header
  @doc("Whether the object represents a directory.")
  `ocp-batch-file-isdirectory`: boolean;

  @header
  @doc("The URL of the file.")
  `ocp-batch-file-url`: string;

  @header
  @doc("The file mode attribute in octal format.")
  `ocp-batch-file-mode`: string;

  @header
  @doc("The length of the file.")
  `Content-Length`: int64;
}

/////////////////////////////////////  Headers models ///////////////////////////////////

@doc("Common header values for pool requests")
model BatchPoolHeaders extends BatchMatchHeaders {
  @doc("The ID of the Pool to get.")
  @path
  poolId: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
@doc("Common header values for pool requests")
model BatchMatchHeaders extends BatchModifiedSinceHeaders {
  @doc("""
An ETag value associated with the version of the resource known to the client.
The operation will be performed only if the resource's current ETag on the
service exactly matches the value specified by the client.
""")
  @header
  @projectedName("python", "if__match")
  `If-Match`?: string;

  @doc("""
An ETag value associated with the version of the resource known to the client.
The operation will be performed only if the resource's current ETag on the
service does not match the value specified by the client.
""")
  @header
  @projectedName("python", "if_none_match")
  `If-None-Match`?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
@doc("Common header values for modified headers")
model BatchModifiedSinceHeaders {
  @doc("""
A timestamp indicating the last modified time of the resource known to the
client. The operation will be performed only if the resource on the service has
been modified since the specified time.
""")
  @header
  @encode(DateTimeKnownEncoding.rfc7231)
  @projectedName("python", "if_modified_since")
  `If-Modified-Since`?: utcDateTime;

  @doc("""
A timestamp indicating the last modified time of the resource known to the
client. The operation will be performed only if the resource on the service has
not been modified since the specified time.
""")
  @header
  @encode(DateTimeKnownEncoding.rfc7231)
  @projectedName("python", "if_unmodified_since")
  `If-Unmodified-Since`?: utcDateTime;
}

// This is the standard set of headers that most of batch apis return
alias BatchResponseHeaders = BatchClientResponseHeaders &
  BatchEtagResponseHeaders;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
@doc("Etag related response header values")
model BatchEtagResponseHeaders {
  @doc("The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Modified-Since, If-Unmodified-Since, If-Match or If-None-Match headers.")
  @header
  @projectedName("python", "etag")
  ETag?: string;

  @doc("The time at which the resource was last modified.")
  @header
  @encode(DateTimeKnownEncoding.rfc7231)
  `Last-Modified`?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
@doc("Client related response header values")
model BatchClientResponseHeaders {
  @doc("The client-request-id provided by the client during the request. This will be returned only if the return-client-request-id parameter was set to true.")
  @header
  `client-request-id`?: string;

  @doc("A unique identifier for the request that was made to the Batch service. If a request is consistently failing and you have verified that the request is properly formulated, you may use this value to report the error to Microsoft. In your report, include the value of this request ID, the approximate time that the request was made, the Batch Account against which the request was made, and the region that Account resides in.")
  @header
  `request-id`?: string;
}

@doc("A response containing headers related to the Pool, if it exists.")
model PoolDoesExistResponseHeaders {
  ...BatchResponseHeaders;

  @doc("A process exit code.")
  @statusCode
  code: "200";
}

@doc("The Pool does not exist.")
model PoolDoesntExistResponseHeaders {
  @doc("A process exit code.")
  @statusCode
  code: "404";
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
@doc("The parameters for a widget status request")
model DeleteResponseHeaders {
  @doc("A process exit code.")
  @statusCode
  code: "202";

  @doc("The client-request-id provided by the client during the request. This will be returned only if the return-client-request-id parameter was set to true.")
  @header
  `client-request-id`?: string;

  @doc("A unique identifier for the request that was made to the Batch service. If a request is consistently failing and you have verified that the request is properly formulated, you may use this value to report the error to Microsoft. In your report, include the value of this request ID, the approximate time that the request was made, the Batch Account against which the request was made, and the region that Account resides in.")
  @header
  `request-id`?: string;
}

@doc("The parameters for a widget status request")
model BatchApplicationListHeaders extends BatchClientRequestHeaders {
  @doc("""
The maximum number of items to return in the response. A maximum of 1000
applications can be returned.
""")
  @query
  @minValue(1)
  @maxValue(1000)
  maxresults?: int32 = 1000;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
  @doc("""
The time the request was issued. Client libraries typically set this to the
current system clock time; set it explicitly if you are calling the REST API
directly.
""")
  @header
  @encode(DateTimeKnownEncoding.rfc7231)
  `ocp-date`?: utcDateTime;
}

@doc("Common path parms for Node related File operartions")
model BatchNodeFileClientPathParameters extends BatchClientRequestHeaders {
  @doc("The ID of the Pool that contains the Compute Node.")
  @path
  poolId: string;

  @doc("The ID of the Compute Node from which you want to delete the file.")
  @path
  nodeId: string;

  @doc("The path to the file or directory that you want to delete.")
  @path
  filePath: string;
}

@doc("Common path parms for Task related File operartions")
model BatchTaskFileClientPathParameters extends BatchClientRequestHeaders {
  @doc("The ID of the Job that contains the Task.")
  @path
  jobId: string;

  @doc("The ID of the Task whose file you want to retrieve.")
  @path
  taskId: string;

  @doc("The path to the Task file that you want to get the content of.")
  @path
  filePath: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use camelCase"
@doc("The parameters for a widget status request")
model BatchClientRequestHeaders {
  @doc("""
The maximum number of items to return in the response. A maximum of 1000
applications can be returned.
""")
  @query
  @projectedName("client", "timeOutInSeconds")
  timeOut?: int32 = 30;

  @doc("""
The caller-generated request identity, in the form of a GUID with no decoration
such as curly braces, e.g. 9C4D50EE-2D56-4CD3-8152-34347DC9F2B0.
""")
  @header
  `client-request-id`?: string;

  @doc("Whether the server should return the client-request-id in the response.")
  @header
  `return-client-request-id`?: boolean = false;

  @doc("""
The time the request was issued. Client libraries typically set this to the
current system clock time; set it explicitly if you are calling the REST API
directly.
""")
  @header
  @encode(DateTimeKnownEncoding.rfc7231)
  `ocp-date`?: utcDateTime;
}
