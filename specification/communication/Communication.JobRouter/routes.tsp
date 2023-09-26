import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";
import "@typespec/http";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core.Traits;
using Autorest;

namespace AzureCommunicationRoutingService;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests & NoClientRequestId;
alias PatchOperationTraits = NoRepeatableRequests & NoClientRequestId & SupportsRouterConditionalPatchUpdateRequests & RouterReturnConditionalResponseHeaders;
alias GetOperationTraits = ServiceTraits & RouterReturnConditionalResponseHeaders;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;
alias GetOperations = Azure.Core.ResourceOperations<GetOperationTraits>;
alias PatchOperations = Azure.Core.ResourceOperations<PatchOperationTraits>;

interface JobRouterAdministrationOperations {
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Creates or updates a classification policy.")
  @doc("Creates or updates a classification policy.")
  @example("./examples/ClassificationPolicies_CreateClassificationPolicy.json", "Creates a Classification Policy")
  @example("./examples/ClassificationPolicies_UpdateClassificationPolicy.json", "Updates a Classification Policy")
  @route("/routing")
  upsertClassificationPolicy is PatchOperations.ResourceCreateOrUpdate<ClassificationPolicy>;
  
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing classification policy by Id.")
  @doc("Retrieves an existing classification policy by Id.")
  @example("./examples/ClassificationPolicies_GetClassificationPolicy.json", "Get a single Classification policy")
  @route("/routing")
  getClassificationPolicy is GetOperations.ResourceRead<ClassificationPolicy>;
  
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Delete a classification policy by Id.")
  @doc("Delete a classification policy by Id.")
  @example("./examples/ClassificationPolicies_DeleteClassificationPolicy.json", "Delete a Classification policy")
  @route("/routing")
  deleteClassificationPolicy is Operations.ResourceDelete<ClassificationPolicy>;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves existing classification policies.")
  @doc("Retrieves existing classification policies.")
  @example("./examples/ClassificationPolicies_ListClassificationPoliciesWithPageSize.json", "Get Classification policies with pagination (max page size)")
  @route("/routing/classificationPolicies")
  @get
  listClassificationPolicies is Azure.Core.Foundations.Operation<
    {
      @doc("Maximum page size.")
      @query
      maxpagesize?: int32;
    },
    ClassificationPolicyCollection
  >;
  
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Creates or updates a distribution policy.")
  @doc("Creates or updates a distribution policy.")
  @example("./examples/DistributionPolicies_CreateDistributionPolicy.json", "Creates a Distribution policy")
  @example("./examples/DistributionPolicies_UpdateDistributionPolicy.json", "Update a Distribution policy")
  @route("/routing")
  upsertDistributionPolicy is PatchOperations.ResourceCreateOrUpdate<DistributionPolicy>;
  
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing distribution policy by Id.")
  @doc("Retrieves an existing distribution policy by Id.")
  @example("./examples/DistributionPolicies_GetDistributionPolicy.json", "Get a single Distribution policy")
  @route("/routing")
  getDistributionPolicy is GetOperations.ResourceRead<DistributionPolicy>;
  
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Delete a distribution policy by Id.")
  @doc("Delete a distribution policy by Id.")
  @example("./examples/DistributionPolicies_DeleteDistributionPolicy.json", "Delete a Distribution policy")
  @route("/routing")
  deleteDistributionPolicy is Operations.ResourceDelete<DistributionPolicy>;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves existing distribution policies.")
  @doc("Retrieves existing distribution policies.")
  @example("./examples/DistributionPolicies_ListDistributionPoliciesWithPageSize.json", "Get Distribution policies with pagination (max page size)")
  @route("/routing/distributionPolicies")
  @get
  listDistributionPolicies is Azure.Core.Foundations.Operation<
    {
      @doc("Maximum page size.")
      @query
      maxpagesize?: int32;
    },
    DistributionPolicyCollection
  >;
  
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Creates or updates a exception policy.")
  @doc("Creates or updates a exception policy.")
  @example("./examples/ExceptionPolicies_CreateExceptionPolicy.json", "Creates a Exception policy")
  @example("./examples/ExceptionPolicies_UpdateExceptionPolicy.json", "Update a Exception policy")
  @route("/routing")
  upsertExceptionPolicy is PatchOperations.ResourceCreateOrUpdate<ExceptionPolicy>;
  
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing exception policy by Id.")
  @doc("Retrieves an existing exception policy by Id.")
  @example("./examples/ExceptionPolicies_GetExceptionPolicy.json", "Get a single Exception policy")
  @route("/routing")
  getExceptionPolicy is GetOperations.ResourceRead<ExceptionPolicy>;
  
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Deletes a exception policy by Id.")
  @doc("Deletes a exception policy by Id.")
  @example("./examples/ExceptionPolicies_DeleteExceptionPolicy.json", "Delete a Exception policy")
  @route("/routing")
  deleteExceptionPolicy is Operations.ResourceDelete<ExceptionPolicy>;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves existing exception policies.")
  @doc("Retrieves existing exception policies.")
  @example("./examples/ExceptionPolicies_ListExceptionPoliciesWithPageSize.json", "Get Exception policies with pagination (max page size)")
  @route("/routing/exceptionPolicies")
  @get
  listExceptionPolicies is Azure.Core.Foundations.Operation<
    {
      @doc("Number of objects to return per page.")
      @query
      maxpagesize?: int32;
    },
    ExceptionPolicyCollection
  >;
  
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Creates or updates a queue.")
  @doc("Creates or updates a queue.")
  @example("./examples/Queues_CreateQueue.json", "Create a Queue")
  @example("./examples/Queues_UpdateQueue.json", "Update a Queue")
  @route("/routing")
  upsertQueue is PatchOperations.ResourceCreateOrUpdate<RouterQueue>;
  
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing queue by Id.")
  @doc("Retrieves an existing queue by Id.")
  @example("./examples/Queues_GetQueue.json", "Get a single Queue")
  @route("/routing")
  getQueue is GetOperations.ResourceRead<RouterQueue>;
  
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Deletes a queue by Id.")
  @doc("Deletes a queue by Id.")
  @example("./examples/Queues_DeleteQueue.json", "Delete a Queue")
  @route("/routing")
  deleteQueue is Operations.ResourceDelete<RouterQueue>;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves existing queues.")
  @doc("Retrieves existing queues.")
  @example("./examples/Queues_ListQueuesWithPageSize.json", "Get Queues with pagination (max page size)")
  @route("/routing/queues")
  @get
  listQueues is Azure.Core.Foundations.Operation<
    {
      @doc("Number of objects to return per page.")
      @query
      maxpagesize?: int32;
    },
    RouterQueueCollection
  >;
}

interface JobRouterOperations {
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Creates or updates a router job.")
  @doc("Creates or updates a router job.")
  @example("./examples/Jobs_CreateJob.json", "Creates a new Job")
  @example("./examples/Jobs_CreateScheduledJob.json", "Creates a scheduled job")
  @example("./examples/Jobs_UpdateJob.json", "Update a job")
  @route("/routing")
  upsertJob is PatchOperations.ResourceCreateOrUpdate<RouterJob>;
  
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing job by Id.")
  @doc("Retrieves an existing job by Id.")
  @example("./examples/Jobs_GetJob.json", "Get a single Job")
  @route("/routing")
  getJob is GetOperations.ResourceRead<RouterJob>;
  
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Deletes a job and all of its traces.")
  @doc("Deletes a job and all of its traces.")
  @example("./examples/Jobs_DeleteJob.json", "Deletes a job and all of its traces")
  @route("/routing")
  deleteJob is Operations.ResourceDelete<RouterJob>;

  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Reclassify a job.")
  @doc("Reclassify a job.")
  @example("./examples/Jobs_ReclassifyJob.json", "Reclassify a job")
  @route("/routing/jobs/{id}:reclassify")
  @post
  reclassifyJobAction is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the job.")
      @path
      id: string;

      @doc("Request object for reclassifying a job.")
      @body
      reclassifyJobRequest: ReclassifyJobRequest;
    },
    ReclassfiyJobOkReponse
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("""
Submits request to cancel an existing job by Id while supplying free-form
cancellation reason.
""")
  @doc("""
Submits request to cancel an existing job by Id while supplying free-form
cancellation reason.
""")
  @example("./examples/Jobs_RequestJobCancel.json", "Cancels a job")
  @route("/routing/jobs/{id}:cancel")
  @post
  cancelJobAction is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the job.")
      @path
      id: string;

      @doc("Request model for cancelling job.")
      @body
      cancelJobRequest: CancelJobRequest;
    },
    CancelJobResultWithOkResponse
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Completes an assigned job.")
  @doc("Completes an assigned job.")
  @example("./examples/Jobs_CompleteJob.json", "Completes a job")
  @route("/routing/jobs/{id}:complete")
  @post
  completeJobAction is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the job.")
      @path
      id: string;

      @doc("Request model for completing job.")
      @body
      completeJobRequest: CompleteJobRequest;
    },
    CompleteJobResultWithOkResponse
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Closes a completed job.")
  @doc("Closes a completed job.")
  @example("./examples/Jobs_CloseJob.json", "Closes a job")
  @route("/routing/jobs/{id}:close")
  @post
  closeJobAction is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the job.")
      @path
      id: string;

      @doc("Request model for closing job.")
      @body
      closeJobRequest: CloseJobRequest;
    },
    CloseJobResultResponse
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves list of jobs based on filter parameters.")
  @doc("Retrieves list of jobs based on filter parameters.")
  @example("./examples/Jobs_GetJobsWithPageSize.json", "Gets a list of jobs with pagination (max page size)")
  @route("/routing/jobs")
  @get
  listJobs is Azure.Core.Foundations.Operation<
    {
      @doc("If specified, filter jobs by status.")
      @query
      status?: RouterJobStatusSelector = RouterJobStatusSelector.all;

      @doc("If specified, filter jobs by queue.")
      @query
      queueId?: string;

      @doc("If specified, filter jobs by channel.")
      @query
      channelId?: string;

      @doc("If specified, filter jobs by classificationPolicy.")
      @query
      classificationPolicyId?: string;

      @doc("""
If specified, filter on jobs that was scheduled before or at given timestamp.
Range: (-Inf, scheduledBefore].
""")
      @query
      scheduledBefore?: utcDateTime;

      @doc("""
If specified, filter on jobs that was scheduled at or after given value. Range:
[scheduledAfter, +Inf).
""")
      @query
      scheduledAfter?: utcDateTime;

      @doc("Number of objects to return per page.")
      @query
      maxpagesize?: int32;
    },
    RouterJobCollection
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Gets a job's position details.")
  @doc("Gets a job's position details.")
  @example("./examples/Jobs_GetInQueuePosition.json", "Gets a job position in a queue")
  @route("/routing/jobs/{id}/position")
  @get
  getInQueuePosition is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the job.")
      @path
      id: string;
    },
    RouterJobPositionDetails
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Un-assign a job.")
  @doc("Un-assign a job.")
  @example("./examples/Jobs_UnassignJob.json", "Unassigns a job")
  @route("/routing/jobs/{id}/assignments/{assignmentId}:unassign")
  @post
  unassignJobAction is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the job to un-assign.")
      @path
      id: string;

      @doc("Id of the assignment to un-assign.")
      @path
      assignmentId: string;

      @doc("Request body for unassign route.")
      @body
      unassignJobRequest: UnassignJobRequest;
    },
    UnassignJobResult
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("""
Accepts an offer to work on a job and returns a 409/Conflict if another agent
accepted the job already.
""")
  @doc("""
Accepts an offer to work on a job and returns a 409/Conflict if another agent
accepted the job already.
""")
  @example("./examples/Offers_AcceptJobOffer.json", "Accept a Job Offer")
  @route("/routing/workers/{workerId}/offers/{offerId}:accept")
  @post
  acceptJobAction is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the worker.")
      @path
      workerId: string;

      @doc("Id of the offer.")
      @path
      offerId: string;
    },
    AcceptJobOfferResult
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Declines an offer to work on a job.")
  @doc("Declines an offer to work on a job.")
  @example("./examples/Offers_DeclineJobOffer.json", "Decline a Job Offer")
  @route("/routing/workers/{workerId}/offers/{offerId}:decline")
  @post
  declineJobAction is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the worker.")
      @path
      workerId: string;

      @doc("Id of the offer.")
      @path
      offerId: string;

      @doc("Request model for declining offer.")
      @body
      declineJobOfferRequest: DeclineJobOfferRequest;
    },
    void
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves a queue's statistics.")
  @doc("Retrieves a queue's statistics.")
  @example("./examples/Queues_GetQueueStatistics.json", "Get a single Queue statistics")
  @route("/routing/queues/{id}/statistics")
  @get
  getQueueStatistics is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the queue to retrieve statistics.")
      @path
      id: string;
    },
    RouterQueueStatistics
  >;
  
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Creates or updates a worker.")
  @doc("Creates or updates a worker.")
  @example("./examples/Workers_CreateWorker.json", "Create a Worker")
  @example("./examples/Workers_UpdateWorker.json", "Update a Worker properties")
  @example("./examples/Workers_RegisterWorker.json", "Register a Worker")
  @example("./examples/Workers_DeregisterActiveWorker.json", "Deregister an active Worker")
  @example("./examples/Workers_DeregisterInactiveWorker.json", "Deregister a inactive Worker")
  @route("/routing")
  upsertWorker is PatchOperations.ResourceCreateOrUpdate<RouterWorker>;
  
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing worker by Id.")
  @doc("Retrieves an existing worker by Id.")
  @example("./examples/Workers_GetWorker.json", "Get a single Worker")
  @route("/routing")
  getWorker is GetOperations.ResourceRead<RouterWorker>;
  
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Deletes a worker and all of its traces.")
  @doc("Deletes a worker and all of its traces.")
  @example("./examples/Workers_DeleteWorker.json", "Delete a Worker and all of its traces")
  @route("/routing")
  deleteWorker is Operations.ResourceDelete<RouterWorker>;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves existing workers.")
  @doc("Retrieves existing workers.")
  @example("./examples/Workers_GetWorkersWithPageSize.json", "List workers with pagination (max page size)")
  @example("./examples/Workers_GetAvailableWorkersByChannel.json", "List available Workers by channel")
  @route("/routing/workers")
  @get
  listWorkers is Azure.Core.Foundations.Operation<
    {
      @doc("If specified, select workers by worker state.")
      @query
      state?: RouterWorkerStateSelector = RouterWorkerStateSelector.all;

      @doc("If specified, select workers who have a channel configuration with this channel.")
      @query
      channelId?: string;

      @doc("If specified, select workers who are assigned to this queue.")
      @query
      queueId?: string;

      @doc("""
If set to true, select only workers who have capacity for the channel specified
by `channelId` or for any channel if `channelId` not specified. If set to
false, then will return all workers including workers without any capacity for
jobs. Defaults to false.
""")
      @query
      hasCapacity?: boolean;

      @doc("Number of objects to return per page.")
      @query
      maxpagesize?: int32;
    },
    RouterWorkerCollection
  >;
}
