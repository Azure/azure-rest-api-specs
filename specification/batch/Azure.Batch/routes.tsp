import "@typespec/versioning";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "./models.tsp";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

namespace Azure.Batch;

// Interfaces ////////////////////

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@tag("Applications")
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
  @clientName("listApplicationsInternal", "java")
  listApplications is ListOperation<{}, BatchApplicationListResult>;

  @summary("Gets information about the specified Application.")
  @doc("""
    This operation returns only Applications and versions that are available for
    use on Compute Nodes; that is, that can be used in an Package reference. For
    administrator information about Applications and versions that are not yet
    available to Compute Nodes, use the Azure portal or the Azure Resource Manager
    API.
    """)
  @route("/applications/{applicationId}")
  @clientName("getApplicationInternal", "java")
  getApplication is ReadOperation<
    {
      @doc("The ID of the Application")
      @path
      applicationId: string;
    },
    BatchApplication
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-response-body" ""
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
#suppress "@azure-tools/typespec-azure-core/no-error-status-codes" ""
@tag("Pools")
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
  @clientName("listPoolUsageMetricsInternal", "java")
  listPoolUsageMetrics is ListOperation<
    {
      @doc("""
        The earliest time from which to include metrics. This must be at least two and
        a half hours before the current time. If not specified this defaults to the
        start time of the last aggregation interval currently available.
        """)
      @query
      @clientName("starttime", "!autorest")
      startTime?: utcDateTime;

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
      @clientName("filter", "!autorest")
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
  @clientName("createPoolInternal", "java")
  createPool is CreateOperation<
    {
      @bodyRoot
      @doc("The Pool to be created.")
      pool: BatchPoolCreateContent;
    },
    {}
  >;

  @summary("Lists all of the Pools in the specified Account.")
  @doc("Lists all of the Pools in the specified Account.")
  @route("/pools")
  @clientName("listPoolsInternal", "java")
  listPools is ListOperation<
    {
      @doc("""
        An OData $filter clause. For more information on constructing this filter, see
        https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-pools.
        """)
      @query
      @clientName("filter", "!autorest")
      $filter?: string;

      @doc("An OData $select clause.")
      @query
      @clientName("select", "!autorest")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query
      @clientName("expand", "!autorest")
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
  @clientName("deletePoolInternal", "java")
  deletePool is DeleteOperation<BatchPoolHeaders, DeleteResponseHeaders>;

  @doc("Gets basic properties of a Pool.")
  @route("/pools/{poolId}")
  @clientName("poolExistsInternal", "java")
  poolExists is ResourceInfoOperationWithAdditionalResponse<
    BatchClientRequestHeaders & BatchPoolHeaders,
    PoolDoesNotExistResponseHeaders,
    PoolDoesExistResponseHeaders
  >;

  @doc("Gets information about the specified Pool.")
  @route("/pools/{poolId}")
  @clientName("getPoolInternal", "java")
  getPool is ReadOperation<
    BatchPoolHeaders & {
      @doc("An OData $select clause.")
      @query
      @clientName("select", "!autorest")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query
      @clientName("expand", "!autorest")
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
  @clientName("updatePoolInternal", "java")
  updatePool is UpdateOperation<
    BatchPoolHeaders & {
      @doc("The pool properties to update.")
      @bodyRoot
      pool: BatchPoolUpdateContent;
    },
    RequestSuccessResponseHeaders
  >;

  @summary("Disables automatic scaling for a Pool.")
  @doc("Disables automatic scaling for a Pool.")
  @route("/pools/{poolId}/disableautoscale")
  @clientName("disablePoolAutoScaleInternal", "java")
  disablePoolAutoScale is PostOperation<
    {
      @doc("The ID of the Pool on which to disable automatic scaling.")
      @path
      poolId: string;
    },
    RequestSuccessResponseHeaders
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
  @clientName("enablePoolAutoScaleInternal", "java")
  enablePoolAutoScale is PostOperation<
    BatchPoolHeaders &
      MinimalMetadata & {
        @doc("The options to use for enabling automatic scaling.")
        @bodyRoot
        content: BatchPoolEnableAutoScaleContent;
      },
    RequestSuccessResponseHeaders
  >;

  @summary("Gets the result of evaluating an automatic scaling formula on the Pool.")
  @doc("""
    This API is primarily for validating an autoscale formula, as it simply returns
    the result without applying the formula to the Pool. The Pool must have auto
    scaling enabled in order to evaluate a formula.
    """)
  @route("/pools/{poolId}/evaluateautoscale")
  @clientName("evaluatePoolAutoScaleInternal", "java")
  evaluatePoolAutoScale is PostOperation<
    MinimalMetadata & {
      @doc("The ID of the Pool on which to evaluate the automatic scaling formula.")
      @path
      poolId: string;

      @doc("The options to use for evaluating the automatic scaling formula.")
      @bodyRoot
      content: BatchPoolEvaluateAutoScaleContent;
    },
    AutoScaleRun & RequestSuccessResponseHeaders
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
  @clientName("resizePoolInternal", "java")
  resizePool is PostOperation<
    BatchPoolHeaders &
      MinimalMetadata & {
        @doc("The options to use for resizing the pool.")
        @bodyRoot
        content: BatchPoolResizeContent;
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
  @clientName("stopPoolResizeInternal", "java")
  stopPoolResize is PostOperation<
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
  @clientName("replacePoolPropertiesInternal", "java")
  replacePoolProperties is PostOperation<
    MinimalMetadata & {
      @doc("The ID of the Pool to update.")
      @path
      poolId: string;

      @doc("The options to use for replacing properties on the pool.")
      @bodyRoot
      pool: BatchPoolReplaceContent;
    },
    NoContentSuccessResponseHeaders
  >;

  @summary("Removes Compute Nodes from the specified Pool.")
  @doc("""
    This operation can only run when the allocation state of the Pool is steady.
    When this operation runs, the allocation state changes from steady to resizing.
    Each request may remove up to 100 nodes.
    """)
  @route("/pools/{poolId}/removenodes")
  @clientName("removeNodesInternal", "java")
  removeNodes is PostOperation<
    BatchPoolHeaders &
      MinimalMetadata & {
        @doc("The options to use for removing the node.")
        @bodyRoot
        content: BatchNodeRemoveContent;
      },
    AcceptedProcessingResponseHeaders
  >;

  @summary("Lists all Virtual Machine Images supported by the Azure Batch service.")
  @doc("Lists all Virtual Machine Images supported by the Azure Batch service.")
  @route("/supportedimages")
  @clientName("listSupportedImagesInternal", "java")
  listSupportedImages is ListOperation<
    {
      @doc("""
        An OData $filter clause. For more information on constructing this filter, see
        https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-support-images.
        """)
      @query
      @clientName("filter", "!autorest")
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
  @clientName("listPoolNodeCountsInternal", "java")
  listPoolNodeCounts is ListOperation<
    {
      @doc("""
        An OData $filter clause. For more information on constructing this filter, see
        https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-support-images.
        """)
      @query
      @clientName("filter", "!autorest")
      $filter?: string;
    },
    BatchPoolNodeCountsListResult
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
#suppress "@azure-tools/typespec-azure-core/no-response-body" ""
@tag("Jobs")
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
  @clientName("deleteJobInternal", "java")
  deleteJob is DeleteOperation<
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
  @clientName("getJobInternal", "java")
  getJob is ReadOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job.")
      @path
      jobId: string;

      @doc("An OData $select clause.")
      @query
      @clientName("select", "!autorest")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query
      @clientName("expand", "!autorest")
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
  @clientName("updateJobInternal", "java")
  updateJob is UpdateOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job whose properties you want to update.")
      @path
      jobId: string;

      @doc("The options to use for updating the Job.")
      @bodyRoot
      job: BatchJobUpdateContent;
    },
    RequestSuccessResponseHeaders
  >;

  @summary("Updates the properties of the specified Job.")
  @doc("""
    This fully replaces all the updatable properties of the Job. For example, if
    the Job has constraints associated with it and if constraints is not specified
    with this request, then the Batch service will remove the existing constraints.
    """)
  @route("/jobs/{jobId}")
  @clientName("replaceJobInternal", "java")
  replaceJob is ReplaceOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job whose properties you want to update.")
      @path
      jobId: string;

      @doc("A job with updated properties")
      @bodyRoot
      job: BatchJob;
    },
    RequestSuccessResponseHeaders
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
  @clientName("disableJobInternal", "java")
  disableJob is PostOperation<
    BatchMatchHeaders &
      MinimalMetadata & {
        @doc("The ID of the Job to disable.")
        @path
        jobId: string;

        @doc("The options to use for disabling the Job.")
        @bodyRoot
        content: BatchJobDisableContent;
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
  @clientName("enableJobInternal", "java")
  enableJob is PostOperation<
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
  @clientName("terminateJobInternal", "java")
  terminateJob is PostOperation<
    BatchMatchHeaders &
      MinimalMetadata & {
        @doc("The ID of the Job to terminate.")
        @path
        jobId: string;

        @doc("The options to use for terminating the Job.")
        @bodyRoot
        parameters?: BatchJobTerminateContent;
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
  @clientName("createJobInternal", "java")
  createJob is CreateOperation<
    {
      @doc("The Job to be created.")
      @bodyRoot
      job: BatchJobCreateContent;
    },
    {}
  >;

  @summary("Lists all of the Jobs in the specified Account.")
  @doc("Lists all of the Jobs in the specified Account.")
  @route("/jobs")
  @clientName("listJobsInternal", "java")
  listJobs is ListOperation<
    {
      @doc("""
        An OData $filter clause. For more information on constructing this filter, see
        https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-jobs.
        """)
      @query
      @clientName("filter", "!autorest")
      $filter?: string;

      @doc("An OData $select clause.")
      @query
      @clientName("select", "!autorest")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query
      @clientName("expand", "!autorest")
      $expand?: string[];
    },
    BatchJobListResult
  >;

  @summary("Lists the Jobs that have been created under the specified Job Schedule.")
  @doc("Lists the Jobs that have been created under the specified Job Schedule.")
  @route("/jobschedules/{jobScheduleId}/jobs")
  @clientName("listJobsFromScheduleInternal", "java")
  listJobsFromSchedule is ListOperation<
    {
      @doc("The ID of the Job Schedule from which you want to get a list of Jobs.")
      @path
      jobScheduleId: string;

      @doc("""
        An OData $filter clause. For more information on constructing this filter, see
        https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-jobs-in-a-job-schedule.
        """)
      @query
      @clientName("filter", "!autorest")
      $filter?: string;

      @doc("An OData $select clause.")
      @query
      @clientName("select", "!autorest")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query
      @clientName("expand", "!autorest")
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
  @clientName("listJobPreparationAndReleaseTaskStatusInternal", "java")
  listJobPreparationAndReleaseTaskStatus is ListOperation<
    {
      @doc("The ID of the Job.")
      @path
      jobId: string;

      @doc("""
        An OData $filter clause. For more information on constructing this filter, see
        https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-job-preparation-and-release-status.
        """)
      @query
      @clientName("filter", "!autorest")
      $filter?: string;

      @doc("An OData $select clause.")
      @query
      @clientName("select", "!autorest")
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
  @clientName("getJobTaskCountsInternal", "java")
  getJobTaskCounts is ReadOperation<
    {
      @doc("The ID of the Job.")
      @path
      jobId: string;
    },
    BatchTaskCountsResult
  >;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
#suppress "@azure-tools/typespec-azure-core/no-response-body" ""
#suppress "@azure-tools/typespec-azure-core/no-error-status-codes" ""
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@tag("Job Schedules")
interface JobSchedules {
  @summary("Checks the specified Job Schedule exists.")
  @doc("Checks the specified Job Schedule exists.")
  @route("/jobschedules/{jobScheduleId}")
  @clientName("jobScheduleExistsInternal", "java")
  jobScheduleExists is ResourceInfoOperationWithAdditionalResponse<
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
  @clientName("deleteJobScheduleInternal", "java")
  deleteJobSchedule is DeleteOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job Schedule to delete.")
      @path
      jobScheduleId: string;
    },
    DeleteResponseHeaders
  >;

  @doc("Gets information about the specified Job Schedule.")
  @route("/jobschedules/{jobScheduleId}")
  @clientName("getJobScheduleInternal", "java")
  getJobSchedule is ReadOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job Schedule to get.")
      @path
      jobScheduleId: string;

      @doc("An OData $select clause.")
      @query
      @clientName("select", "!autorest")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query
      @clientName("expand", "!autorest")
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
  @clientName("updateJobScheduleInternal", "java")
  updateJobSchedule is UpdateOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job Schedule to update.")
      @path
      jobScheduleId: string;

      @doc("The options to use for updating the Job Schedule.")
      @bodyRoot
      jobSchedule: BatchJobScheduleUpdateContent;
    },
    RequestSuccessResponseHeaders
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
  @clientName("replaceJobScheduleInternal", "java")
  replaceJobSchedule is ReplaceOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job Schedule to update.")
      @path
      jobScheduleId: string;

      @doc("A Job Schedule with updated properties")
      @bodyRoot
      jobSchedule: BatchJobSchedule;
    },
    RequestSuccessResponseHeaders
  >;

  @summary("Disables a Job Schedule.")
  @doc("No new Jobs will be created until the Job Schedule is enabled again.")
  @route("/jobschedules/{jobScheduleId}/disable")
  @clientName("disableJobScheduleInternal", "java")
  disableJobSchedule is PostOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job Schedule to disable.")
      @path
      jobScheduleId: string;
    },
    NoContentSuccessResponseHeaders
  >;

  @summary("Enables a Job Schedule.")
  @doc("Enables a Job Schedule.")
  @route("/jobschedules/{jobScheduleId}/enable")
  @clientName("enableJobScheduleInternal", "java")
  enableJobSchedule is PostOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job Schedule to enable.")
      @path
      jobScheduleId: string;
    },
    NoContentSuccessResponseHeaders
  >;

  @summary("Terminates a Job Schedule.")
  @doc("Terminates a Job Schedule.")
  @route("/jobschedules/{jobScheduleId}/terminate")
  @clientName("terminateJobScheduleInternal", "java")
  terminateJobSchedule is PostOperation<
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
  @clientName("createJobScheduleInternal", "java")
  createJobSchedule is CreateOperation<
    {
      @doc("The Job Schedule to be created.")
      @bodyRoot
      jobSchedule: BatchJobScheduleCreateContent;
    },
    {}
  >;

  @summary("Lists all of the Job Schedules in the specified Account.")
  @doc("Lists all of the Job Schedules in the specified Account.")
  @route("/jobschedules")
  @clientName("listJobSchedulesInternal", "java")
  listJobSchedules is ListOperation<
    {
      @doc("""
        An OData $filter clause. For more information on constructing this filter, see
        https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-job-schedules.
        """)
      @query
      @clientName("filter", "!autorest")
      $filter?: string;

      @doc("An OData $select clause.")
      @query
      @clientName("select", "!autorest")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query
      @clientName("expand", "!autorest")
      $expand?: string[];
    },
    BatchJobScheduleListResult
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
#suppress "@azure-tools/typespec-azure-core/no-response-body" ""
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@tag("Tasks")
interface Tasks {
  @summary("Creates a Task to the specified Job.")
  @doc("""
    The maximum lifetime of a Task from addition to completion is 180 days. If a
    Task has not completed within 180 days of being added it will be terminated by
    the Batch service and left in whatever state it was in at that time.
    """)
  @route("/jobs/{jobId}/tasks")
  @clientName("createTaskInternal", "java")
  createTask is CreateOperation<
    {
      @doc("The ID of the Job to which the Task is to be created.")
      @path
      jobId: string;

      @doc("The Task to be created.")
      @bodyRoot
      task: BatchTaskCreateContent;
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
  @clientName("listTasksInternal", "java")
  listTasks is ListOperation<
    {
      @doc("The ID of the Job.")
      @path
      jobId: string;

      @doc("""
        An OData $filter clause. For more information on constructing this filter, see
        https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-tasks.
        """)
      @query
      @clientName("filter", "!autorest")
      $filter?: string;

      @doc("An OData $select clause.")
      @query
      @clientName("select", "!autorest")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query
      @clientName("expand", "!autorest")
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
  @clientName("createTaskCollectionInternal", "java")
  createTaskCollection is PostOperation<
    MinimalMetadata & {
      @doc("The ID of the Job to which the Task collection is to be added.")
      @path
      jobId: string;

      @doc("The Tasks to be added.")
      @bodyRoot
      taskCollection: BatchTaskGroup;
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
  @clientName("deleteTaskInternal", "java")
  deleteTask is DeleteOperation<
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
  @clientName("getTaskInternal", "java")
  getTask is ReadOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job that contains the Task.")
      @path
      jobId: string;

      @doc("The ID of the Task to get information about.")
      @path
      taskId: string;

      @doc("An OData $select clause.")
      @query
      @clientName("select", "!autorest")
      $select?: string[];

      @doc("An OData $expand clause.")
      @query
      @clientName("expand", "!autorest")
      $expand?: string[];
    },
    BatchTask & DataServiceResponseHeaders
  >;

  @doc("Updates the properties of the specified Task.")
  @route("/jobs/{jobId}/tasks/{taskId}")
  @clientName("replaceTaskInternal", "java")
  replaceTask is ReplaceOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job containing the Task.")
      @path
      jobId: string;

      @doc("The ID of the Task to update.")
      @path
      taskId: string;

      @doc("The Task to update.")
      @bodyRoot
      task: BatchTask;
    },
    RequestSuccessResponseHeaders
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "GET operations that return single objects should start with 'get'"
  @summary("""
    Lists all of the subtasks that are associated with the specified multi-instance
    Task.
    """)
  @doc("If the Task is not a multi-instance Task then this returns an empty collection.")
  @route("/jobs/{jobId}/tasks/{taskId}/subtasksinfo")
  @clientName("listSubTasksInternal", "java")
  listSubTasks is ReadOperation<
    {
      @doc("The ID of the Job.")
      @path
      jobId: string;

      @doc("The ID of the Task.")
      @path
      taskId: string;

      @doc("An OData $select clause.")
      @query
      @clientName("select", "!autorest")
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
  @clientName("terminateTaskInternal", "java")
  terminateTask is PostOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job containing the Task.")
      @path
      jobId: string;

      @doc("The ID of the Task to terminate.")
      @path
      taskId: string;
    },
    NoContentResponse & DataServiceResponseHeaders
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
  @clientName("reactivateTaskInternal", "java")
  reactivateTask is PostOperation<
    BatchMatchHeaders & {
      @doc("The ID of the Job containing the Task.")
      @path
      jobId: string;

      @doc("The ID of the Task to reactivate.")
      @path
      taskId: string;
    },
    NoContentResponse & DataServiceResponseHeaders
  >;

  @summary("Deletes the specified Task file from the Compute Node where the Task ran.")
  @doc("Deletes the specified Task file from the Compute Node where the Task ran.")
  @route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
  @clientName("deleteTaskFileInternal", "java")
  deleteTaskFile is DeleteOperation<
    BatchTaskFileClientPathContent & {
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
  @clientName("getTaskFileInternal", "java")
  getTaskFile is FileOperation<
    BatchTaskFileClientPathContent &
      BatchModifiedSinceHeaders & {
        @doc("""
          The byte range to be retrieved. The default is to retrieve the entire file. The
          format is bytes=startRange-endRange.
          """)
        @header
        `ocp-range`?: string;
      },
    {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/octet-stream";

      @bodyRoot
      @doc("A response containing the file content.")
      file: bytes;
    }
  >;

  @doc("Gets the properties of the specified Task file.")
  @route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
  @clientName("getTaskFilePropertiesInternal", "java")
  @clientName("getTaskFilePropertiesInternal", "csharp")
  getTaskFileProperties is HeadFileOperation<
    BatchTaskFileClientPathContent & BatchModifiedSinceHeaders,
    {}
  >;

  @summary("Lists the files in a Task's directory on its Compute Node.")
  @doc("Lists the files in a Task's directory on its Compute Node.")
  @route("/jobs/{jobId}/tasks/{taskId}/files")
  @clientName("listTaskFilesInternal", "java")
  listTaskFiles is ListOperation<
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
      @clientName("filter", "!autorest")
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
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
#suppress "@azure-tools/typespec-azure-core/no-response-body" ""
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@tag("Nodes")
interface Nodes {
  @summary("Adds a user Account to the specified Compute Node.")
  @doc("""
    You can add a user Account to a Compute Node only when it is in the idle or
    running state.
    """)
  @route("/pools/{poolId}/nodes/{nodeId}/users")
  @clientName("createNodeUserInternal", "java")
  createNodeUser is CreateOperation<
    {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the machine on which you want to create a user Account.")
      @path
      nodeId: string;

      @doc("The options to use for creating the user.")
      @bodyRoot
      user: BatchNodeUserCreateContent;
    },
    {}
  >;

  @summary("Deletes a user Account from the specified Compute Node.")
  @doc("""
    You can delete a user Account to a Compute Node only when it is in the idle or
    running state.
    """)
  @route("/pools/{poolId}/nodes/{nodeId}/users/{userName}")
  @clientName("deleteNodeUserInternal", "java")
  deleteNodeUser is DeleteOperation<
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
  @clientName("replaceNodeUserInternal", "java")
  replaceNodeUser is ReplaceOperation<
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
      @bodyRoot
      content: BatchNodeUserUpdateContent;
    },
    RequestSuccessResponseHeaders
  >;

  @summary("Gets information about the specified Compute Node.")
  @doc("Gets information about the specified Compute Node.")
  @route("/pools/{poolId}/nodes/{nodeId}")
  @clientName("getNodeInternal", "java")
  getNode is ReadOperation<
    {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node that you want to get information about.")
      @path
      nodeId: string;

      @doc("An OData $select clause.")
      @query
      @clientName("select", "!autorest")
      $select?: string[];
    },
    BatchNode
  >;

  @summary("Restarts the specified Compute Node.")
  @doc("You can restart a Compute Node only if it is in an idle or running state.")
  @route("/pools/{poolId}/nodes/{nodeId}/reboot")
  @clientName("rebootNodeInternal", "java")
  rebootNode is PostOperation<
    MinimalMetadata & {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node that you want to restart.")
      @path
      nodeId: string;

      @doc("The options to use for rebooting the Compute Node.")
      @bodyRoot
      parameters?: BatchNodeRebootContent;
    },
    AcceptedProcessingResponseHeaders
  >;

  @summary("Disables Task scheduling on the specified Compute Node.")
  @doc("""
    You can disable Task scheduling on a Compute Node only if its current
    scheduling state is enabled.
    """)
  @route("/pools/{poolId}/nodes/{nodeId}/disablescheduling")
  @clientName("disableNodeSchedulingInternal", "java")
  disableNodeScheduling is PostOperation<
    MinimalMetadata & {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node on which you want to disable Task scheduling.")
      @path
      nodeId: string;

      @doc("The options to use for disabling scheduling on the Compute Node.")
      @bodyRoot
      parameters?: BatchNodeDisableSchedulingContent;
    },
    RequestSuccessResponseHeaders
  >;

  @summary("Enables Task scheduling on the specified Compute Node.")
  @doc("""
    You can enable Task scheduling on a Compute Node only if its current scheduling
    state is disabled
    """)
  @route("/pools/{poolId}/nodes/{nodeId}/enablescheduling")
  @clientName("enableNodeSchedulingInternal", "java")
  enableNodeScheduling is PostOperation<
    {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node on which you want to enable Task scheduling.")
      @path
      nodeId: string;
    },
    RequestSuccessResponseHeaders
  >;

  @summary("Gets the settings required for remote login to a Compute Node.")
  @doc("""
    Before you can remotely login to a Compute Node using the remote login
    settings, you must create a user Account on the Compute Node. This API can be
    invoked only on Pools created with the virtual machine configuration property.
    """)
  @route("/pools/{poolId}/nodes/{nodeId}/remoteloginsettings")
  @clientName("getNodeRemoteLoginSettingsInternal", "java")
  getNodeRemoteLoginSettings is ReadOperation<
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
  @clientName("uploadNodeLogsInternal", "java")
  uploadNodeLogs is PostOperation<
    MinimalMetadata & {
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
      @bodyRoot
      content: UploadBatchServiceLogsContent;
    },
    UploadBatchServiceLogsResult
  >;

  @summary("Lists the Compute Nodes in the specified Pool.")
  @doc("Lists the Compute Nodes in the specified Pool.")
  @route("/pools/{poolId}/nodes")
  @clientName("listNodesInternal", "java")
  listNodes is ListOperation<
    {
      @doc("The ID of the Pool from which you want to list Compute Nodes.")
      @path
      poolId: string;

      @doc("""
        An OData $filter clause. For more information on constructing this filter, see
        https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-nodes-in-a-pool.
        """)
      @query
      @clientName("filter", "!autorest")
      $filter?: string;

      @doc("An OData $select clause.")
      @query
      @clientName("select", "!autorest")
      $select?: string[];
    },
    BatchNodeListResult
  >;

  @summary("Gets information about the specified Compute Node Extension.")
  @doc("Gets information about the specified Compute Node Extension.")
  @route("/pools/{poolId}/nodes/{nodeId}/extensions/{extensionName}")
  @clientName("getNodeExtensionInternal", "java")
  getNodeExtension is ReadOperation<
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
      @query
      @clientName("select", "!autorest")
      $select?: string[];
    },
    BatchNodeVMExtension
  >;

  @summary("Lists the Compute Nodes Extensions in the specified Pool.")
  @doc("Lists the Compute Nodes Extensions in the specified Pool.")
  @route("/pools/{poolId}/nodes/{nodeId}/extensions")
  @clientName("listNodeExtensionsInternal", "java")
  listNodeExtensions is ListOperation<
    {
      @doc("The ID of the Pool that contains Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node that you want to list extensions.")
      @path
      nodeId: string;

      @doc("An OData $select clause.")
      @query
      @clientName("select", "!autorest")
      $select?: string[];
    },
    BatchNodeVMExtensionListResult
  >;

  @summary("Deletes the specified file from the Compute Node.")
  @doc("Deletes the specified file from the Compute Node.")
  @route("/pools/{poolId}/nodes/{nodeId}/files/{filePath}")
  @clientName("deleteNodeFileInternal", "java")
  deleteNodeFile is DeleteOperation<
    BatchNodeFileClientPathContent & {
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
  @clientName("getNodeFileInternal", "java")
  getNodeFile is FileOperation<
    BatchNodeFileClientPathContent &
      BatchModifiedSinceHeaders & {
        @doc("""
          The byte range to be retrieved. The default is to retrieve the entire file. The
          format is bytes=startRange-endRange.
          """)
        @header
        `ocp-range`?: string;
      },
    {
      @doc("Type of content")
      @header("content-type")
      contentType: "application/octet-stream";

      @bodyRoot
      @doc("A response containing the file content.")
      file: bytes;
    }
  >;

  @doc("Gets the properties of the specified Compute Node file.")
  @route("/pools/{poolId}/nodes/{nodeId}/files/{filePath}")
  @clientName("getNodeFilePropertiesInternal", "java")
  @clientName("getNodeFilePropertiesInternal", "csharp")
  getNodeFileProperties is HeadFileOperation<
    BatchNodeFileClientPathContent & BatchModifiedSinceHeaders,
    {}
  >;

  @summary("Lists all of the files in Task directories on the specified Compute Node.")
  @doc("Lists all of the files in Task directories on the specified Compute Node.")
  @route("/pools/{poolId}/nodes/{nodeId}/files")
  @clientName("listNodeFilesInternal", "java")
  listNodeFiles is ListOperation<
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
      @clientName("filter", "!autorest")
      $filter?: string;

      @doc("Whether to list children of a directory.")
      @query
      recursive?: boolean;
    },
    BatchNodeFileListResult
  >;
}
