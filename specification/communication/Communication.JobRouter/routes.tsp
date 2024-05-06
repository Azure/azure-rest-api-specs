import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

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
  @summary("Creates or updates a classification policy.")
  @doc("Creates or updates a classification policy.")
  upsertClassificationPolicy is PatchOperations.ResourceCreateOrUpdate<ClassificationPolicy>;

  @summary("Retrieves an existing classification policy by Id.")
  @doc("Retrieves an existing classification policy by Id.")
  getClassificationPolicy is GetOperations.ResourceRead<ClassificationPolicy>;

  @summary("Delete a classification policy by Id.")
  @doc("Delete a classification policy by Id.")
  deleteClassificationPolicy is Operations.ResourceDelete<ClassificationPolicy>;

  @summary("Retrieves existing classification policies.")
  @doc("Retrieves existing classification policies.")
  listClassificationPolicies is Operations.ResourceList<
    ClassificationPolicy,
    ListClassificationPoliciesQueryParams
  >;

  @summary("Creates or updates a distribution policy.")
  @doc("Creates or updates a distribution policy.")
  upsertDistributionPolicy is PatchOperations.ResourceCreateOrUpdate<DistributionPolicy>;

  @summary("Retrieves an existing distribution policy by Id.")
  @doc("Retrieves an existing distribution policy by Id.")
  getDistributionPolicy is GetOperations.ResourceRead<DistributionPolicy>;

  @summary("Delete a distribution policy by Id.")
  @doc("Delete a distribution policy by Id.")
  deleteDistributionPolicy is Operations.ResourceDelete<DistributionPolicy>;

  @summary("Retrieves existing distribution policies.")
  @doc("Retrieves existing distribution policies.")
  listDistributionPolicies is Operations.ResourceList<
    DistributionPolicy,
    ListDistributionPoliciesQueryParams
  >;

  @summary("Creates or updates a exception policy.")
  @doc("Creates or updates a exception policy.")
  upsertExceptionPolicy is PatchOperations.ResourceCreateOrUpdate<ExceptionPolicy>;

  @summary("Retrieves an existing exception policy by Id.")
  @doc("Retrieves an existing exception policy by Id.")
  getExceptionPolicy is GetOperations.ResourceRead<ExceptionPolicy>;

  @summary("Deletes a exception policy by Id.")
  @doc("Deletes a exception policy by Id.")
  deleteExceptionPolicy is Operations.ResourceDelete<ExceptionPolicy>;

  @summary("Retrieves existing exception policies.")
  @doc("Retrieves existing exception policies.")
  listExceptionPolicies is Operations.ResourceList<
    ExceptionPolicy,
    ListExceptionPoliciesQueryParams
  >;

  @summary("Creates or updates a queue.")
  @doc("Creates or updates a queue.")
  upsertQueue is PatchOperations.ResourceCreateOrUpdate<RouterQueue>;

  @summary("Retrieves an existing queue by Id.")
  @doc("Retrieves an existing queue by Id.")
  getQueue is GetOperations.ResourceRead<RouterQueue>;

  @summary("Deletes a queue by Id.")
  @doc("Deletes a queue by Id.")
  deleteQueue is Operations.ResourceDelete<RouterQueue>;

  @summary("Retrieves existing queues.")
  @doc("Retrieves existing queues.")
  listQueues is Operations.ResourceList<RouterQueue, ListQueuesQueryParams>;
}

interface JobRouterOperations {
  @summary("Creates or updates a router job.")
  @doc("Creates or updates a router job.")
  upsertJob is PatchOperations.ResourceCreateOrUpdate<RouterJob>;

  @summary("Retrieves an existing job by Id.")
  @doc("Retrieves an existing job by Id.")
  getJob is GetOperations.ResourceRead<RouterJob>;

  @summary("Deletes a job and all of its traces.")
  @doc("Deletes a job and all of its traces.")
  deleteJob is Operations.ResourceDelete<RouterJob>;

  @summary("Reclassify a job.")
  @doc("Reclassify a job.")
  @clientName("reclassifyJob")
  reclassify is Operations.ResourceAction<
    RouterJob,
    {
      @doc("Request object for reclassifying a job.")
      @body
      options?: ReclassifyJobOptions;
    },
    ReclassifyJobResultWithOkResponse
  >;

  @summary("Submits request to cancel an existing job by Id while supplying free-form cancellation reason.")
  @doc("Submits request to cancel an existing job by Id while supplying free-form cancellation reason.")
  @clientName("cancelJob")
  cancel is Operations.ResourceAction<
    RouterJob,
    {
      @doc("Request model for cancelling job.")
      @body
      options?: CancelJobOptions;
    },
    CancelJobResultWithOkResponse
  >;

  @summary("Completes an assigned job.")
  @doc("Completes an assigned job.")
  @clientName("completeJob")
  complete is Operations.ResourceAction<
    RouterJobAssignment,
    {
      @doc("Request model for completing job.")
      @body
      options?: CompleteJobOptions;
    },
    CompleteJobResultWithOkResponse
  >;

  @summary("Closes a completed job.")
  @doc("Closes a completed job.")
  @clientName("closeJob")
  close is Operations.ResourceAction<
    RouterJobAssignment,
    {
      @doc("Request model for closing job.")
      @body
      options?: CloseJobOptions;
    },
    CloseJobResultWithOkResponse
  >;

  @summary("Retrieves list of jobs based on filter parameters.")
  @doc("Retrieves list of jobs based on filter parameters.")
  listJobs is Operations.ResourceList<RouterJob, ListJobQueryParams>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to revist how to correctly define singletons https://github.com/Azure/azure-rest-api-specs/issues/25605#issuecomment-1736265997"
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

  @summary("Unassign a job.")
  @doc("Unassign a job.")
  @clientName("unassignJob")
  unassign is Operations.ResourceAction<
    RouterJobAssignment,
    {
      @doc("Request body for unassign route.")
      @body
      options?: UnassignJobOptions;
    },
    UnassignJobResult
  >;

  @summary("Accepts an offer to work on a job and returns a 409/Conflict if another agent accepted the job already.")
  @doc("Accepts an offer to work on a job and returns a 409/Conflict if another agent accepted the job already.")
  @clientName("acceptJobOffer")
  accept is Operations.ResourceAction<RouterJobOffer, {}, AcceptJobOfferResult>;

  @summary("Declines an offer to work on a job.")
  @doc("Declines an offer to work on a job.")
  @clientName("declineJobOffer")
  decline is Operations.ResourceAction<
    RouterJobOffer,
    {
      @doc("Request model for declining offer.")
      @body
      options?: DeclineJobOfferOptions;
    },
    DeclineJobOfferResultWithOkResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Need to revist how to correctly define singletons https://github.com/Azure/azure-rest-api-specs/issues/25605#issuecomment-1736265997"
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

  @summary("Creates or updates a worker.")
  @doc("Creates or updates a worker.")
  upsertWorker is PatchOperations.ResourceCreateOrUpdate<RouterWorker>;

  @summary("Retrieves an existing worker by Id.")
  @doc("Retrieves an existing worker by Id.")
  getWorker is GetOperations.ResourceRead<RouterWorker>;

  @summary("Deletes a worker and all of its traces.")
  @doc("Deletes a worker and all of its traces.")
  deleteWorker is Operations.ResourceDelete<RouterWorker>;

  @summary("Retrieves existing workers.")
  @doc("Retrieves existing workers.")
  listWorkers is Operations.ResourceList<RouterWorker, ListWorkerQueryParams>;
}
