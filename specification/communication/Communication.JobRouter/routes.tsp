import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core.Traits;

@route("/routing")
namespace AzureCommunicationRoutingService;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests & NoClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface JobRouterAdministrationOperations {
  
  @summary("Creates or updates a classification policy.")
  @doc("Creates or updates a classification policy.")
  upsertClassificationPolicy is Operations.ResourceCreateOrUpdate<ClassificationPolicy>;
  
  @summary("Retrieves an existing classification policy by Id.")
  @doc("Retrieves an existing classification policy by Id.")
  @get
  getClassificationPolicy is Operations.ResourceRead<ClassificationPolicy>;
  
  @summary("Delete a classification policy by Id.")
  @doc("Delete a classification policy by Id.")
  deleteClassificationPolicy is Operations.ResourceDelete<ClassificationPolicy>;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves existing classification policies.")
  @doc("Retrieves existing classification policies.")
  @route("/classificationPolicies")
  @get
  listClassificationPolicies is Azure.Core.Foundations.Operation<
    {
      @doc("Maximum page size.")
      @query
      maxpagesize: int32;
    },
    ClassificationPolicyCollection
  >;
  
  @summary("Creates or updates a distribution policy.")
  @doc("Creates or updates a distribution policy.")
  upsertDistributionPolicy is Operations.ResourceCreateOrUpdate<DistributionPolicy>;
  
  @summary("Retrieves an existing distribution policy by Id.")
  @doc("Retrieves an existing distribution policy by Id.")
  getDistributionPolicy is Operations.ResourceRead<DistributionPolicy>;
  
  @summary("Delete a distribution policy by Id.")
  @doc("Delete a distribution policy by Id.")
  deleteDistributionPolicy is Operations.ResourceDelete<DistributionPolicy>;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves existing distribution policies.")
  @doc("Retrieves existing distribution policies.")
  @route("/distributionPolicies")
  @get
  listDistributionPolicies is Azure.Core.Foundations.Operation<
    {
      @doc("Maximum page size.")
      @query
      maxpagesize: int32;
    },
    DistributionPolicyCollection
  >;
  
  @summary("Creates or updates a exception policy.")
  @doc("Creates or updates a exception policy.")
  upsertExceptionPolicy is Operations.ResourceCreateOrUpdate<ExceptionPolicy>;
  
  @summary("Retrieves an existing exception policy by Id.")
  @doc("Retrieves an existing exception policy by Id.")
  getExceptionPolicy is Operations.ResourceRead<ExceptionPolicy>;
  
  @summary("Deletes a exception policy by Id.")
  @doc("Deletes a exception policy by Id.")
  deleteExceptionPolicy is Operations.ResourceDelete<ExceptionPolicy>;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves existing exception policies.")
  @doc("Retrieves existing exception policies.")
  @route("/exceptionPolicies")
  @get
  listExceptionPolicies is Azure.Core.Foundations.Operation<
    {
      @doc("Number of objects to return per page.")
      @query
      maxpagesize: int32;
    },
    ExceptionPolicyCollection
  >;
  
  @summary("Creates or updates a queue.")
  @doc("Creates or updates a queue.")
  upsertQueue is Operations.ResourceCreateOrUpdate<RouterQueue>;
  
  @summary("Retrieves an existing queue by Id.")
  @doc("Retrieves an existing queue by Id.")
  getQueue is Operations.ResourceRead<RouterQueue>;
  
  @summary("Deletes a queue by Id.")
  @doc("Deletes a queue by Id.")
  deleteQueue is Operations.ResourceDelete<RouterQueue>;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves existing queues.")
  @doc("Retrieves existing queues.")
  @route("/queues")
  @get
  listQueues is Azure.Core.Foundations.Operation<
    {
      @doc("Number of objects to return per page.")
      @query
      maxpagesize: int32;
    },
    RouterQueueCollection
  >;
}

interface JobRouterOperations {
  @summary("Creates or updates a router job.")
  @doc("Creates or updates a router job.")
  upsertJob is Operations.ResourceCreateOrUpdate<RouterJob>;
  
  @summary("Retrieves an existing job by Id.")
  @doc("Retrieves an existing job by Id.")
  getJob is Operations.ResourceRead<RouterJob>;
  
  @summary("Deletes a job and all of its traces.")
  @doc("Deletes a job and all of its traces.")
  deleteJob is Operations.ResourceDelete<RouterJob>;

  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Reclassify a job.")
  @doc("Reclassify a job.")
  @route("/jobs/{id}:reclassify")
  @post
  reclassifyJobAction is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the job.")
      @path
      id: string;

      @doc("Request object for reclassifying a job.")
      @body
      reclassifyJobRequest: {};
    },
    void
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
  @route("/jobs/{id}:cancel")
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
    void
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Completes an assigned job.")
  @doc("Completes an assigned job.")
  @route("/jobs/{id}:complete")
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
    void
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Closes a completed job.")
  @doc("Closes a completed job.")
  @route("/jobs/{id}:close")
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
    void
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves list of jobs based on filter parameters.")
  @doc("Retrieves list of jobs based on filter parameters.")
  @route("/jobs")
  @get
  listJobs is Azure.Core.Foundations.Operation<
    {
      @doc("If specified, filter jobs by status.")
      @query
      status: RouterJobStatusSelector;

      @doc("If specified, filter jobs by queue.")
      @query
      queueId: string;

      @doc("If specified, filter jobs by channel.")
      @query
      channelId: string;

      @doc("If specified, filter jobs by classificationPolicy.")
      @query
      classificationPolicyId: string;

      @doc("""
If specified, filter on jobs that was scheduled before or at given timestamp.
Range: (-Inf, scheduledBefore].
""")
      @query
      scheduledBefore: utcDateTime;

      @doc("""
If specified, filter on jobs that was scheduled at or after given value. Range:
[scheduledAfter, +Inf).
""")
      @query
      scheduledAfter: utcDateTime;

      @doc("Number of objects to return per page.")
      @query
      maxpagesize: int32;
    },
    RouterJobCollection
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Gets a job's position details.")
  @doc("Gets a job's position details.")
  @route("/jobs/{id}/position")
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
  @route("/jobs/{id}/assignments/{assignmentId}:unassign")
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
  @route("/workers/{workerId}/offers/{offerId}:accept")
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
  @route("/workers/{workerId}/offers/{offerId}:decline")
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
  @route("/queues/{id}/statistics")
  @get
  getQueueStatistics is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the queue to retrieve statistics.")
      @path
      id: string;
    },
    RouterQueueStatistics
  >;
  
  @summary("Creates or updates a worker.")
  @doc("Creates or updates a worker.")
  upsertWorker is Operations.ResourceCreateOrUpdate<RouterWorker>;
  
  @summary("Retrieves an existing worker by Id.")
  @doc("Retrieves an existing worker by Id.")
  getWorker is Operations.ResourceRead<RouterWorker>;
  
  @summary("Deletes a worker and all of its traces.")
  @doc("Deletes a worker and all of its traces.")
  deleteWorker is Operations.ResourceDelete<RouterWorker>;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves existing workers.")
  @doc("Retrieves existing workers.")
  @route("/routing/workers")
  @get
  listWorkers is Azure.Core.Foundations.Operation<
    {
      @doc("If specified, select workers by worker state.")
      @query
      state: RouterWorkerStateSelector;

      @doc("If specified, select workers who have a channel configuration with this channel.")
      @query
      channelId: string;

      @doc("If specified, select workers who are assigned to this queue.")
      @query
      queueId: string;

      @doc("""
If set to true, select only workers who have capacity for the channel specified
by `channelId` or for any channel if `channelId` not specified. If set to
false, then will return all workers including workers without any capacity for
jobs. Defaults to false.
""")
      @query
      hasCapacity: boolean;

      @doc("Number of objects to return per page.")
      @query
      maxpagesize: int32;
    },
    RouterWorkerCollection
  >;
}
