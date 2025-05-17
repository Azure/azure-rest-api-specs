import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "./common.tsp";

using TypeSpec.Http;

namespace Azure.Batch;

// Interfaces ////////////////////

// Application Interface
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
  listApplications is ListOperation<
    {
      ...CommonListParameters;
    },
    BatchApplicationListResult
  >;

  @summary("Gets information about the specified Application.")
  @doc("""
    This operation returns only Applications and versions that are available for
    use on Compute Nodes; that is, that can be used in an Package reference. For
    administrator information about Applications and versions that are not yet
    available to Compute Nodes, use the Azure portal or the Azure Resource Manager
    API.
    """)
  @route("/applications/{applicationId}")
  getApplication is ReadOperation<
    {
      ...CommonParameters;
      ...GetApplicationRequiredParameters;
    },
    BatchApplication
  >;
}

// Pool Interface
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
  listPoolUsageMetrics is ListOperation<
    {
      ...CommonListParameters;
      ...ListPoolUsageMetricsOptionalParameters;
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
  createPool is CreateOperation<
    {
      ...CommonJsonParameters;
      ...CreatePoolRequiredParameters;
    },
    {}
  >;

  @summary("Lists all of the Pools which be mounted.")
  @doc("Lists all of the Pools which be mounted.")
  @route("/pools")
  listPools is ListOperation<
    {
      ...CommonListParameters;
      ...ListPoolsOptionalParameters;
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
  deletePool is DeleteOperation<
    {
      ...CommonParameters;
      ...BatchMatchHeaders;
      ...DeletePoolRequiredParameters;
    },
    DeleteResponseHeaders
  >;

  @doc("Gets basic properties of a Pool.")
  @route("/pools/{poolId}")
  poolExists is ResourceInfoOperationWithAdditionalResponse<
    {
      ...CommonParameters;
      ...BatchMatchHeaders;
      ...PoolExistsRequiredParameters;
    },
    PoolDoesNotExistResponseHeaders,
    PoolDoesExistResponseHeaders
  >;

  @doc("Gets information about the specified Pool.")
  @route("/pools/{poolId}")
  getPool is ReadOperation<
    {
      ...CommonParameters;
      ...BatchMatchHeaders;
      ...GetPoolRequiredParameters;
      ...GetPoolOptionalParameters;
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
  updatePool is UpdateOperation<
    {
      ...CommonJsonParameters;
      ...BatchMatchHeaders;
      ...UpdatePoolRequiredParameters;
    },
    RequestSuccessResponseHeaders
  >;

  @summary("Disables automatic scaling for a Pool.")
  @doc("Disables automatic scaling for a Pool.")
  @route("/pools/{poolId}/disableautoscale")
  disablePoolAutoScale is PostOperation<
    {
      ...CommonParameters;
      ...DisablePoolAutoscaleRequiredParameters;
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
  enablePoolAutoScale is PostOperation<
    {
      ...CommonJsonParameters;
      ...BatchMatchHeaders;
      ...EnablePoolAutoscaleRequiredParameters;
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
  evaluatePoolAutoScale is PostOperation<
    {
      ...CommonJsonParameters;
      ...EvaluatePoolAutoScaleRequiredParameters;
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
  resizePool is PostOperation<
    {
      ...CommonJsonParameters;
      ...BatchMatchHeaders;
      ...ResizePoolRequiredParameters;
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
  stopPoolResize is PostOperation<
    {
      ...CommonParameters;
      ...BatchMatchHeaders;
      ...StopPoolResizeRequiredParameters;
    },
    AcceptedProcessingResponseHeaders
  >;

  @summary("Updates the properties of the specified Pool.")
  @doc("""
    This fully replaces all the updatable properties of the Pool. For example, if
    the Pool has a StartTask associated with it and if StartTask is not specified
    with this request, then the Batch service will remove the existing StartTask.
    """)
  @route("/pools/{poolId}/updateproperties")
  replacePoolProperties is PostOperation<
    {
      ...CommonJsonParameters;
      ...ReplacePoolPropertiesRequiredParameters;
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
  removeNodes is PostOperation<
    {
      ...CommonJsonParameters;
      ...BatchMatchHeaders;
      ...RemoveNodesRequiredParameters;
    },
    AcceptedProcessingResponseHeaders
  >;

  @summary("Lists all Virtual Machine Images supported by the Azure Batch service.")
  @doc("Lists all Virtual Machine Images supported by the Azure Batch service.")
  @route("/supportedimages")
  listSupportedImages is ListOperation<
    {
      ...CommonListParameters;
      ...ListSupportedImagesOptionalParameters;
    },
    BatchAccountListSupportedImagesResult
  >;

  @doc("""
    Gets the number of Compute Nodes in each state, grouped by Pool. Note that the
    numbers returned may not always be up to date. If you need exact node counts,
    use a list query.
    """)
  @route("/nodecounts")
  listPoolNodeCounts is ListOperation<
    {
      ...CommonListParameters;
      ...ListPoolNodeCountsOptionalParameters;
    },
    BatchPoolNodeCountsListResult
  >;
}

// Job Interface
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
  deleteJob is DeleteOperation<
    {
      ...CommonParameters;
      ...BatchMatchHeaders;
      ...DeleteJobRequiredParameters;
      ...DeleteJobOptionalParameters;
    },
    DeleteResponseHeaders
  >;

  @summary("Gets information about the specified Job.")
  @doc("Gets information about the specified Job.")
  @route("/jobs/{jobId}")
  getJob is ReadOperation<
    {
      ...CommonParameters;
      ...BatchMatchHeaders;
      ...GetJobRequiredParameters;
      ...GetJobOptionalParameters;
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
  updateJob is UpdateOperation<
    {
      ...CommonJsonParameters;
      ...BatchMatchHeaders;
      ...UpdateJobRequiredParameters;
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
  replaceJob is ReplaceOperation<
    {
      ...CommonJsonParameters;
      ...BatchMatchHeaders;
      ...ReplaceJobRequiredParameters;
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
  disableJob is PostOperation<
    {
      ...CommonJsonParameters;
      ...BatchMatchHeaders;
      ...DisableJobRequiredParameters;
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
  enableJob is PostOperation<
    {
      ...CommonParameters;
      ...BatchMatchHeaders;
      ...EnableJobRequiredParameters;
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
  terminateJob is PostOperation<
    {
      ...CommonJsonParameters;
      ...BatchMatchHeaders;
      ...TerminateJobRequiredParameters;
      ...TerminateJobOptionalParameters;
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
  createJob is CreateOperation<
    {
      ...CommonJsonParameters;
      ...CreateJobRequiredParameters;
    },
    {}
  >;

  @summary("Lists all of the Jobs in the specified Account.")
  @doc("Lists all of the Jobs in the specified Account.")
  @route("/jobs")
  listJobs is ListOperation<
    {
      ...CommonListParameters;
      ...ListJobsOptionalParameters;
    },
    BatchJobListResult
  >;

  @summary("Lists the Jobs that have been created under the specified Job Schedule.")
  @doc("Lists the Jobs that have been created under the specified Job Schedule.")
  @route("/jobschedules/{jobScheduleId}/jobs")
  listJobsFromSchedule is ListOperation<
    {
      ...CommonListParameters;
      ...ListJobsFromScheduleRequiredParameters;
      ...ListJobsFromScheduleOptionalParameters;
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
  listJobPreparationAndReleaseTaskStatus is ListOperation<
    {
      ...CommonListParameters;
      ...ListJobPreparationAndReleaseTaskStatusRequiredParameters;
      ...ListJobPreparationAndReleaseTaskStatusOptionalParameters;
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
  getJobTaskCounts is ReadOperation<
    {
      ...CommonParameters;
      ...GetJobTaskCountsRequiredParameters;
    },
    BatchTaskCountsResult
  >;
}

// Certificate Interface
#suppress "@azure-tools/typespec-azure-core/no-response-body" ""
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@tag("Certificates")
interface Certificates {
  #deprecated "Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead."
  @summary("Creates a Certificate to the specified Account.")
  @doc("Creates a Certificate to the specified Account.")
  @route("/certificates")
  createCertificate is CreateOperation<
    {
      ...CommonJsonParameters;
      ...CreateCertificateRequiredParameters;
    },
    {}
  >;

  #deprecated "Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead."
  @summary("Lists all of the Certificates that have been added to the specified Account.")
  @doc("Lists all of the Certificates that have been added to the specified Account.")
  @route("/certificates")
  listCertificates is ListOperation<
    {
      ...CommonListParameters;
      ...ListCertificatesOptionalParameters;
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
  cancelCertificateDeletion is PostOperation<
    {
      ...CommonParameters;
      ...CancelCertificateDeletionRequiredParameters;
    },
    NoContentSuccessResponseHeaders
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
  deleteCertificate is DeleteOperation<
    {
      ...CommonParameters;
      ...DeleteCertificateRequiredParameters;
    },
    DeleteCertificateResponse
  >;

  #deprecated "Warning: This operation is deprecated and will be removed after February, 2024. Please use the [Azure KeyVault Extension](https://learn.microsoft.com/azure/batch/batch-certificate-migration-guide) instead."
  @doc("Gets information about the specified Certificate.")
  @route("/certificates(thumbprintAlgorithm={thumbprintAlgorithm},thumbprint={thumbprint})")
  getCertificate is ReadOperation<
    {
      ...CommonParameters;
      ...GetCertificateRequiredParameters;
      ...GetCertificateOptionalParameters;
    },
    BatchCertificate
  >;
}

// Job Schedule Interface
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
#suppress "@azure-tools/typespec-azure-core/no-response-body" ""
#suppress "@azure-tools/typespec-azure-core/no-error-status-codes" ""
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@tag("Job Schedules")
interface JobSchedules {
  @summary("Checks the specified Job Schedule exists.")
  @doc("Checks the specified Job Schedule exists.")
  @route("/jobschedules/{jobScheduleId}")
  jobScheduleExists is ResourceInfoOperationWithAdditionalResponse<
    {
      ...CommonParameters;
      ...BatchMatchHeaders;
      ...JobScheduleExistsRequiredParameters;
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
  deleteJobSchedule is DeleteOperation<
    {
      ...CommonParameters;
      ...BatchMatchHeaders;
      ...DeleteJobScheduleRequiredParameters;
      ...DeleteJobScheduleOptionalParameters;
    },
    DeleteResponseHeaders
  >;

  @doc("Gets information about the specified Job Schedule.")
  @route("/jobschedules/{jobScheduleId}")
  getJobSchedule is ReadOperation<
    {
      ...CommonParameters;
      ...BatchMatchHeaders;
      ...GetJobScheduleRequiredParameters;
      ...GetJobScheduleOptionalParameters;
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
  updateJobSchedule is UpdateOperation<
    {
      ...CommonJsonParameters;
      ...BatchMatchHeaders;
      ...UpdateJobScheduleRequiredParameters;
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
  replaceJobSchedule is ReplaceOperation<
    {
      ...CommonJsonParameters;
      ...BatchMatchHeaders;
      ...ReplaceJobScheduleRequiredParameters;
    },
    RequestSuccessResponseHeaders
  >;

  @summary("Disables a Job Schedule.")
  @doc("No new Jobs will be created until the Job Schedule is enabled again.")
  @route("/jobschedules/{jobScheduleId}/disable")
  disableJobSchedule is PostOperation<
    {
      ...CommonParameters;
      ...BatchMatchHeaders;
      ...DisableJobScheduleRequiredParameters;
    },
    NoContentSuccessResponseHeaders
  >;

  @summary("Enables a Job Schedule.")
  @doc("Enables a Job Schedule.")
  @route("/jobschedules/{jobScheduleId}/enable")
  enableJobSchedule is PostOperation<
    {
      ...CommonParameters;
      ...BatchMatchHeaders;
      ...EnableJobScheduleRequiredParameters;
    },
    NoContentSuccessResponseHeaders
  >;

  @summary("Terminates a Job Schedule.")
  @doc("Terminates a Job Schedule.")
  @route("/jobschedules/{jobScheduleId}/terminate")
  terminateJobSchedule is PostOperation<
    {
      ...CommonParameters;
      ...BatchMatchHeaders;
      ...TerminateJobScheduleRequiredParameters;
      ...TerminateJobScheduleOptionalParameters;
    },
    AcceptedProcessingResponseHeaders
  >;

  @summary("Creates a Job Schedule to the specified Account.")
  @doc("Creates a Job Schedule to the specified Account.")
  @route("/jobschedules")
  createJobSchedule is CreateOperation<
    {
      ...CommonJsonParameters;
      ...CreateJobScheduleRequiredParameters;
    },
    {}
  >;

  @summary("Lists all of the Job Schedules in the specified Account.")
  @doc("Lists all of the Job Schedules in the specified Account.")
  @route("/jobschedules")
  listJobSchedules is ListOperation<
    {
      ...CommonListParameters;
      ...ListJobSchedulesOptionalParameters;
    },
    BatchJobScheduleListResult
  >;
}

// Task Interface
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
  createTask is CreateOperation<
    {
      ...CommonJsonParameters;
      ...CreateTaskRequiredParameters;
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
  listTasks is ListOperation<
    {
      ...CommonListParameters;
      ...ListTasksRequiredParameters;
      ...ListTasksOptionalParameters;
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
  createTaskCollection is PostOperation<
    {
      ...CommonJsonParameters;
      ...CreateTaskCollectionRequiredParameters;
    },
    BatchCreateTaskCollectionResult
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
  deleteTask is DeleteOperation<
    {
      ...CommonParameters;
      ...BatchMatchHeaders;
      ...DeleteTaskRequiredParameters;
    },
    DeleteTaskResponse
  >;

  @summary("Gets information about the specified Task.")
  @doc("""
    For multi-instance Tasks, information such as affinityId, executionInfo and
    nodeInfo refer to the primary Task. Use the list subtasks API to retrieve
    information about subtasks.
    """)
  @route("/jobs/{jobId}/tasks/{taskId}")
  getTask is ReadOperation<
    {
      ...CommonParameters;
      ...BatchMatchHeaders;
      ...GetTaskRequiredParameters;
      ...GetTaskOptionalParameters;
    },
    BatchTask & DataServiceResponseHeaders
  >;

  @doc("Updates the properties of the specified Task.")
  @route("/jobs/{jobId}/tasks/{taskId}")
  replaceTask is ReplaceOperation<
    {
      ...CommonJsonParameters;
      ...BatchMatchHeaders;
      ...ReplaceTaskRequiredParameters;
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
  listSubTasks is ReadOperation<
    {
      ...CommonParameters;
      ...ListSubTasksRequiredParameters;
      ...ListSubTasksOptionalParameters;
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
  terminateTask is PostOperation<
    {
      ...CommonParameters;
      ...BatchMatchHeaders;
      ...TerminateTaskRequiredParameters;
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
  reactivateTask is PostOperation<
    {
      ...CommonParameters;
      ...BatchMatchHeaders;
      ...ReactivateTaskRequiredParameters;
    },
    NoContentResponse & DataServiceResponseHeaders
  >;

  @summary("Deletes the specified Task file from the Compute Node where the Task ran.")
  @doc("Deletes the specified Task file from the Compute Node where the Task ran.")
  @route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
  deleteTaskFile is DeleteOperation<
    {
      ...CommonParameters;
      ...BatchTaskFileClientPathContent;
      ...DeleteTaskFileOptionalParameters;
    },
    DeleteTaskFileResponse
  >;

  @doc("Returns the content of the specified Task file.")
  @route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
  getTaskFile is FileOperation<
    {
      ...CommonParameters;
      ...BatchTaskFileClientPathContent;
      ...BatchModifiedSinceHeaders;
      ...GetTaskFileOptionalParameters;
    },
    GetTaskFileResponse
  >;

  @doc("Gets the properties of the specified Task file.")
  @route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
  getTaskFileProperties is HeadFileOperation<
    {
      ...CommonParameters;
      ...BatchTaskFileClientPathContent;
      ...BatchModifiedSinceHeaders;
    },
    {}
  >;

  @summary("Lists the files in a Task's directory on its Compute Node.")
  @doc("Lists the files in a Task's directory on its Compute Node.")
  @route("/jobs/{jobId}/tasks/{taskId}/files")
  listTaskFiles is ListOperation<
    {
      ...CommonListParameters;
      ...ListTaskFilesRequiredParameters;
      ...ListTaskFilesOptionalParameters;
    },
    BatchNodeFileListResult
  >;
}

// Node Interface
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
  createNodeUser is CreateOperation<
    {
      ...CommonJsonParameters;
      ...CreateNodeUserRequiredParameters;
    },
    {}
  >;

  @summary("Deletes a user Account from the specified Compute Node.")
  @doc("""
    You can delete a user Account to a Compute Node only when it is in the idle or
    running state.
    """)
  @route("/pools/{poolId}/nodes/{nodeId}/users/{userName}")
  deleteNodeUser is DeleteOperation<
    {
      ...CommonParameters;
      ...DeleteNodeUserRequiredParameters;
    },
    DeleteNodeUserResponse
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
  replaceNodeUser is ReplaceOperation<
    {
      ...CommonJsonParameters;
      ...ReplaceNodeUserRequiredParameters;
    },
    RequestSuccessResponseHeaders
  >;

  @summary("Gets information about the specified Compute Node.")
  @doc("Gets information about the specified Compute Node.")
  @route("/pools/{poolId}/nodes/{nodeId}")
  getNode is ReadOperation<
    {
      ...CommonParameters;
      ...GetNodeRequiredParameters;
      ...GetNodeOptionalParameters;
    },
    BatchNode
  >;

  @summary("Restarts the specified Compute Node.")
  @doc("You can restart a Compute Node only if it is in an idle or running state.")
  @route("/pools/{poolId}/nodes/{nodeId}/reboot")
  rebootNode is PostOperation<
    {
      ...CommonJsonParameters;
      ...RebootNodeOptionalParameters;
      ...RebootNodeRequiredParameters;
    },
    AcceptedProcessingResponseHeaders
  >;

  @summary("Starts the specified Compute Node.")
  @doc("You can start a Compute Node only if it has been deallocated.")
  @route("/pools/{poolId}/nodes/{nodeId}/start")
  startNode is PostOperation<
    {
      ...CommonParameters;
      ...StartNodeRequiredParameters;
    },
    AcceptedProcessingResponseHeaders
  >;

  @summary("Deallocates the specified Compute Node.")
  @doc("You can deallocate a Compute Node only if it is in an idle or running state.")
  @route("/pools/{poolId}/nodes/{nodeId}/deallocate")
  deallocateNode is PostOperation<
    {
      ...CommonJsonParameters;
      ...DeallocateNodeOptionalParameters;
      ...DeallocateNodeRequiredParameters;
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
  reimageNode is PostOperation<
    {
      ...CommonJsonParameters;
      ...ReimageNodeRequiredParameters;
      ...ReimageNodeOptionalParameters;
    },
    AcceptedProcessingResponseHeaders
  >;

  @summary("Disables Task scheduling on the specified Compute Node.")
  @doc("""
    You can disable Task scheduling on a Compute Node only if its current
    scheduling state is enabled.
    """)
  @route("/pools/{poolId}/nodes/{nodeId}/disablescheduling")
  disableNodeScheduling is PostOperation<
    {
      ...CommonJsonParameters;
      ...DisableNodeSchedulingRequiredParameters;
      ...DisableNodeSchedulingOptionalParameters;
    },
    RequestSuccessResponseHeaders
  >;

  @summary("Enables Task scheduling on the specified Compute Node.")
  @doc("""
    You can enable Task scheduling on a Compute Node only if its current scheduling
    state is disabled
    """)
  @route("/pools/{poolId}/nodes/{nodeId}/enablescheduling")
  enableNodeScheduling is PostOperation<
    {
      ...CommonParameters;
      ...EnableNodeSchedulingRequiredParameters;
    },
    RequestSuccessResponseHeaders
  >;

  @summary("Gets the settings required for remote login to a Compute Node.")
  @doc("""
    Before you can remotely login to a Compute Node using the remote login settings, 
    you must create a user Account on the Compute Node.
    """)
  @route("/pools/{poolId}/nodes/{nodeId}/remoteloginsettings")
  getNodeRemoteLoginSettings is ReadOperation<
    {
      ...CommonParameters;
      ...GetNodeRemoteLoginSettingsRequiredParameters;
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
  uploadNodeLogs is PostOperation<
    {
      ...CommonJsonParameters;
      ...UploadNodeLogsRequiredParameters;
    },
    UploadBatchServiceLogsResult
  >;

  @summary("Lists the Compute Nodes in the specified Pool.")
  @doc("Lists the Compute Nodes in the specified Pool.")
  @route("/pools/{poolId}/nodes")
  listNodes is ListOperation<
    {
      ...CommonListParameters;
      ...ListNodesRequiredParameters;
      ...ListNodesOptionalParameters;
    },
    BatchNodeListResult
  >;

  @summary("Gets information about the specified Compute Node Extension.")
  @doc("Gets information about the specified Compute Node Extension.")
  @route("/pools/{poolId}/nodes/{nodeId}/extensions/{extensionName}")
  getNodeExtension is ReadOperation<
    {
      ...CommonParameters;
      ...GetNodeExtensionRequiredParameters;
      ...GetNodeExtensionOptionalParameters;
    },
    BatchNodeVMExtension
  >;

  @summary("Lists the Compute Nodes Extensions in the specified Pool.")
  @doc("Lists the Compute Nodes Extensions in the specified Pool.")
  @route("/pools/{poolId}/nodes/{nodeId}/extensions")
  listNodeExtensions is ListOperation<
    {
      ...CommonListParameters;
      ...ListNodeExtensionsRequiredParameters;
      ...ListNodeExtensionsOptionalParameters;
    },
    BatchNodeVMExtensionListResult
  >;

  @summary("Deletes the specified file from the Compute Node.")
  @doc("Deletes the specified file from the Compute Node.")
  @route("/pools/{poolId}/nodes/{nodeId}/files/{filePath}")
  deleteNodeFile is DeleteOperation<
    {
      ...CommonParameters;
      ...BatchNodeFileClientPathContent;
      ...DeleteNodeFileOptionalParameters;
    },
    DeleteNodeFileResponse
  >;

  @doc("Returns the content of the specified Compute Node file.")
  @route("/pools/{poolId}/nodes/{nodeId}/files/{filePath}")
  getNodeFile is FileOperation<
    {
      ...CommonParameters;
      ...BatchNodeFileClientPathContent;
      ...BatchModifiedSinceHeaders;
      ...GetNodeFileOptionalParameters;
    },
    GetNodeFileResponse
  >;

  @doc("Gets the properties of the specified Compute Node file.")
  @route("/pools/{poolId}/nodes/{nodeId}/files/{filePath}")
  getNodeFileProperties is HeadFileOperation<
    {
      ...CommonParameters;
      ...BatchNodeFileClientPathContent;
      ...BatchModifiedSinceHeaders;
    },
    {}
  >;

  @summary("Lists all of the files in Task directories on the specified Compute Node.")
  @doc("Lists all of the files in Task directories on the specified Compute Node.")
  @route("/pools/{poolId}/nodes/{nodeId}/files")
  listNodeFiles is ListOperation<
    {
      ...CommonListParameters;
      ...ListNodeFilesRequiredParameters;
      ...ListNodeFilesOptionalParameters;
    },
    BatchNodeFileListResult
  >;
}
