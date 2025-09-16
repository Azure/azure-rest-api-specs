import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.BatchScheduler;

alias ServiceTraits = NoRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId &
  RequestIdResponseHeaderTrait &
  ResponseHeadersTrait<
    {
      ...LastModifiedResponseEnvelope;
    },
    TraitContext.Read
  >;

alias ResourceOperations = Azure.Core.ResourceOperations<ServiceTraits>;

@tag("Jobs")
interface JobOperations {
  @doc("Deleting a Job also deletes all Tasks that are part of that Job, and all Job statistics. This also overrides the retention period for Task data; that is, if the Job contains Tasks which are still retained on Compute Nodes, the Batch services deletes those Tasks' working directories and all their contents.  When a Delete Job request is received, the Batch service sets the Job to the deleting state. All update operations on a Job that is in deleting state will fail with status code 409 (Conflict), with additional information indicating that the Job is being deleted")
  @summary("Deletes a Job.")
  deleteJob is ResourceOperations.LongRunningResourceDelete<CloudJob>;

  @doc("Gets information about the specified Job.")
  @summary("Gets information about the specified Job.")
  getJob is ResourceOperations.ResourceRead<
    CloudJob,
    QueryParametersTrait<{
      ...ExpandQueryParameter;
      ...SelectQueryParameter;
    }>
  >;

  @doc("The Batch service supports two ways to control the work done as part of a Job. In the first approach, the user specifies a Job Manager Task. The Batch service launches this Task when it is ready to start the Job. The Job Manager Task controls all other Tasks that run under this Job, by using the Task APIs. In the second approach, the user directly controls the execution of Tasks under an active Job, by using the Task APIs. Also note: when naming Jobs, avoid including sensitive information such as user names or secret project names. This information may appear in telemetry logs accessible to Microsoft Support engineers.")
  @summary("Adds a Job to the specified Account.")
  @route("/jobs/{jobName}")
  @put
  addJob is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the Job. The ID must be unique within the Account.")
      @path
      jobName: string;

      @body
      job: JobAddParameter;

      ...ClientRequestIdHeader;
    },
    Azure.Core.Foundations.ResourceOkResponse<CloudJob> &
      ClientRequestIdHeader &
      RequestIdResponseHeader &
      EtagResponseEnvelope &
      LastModifiedResponseEnvelope
  >;

  @doc("This replaces only the Job properties specified in the request. For example, if the Job has constraints, and a request does not specify the constraints element, then the Job keeps the existing constraints.")
  @summary("Updates the properties of the specified Job.")
  @patch
  patchJob is Azure.Core.Foundations.ResourceOperation<
    CloudJob,
    Azure.Core.ConditionalRequestHeaders & {
      @body
      job: JobPatchParameter;
    },
    NoContentResponse
  >;

  @doc("This fully replaces all the updatable properties of the Job. For example, if the Job has constraints associated with it and if constraints is not specified with this request, then the Batch service will remove the existing constraints.")
  @summary("Updates the properties of the specified Job.")
  @action("update")
  updateJob is ResourceOperations.ResourceAction<
    CloudJob,
    {
      @body
      job: JobUpdateParameter;
    },
    NoContentResponse
  >;

  @doc("Lists all of the Jobs in the specified Account.")
  @summary("Lists all of the Jobs in the specified Account.")
  listJobs is ResourceOperations.ResourceList<
    CloudJob,
    QueryParametersTrait<{
      ...FilterQueryParameter;
      ...SelectQueryParameter;
      ...ExpandQueryParameter;
      ...MaxPageSizeQueryParameter;
    }>
  >;

  @doc("When a Terminate Job request is received, the Batch service sets the Job to the terminating state. The Batch service then terminates any running Tasks associated with the Job and runs any required Job release Tasks. Then the Job moves into the completed state. If there are any Tasks in the Job in the active state, they will remain in the active state. Once a Job is terminated, new Tasks cannot be added and any remaining active Tasks will not be scheduled.")
  @summary("Cancels the specified Job, marking it as completed.")
  @action("cancel")
  cancelJob is ResourceOperations.ResourceAction<
    CloudJob,
    {
      ...ConditionalRequestHeaders;
    },
    NoContentResponse
  >;

  @doc("Submit Job request is received, the Batch service sets the Job to the Running state.")
  @summary("Submit the specified Job, marking it as running.")
  @action("submit")
  submitJob is ResourceOperations.ResourceAction<
    CloudJob,
    {},
    NoContentResponse
  >;

  @doc("Gets status of a Job operation.")
  getJobOperationStatus is GetResourceOperationStatus<CloudJob>;

  // /**
  //  * This API returns the Job Preparation and Job Release Task status on all Compute
  //  * Nodes that have run the Job Preparation or Job Release Task. This includes
  //  * Compute Nodes which have since been removed from the Pool. If this API is
  //  * invoked on a Job which has no Job Preparation or Job Release Task, the Batch
  //  * service returns HTTP status code 409 (Conflict) with an error code of
  //  * JobPreparationTaskNotSpecified.
  //  */
  // @summary("""
  //   Lists the execution status of the Job Preparation and Job Release Task for the
  //   specified Job across the Compute Nodes where the Job has run.
  //   """)
  // @route("/jobs/{jobId}/jobpreparationandreleasetaskstatus")
  // @get
  // listPreparationAndReleaseTaskStatus is Azure.Core.Foundations.Operation<
  //   {
  //     /**
  //      * The ID of the Job.
  //      */
  //     @path
  //     jobId: string;

  //     /**
  //      * An OData $filter clause. For more information on constructing this filter, see
  //      * https://docs.microsoft.com/rest/api/batchservice/odata-filters-in-batch#list-job-preparation-and-release-status.
  //      */
  //     @query("$filter")
  //     $filter?: string;

  //     /**
  //      * An OData $select clause.
  //      */
  //     @query("$select")
  //     $select?: string;

  //     /**
  //      * The maximum number of items to return in the response. A maximum of 1000 Tasks
  //      * can be returned.
  //      */
  //     @maxValue(1000)
  //     @minValue(1)
  //     @query("maxresults")
  //     maxResults?: int32 = 1000;
  //   },
  //   CloudJobListPreparationAndReleaseTaskStatusResult
  // >;
}

@tag("Tasks")
interface TaskOperations {
  @doc("The maximum lifetime of a Task from addition to completion is 180 days. If a Task has not completed within 180 days of being added it will be terminated by the Batch service and left in whatever state it was in at that time.")
  @summary("Adds a Task to the specified Job.")
  @route("/jobs/{jobName}/tasks/{taskName}")
  @put
  addTask is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Job to which the Task collection is to be added.")
      @path
      jobName: string;

      @doc("The ID of the Task. The ID must be unique within the Job.")
      @path
      taskName: string;

      @body
      task: TaskAddParameter;

      ...ClientRequestIdHeader;
    },
    Azure.Core.Foundations.ResourceOkResponse<CloudTask> &
      ClientRequestIdHeader &
      RequestIdResponseHeader &
      EtagResponseEnvelope &
      LastModifiedResponseEnvelope
  >;

  @doc("For multi-instance Tasks, information such as affinityId, executionInfo and nodeInfo refer to the primary Task. Use the list subtasks API to retrieve information about subtasks.")
  @summary("Lists all of the Tasks that are associated with the specified Job.")
  listTasks is ResourceOperations.ResourceList<
    CloudTask,
    QueryParametersTrait<{
      ...FilterQueryParameter;
      ...SelectQueryParameter;
      ...ExpandQueryParameter;
      ...MaxPageSizeQueryParameter;
    }>
  >;

  @doc("Note that each Task must have a unique ID. The Batch service may not return the results for each Task in the same order the Tasks were submitted in this request. If the server times out or the connection is closed during the request, the request may have been partially or fully processed, or not at all. In such cases, the user should re-issue the request. Note that it is up to the user to correctly handle failures when re-issuing a request. For example, you should use the same Task IDs during a retry so that if the prior operation succeeded, the retry will not create extra Tasks unexpectedly. If the response contains any Tasks which failed to add, a client can retry the request. In a retry, it is most efficient to resubmit only Tasks that failed to add, and to omit Tasks that were successfully added on the first attempt. The maximum lifetime of a Task from addition to completion is 180 days. If a Task has not completed within 180 days of being added it will be terminated by the Batch service and left in whatever state it was in at that time.")
  @summary("Adds a collection of Tasks to the specified Job.")
  @route("/jobs/{jobName}:addtaskcollection")
  @post
  addTaskCollection is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the Job to which the Task collection is to be added.")
      @path
      jobName: string;

      @doc("""
        The Tasks to be added.
        """)
      @body
      taskCollection: TaskAddCollectionParameter;

      ...ClientRequestIdHeader;
    },
    TaskAddCollectionResult & ClientRequestIdHeader & RequestIdResponseHeader
  >;

  @summary("Terminates the specified Task.")
  @doc("When the Task has been terminated, it moves to the completed state. For multi-instance Tasks, the terminate Task operation applies synchronously to the primary task; subtasks are then terminated asynchronously in the background.")
  @action("cancel")
  cancelTask is ResourceOperations.ResourceAction<
    CloudTask,
    {
      ...ConditionalRequestHeaders;
    },
    NoContentResponse
  >;

  @summary("Deletes a Task from the specified Job.")
  @doc("When a Task is deleted, all of the files in its directory on the Compute Node where it ran are also deleted (regardless of the retention time). For multi-instance Tasks, the delete Task operation applies synchronously to the primary task; subtasks and their files are then deleted asynchronously in the background.")
  deleteTask is ResourceOperations.LongRunningResourceDelete<CloudTask>;

  @doc("Gets status of a Task operation.")
  getTaskOperationStatus is GetResourceOperationStatus<CloudTask>;

  @summary("Gets information about the specified Task.")
  @doc("For multi-instance Tasks, information such as affinityId, executionInfo andnodeInfo refer to the primary Task. Use the list subtasks API to retrieve information about subtasks.")
  getTask is ResourceOperations.ResourceRead<
    CloudTask,
    QueryParametersTrait<{
      ...ExpandQueryParameter;
      ...SelectQueryParameter;
    }>
  >;

  @doc("This fully replaces all the updatable properties of the Task. For example, if the Task has constraints associated with it and if constraints is not specified with this request, then the Batch service will remove the existing constraints.")
  @summary("Updates the properties of the specified task.")
  @action("update")
  updateTask is ResourceOperations.ResourceAction<
    CloudTask,
    {
      @body
      job: TaskUpdateParameter;
    },
    NoContentResponse
  >;
}

@tag("Autoscaler")
interface AutoscalerOperations {
  @summary("Adds an Autoscaler to the specified Account.")
  @route("/autoscalers")
  @put
  addAutoscaler is Azure.Core.Foundations.Operation<
    {
      @body
      autoscaler: AutoscalerAddParameter;

      ...ClientRequestIdHeader;
    },
    TypeSpec.Http.Response<201> &
      ClientRequestIdHeader &
      RequestIdResponseHeader &
      EtagResponseEnvelope &
      LastModifiedResponseEnvelope
  >;

  // TODO: Should we combine create and update into a single action?
  @summary("Updates the properties of the specified Autoscaler.")
  @action("update")
  updateAutoscaler is ResourceOperations.ResourceAction<
    Autoscaler,
    {
      @body
      autoscaler: AutoscalerUpdateParameter;
    },
    NoContentResponse
  >;

  @summary("Lists all of the Autoscalers that are associated with the specified Account.")
  listAutoscalers is ResourceOperations.ResourceList<
    Autoscaler,
    QueryParametersTrait<{
      ...MaxPageSizeQueryParameter;
    }>
  >;

  @summary("Deletes an Autoscaler from the specified Account.")
  deleteAutoscaler is ResourceOperations.ResourceDelete<Autoscaler>;

  @summary("Gets information about the specified Autoscaler.")
  getAutoscaler is ResourceOperations.ResourceRead<Autoscaler>;
}
