import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/openapi";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";


using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Autorest;
using OpenAPI;
using Azure.ClientGenerator.Core;

namespace BatchService;

// Interfaces ////////////////////
@operationGroup
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
  @example("./examples/ApplicationList.json", "List applications")
  @route("/applications")
  @operationId("Application_List")
  @get
  List is Azure.Core.Foundations.Operation<
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
  @example("./examples/ApplicationGet.json", "Get applications")
  Get is Azure.Core.ResourceRead<
    Application,
    {
      parameters: BatchClientRequestHeaders;
      response: BatchError;
    }
  >;
}

@operationGroup
@tag("Pools")
interface Pool {
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
  @example("./examples/PoolListUsageMetrics.json", "Pool list usage metrics")
  ListUsageMetrics is Azure.Core.ResourceList<
    PoolUsageMetrics,
    {
      parameters: BatchApplicationListHeaders &
        Pool_ListUsageMetricRequestHeaders;
      response: BatchResponseHeaders;
    }
  >;

  @summary("Gets lifetime summary statistics for all of the Pools in the specified Account.")
  @doc("""
Statistics are aggregated across all Pools that have ever existed in the
Account, from Account creation to the last update time of the statistics. The
statistics may not be immediately available. The Batch service performs
periodic roll-up of statistics. The typical delay is about 30 minutes.
""")
  @route("/lifetimepoolstats")
  @example(
    "./examples/PoolGetLifetimeStatistics.json",
    "Pool get lifetime statistics"
  )
  @get
  GetAllLifetimeStatistics is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders,
    BatchResponseHeaders & PoolStatistics,
    {},
    BatchError
  >;

  @summary("Adds a Pool to the specified Account.")
  @doc("""
When naming Pools, avoid including sensitive information such as user names or
secret project names. This information may appear in telemetry logs accessible
to Microsoft Support engineers.
""")
  @route("/pools")
  @example(
    "./examples/PoolAdd_CloudServiceConfiguration.json",
    "Add a CloudServiceConfiguration pool"
  )
  @example(
    "./examples/PoolAdd_VirtualMachineConfiguration.json",
    "Add a VirtualMachineConfiguration pool"
  )
  @example(
    "./examples/PoolAdd_VirtualMachineConfigurationWithContainers.json",
    "Add a VirtualMachineConfiguration pool with containers"
  )
  @example(
    "./examples/PoolAdd_VirtualMachineConfigurationWithExtensions.json",
    "Add a VirtualMachineConfiguration pool with extensions"
  )
  @example(
    "./examples/PoolAdd_MountConfiguration.json",
    "Add a pool with mount drive specified"
  )
  @post
  Add is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @body
      @doc("The Pool to be added.")
      pool: BatchPool;
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

  @summary("Lists all of the Pools in the specified Account.")
  @doc("Lists all of the Pools in the specified Account.")
  @route("/pools")
  @example("./examples/PoolList_Basic.json", "Pool list")
  @get
  List is Azure.Core.Foundations.Operation<
    BatchApplicationListHeaders & {
      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-pools.
""")
      @query
      $filter?: string;

      @doc("An OData $select clause.")
      @query
      $select?: string;

      @doc("An OData $expand clause.")
      @query
      $expand?: string;
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
  @example("./examples/PoolDelete.json", "Pool delete")
  @route("/pools/{poolId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & BatchPoolHeaders,
    DeleteResponseHeaders,
    {},
    BatchError
  >;

  @doc("Gets basic properties of a Pool.")
  @example("./examples/PoolExists.json", "Check Pool Exists")
  @route("/pools/{poolId}")
  @head
  Exists is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & BatchPoolHeaders,
    PoolDoesntExistResponseHeaders | PoolDoesExistResponseHeaders,
    {},
    BatchError
  >;

  @doc("Gets information about the specified Pool.")
  @example("./examples/PoolGet_Basic.json", "Pool get")
  @example(
    "./examples/PoolGet_VirtualMachineConfigurationWithExtensions.json",
    "Get a VirtualMachineConfiguration pool with extensions"
  )
  @route("/pools/{poolId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders &
      BatchPoolHeaders & {
        @doc("An OData $select clause.")
        @query
        $select?: string;

        @doc("An OData $expand clause.")
        @query
        $expand?: string;
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
  @example("./examples/PoolPatch.json", "Patch the Pool")
  @route("/pools/{poolId}")
  @patch
  Patch is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders &
      BatchPoolHeaders & {
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The parameters for the request.")
        @body
        poolUpdate: BatchPool;
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
  @example("./examples/PoolDisableAutoScale.json", "Disable pool autoscale")
  @route("/pools/{poolId}/disableautoscale")
  @post
  DisableAutoScale is Azure.Core.Foundations.Operation<
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
  @example("./examples/PoolEnableAutoscale.json", "Pool enable autoscale")
  @route("/pools/{poolId}/enableautoscale")
  @post
  EnableAutoScale is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders &
      BatchPoolHeaders & {
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The parameters for the request.")
        @body
        poolEnableAutoScaleParameter: BatchPoolEnableAutoScaleParameters;
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
  @example("./examples/PoolEvaluateAutoscale.json", "Pool evaluate autoscale")
  @route("/pools/{poolId}/evaluateautoscale")
  @post
  EvaluateAutoScale is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Pool on which to evaluate the automatic scaling formula.")
      @path
      poolId: string;

      @doc("The parameters for the request.")
      @body
      parameters: BatchPoolEvaluateAutoScaleParameters;
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
  @example("./examples/PoolResize.json", "Pool resize")
  @route("/pools/{poolId}/resize")
  @post
  Resize is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders &
      BatchPoolHeaders & {
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The parameters for the request.")
        @body
        parameters: BatchPoolResizeParameters;
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
  @example("./examples/PoolStopResize.json", "Pool stop resize")
  @route("/pools/{poolId}/stopresize")
  @post
  StopResize is Azure.Core.Foundations.Operation<
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
  @example("./examples/PoolUpdate.json", "Pool update")
  @route("/pools/{poolId}/updateproperties")
  @post
  UpdateProperties is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Pool to update.")
      @path
      poolId: string;

      @doc("The parameters for the request.")
      @body
      poolUpdatePropertiesParameter: BatchPool;
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
  @example("./examples/PoolRemoveNodes.json", "Pool remove nodes")
  @route("/pools/{poolId}/removenodes")
  @post
  RemoveNodes is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders &
      BatchPoolHeaders & {
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The parameters for the request.")
        @body
        parameters: NodeRemoveParameters;
      },
    PoolRemoveNodesResponseHeaders,
    {},
    BatchError
  >;
}

@operationGroup
@tag("Accounts")
interface Account {
  @summary("Lists all Virtual Machine Images supported by the Azure Batch service.")
  @doc("Lists all Virtual Machine Images supported by the Azure Batch service.")
  @example(
    "./examples/AccountListSupportedImages.json",
    "Account list node agent skus"
  )
  @route("/supportedimages")
  @get
  ListSupportedImages is Azure.Core.Foundations.Operation<
    BatchApplicationListHeaders & {
      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-support-images.
""")
      @query
      $filter?: string;
    },
    BatchResponseHeaders & AccountListSupportedImagesResult,
    {},
    BatchError
  >;

  @doc("""
Gets the number of Compute Nodes in each state, grouped by Pool. Note that the
numbers returned may not always be up to date. If you need exact node counts,
use a list query.
""")
  @example("./examples/AccountListPoolNodeCounts.json", "NodeCountsPayload")
  @route("/nodecounts")
  @get
  ListPoolNodeCounts is Azure.Core.Foundations.Operation<
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

@operationGroup
@tag("Jobs")
interface Job {
  @summary("Gets lifetime summary statistics for all of the Jobs in the specified Account.")
  @doc("""
Statistics are aggregated across all Jobs that have ever existed in the
Account, from Account creation to the last update time of the statistics. The
statistics may not be immediately available. The Batch service performs
periodic roll-up of statistics. The typical delay is about 30 minutes.
""")
  @example(
    "./examples/JobGetLifetimeStatistics.json",
    "Job get lifetime statistics"
  )
  @route("/lifetimejobstats")
  @get
  GetAllLifetimeStatistics is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders,
    BatchResponseHeaders & JobStatistics,
    {},
    BatchError
  >;

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
  @example("./examples/JobDelete.json", "Delete Job")
  @route("/jobs/{jobId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
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
  @example("./examples/JobGet.json", "Job get")
  @route("/jobs/{jobId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("The ID of the Job.")
        @path
        jobId: string;

        @doc("An OData $select clause.")
        @query
        $select?: string;

        @doc("An OData $expand clause.")
        @query
        $expand?: string;
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
  @example("./examples/JobPatch.json", "Job patch")
  @route("/jobs/{jobId}")
  @patch
  Patch is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The ID of the Job whose properties you want to update.")
        @path
        jobId: string;

        @doc("The parameters for the request.")
        @body
        jobUpdate: BatchJob;
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
  @example("./examples/JobUpdate.json", "Job update")
  @route("/jobs/{jobId}")
  @put
  Update is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The ID of the Job whose properties you want to update.")
        @path
        jobId: string;

        @doc("The parameters for the request.")
        @body
        job: BatchJob;
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
  @example("./examples/JobDisable.json", "Job disable")
  @route("/jobs/{jobId}/disable")
  @post
  Disable is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The ID of the Job to disable.")
        @path
        jobId: string;

        @doc("The parameters for the request.")
        @body
        parameters: BatchJobDisableParameters;
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
  @example("./examples/JobEnable.json", "Job enable")
  @route("/jobs/{jobId}/enable")
  @post
  Enable is Azure.Core.Foundations.Operation<
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
  @example("./examples/JobTerminate.json", "Job terminate")
  @route("/jobs/{jobId}/terminate")
  @post
  Terminate is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("The ID of the Job to terminate.")
        @path
        jobId: string;

        @doc("The parameters for the request.")
        @body
        parameters?: BatchJobTerminateParameters;
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

  @summary("Adds a Job to the specified Account.")
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
  @example("./examples/JobAdd_Basic.json", "Add a basic job")
  @example("./examples/JobAdd_Complex.json", "Add a complex job")
  @route("/jobs")
  @post
  Add is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The Job to be added.")
      @body
      job: BatchJob;
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
  @example("./examples/JobList.json", "Job list")
  @route("/jobs")
  @get
  List is Azure.Core.Foundations.Operation<
    BatchApplicationListHeaders & {
      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-jobs.
""")
      @query
      $filter?: string;

      @doc("An OData $select clause.")
      @query
      $select?: string;

      @doc("An OData $expand clause.")
      @query
      $expand?: string;
    },
    BatchResponseHeaders & BatchJobListResult,
    {},
    BatchError
  >;

  @summary("Lists the Jobs that have been created under the specified Job Schedule.")
  @doc("Lists the Jobs that have been created under the specified Job Schedule.")
  @example(
    "./examples/JobListFromJobSchedule.json",
    "List Job Under Job Schedule"
  )
  @route("/jobschedules/{jobScheduleId}/jobs")
  @get
  ListFromJobSchedule is Azure.Core.Foundations.Operation<
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
      @query
      $select?: string;

      @doc("An OData $expand clause.")
      @query
      $expand?: string;
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
  @example(
    "./examples/JobListPreparationAndReleaseTaskStatus.json",
    "Job list preparation and release task status"
  )
  @route("/jobs/{jobId}/jobpreparationandreleasetaskstatus")
  @get
  ListPreparationAndReleaseTaskStatus is Azure.Core.Foundations.Operation<
    BatchApplicationListHeaders & {
      @doc("The ID of the Job.")
      @path
      jobId: string;

      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-job-preparation-and-release-status.
""")
      @query
      $filter?: string;

      @doc("An OData $select clause.")
      @query
      $select?: string;
    },
    BatchResponseHeaders & BatchJobListPreparationAndReleaseTaskStatusResult,
    {},
    BatchError
  >;

  @summary("Gets the Task counts for the specified Job.")
  @doc("""
Task counts provide a count of the Tasks by active, running or completed Task
state, and a count of Tasks which succeeded or failed. Tasks in the preparing
state are counted as running. Note that the numbers returned may not always be
up to date. If you need exact task counts, use a list query.
""")
  @example("./examples/JobGetTaskCounts.json", "Job get task counts")
  @route("/jobs/{jobId}/taskcounts")
  @get
  GetTaskCounts is Azure.Core.Foundations.Operation<
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

@operationGroup
@tag("Certificates")
interface Certificates {
  @summary("Adds a Certificate to the specified Account.")
  @doc("Adds a Certificate to the specified Account.")
  @example("./examples/CertificateAdd.json", "Certificate add")
  @route("/certificates")
  @post
  Add is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The Certificate to be added.")
      @body
      certificate: Certificate;
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

  @summary("Lists all of the Certificates that have been added to the specified Account.")
  @doc("Lists all of the Certificates that have been added to the specified Account.")
  @example("./examples/CertificateList.json", "Certificate list")
  @route("/certificates")
  @get
  List is Azure.Core.Foundations.Operation<
    BatchApplicationListHeaders & {
      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-certificates.
""")
      @query
      $filter?: string;

      @doc("An OData $select clause.")
      @query
      $select?: string;
    },
    BatchResponseHeaders & CertificateListResult,
    {},
    BatchError
  >;

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
  @example(
    "./examples/CertificateCancelDelete.json",
    "Certificate cancel delete"
  )
  @route("/certificates(thumbprintAlgorithm={thumbprintAlgorithm},thumbprint={thumbprint})/canceldelete")
  @post
  CancelDeletion is Azure.Core.Foundations.Operation<
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
  @example("./examples/CertificateDelete.json", "Certificate delete")
  @route("/certificates(thumbprintAlgorithm={thumbprintAlgorithm},thumbprint={thumbprint})")
  @delete
  Delete is Azure.Core.Foundations.Operation<
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

  @doc("Gets information about the specified Certificate.")
  @example("./examples/CertificateGet.json", "Certificate get")
  @route("/certificates(thumbprintAlgorithm={thumbprintAlgorithm},thumbprint={thumbprint})")
  @get
  Get is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
      @doc("The algorithm used to derive the thumbprint parameter. This must be sha1.")
      @path
      thumbprintAlgorithm: string;

      @doc("The thumbprint of the Certificate to get.")
      @path
      thumbprint: string;

      @doc("An OData $select clause.")
      @query
      $select?: string;
    },
    BatchResponseHeaders & Certificate,
    {},
    BatchError
  >;
}

@operationGroup
@tag("Files")
interface File {
  @summary("Deletes the specified Task file from the Compute Node where the Task ran.")
  @doc("Deletes the specified Task file from the Compute Node where the Task ran.")
  @example("./examples/FileDeleteFromTask.json", "File delete from task")
  @route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
  @delete
  DeleteFromTask is Azure.Core.Foundations.Operation<
    BatchJobFileClientRequestHeaders & {
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
  @example("./examples/FileGetFromTask.json", "Get File From Task")
  @route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
  @get
  GetFromTask is Azure.Core.Foundations.Operation<
    BatchJobFileClientRequestHeaders &
      BatchModifiedSinceHeaders & {
        @doc("""
The byte range to be retrieved. The default is to retrieve the entire file. The
format is bytes=startRange-endRange.
""")
        @header
        "ocp-range"?: string;
      },
    BatchResponseHeaders &
      FileResponse & {
        @header("content-type") contentType: "application/octet-stream";

        @body
        @doc("A response containing the file content.")
        file: bytes;
      },
      {},
      BatchError
  >;

  @doc("Gets the properties of the specified Task file.")
  @example(
    "./examples/FileGetPropertiesFromTask.json",
    "File get properties from task"
  )
  @route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
  @head
  GetPropertiesFromTask is Azure.Core.Foundations.Operation<
    BatchJobFileClientRequestHeaders & BatchModifiedSinceHeaders,
    BatchResponseHeaders & FileResponse,
    {},
    BatchError
  >;

  @summary("Deletes the specified file from the Compute Node.")
  @doc("Deletes the specified file from the Compute Node.")
  @example("./examples/FileDeleteFromNode.json", "File delete from node")
  @route("/pools/{poolId}/nodes/{nodeId}/files/{filePath}")
  @delete
  DeleteFromComputeNode is Azure.Core.Foundations.Operation<
    BatchPoolFileClientRequestHeaders & {
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
  @example("./examples/FileGetFromNode.json", "Get File From Compute Node")
  @route("/pools/{poolId}/nodes/{nodeId}/files/{filePath}")
  @get
  GetFromComputeNode is Azure.Core.Foundations.Operation<
    BatchPoolFileClientRequestHeaders &
      BatchModifiedSinceHeaders & {
        @doc("""
The byte range to be retrieved. The default is to retrieve the entire file. The
format is bytes=startRange-endRange.
""")
        @header
        "ocp-range"?: string;
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
  @example(
    "./examples/FileGetPropertiesFromNode.json",
    "File get properties from node"
  )
  @route("/pools/{poolId}/nodes/{nodeId}/files/{filePath}")
  @head
  GetPropertiesFromComputeNode is Azure.Core.Foundations.Operation<
    BatchPoolFileClientRequestHeaders & BatchModifiedSinceHeaders,
    BatchResponseHeaders & FileResponse,
    {},
    BatchError
  >;

  @summary("Lists the files in a Task's directory on its Compute Node.")
  @doc("Lists the files in a Task's directory on its Compute Node.")
  @example("./examples/FileListFromTask.json", "File list from task")
  @route("/jobs/{jobId}/tasks/{taskId}/files")
  @get
  ListFromTask is Azure.Core.Foundations.Operation<
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

  @summary("Lists all of the files in Task directories on the specified Compute Node.")
  @doc("Lists all of the files in Task directories on the specified Compute Node.")
  @example("./examples/FileListFromNode.json", "File list from node")
  @route("/pools/{poolId}/nodes/{nodeId}/files")
  @get
  ListFromComputeNode is Azure.Core.Foundations.Operation<
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

@operationGroup
@tag("JobSchedules")
interface JobSchedule {
  @summary("Checks the specified Job Schedule exists.")
  @doc("Checks the specified Job Schedule exists.")
  @example("./examples/JobScheduleExists.json", "Check Job Schedule Exists")
  @route("/jobschedules/{jobScheduleId}")
  @head
  Exists is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("The ID of the Job Schedule which you want to check.")
        @path
        jobScheduleId: string;
      },
    (BatchResponseHeaders & {
      @doc("A response containing headers related to the Job Schedule, if it exists.")
      @statusCode
      code: "200";
    }) | {
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
  @example("./examples/JobScheduleDelete.json", "JobSchedule delete")
  @route("/jobschedules/{jobScheduleId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
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
  @example("./examples/JobScheduleGet.json", "JobSchedule get")
  @route("/jobschedules/{jobScheduleId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("The ID of the Job Schedule to get.")
        @path
        jobScheduleId: string;

        @doc("An OData $select clause.")
        @query
        $select?: string;

        @doc("An OData $expand clause.")
        @query
        $expand?: string;
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
  @example("./examples/JobSchedulePatch.json", "JobSchedule patch")
  @route("/jobschedules/{jobScheduleId}")
  @patch
  Patch is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The ID of the Job Schedule to update.")
        @path
        jobScheduleId: string;

        @doc("The parameters for the request.")
        @body
        jobScheduleUpdate: BatchJobSchedule;
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
  @example("./examples/JobScheduleUpdate.json", "JobSchedule update")
  @route("/jobschedules/{jobScheduleId}")
  @put
  Update is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The ID of the Job Schedule to update.")
        @path
        jobScheduleId: string;

        @doc("The parameters for the request.")
        @body
        jobSchedule: BatchJobSchedule;
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
  @example("./examples/JobScheduleDisable.json", "JobSchedule disable")
  @route("/jobschedules/{jobScheduleId}/disable")
  @post
  Disable is Azure.Core.Foundations.Operation<
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
  @example("./examples/JobScheduleEnable.json", "JobSchedule enable")
  @route("/jobschedules/{jobScheduleId}/enable")
  @post
  Enable is Azure.Core.Foundations.Operation<
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
  @example("./examples/JobScheduleTerminate.json", "JobSchedule terminate")
  @route("/jobschedules/{jobScheduleId}/terminate")
  @post
  Terminate is Azure.Core.Foundations.Operation<
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

  @summary("Adds a Job Schedule to the specified Account.")
  @doc("Adds a Job Schedule to the specified Account.")
  @example("./examples/JobScheduleAdd_Basic.json", "Add a basic JobSchedule")
  @example(
    "./examples/JobScheduleAdd_Complex.json",
    "Add a complex JobScheduleAdd"
  )
  @route("/jobschedules")
  @post
  Add is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The Job Schedule to be added.")
      @body
      jobSchedule: BatchJobSchedule;
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
  @example("./examples/JobScheduleList.json", "JobSchedule list")
  @route("/jobschedules")
  @get
  List is Azure.Core.Foundations.Operation<
    BatchApplicationListHeaders & {
      @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-job-schedules.
""")
      @query
      $filter?: string;

      @doc("An OData $select clause.")
      @query
      $select?: string;

      @doc("An OData $expand clause.")
      @query
      $expand?: string;
    },
    BatchResponseHeaders & BatchJobScheduleListResult,
    {},
    BatchError
  >;
}

@operationGroup
@tag("Tasks")
interface Task {
  @summary("Adds a Task to the specified Job.")
  @doc("""
The maximum lifetime of a Task from addition to completion is 180 days. If a
Task has not completed within 180 days of being added it will be terminated by
the Batch service and left in whatever state it was in at that time.
""")
  @example("./examples/TaskAdd_Basic.json", "Add a basic task")
  @example(
    "./examples/TaskAdd_ExitConditions.json",
    "Add a task with exit conditions"
  )
  @example(
    "./examples/TaskAdd_ContainerSettings.json",
    "Add a task with container settings"
  )
  @example(
    "./examples/TaskAdd_RequiredSlots.json",
    "Add a task with extra slot requirement"
  )
  @route("/jobs/{jobId}/tasks")
  @post
  Add is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Job to which the Task is to be added.")
      @path
      jobId: string;

      @doc("The Task to be added.")
      @body
      task: BatchTask;
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
  @example("./examples/TaskList.json", "Task list")
  @route("/jobs/{jobId}/tasks")
  @get
  List is Azure.Core.Foundations.Operation<
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
      @query
      $select?: string;

      @doc("An OData $expand clause.")
      @query
      $expand?: string;
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
  @example(
    "./examples/TaskAddCollection_Basic.json",
    "Add a basic collection of tasks"
  )
  @example(
    "./examples/TaskAddCollection_Complex.json",
    "Add a complex collection of tasks"
  )
  @route("/jobs/{jobId}/addtaskcollection")
  @post
  AddCollection is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Job to which the Task collection is to be added.")
      @path
      jobId: string;

      @doc("The Tasks to be added.")
      @body
      taskCollection: BatchTaskCollection;
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
  @example("./examples/TaskDelete.json", "Task delete")
  @route("/jobs/{jobId}/tasks/{taskId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
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
  @example("./examples/TaskGet.json", "Task get")
  @route("/jobs/{jobId}/tasks/{taskId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @doc("The ID of the Job that contains the Task.")
        @path
        jobId: string;

        @doc("The ID of the Task to get information about.")
        @path
        taskId: string;

        @doc("An OData $select clause.")
        @query
        $select?: string;

        @doc("An OData $expand clause.")
        @query
        $expand?: string;
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
  @example("./examples/TaskUpdate.json", "Task update")
  @route("/jobs/{jobId}/tasks/{taskId}")
  @put
  Update is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders &
      BatchMatchHeaders & {
        @header("content-type")
        contentType: "application/json; odata=minimalmetadata";

        @doc("The ID of the Job containing the Task.")
        @path
        jobId: string;

        @doc("The ID of the Task to update.")
        @path
        taskId: string;

        @doc("The parameters for the request.")
        @body
        task: BatchTask;
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

  @summary("""
Lists all of the subtasks that are associated with the specified multi-instance
Task.
""")
  @doc("If the Task is not a multi-instance Task then this returns an empty collection.")
  @example("./examples/TaskListSubtasks.json", "Task list subtasks")
  @route("/jobs/{jobId}/tasks/{taskId}/subtasksinfo")
  @get
  ListSubtasks is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
      @doc("The ID of the Job.")
      @path
      jobId: string;

      @doc("The ID of the Task.")
      @path
      taskId: string;

      @doc("An OData $select clause.")
      @query
      $select?: string;
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
  @example("./examples/TaskTerminate.json", "Task terminate")
  @route("/jobs/{jobId}/tasks/{taskId}/terminate")
  @post
  Terminate is Azure.Core.Foundations.Operation<
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
  @example("./examples/TaskReactivate.json", "Task reactivate")
  @route("/jobs/{jobId}/tasks/{taskId}/reactivate")
  @post
  Reactivate is Azure.Core.Foundations.Operation<
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
}

@operationGroup
@tag("ComputeNodes")
interface ComputeNodes {
  @summary("Adds a user Account to the specified Compute Node.")
  @doc("""
You can add a user Account to a Compute Node only when it is in the idle or
running state.
""")
  @example("./examples/NodeAddUser.json", "Node add user")
  @route("/pools/{poolId}/nodes/{nodeId}/users")
  @post
  AddUser is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the machine on which you want to create a user Account.")
      @path
      nodeId: string;

      @doc("The user Account to be created.")
      @body
      user: ComputeNodeUser;
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
  @example("./examples/NodeDeleteUser.json", "Node delete user")
  @route("/pools/{poolId}/nodes/{nodeId}/users/{userName}")
  @delete
  DeleteUser is Azure.Core.Foundations.Operation<
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
Updates the password and expiration time of a user Account on the specified
Compute Node.
""")
  @doc("""
This operation replaces of all the updatable properties of the Account. For
example, if the expiryTime element is not specified, the current value is
replaced with the default value, not left unmodified. You can update a user
Account on a Compute Node only when it is in the idle or running state.
""")
  @example("./examples/NodeUpdateUser.json", "Node update user")
  @route("/pools/{poolId}/nodes/{nodeId}/users/{userName}")
  @put
  UpdateUser is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
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

      @doc("The parameters for the request.")
      @body
      parameters: NodeUpdateUserParameters;
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
  @example("./examples/NodeGet_Basic.json", "Node get")
  @route("/pools/{poolId}/nodes/{nodeId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node that you want to get information about.")
      @path
      nodeId: string;

      @doc("An OData $select clause.")
      @query
      $select?: string;
    },
    BatchResponseHeaders & ComputeNode,
    {},
    BatchError
  >;

  @summary("Restarts the specified Compute Node.")
  @doc("You can restart a Compute Node only if it is in an idle or running state.")
  @example("./examples/NodeReboot.json", "Node reboot")
  @route("/pools/{poolId}/nodes/{nodeId}/reboot")
  @post
  Reboot is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node that you want to restart.")
      @path
      nodeId: string;

      @doc("The parameters for the request.")
      @body
      parameters?: NodeRebootParameters;
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
  @example("./examples/NodeReimage.json", "Node reimage")
  @route("/pools/{poolId}/nodes/{nodeId}/reimage")
  @post
  Reimage is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
      @header("content-type")
      contentType: "application/json; odata=minimalmetadata";

      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node that you want to restart.")
      @path
      nodeId: string;

      @doc("The parameters for the request.")
      @body
      parameters?: NodeReimageParameters;
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
  @example("./examples/NodeDisableScheduling.json", "Node disable scheduling")
  @route("/pools/{poolId}/nodes/{nodeId}/disablescheduling")
  @post
  DisableScheduling is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node on which you want to disable Task scheduling.")
      @path
      nodeId: string;

      @doc("The parameters for the request.")
      @body
      parameters?: NodeDisableSchedulingParameters;
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
  @example("./examples/NodeEnableScheduling.json", "Node enable scheduling")
  @route("/pools/{poolId}/nodes/{nodeId}/enablescheduling")
  @post
  EnableScheduling is Azure.Core.Foundations.Operation<
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
  @example(
    "./examples/NodeGetRemoteLoginSettings.json",
    "Node get remote login settings"
  )
  @route("/pools/{poolId}/nodes/{nodeId}/remoteloginsettings")
  @get
  GetRemoteLoginSettings is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
      @doc("The ID of the Pool that contains the Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node for which to obtain the remote login settings.")
      @path
      nodeId: string;
    },
    BatchResponseHeaders & ComputeNodeGetRemoteLoginSettingsResult,
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
  @example(
    "./examples/NodeGetRemoteDesktop.json",
    "Get RDP file of the compute node"
  )
  @route("/pools/{poolId}/nodes/{nodeId}/rdp")
  @get
  GetRemoteDesktop is Azure.Core.Foundations.Operation<
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
  @example(
    "./examples/NodeUploadBatchServiceLogs.json",
    "Upload BatchService Logs"
  )
  @route("/pools/{poolId}/nodes/{nodeId}/uploadbatchservicelogs")
  @post
  UploadBatchServiceLogs is Azure.Core.Foundations.Operation<
    BatchClientRequestHeaders & {
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

      @doc("The Azure Batch service log files upload configuration.")
      @body
      uploadBatchServiceLogsConfiguration: UploadBatchServiceLogsConfiguration;
    },
    BatchClientResponseHeaders & UploadBatchServiceLogsResult,
    {},
    BatchError
  >;

  @summary("Lists the Compute Nodes in the specified Pool.")
  @doc("Lists the Compute Nodes in the specified Pool.")
  @example("./examples/NodeList.json", "Node list")
  @route("/pools/{poolId}/nodes")
  @get
  List is Azure.Core.Foundations.Operation<
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
      @query
      $select?: string;
    },
    BatchResponseHeaders & ComputeNodeListResult,
    {},
    BatchError
  >;
}

@operationGroup
@tag("ComputeNodes")
interface ComputeNodeExtensions {
  @summary("Gets information about the specified Compute Node Extension.")
  @doc("Gets information about the specified Compute Node Extension.")
  @example(
    "./examples/ComputeNodeExtensionGet.json",
    "Get compute node extension"
  )
  @route("/pools/{poolId}/nodes/{nodeId}/extensions/{extensionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
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
      @query
      $select?: string;
    },
    BatchResponseHeaders & NodeVMExtension,
    {},
    BatchError
  >;

  @summary("Lists the Compute Nodes Extensions in the specified Pool.")
  @doc("Lists the Compute Nodes Extensions in the specified Pool.")
  @example(
    "./examples/ComputeNodeExtensionList.json",
    "List compute node extensions"
  )
  @route("/pools/{poolId}/nodes/{nodeId}/extensions")
  @get
  List is Azure.Core.Foundations.Operation<
    BatchApplicationListHeaders & {
      @doc("The ID of the Pool that contains Compute Node.")
      @path
      poolId: string;

      @doc("The ID of the Compute Node that you want to list extensions.")
      @path
      nodeId: string;

      @doc("An OData $select clause.")
      @query
      $select?: string;
    },
    BatchResponseHeaders & NodeVMExtensionList,
    {},
    BatchError
  >;
}

// headers ////////////////////

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

@doc("Common header values for pool requests")
model FileResponse {
  @doc("A process exit code.")
  @statusCode
  code: "200";

  @header
  @doc("The file creation time.")
  @format("date-time-rfc1123")
  "ocp-creation-time"?: string;

  @header
  @doc("Whether the object represents a directory.")
  "ocp-batch-file-isdirectory": boolean;

  @header
  @doc("The URL of the file.")
  "ocp-batch-file-url": string;

  @header
  @doc("The file mode attribute in octal format.")
  "ocp-batch-file-mode": string;

  @header
  @doc("The length of the file.")
  "Content-Length": int64;

  //@header
  //@doc("The content type of the file.")
  //"content-Type":  string;
}

@doc("Common header values for pool requests")
model BatchPoolHeaders extends BatchMatchHeaders {
  @doc("The ID of the Pool to get.")
  @path
  poolId: string;
}

@doc("Common header values for pool requests")
model BatchMatchHeaders extends BatchModifiedSinceHeaders {
  @doc("""
An ETag value associated with the version of the resource known to the client.
The operation will be performed only if the resource's current ETag on the
service exactly matches the value specified by the client.
""")
  @header
  "If-Match"?: string;

  @doc("""
An ETag value associated with the version of the resource known to the client.
The operation will be performed only if the resource's current ETag on the
service does not match the value specified by the client.
""")
  @header
  "If-None-Match"?: string;
}

@doc("Common header values for modified headers")
model BatchModifiedSinceHeaders {
  @doc("""
A timestamp indicating the last modified time of the resource known to the
client. The operation will be performed only if the resource on the service has
been modified since the specified time.
""")
  @header
  @format("date-time-rfc1123")
  "If-Modified-Since"?: string;

  @doc("""
A timestamp indicating the last modified time of the resource known to the
client. The operation will be performed only if the resource on the service has
not been modified since the specified time.
""")
  @header
  @format("date-time-rfc1123")
  "If-Unmodified-Since"?: string;
}

// This is the standard set of headers that most of batch apis return
alias BatchResponseHeaders = BatchClientResponseHeaders &
  BatchEtagResponseHeaders;

@doc("Etag related response header values")
model BatchEtagResponseHeaders {
  @doc("The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Modified-Since, If-Unmodified-Since, If-Match or If-None-Match headers.")
  @header
  ETag?: string;

  @doc("The time at which the resource was last modified.")
  @header
  @format("date-time-rfc1123")
  "Last-Modified"?: string;
}

@doc("Client related response header values")
model BatchClientResponseHeaders {
  @doc("The client-request-id provided by the client during the request. This will be returned only if the return-client-request-id parameter was set to true.")
  @header
  @format("uuid")
  "client-request-id"?: string;

  @doc("A unique identifier for the request that was made to the Batch service. If a request is consistently failing and you have verified that the request is properly formulated, you may use this value to report the error to Microsoft. In your report, include the value of this request ID, the approximate time that the request was made, the Batch Account against which the request was made, and the region that Account resides in.")
  @header
  @format("uuid")
  "request-id"?: string;
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

@doc("The parameters for a widget status request")
model DeleteResponseHeaders {
  @doc("A process exit code.")
  @statusCode
  code: "202";

  @doc("The client-request-id provided by the client during the request. This will be returned only if the return-client-request-id parameter was set to true.")
  @header
  "client-request-id"?: string;

  @doc("A unique identifier for the request that was made to the Batch service. If a request is consistently failing and you have verified that the request is properly formulated, you may use this value to report the error to Microsoft. In your report, include the value of this request ID, the approximate time that the request was made, the Batch Account against which the request was made, and the region that Account resides in.")
  @header
  "request-id"?: string;
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
  @extension(
    "x-ms-parameter-grouping",
    {
      postfix: "Options",
    }
  )
  maxresults?: int32 = 1000;

  @doc("""
The time the request was issued. Client libraries typically set this to the
current system clock time; set it explicitly if you are calling the REST API
directly.
""")
  @header
  @format("date-time-rfc1123")
  @extension(
    "x-ms-parameter-grouping",
    {
      postfix: "Options",
    }
  )
  "ocp-date"?: string;
}

@doc("Common header parms for Pool related File operartions")
model BatchPoolFileClientRequestHeaders extends BatchClientRequestHeaders {
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

@doc("Common header parms for Job related File operartions")
model BatchJobFileClientRequestHeaders extends BatchClientRequestHeaders {
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

@doc("The parameters for a widget status request")
model BatchClientRequestHeaders {
  @doc("""
The maximum number of items to return in the response. A maximum of 1000
applications can be returned.
""")
  @query
  @extension(
    "x-ms-parameter-grouping",
    {
      postfix: "Options",
    }
  )
  timeOut?: int32 = 30;

  @doc("""
The caller-generated request identity, in the form of a GUID with no decoration
such as curly braces, e.g. 9C4D50EE-2D56-4CD3-8152-34347DC9F2B0.
""")
  @header
  @extension(
    "x-ms-parameter-grouping",
    {
      postfix: "Options",
    }
  )
  @format("uuid")
  "client-request-id"?: string;

  @doc("Whether the server should return the client-request-id in the response.")
  @header
  @extension(
    "x-ms-parameter-grouping",
    {
      postfix: "Options",
    }
  )
  "return-client-request-id"?: boolean = false;

  @doc("""
The time the request was issued. Client libraries typically set this to the
current system clock time; set it explicitly if you are calling the REST API
directly.
""")
  @header
  @extension(
    "x-ms-parameter-grouping",
    {
      postfix: "Options",
    }
  )
  @format("date-time-rfc1123")
  "ocp-date"?: string;
}

@doc("The parameters for a widget status request")
model Pool_ListUsageMetricRequestHeaders {
  @doc("""
The earliest time from which to include metrics. This must be at least two and
a half hours before the current time. If not specified this defaults to the
start time of the last aggregation interval currently available.
""")
  @query
  starttime?: zonedDateTime;

  @doc("""
The latest time from which to include metrics. This must be at least two hours
before the current time. If not specified this defaults to the end time of the
last aggregation interval currently available.
""")
  @query
  endtime?: zonedDateTime;

  @doc("""
An OData $filter clause. For more information on constructing this filter, see
https://docs.microsoft.com/en-us/rest/api/batchservice/odata-filters-in-batch#list-account-usage-metrics.
""")
  @query
  $filter?: string;
}