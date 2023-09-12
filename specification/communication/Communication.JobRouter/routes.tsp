import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Autorest;
using Azure.Core.Traits;

namespace AzureCommunicationRoutingService;

interface JobRouterAdministrationOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Creates or updates a classification policy.")
  @doc("Creates or updates a classification policy.")
  @example("./ClassificationPolicies_CreateClassificationPolicy.json", "upsertClassificationPolicy")
  @route("/routing/classificationPolicies/{id}")
  @patch
  upsertClassificationPolicy is Azure.Core.Foundations.Operation<
    {
      @doc("content type")
      @header("content-type")
      contentType: "application/merge-patch+json";

      @doc("Id of the classification policy.")
      @path
      id: string;
      
      @doc("""
Model of classification policy properties to be patched. See also:
https://datatracker.ietf.org/doc/html/rfc7386.
""")
      @body
      patch: ClassificationPolicy;
    },
    {
      @statusCode statuscode: 200 | 201;

      @body result: ClassificationPolicy;
    }
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves an existing classification policy by Id.")
  @doc("Retrieves an existing classification policy by Id.")
  @route("/routing/classificationPolicies/{id}")
  @get
  getClassificationPolicy is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the classification policy.")
      @path
      id: string;
    },
    ClassificationPolicy
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Delete a classification policy by Id.")
  @doc("Delete a classification policy by Id.")
  @route("/routing/classificationPolicies/{id}")
  @delete
  deleteClassificationPolicy is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the classification policy.")
      @path
      id: string;
    },
    void
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves existing classification policies.")
  @doc("Retrieves existing classification policies.")
  @route("/routing/classificationPolicies")
  @get
  listClassificationPolicies is Azure.Core.Foundations.Operation<
    {
      @doc("Maximum page size.")
      @query
      maxpagesize: int32;
    },
    ClassificationPolicyCollection
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Creates or updates a distribution policy.")
  @doc("Creates or updates a distribution policy.")
  @route("/routing/distributionPolicies/{id}")
  @patch
  upsertDistributionPolicy is Azure.Core.Foundations.Operation<
    {
      @doc("content type")
      @header("content-type")
      contentType: "application/merge-patch+json";

      @doc("Id of the distribution policy.")
      @path
      id: string;

      @doc("""
Model of distribution policy properties to be patched. See also:
https://datatracker.ietf.org/doc/html/rfc7386.
""")
      @body
      patch: DistributionPolicy;
    },
    {
      @statusCode statuscode: 200 | 201;

      @body result: DistributionPolicy;
    }
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves an existing distribution policy by Id.")
  @doc("Retrieves an existing distribution policy by Id.")
  @route("/routing/distributionPolicies/{id}")
  @get
  getDistributionPolicy is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the distribution policy.")
      @path
      id: string;
    },
    DistributionPolicy
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Delete a distribution policy by Id.")
  @doc("Delete a distribution policy by Id.")
  @route("/routing/distributionPolicies/{id}")
  @delete
  deleteDistributionPolicy is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the distribution policy.")
      @path
      id: string;
    },
    void
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves existing distribution policies.")
  @doc("Retrieves existing distribution policies.")
  @route("/routing/distributionPolicies")
  @get
  listDistributionPolicies is Azure.Core.Foundations.Operation<
    {
      @doc("Maximum page size.")
      @query
      maxpagesize: int32;
    },
    DistributionPolicyCollection
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Creates or updates a exception policy.")
  @doc("Creates or updates a exception policy.")
  @route("/routing/exceptionPolicies/{id}")
  @patch
  upsertExceptionPolicy is Azure.Core.Foundations.Operation<
    {
      @doc("content type")
      @header("content-type")
      contentType: "application/merge-patch+json";

      @doc("Id of the exception policy.")
      @path
      id: string;

      @doc("""
Model of exception policy properties to be patched. See also:
https://datatracker.ietf.org/doc/html/rfc7386
""")
      @body
      patch: ExceptionPolicy;
    },
    {
      @statusCode statuscode: 200 | 201;

      @body result: ExceptionPolicy;
    }
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves an existing exception policy by Id.")
  @doc("Retrieves an existing exception policy by Id.")
  @route("/routing/exceptionPolicies/{id}")
  @get
  getExceptionPolicy is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the exception policy to retrieve.")
      @path
      id: string;
    },
    ExceptionPolicy
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Deletes a exception policy by Id.")
  @doc("Deletes a exception policy by Id.")
  @route("/routing/exceptionPolicies/{id}")
  @delete
  deleteExceptionPolicy is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the exception policy to delete.")
      @path
      id: string;
    },
    void
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves existing exception policies.")
  @doc("Retrieves existing exception policies.")
  @route("/routing/exceptionPolicies")
  @get
  listExceptionPolicies is Azure.Core.Foundations.Operation<
    {
      @doc("Number of objects to return per page.")
      @query
      maxpagesize: int32;
    },
    ExceptionPolicyCollection
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Creates or updates a queue.")
  @doc("Creates or updates a queue.")
  @route("/routing/queues/{id}")
  @patch
  upsertQueue is Azure.Core.Foundations.Operation<
    {
      @doc("content type")
      @header("content-type")
      contentType: "application/merge-patch+json";

      @doc("Id of the queue.")
      @path
      id: string;

      @doc("""
Model of queue properties to be patched. See also:
https://datatracker.ietf.org/doc/html/rfc7386.
""")
      @body
      patch: RouterQueue;
    },
    {
      @statusCode statuscode: 200 | 201;

      @body result: RouterQueue;
    }
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves an existing queue by Id.")
  @doc("Retrieves an existing queue by Id.")
  @route("/routing/queues/{id}")
  @get
  getQueue is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the queue to retrieve.")
      @path
      id: string;
    },
    RouterQueue
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Deletes a queue by Id.")
  @doc("Deletes a queue by Id.")
  @route("/routing/queues/{id}")
  @delete
  deleteQueue is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the queue to delete.")
      @path
      id: string;
    },
    void
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves existing queues.")
  @doc("Retrieves existing queues.")
  @route("/routing/queues")
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Creates or updates a router job.")
  @doc("Creates or updates a router job.")
  @route("/routing/jobs/{id}")
  @patch
  upsertJob is Azure.Core.Foundations.Operation<
    {
      @doc("content type")
      @header("content-type")
      contentType: "application/merge-patch+json";

      @doc("Id of the job.")
      @path
      id: string;

      @doc("""
Model of job properties to be created or patched. See also:
https://datatracker.ietf.org/doc/html/rfc7386.
""")
      @body
      patch: RouterJob;
    },
    {
      @statusCode statuscode: 200 | 201;

      @body result: RouterJob;
    }
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves an existing job by Id.")
  @doc("Retrieves an existing job by Id.")
  @route("/routing/jobs/{id}")
  @get
  getJob is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the job to retrieve.")
      @path
      id: string;
    },
    RouterJob
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Deletes a job and all of its traces.")
  @doc("Deletes a job and all of its traces.")
  @route("/routing/jobs/{id}")
  @delete
  deleteJob is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the job.")
      @path
      id: string;
    },
    void
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Reclassify a job.")
  @doc("Reclassify a job.")
  @route("/routing/jobs/{id}:reclassify")
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
    void
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Completes an assigned job.")
  @doc("Completes an assigned job.")
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
    void
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Closes a completed job.")
  @doc("Closes a completed job.")
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
    void
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves list of jobs based on filter parameters.")
  @doc("Retrieves list of jobs based on filter parameters.")
  @route("/routing/jobs")
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
      declineJobOfferRequest: DeclineJobOfferRequest;
    },
    void
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves a queue's statistics.")
  @doc("Retrieves a queue's statistics.")
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
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Creates or updates a worker.")
  @doc("Creates or updates a worker.")
  @route("/routing/workers/{workerId}")
  @patch
  upsertWorker is Azure.Core.Foundations.Operation<
    {
      @doc("content type")
      @header("content-type")
      contentType: "application/merge-patch+json";
      
      @doc("Id of the worker.")
      @path
      workerId: string;

      @doc("""
Model of worker properties to be created or patched. See also:
https://datatracker.ietf.org/doc/html/rfc7386.
""")
      @body
      patch: RouterWorker;
    },
    {
      @statusCode statuscode: 200 | 201;

      @body result: RouterWorker;
    }
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Retrieves an existing worker by Id.")
  @doc("Retrieves an existing worker by Id.")
  @route("/routing/workers/{workerId}")
  @get
  getWorker is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the worker to retrieve.")
      @path
      workerId: string;
    },
    RouterWorker
  >;
  
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Deletes a worker and all of its traces.")
  @doc("Deletes a worker and all of its traces.")
  @route("/routing/workers/{workerId}")
  @delete
  deleteWorker is Azure.Core.Foundations.Operation<
    {
      @doc("Id of the worker to delete.")
      @path
      workerId: string;
    },
    void
  >;
  
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
