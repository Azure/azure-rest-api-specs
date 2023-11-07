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
  upsertClassificationPolicy is PatchOperations.ResourceCreateOrUpdate<ClassificationPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing classification policy by Id.")
  @doc("Retrieves an existing classification policy by Id.")
  getClassificationPolicy is GetOperations.ResourceRead<ClassificationPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Delete a classification policy by Id.")
  @doc("Delete a classification policy by Id.")
  deleteClassificationPolicy is Operations.ResourceDelete<ClassificationPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves existing classification policies.")
  @doc("Retrieves existing classification policies.")
  listClassificationPolicies is Operations.ResourceList<
    ClassificationPolicy,
    ListClassificationPoliciesQueryParams
  >;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Creates or updates a distribution policy.")
  @doc("Creates or updates a distribution policy.")
  upsertDistributionPolicy is PatchOperations.ResourceCreateOrUpdate<DistributionPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing distribution policy by Id.")
  @doc("Retrieves an existing distribution policy by Id.")
  getDistributionPolicy is GetOperations.ResourceRead<DistributionPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Delete a distribution policy by Id.")
  @doc("Delete a distribution policy by Id.")
  deleteDistributionPolicy is Operations.ResourceDelete<DistributionPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves existing distribution policies.")
  @doc("Retrieves existing distribution policies.")
  listDistributionPolicies is Operations.ResourceList<
    DistributionPolicy,
    ListDistributionPoliciesQueryParams
  >;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Creates or updates a exception policy.")
  @doc("Creates or updates a exception policy.")
  upsertExceptionPolicy is PatchOperations.ResourceCreateOrUpdate<ExceptionPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing exception policy by Id.")
  @doc("Retrieves an existing exception policy by Id.")
  getExceptionPolicy is GetOperations.ResourceRead<ExceptionPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Deletes a exception policy by Id.")
  @doc("Deletes a exception policy by Id.")
  deleteExceptionPolicy is Operations.ResourceDelete<ExceptionPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves existing exception policies.")
  @doc("Retrieves existing exception policies.")
  listExceptionPolicies is Operations.ResourceList<
    ExceptionPolicy,
    ListExceptionPoliciesQueryParams
  >;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Creates or updates a queue.")
  @doc("Creates or updates a queue.")
  upsertQueue is PatchOperations.ResourceCreateOrUpdate<RouterQueue>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing queue by Id.")
  @doc("Retrieves an existing queue by Id.")
  getQueue is GetOperations.ResourceRead<RouterQueue>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Deletes a queue by Id.")
  @doc("Deletes a queue by Id.")
  deleteQueue is Operations.ResourceDelete<RouterQueue>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves existing queues.")
  @doc("Retrieves existing queues.")
  listQueues is Operations.ResourceList<RouterQueue, ListQueuesQueryParams>;
}

interface JobRouterOperations {
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Creates or updates a router job.")
  @doc("Creates or updates a router job.")
  upsertJob is PatchOperations.ResourceCreateOrUpdate<RouterJob>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing job by Id.")
  @doc("Retrieves an existing job by Id.")
  getJob is GetOperations.ResourceRead<RouterJob>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Deletes a job and all of its traces.")
  @doc("Deletes a job and all of its traces.")
  deleteJob is Operations.ResourceDelete<RouterJob>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Reclassify a job.")
  @doc("Reclassify a job.")
  @projectedName("client", "reclassifyJob")
  reclassify is Operations.ResourceAction<
    RouterJob,
    {
      @doc("Request object for reclassifying a job.")
      @body
      options?: ReclassifyJobOptions;
    },
    {
      #suppress "@azure-tools/typespec-azure-core/bad-record-type" "https://github.com/microsoft/typespec/issues/2542"
      @doc("Response after reclassifying a job.")
      @body
      body: ReclassifyJobResult;

      @statusCode
      _: 200;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Submits request to cancel an existing job by Id while supplying free-form cancellation reason.")
  @doc("Submits request to cancel an existing job by Id while supplying free-form cancellation reason.")
  @projectedName("client", "cancelJob")
  cancel is Operations.ResourceAction<
    RouterJob,
    {
      @doc("Request model for cancelling job.")
      @body
      options?: CancelJobOptions;
    },
    CancelJobResultWithOkResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Completes an assigned job.")
  @doc("Completes an assigned job.")
  @projectedName("client", "completeJob")
  complete is Operations.ResourceAction<
    RouterJobAssignment,
    {
      @doc("Request model for completing job.")
      @body
      options?: CompleteJobOptions;
    },
    CompleteJobResultWithOkResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Closes a completed job.")
  @doc("Closes a completed job.")
  @projectedName("client", "closeJob")
  close is Operations.ResourceAction<
    RouterJobAssignment,
    {
      @doc("Request model for closing job.")
      @body
      options?: CloseJobOptions;
    },
    CloseJobResultWithOkResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
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

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Un-assign a job.")
  @doc("Un-assign a job.")
  @projectedName("client", "unassignJob")
  unassign is Operations.ResourceAction<
    RouterJobAssignment,
    {
      @doc("Request body for unassign route.")
      @body
      options?: UnassignJobOptions;
    },
    UnassignJobResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Accepts an offer to work on a job and returns a 409/Conflict if another agent accepted the job already.")
  @doc("Accepts an offer to work on a job and returns a 409/Conflict if another agent accepted the job already.")
  @projectedName("client", "acceptJobOffer")
  accept is Operations.ResourceAction<RouterJobOffer, {}, AcceptJobOfferResult>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Declines an offer to work on a job.")
  @doc("Declines an offer to work on a job.")
  @projectedName("client", "declineJobOffer")
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

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Creates or updates a worker.")
  @doc("Creates or updates a worker.")
  upsertWorker is PatchOperations.ResourceCreateOrUpdate<RouterWorker>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves an existing worker by Id.")
  @doc("Retrieves an existing worker by Id.")
  getWorker is GetOperations.ResourceRead<RouterWorker>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Deletes a worker and all of its traces.")
  @doc("Deletes a worker and all of its traces.")
  deleteWorker is Operations.ResourceDelete<RouterWorker>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops" "Codegen cannot import prefixes from namespace"
  @summary("Retrieves existing workers.")
  @doc("Retrieves existing workers.")
  listWorkers is Operations.ResourceList<RouterWorker, ListWorkerQueryParams>;
}
