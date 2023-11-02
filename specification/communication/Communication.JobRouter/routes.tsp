import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core.Traits;

namespace AzureCommunicationRoutingService;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;
alias PatchOperationTraits = NoRepeatableRequests &
  NoClientRequestId &
  SupportsRouterConditionalPatchUpdateRequests &
  RouterReturnConditionalResponseHeaders;
alias GetOperationTraits = ServiceTraits &
  RouterReturnConditionalResponseHeaders;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;
alias GetOperations = Azure.Core.ResourceOperations<GetOperationTraits>;
alias PatchOperations = Azure.Core.ResourceOperations<PatchOperationTraits>;

interface JobRouterAdministrationOperations {
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Creates or updates a classification policy.")
  @doc("Creates or updates a classification policy.")
  @route("/routing")
  upsertClassificationPolicy is PatchOperations.ResourceCreateOrUpdate<ClassificationPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing classification policy by Id.")
  @doc("Retrieves an existing classification policy by Id.")
  @route("/routing")
  getClassificationPolicy is GetOperations.ResourceRead<ClassificationPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Delete a classification policy by Id.")
  @doc("Delete a classification policy by Id.")
  @route("/routing")
  deleteClassificationPolicy is Operations.ResourceDelete<ClassificationPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves existing classification policies.")
  @doc("Retrieves existing classification policies.")
  @route("/routing")
  listClassificationPolicies is Operations.ResourceList<
    ClassificationPolicy,
    ListClassificationPoliciesQueryParams
  >;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Creates or updates a distribution policy.")
  @doc("Creates or updates a distribution policy.")
  @route("/routing")
  upsertDistributionPolicy is PatchOperations.ResourceCreateOrUpdate<DistributionPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing distribution policy by Id.")
  @doc("Retrieves an existing distribution policy by Id.")
  @route("/routing")
  getDistributionPolicy is GetOperations.ResourceRead<DistributionPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Delete a distribution policy by Id.")
  @doc("Delete a distribution policy by Id.")
  @route("/routing")
  deleteDistributionPolicy is Operations.ResourceDelete<DistributionPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves existing distribution policies.")
  @doc("Retrieves existing distribution policies.")
  @route("/routing")
  listDistributionPolicies is Operations.ResourceList<
    DistributionPolicy,
    ListDistributionPoliciesQueryParams
  >;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Creates or updates a exception policy.")
  @doc("Creates or updates a exception policy.")
  @route("/routing")
  upsertExceptionPolicy is PatchOperations.ResourceCreateOrUpdate<ExceptionPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing exception policy by Id.")
  @doc("Retrieves an existing exception policy by Id.")
  @route("/routing")
  getExceptionPolicy is GetOperations.ResourceRead<ExceptionPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Deletes a exception policy by Id.")
  @doc("Deletes a exception policy by Id.")
  @route("/routing")
  deleteExceptionPolicy is Operations.ResourceDelete<ExceptionPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves existing exception policies.")
  @doc("Retrieves existing exception policies.")
  @route("/routing")
  listExceptionPolicies is Operations.ResourceList<
    ExceptionPolicy,
    ListExceptionPoliciesQueryParams
  >;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Creates or updates a queue.")
  @doc("Creates or updates a queue.")
  @route("/routing")
  upsertQueue is PatchOperations.ResourceCreateOrUpdate<RouterQueue>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing queue by Id.")
  @doc("Retrieves an existing queue by Id.")
  @route("/routing")
  getQueue is GetOperations.ResourceRead<RouterQueue>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Deletes a queue by Id.")
  @doc("Deletes a queue by Id.")
  @route("/routing")
  deleteQueue is Operations.ResourceDelete<RouterQueue>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves existing queues.")
  @doc("Retrieves existing queues.")
  @route("/routing")
  listQueues is Operations.ResourceList<RouterQueue, ListQueuesQueryParams>;
}

interface JobRouterOperations {
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Creates or updates a router job.")
  @doc("Creates or updates a router job.")
  @route("/routing")
  upsertJob is PatchOperations.ResourceCreateOrUpdate<RouterJob>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing job by Id.")
  @doc("Retrieves an existing job by Id.")
  @route("/routing")
  getJob is GetOperations.ResourceRead<RouterJob>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Deletes a job and all of its traces.")
  @doc("Deletes a job and all of its traces.")
  @route("/routing")
  deleteJob is Operations.ResourceDelete<RouterJob>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Reclassify a job.")
  @doc("Reclassify a job.")
  @route("/routing/jobs/{jobId}:reclassify")
  @post
  reclassifyJobAction is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the job.")
      @path
      jobId: string;

      @doc("Request object for reclassifying a job.")
      @body
      options?: ReclassifyJobOptions;
    },
    ReclassfiyJobOkReponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Submits request to cancel an existing job by Id while supplying free-form cancellation reason.")
  @doc("Submits request to cancel an existing job by Id while supplying free-form cancellation reason.")
  @route("/routing/jobs/{jobId}:cancel")
  @post
  cancelJobAction is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the job.")
      @path
      jobId: string;

      @doc("Request model for cancelling job.")
      @body
      options?: CancelJobOptions;
    },
    CancelJobResultWithOkResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Completes an assigned job.")
  @doc("Completes an assigned job.")
  @route("/routing/jobs/{jobId}:complete")
  @post
  completeJobAction is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the job.")
      @path
      jobId: string;

      @doc("Request model for completing job.")
      @body
      options: CompleteJobOptions;
    },
    CompleteJobResultWithOkResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Closes a completed job.")
  @doc("Closes a completed job.")
  @route("/routing/jobs/{jobId}:close")
  @post
  closeJobAction is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the job.")
      @path
      jobId: string;

      @doc("Request model for closing job.")
      @body
      options: CloseJobOptions;
    },
    CloseJobResultResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves list of jobs based on filter parameters.")
  @doc("Retrieves list of jobs based on filter parameters.")
  @route("/routing")
  listJobs is Operations.ResourceList<RouterJob, ListJobQueryParams>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Gets a job's position details.")
  @doc("Gets a job's position details.")
  @route("/routing/jobs/{jobId}/position")
  @get
  getInQueuePosition is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the job.")
      @path
      jobId: string;
    },
    RouterJobPositionDetails
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Un-assign a job.")
  @doc("Un-assign a job.")
  @route("/routing/jobs/{jobId}/assignments/{assignmentId}:unassign")
  @post
  unassignJobAction is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the job to un-assign.")
      @path
      jobId: string;

      @doc("Id of the assignment to un-assign.")
      @path
      assignmentId: string;

      @doc("Request body for unassign route.")
      @body
      options?: UnassignJobOptions;
    },
    UnassignJobResult
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Accepts an offer to work on a job and returns a 409/Conflict if another agent accepted the job already.")
  @doc("Accepts an offer to work on a job and returns a 409/Conflict if another agent accepted the job already.")
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
      options?: DeclineJobOfferOptions;
    },
    DeclineJobOfferResultWithOkResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves a queue's statistics.")
  @doc("Retrieves a queue's statistics.")
  @route("/routing/queues/{queueId}/statistics")
  @get
  getQueueStatistics is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the queue to retrieve statistics.")
      @path
      queueId: string;
    },
    RouterQueueStatistics
  >;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Creates or updates a worker.")
  @doc("Creates or updates a worker.")
  @route("/routing")
  upsertWorker is PatchOperations.ResourceCreateOrUpdate<RouterWorker>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing worker by Id.")
  @doc("Retrieves an existing worker by Id.")
  @route("/routing")
  getWorker is GetOperations.ResourceRead<RouterWorker>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Deletes a worker and all of its traces.")
  @doc("Deletes a worker and all of its traces.")
  @route("/routing")
  deleteWorker is Operations.ResourceDelete<RouterWorker>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves existing workers.")
  @doc("Retrieves existing workers.")
  @route("/routing")
  listWorkers is Operations.ResourceList<RouterWorker, ListWorkerQueryParams>;
}
