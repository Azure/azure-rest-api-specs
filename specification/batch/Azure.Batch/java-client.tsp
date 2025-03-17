import "./common.tsp";
import "./main.tsp";
import "./routes.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(Azure.Batch.Versions.v2024_07_01)
namespace JavaClient;

// Get Application Operation
@doc("Optional parameters for Get Application operation.")
model GetApplicationOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Application operation.")
@route("/applications/{applicationId}")
op getApplicationCustomization is Azure.Batch.ReadOperationNew<
  {
    ...Azure.Batch.GetApplicationRequiredParameters;

    @doc("Optional parameters for Get Application operation.")
    options?: GetApplicationOptions;
  },
  Azure.Batch.BatchApplication
>;

@@override(Azure.Batch.Applications.getApplication,
  getApplicationCustomization,
  "java"
);

// List Applications Operation

@doc("Optional parameters for List Applications operation.")
model ListBatchApplicationsOptions {
  ...Azure.Batch.CommonListParameters;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Custom override for List Applications operation.")
@route("/applications")
op listApplicationsCustomization is Azure.Batch.ListOperationNew<
  {
    @doc("Optional parameters for List Applications operation.")
    options?: ListBatchApplicationsOptions;
  },
  Azure.Batch.BatchApplicationListResult
>;

@@override(Azure.Batch.Applications.listApplications,
  listApplicationsCustomization,
  "java"
);

// List Pool Usage Metrics Operation
@doc("Optional parameters for List Pool Usage Metrics operation.")
model ListBatchPoolUsageMetricsOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListPoolUsageMetricsParameters;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Custom override for List Pool Usage Metrics operation.")
@route("/poolusagemetrics")
op listPoolUsageMetricsCustomization is Azure.Batch.ListOperationNew<
  {
    @doc("Optional parameters for List Pool Usage Metrics operation.")
    options?: ListBatchPoolUsageMetricsOptions;
  },
  Azure.Batch.BatchPoolListUsageMetricsResult
>;

@@override(Azure.Batch.Pools.listPoolUsageMetrics,
  listPoolUsageMetricsCustomization,
  "java"
);

// Create Pool Operation
@doc("Optional parameters for Create Pool operation.")
model CreateBatchPoolOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Custom override for Create Pool operation.")
@route("/pools")
op createPoolCustomization is Azure.Batch.CreateOperationNew<
  {
    ...Azure.Batch.CreatePoolParameters;

    @doc("Optional parameters for Create Pool operation.")
    options?: CreateBatchPoolOptions;
  },
  void
>;

@@override(Azure.Batch.Pools.createPool, createPoolCustomization, "java");

// List Pools Operation
@doc("Optional parameters for List Pools operation.")
model ListBatchPoolsOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListPoolsParameters;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Custom override for List Pools operation.")
@route("/pools")
op listPoolsCustomization is Azure.Batch.ListOperationNew<
  {
    @doc("Optional parameters for List Pools operation.")
    options?: ListBatchPoolsOptions;
  },
  Azure.Batch.BatchPoolListResult
>;

@@override(Azure.Batch.Pools.listPools, listPoolsCustomization, "java");

// Delete Pool Operation
@doc("Optional parameters for Delete Pool operation.")
model DeleteBatchPoolOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Delete Pool operation.")
@route("/pools/{poolId}")
op deletePoolCustomization is Azure.Batch.DeleteOperationNew<
  {
    ...Azure.Batch.DeletePoolRequiredParameters;

    @doc("Optional parameters for Delete Pool operation.")
    options?: DeleteBatchPoolOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.DeleteResponseHeaders
>;

@@override(Azure.Batch.Pools.deletePool, deletePoolCustomization, "java");

// Pool Exists Operation
@doc("Optional parameters for Pool Exists operation.")
model BatchPoolExistsOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Custom override for Pool Exists operation.")
@route("/pools/{poolId}")
op poolExistsCustomization is Azure.Batch.ResourceInfoOperationWithAdditionalResponseNew<
  {
    ...Azure.Batch.PoolExistsRequiredParameters;

    @doc("Optional parameters for Pool Exists operation.")
    options?: BatchPoolExistsOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.PoolDoesNotExistResponseHeaders,
  Azure.Batch.PoolDoesExistResponseHeaders
>;

@@override(Azure.Batch.Pools.poolExists, poolExistsCustomization, "java");

// Get Pool Operation
@doc("Optional parameters for Get Pool operation.")
model GetBatchPoolOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.GetPoolOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Pool operation.")
@route("/pools/{poolId}")
op getPoolCustomization is Azure.Batch.ReadOperationNew<
  {
    ...Azure.Batch.GetPoolRequiredParameters;

    @doc("Optional parameters for Get Pool operation.")
    options?: GetBatchPoolOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.BatchPool
>;

@@override(Azure.Batch.Pools.getPool, getPoolCustomization, "java");

// Update Pool Operation
@doc("Optional parameters for Update Pool operation.")
model UpdateBatchPoolOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Update Pool operation.")
@route("/pools/{poolId}")
op updatePoolCustomization is Azure.Batch.UpdateOperationNew<
  {
    ...Azure.Batch.UpdatePoolRequiredParameters;

    @doc("Optional parameters for Update Pool operation.")
    options?: UpdateBatchPoolOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.Pools.updatePool, updatePoolCustomization, "java");

// Disable Pool Autoscale Operation
@doc("Optional parameters for Disable Pool AutoScale operation.")
model DisableBatchPoolAutoScaleOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Disable Pool AutoScale operation.")
@route("/pools/{poolId}/disableautoscale")
op disablePoolAutoScaleCustomization is Azure.Batch.PostOperationNew<
  {
    ...Azure.Batch.DisablePoolAutoscaleParameters;

    @doc("Optional parameters for Disable Pool AutoScale operation.")
    options?: DisableBatchPoolAutoScaleOptions;
  },
  Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.Pools.disablePoolAutoScale,
  disablePoolAutoScaleCustomization,
  "java"
);

// Enable Pool Autoscale Operation
@doc("Optional parameters for Enable Pool AutoScale operation.")
model EnableBatchPoolAutoScaleOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Enable Pool AutoScale operation.")
@route("/pools/{poolId}/enableautoscale")
op enablePoolAutoScaleCustomization is Azure.Batch.PostOperationNew<
  {
    ...Azure.Batch.EnablePoolAutoscaleRequiredParameters;

    @doc("Optional parameters for Enable Pool AutoScale operation.")
    options?: EnableBatchPoolAutoScaleOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.Pools.enablePoolAutoScale,
  enablePoolAutoScaleCustomization,
  "java"
);

// Evaluate Pool Autoscale Operation
@doc("Optional parameters for Evaluate Pool AutoScale operation.")
model EvaluateBatchPoolAutoScaleOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Evaluate Pool AutoScale operation.")
@route("/pools/{poolId}/evaluateautoscale")
op evaluatePoolAutoScaleCustomization is Azure.Batch.PostOperationNew<
  {
    ...Azure.Batch.EvaluatePoolAutoScaleRequiredParameters;

    @doc("Optional parameters for Evaluate Pool AutoScale operation.")
    options?: EvaluateBatchPoolAutoScaleOptions;
  },
  Azure.Batch.AutoScaleRun & Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.Pools.evaluatePoolAutoScale,
  evaluatePoolAutoScaleCustomization,
  "java"
);

// Resize Pool Operation
@doc("Optional parameters for Resize Pool operation.")
model ResizeBatchPoolOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Resize Pool operation.")
@route("/pools/{poolId}/resize")
op resizePoolCustomization is Azure.Batch.PostOperationNew<
  {
    ...Azure.Batch.ResizePoolRequiredParameters;

    @doc("Optional parameters for Resize Pool operation.")
    options?: ResizeBatchPoolOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Pools.resizePool, resizePoolCustomization, "java");

// Stop Pool Resize Operation
@doc("Optional parameters for Stop Pool Resize operation.")
model StopBatchPoolResizeOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Stop Pool Resize operation.")
@route("/pools/{poolId}/stopresize")
op stopPoolResizeCustomization is Azure.Batch.PostOperationNew<
  {
    ...Azure.Batch.StopPoolResizeRequiredParameters;

    @doc("Optional parameters for Stop Pool Resize operation.")
    options?: StopBatchPoolResizeOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Pools.stopPoolResize,
  stopPoolResizeCustomization,
  "java"
);

// Replace Pool Properties Operation
@doc("Optional parameters for Replace Pool Properties operation.")
model ReplaceBatchPoolPropertiesOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Replace Pool Properties operation.")
@route("/pools/{poolId}/updateproperties")
op replacePoolPropertiesCustomization is Azure.Batch.PostOperationNew<
  {
    ...Azure.Batch.ReplacePoolPropertiesRequiredParameters;

    @doc("Optional parameters for Replace Pool Properties operation.")
    options?: ReplaceBatchPoolPropertiesOptions;
  },
  Azure.Batch.NoContentSuccessResponseHeaders
>;

@@override(Azure.Batch.Pools.replacePoolProperties,
  replacePoolPropertiesCustomization,
  "java"
);

// Remove Nodes Operation
@doc("Optional parameters for Remove Nodes operation.")
model RemoveBatchNodesOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Remove Nodes operation.")
@route("/pools/{poolId}/removenodes")
op removeNodesCustomization is Azure.Batch.PostOperationNew<
  {
    ...Azure.Batch.RemoveNodesRequiredParameters;

    @doc("Optional parameters for Remove Nodes operation.")
    options?: RemoveBatchNodesOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Pools.removeNodes, removeNodesCustomization, "java");

// List Supported Images Operation
@doc("Optional parameters for List Supported Images operation.")
model ListSupportedBatchImagesOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListSupportedImagesParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Supported Images operation.")
@route("/supportedimages")
op listSupportedImagesCustomization is Azure.Batch.ListOperationNew<
  {
    @doc("Optional parameters for List Supported Images operation.")
    options?: ListSupportedBatchImagesOptions;
  },
  Azure.Batch.BatchAccountListSupportedImagesResult
>;

@@override(Azure.Batch.Pools.listSupportedImages,
  listSupportedImagesCustomization,
  "java"
);

// List Pool Node Counts Operation
@doc("Optional parameters for List Pool Node Counts operation.")
model ListBatchPoolNodeCountsOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListPoolNodeCountsParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Pool Node Counts operation.")
@route("/nodecounts")
op listPoolNodeCountsCustomization is Azure.Batch.ListOperationNew<
  {
    @doc("Optional parameters for List Pool Node Counts operation.")
    options?: ListBatchPoolNodeCountsOptions;
  },
  Azure.Batch.BatchPoolNodeCountsListResult
>;

@@override(Azure.Batch.Pools.listPoolNodeCounts,
  listPoolNodeCountsCustomization,
  "java"
);

// Delete Job Operation
@doc("Optional parameters for Delete Job operation.")
model DeleteBatchJobOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.DeleteJobOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Delete Job operation.")
@route("/jobs/{jobId}")
op deleteJobCustomization is Azure.Batch.DeleteOperationNew<
  {
    ...Azure.Batch.DeleteJobRequiredParameters;

    @doc("Optional parameters for Delete Job operation.")
    options?: DeleteBatchJobOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.DeleteResponseHeaders
>;

@@override(Azure.Batch.Jobs.deleteJob, deleteJobCustomization, "java");

// Get Job Operation
@doc("Optional parameters for Get Job operation.")
model GetBatchJobOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.GetJobOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Job operation.")
@route("/jobs/{jobId}")
op getJobCustomization is Azure.Batch.ReadOperationNew<
  {
    ...Azure.Batch.GetJobRequiredParameters;

    @doc("Optional parameters for Get Job operation.")
    options?: GetBatchJobOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.BatchJob
>;

@@override(Azure.Batch.Jobs.getJob, getJobCustomization, "java");

// Update Job Operation
@doc("Optional parameters for Update Job operation.")
model UpdateBatchJobOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Update Job operation.")
@route("/jobs/{jobId}")
op updateJobCustomization is Azure.Batch.UpdateOperationNew<
  {
    ...Azure.Batch.UpdateJobRequiredParameters;

    @doc("Optional parameters for Update Job operation.")
    options?: UpdateBatchJobOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.Jobs.updateJob, updateJobCustomization, "java");

// Replace Job Operation
@doc("Optional parameters for Replace Job operation.")
model ReplaceBatchJobOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Replace Job operation.")
@route("/jobs/{jobId}")
op replaceJobCustomization is Azure.Batch.ReplaceOperationNew<
  {
    ...Azure.Batch.ReplaceJobRequiredParameters;

    @doc("Optional parameters for Replace Job operation.")
    options?: ReplaceBatchJobOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.Jobs.replaceJob, replaceJobCustomization, "java");

// Disable Job Operation
@doc("Optional parameters for Disable Job operation.")
model DisableBatchJobOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Disable Job operation.")
@route("/jobs/{jobId}/disable")
op disableJobCustomization is Azure.Batch.PostOperationNew<
  {
    ...Azure.Batch.DisableJobRequiredParameters;

    @doc("Optional parameters for Disable Job operation.")
    options?: DisableBatchJobOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Jobs.disableJob, disableJobCustomization, "java");

// Enable Job Operation
@doc("Optional parameters for Enable Job operation.")
model EnableBatchJobOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Enable Job operation.")
@route("/jobs/{jobId}/enable")
op enableJobCustomization is Azure.Batch.PostOperationNew<
  {
    ...Azure.Batch.EnableJobRequiredParameters;

    @doc("Optional parameters for Enable Job operation.")
    options?: EnableBatchJobOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Jobs.enableJob, enableJobCustomization, "java");

// Terminate Job Operation
@doc("Optional parameters for Terminate Job operation.")
model TerminateBatchJobOptions {
  ...Azure.Batch.CommonJsonParameters;
  ...Azure.Batch.TerminateJobOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Terminate Job operation.")
@route("/jobs/{jobId}/terminate")
op terminateJobCustomization is Azure.Batch.PostOperationNew<
  {
    ...Azure.Batch.TerminateJobRequiredParameters;

    @doc("Optional parameters for Terminate Job operation.")
    options?: TerminateBatchJobOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Jobs.terminateJob, terminateJobCustomization, "java");

// Create Job Operation
@doc("Optional parameters for Create Job operation.")
model CreateBatchJobOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Create Job operation.")
@route("/jobs")
op createJobCustomization is Azure.Batch.CreateOperationNew<
  {
    ...Azure.Batch.CreateJobRequiredParameters;

    @doc("Optional parameters for Create Job operation.")
    options?: CreateBatchJobOptions;
  },
  void
>;

@@override(Azure.Batch.Jobs.createJob, createJobCustomization, "java");

// List Jobs Operation
@doc("Optional parameters for List Jobs operation.")
model ListBatchJobsOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListJobsParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Jobs operation.")
@route("/jobs")
op listJobsCustomization is Azure.Batch.ListOperationNew<
  {
    @doc("Optional parameters for List Jobs operation.")
    options?: ListBatchJobsOptions;
  },
  Azure.Batch.BatchJobListResult
>;

@@override(Azure.Batch.Jobs.listJobs, listJobsCustomization, "java");

// List Jobs From Schedule Operation
@doc("Optional parameters for List Jobs From Schedule operation.")
model ListBatchJobsFromScheduleOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListJobsFromScheduleParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Jobs From Schedule operation.")
@route("/jobschedules/{jobScheduleId}/jobs")
op listJobsFromScheduleCustomization is Azure.Batch.ListOperationNew<
  {
    ...Azure.Batch.ListJobsFromScheduleRequiredParameters;

    @doc("Optional parameters for List Jobs From Schedule operation.")
    options?: ListBatchJobsFromScheduleOptions;
  },
  Azure.Batch.BatchJobListResult
>;

@@override(Azure.Batch.Jobs.listJobsFromSchedule,
  listJobsFromScheduleCustomization,
  "java"
);

// List Jobs Preparation and Release Task Status Operation
@doc("Optional parameters for List Jobs From Schedule operation.")
model ListBatchJobPreparationAndReleaseTaskStatusOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListJobPreparationAndReleaseTaskStatusParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Jobs Preparation and Release Task Status operation.")
@route("/jobs/{jobId}/jobpreparationandreleasetaskstatus")
op listJobPreparationAndReleaseTaskStatusCustomization is Azure.Batch.ListOperationNew<
  {
    ...Azure.Batch.ListJobPreparationAndReleaseTaskStatusRequiredParameters;

    @doc("Optional parameters for List Jobs Preparation and Release Task Status operation.")
    options?: ListBatchJobPreparationAndReleaseTaskStatusOptions;
  },
  Azure.Batch.BatchJobPreparationAndReleaseTaskStatusListResult
>;

@@override(Azure.Batch.Jobs.listJobPreparationAndReleaseTaskStatus,
  listJobPreparationAndReleaseTaskStatusCustomization,
  "java"
);

// Get Job Task Counts Operation
@doc("Optional parameters for Get Job Task Counts operation.")
model GetBatchJobTaskCountsOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Job Task Counts operation.")
@route("/jobs/{jobId}/taskcounts")
op getJobTaskCountsCustomization is Azure.Batch.ReadOperationNew<
  {
    ...Azure.Batch.getJobTaskCountsParameters;

    @doc("Optional parameters for Get Job Task Counts operation.")
    options?: GetBatchJobTaskCountsOptions;
  },
  Azure.Batch.BatchTaskCountsResult
>;

@@override(Azure.Batch.Jobs.getJobTaskCounts,
  getJobTaskCountsCustomization,
  "java"
);

// Create Certificate Operation
@doc("Optional parameters for Create Certificate operation.")
model CreateBatchCertificateOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Create Certificate operation.")
@route("/certificates")
op createCertificateCustomization is Azure.Batch.CreateOperationNew<
  {
    ...Azure.Batch.CreateCertificateRequiredParameters;

    @doc("Optional parameters for Create Certificate operation.")
    options?: CreateBatchCertificateOptions;
  },
  void
>;

@@override(Azure.Batch.Certificates.createCertificate,
  createCertificateCustomization,
  "java"
);

// List Certificates Operation
@doc("Optional parameters for List Certificates operation.")
model ListBatchCertificatesOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListCertificatesOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Certificates operation.")
@route("/certificates")
op listCertificatesCustomization is Azure.Batch.ListOperationNew<
  {
    @doc("Optional parameters for List Certificates operation.")
    options?: ListBatchCertificatesOptions;
  },
  Azure.Batch.BatchCertificateListResult
>;

@@override(Azure.Batch.Certificates.listCertificates,
  listCertificatesCustomization,
  "java"
);

// Cancel Certificate Deletion Operation
@doc("Optional parameters for Cancel Certificate Deletion operation.")
model CancelBatchCertificateDeletionOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Cancel Certificate Deletion operation.")
@route("/certificates(thumbprintAlgorithm={thumbprintAlgorithm},thumbprint={thumbprint})/canceldelete")
op cancelCertificateDeletionCustomization is Azure.Batch.PostOperationNew<
  {
    ...Azure.Batch.CancelCertificateDeletionRequiredParameters;

    @doc("Optional parameters for Cancel Certificate Deletion operation.")
    options?: CancelBatchCertificateDeletionOptions;
  },
  Azure.Batch.NoContentSuccessResponseHeaders
>;

@@override(Azure.Batch.Certificates.cancelCertificateDeletion,
  cancelCertificateDeletionCustomization,
  "java"
);

// Delete Certificate Operation
@doc("Optional parameters for Delete Certificate operation.")
model DeleteBatchCertificateOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Delete Certificate operation.")
@route("/certificates(thumbprintAlgorithm={thumbprintAlgorithm},thumbprint={thumbprint})")
op deleteCertificateCustomization is Azure.Batch.DeleteOperationNew<
  {
    ...Azure.Batch.DeleteCertificateRequiredParameters;

    @doc("Optional parameters for Delete Certificate operation.")
    options?: DeleteBatchCertificateOptions;
  },
  Azure.Batch.DeleteCertificateResponse
>;

@@override(Azure.Batch.Certificates.deleteCertificate,
  deleteCertificateCustomization,
  "java"
);

// Create Job Schedule Operation
@doc("Optional parameters for Create Job Schedule operation.")
model CreateBatchJobScheduleOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Custom override for Create Job Schedule operation.")
@route("/jobschedules")
op createJobScheduleCustomization is Azure.Batch.CreateOperationNew<
  {
    ...Azure.Batch.CreateJobScheduleParameters;

    @doc("Optional parameters for Create Job Schedule operation.")
    options?: CreateBatchJobScheduleOptions;
  },
  void
>;

@@override(Azure.Batch.JobSchedules.createJobSchedule,
  createJobScheduleCustomization,
  "java"
);

// List Job Schedules Operation
@doc("Optional parameters for List Job Schedules operation.")
model ListBatchJobSchedulesOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListJobSchedulesParameters;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Custom override for List Job Schedules operation.")
@route("/jobschedules")
op listJobSchedulesCustomization is Azure.Batch.ListOperationNew<
  {
    @doc("Optional parameters for List Job Schedules operation.")
    options?: ListBatchJobSchedulesOptions;
  },
  Azure.Batch.BatchJobScheduleListResult
>;

@@override(Azure.Batch.JobSchedules.listJobSchedules,
  listJobSchedulesCustomization,
  "java"
);

// Create Task Operation
@doc("Optional parameters for Create Task operation.")
model CreateBatchTaskOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Create Task operation.")
@route("/jobs/{jobId}/tasks")
op createTaskCustomization is Azure.Batch.CreateOperationNew<
  {
    ...Azure.Batch.CreateTaskRequiredParameters;

    @doc("Optional parameters for Create Task operation.")
    options?: CreateBatchTaskOptions;
  },
  void
>;

@@override(Azure.Batch.Tasks.createTask, createTaskCustomization, "java");

// List Tasks Operation
@doc("Optional parameters for List Tasks operation.")
model ListBatchTasksOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListTasksParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Tasks operation.")
@route("/jobs")
op listTasksCustomization is Azure.Batch.ListOperationNew<
  {
    ...Azure.Batch.ListTasksRequiredParameters;

    @doc("Optional parameters for List Tasks operation.")
    options?: ListBatchTasksOptions;
  },
  Azure.Batch.BatchTaskListResult
>;

@@override(Azure.Batch.Tasks.listTasks, listTasksCustomization, "java");

// Create Task Collection Operation
@doc("Optional parameters for Create Task Collection operation.")
model CreateBatchTaskCollectionOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Create Task Collection operation.")
@route("/jobs/{jobId}/addtaskcollection")
op createTaskCollectionCustomization is Azure.Batch.PostOperationNew<
  {
    ...Azure.Batch.CreateTaskCollectionParameters;

    @doc("Optional parameters for Create Task Collection operation.")
    options?: CreateBatchTaskCollectionOptions;
  },
  Azure.Batch.BatchTaskAddCollectionResult
>;

@@override(Azure.Batch.Tasks.createTaskCollection,
  createTaskCollectionCustomization,
  "java"
);

// List SubTasks Operation
@doc("Optional parameters for List SubTasks operation.")
model ListBatchSubTasksOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.ListSubTasksParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List SubTasks operation.")
@route("/jobs/{jobId}/tasks/{taskId}/subtasksinfo")
op listSubTasksCustomization is Azure.Batch.ReadOperationNew<
  {
    ...Azure.Batch.ListSubTasksRequiredParameters;

    @doc("Optional parameters for List SubTasks operation.")
    options?: ListBatchSubTasksOptions;
  },
  Azure.Batch.BatchTaskListSubtasksResult
>;

@@override(Azure.Batch.Tasks.listSubTasks, listSubTasksCustomization, "java");

// Delete Task File Operation
@doc("Optional parameters for Delete Task File operation.")
model DeleteBatchTaskFileOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.DeleteTaskFileOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Delete Task File operation.")
@route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
op deleteTaskFileCustomization is Azure.Batch.DeleteOperationNew<
  {
    ...Azure.Batch.BatchTaskFileClientPathContent;

    @doc("Optional parameters for Delete Task File operation.")
    options?: DeleteBatchTaskFileOptions;
  },
  Azure.Batch.DeleteTaskFileResponse
>;

@@override(Azure.Batch.Tasks.deleteTaskFile,
  deleteTaskFileCustomization,
  "java"
);

// List Task Files Operation
@doc("Optional parameters for List Task Files operation.")
model ListBatchTaskFilesOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListTaskFilesOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Task Files operation.")
@route("/jobs/{jobId}/tasks/{taskId}/files")
op listTaskFilesCustomization is Azure.Batch.ListOperationNew<
  {
    ...Azure.Batch.ListTaskFilesRequiredParameters;

    @doc("Optional parameters for List Task Files operation.")
    options?: ListBatchTaskFilesOptions;
  },
  Azure.Batch.BatchNodeFileListResult
>;

@@override(Azure.Batch.Tasks.listTaskFiles, listTaskFilesCustomization, "java");

// Create Node User Operation
@doc("Optional parameters for Create Node User operation.")
model CreateBatchNodeUserOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Create Node User operation.")
@route("/pools/{poolId}/nodes/{nodeId}/users")
op createNodeUserCustomization is Azure.Batch.CreateOperationNew<
  {
    ...Azure.Batch.CreateNodeUserRequiredParameters;

    @doc("Optional parameters for Create Node User operation.")
    options?: CreateBatchNodeUserOptions;
  },
  void
>;

@@override(Azure.Batch.Nodes.createNodeUser,
  createNodeUserCustomization,
  "java"
);

// Delete Node User Operation
@doc("Optional parameters for Delete Node User operation.")
model DeleteBatchNodeUserOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Delete Node User operation.")
@route("/pools/{poolId}/nodes/{nodeId}/users/{userName}")
op deleteNodeUserCustomization is Azure.Batch.DeleteOperationNew<
  {
    ...Azure.Batch.DeleteNodeUserRequiredParameters;

    @doc("Optional parameters for Delete Node User operation.")
    options?: DeleteBatchNodeUserOptions;
  },
  Azure.Batch.DeleteNodeUserResponse
>;

@@override(Azure.Batch.Nodes.deleteNodeUser,
  deleteNodeUserCustomization,
  "java"
);

// Replace Node User Operation
@doc("Optional parameters for Replace Node User operation.")
model ReplaceBatchNodeUserOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Replace Node User operation.")
@route("/pools/{poolId}/nodes/{nodeId}/users/{userName}")
op replaceNodeUserCustomization is Azure.Batch.ReplaceOperationNew<
  {
    ...Azure.Batch.ReplaceNodeUserRequiredParameters;

    @doc("Optional parameters for Replace Node User operation.")
    options?: ReplaceBatchNodeUserOptions;
  },
  Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.Nodes.replaceNodeUser,
  replaceNodeUserCustomization,
  "java"
);

// Get Node Operation
@doc("Optional parameters for Get Node operation.")
model GetBatchNodeOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.GetNodeOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Node operation.")
@route("/pools/{poolId}/nodes/{nodeId}")
op getNodeCustomization is Azure.Batch.ReadOperationNew<
  {
    ...Azure.Batch.GetNodeRequiredParameters;

    @doc("Optional parameters for Get Node operation.")
    options?: GetBatchNodeOptions;
  },
  Azure.Batch.BatchNode
>;

@@override(Azure.Batch.Nodes.getNode, getNodeCustomization, "java");

// Reboot Node Operation
@doc("Optional parameters for Reboot Node operation.")
model RebootBatchNodeOptions {
  ...Azure.Batch.CommonJsonParameters;
  ...Azure.Batch.RebootNodeOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Reboot Node operation.")
@route("/pools/{poolId}/nodes/{nodeId}/reboot")
op rebootNodeCustomization is Azure.Batch.PostOperationNew<
  {
    ...Azure.Batch.RebootNodeRequiredParameters;

    @doc("Optional parameters for Reboot Node operation.")
    options?: RebootBatchNodeOptions;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Nodes.rebootNode, rebootNodeCustomization, "java");

// Start Node Operation
@doc("Optional parameters for Start Node operation.")
model StartBatchNodeOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Start Node operation.")
@route("/pools/{poolId}/nodes/{nodeId}/start")
op startNodeCustomization is Azure.Batch.PostOperationNew<
  {
    ...Azure.Batch.StartNodeRequiredParameters;

    @doc("Optional parameters for Start Node operation.")
    options?: StartBatchNodeOptions;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Nodes.startNode, startNodeCustomization, "java");

// Deallocate Node Operation
@doc("Optional parameters for Deallocate Node operation.")
model DeallocateBatchNodeOptions {
  ...Azure.Batch.CommonJsonParameters;
  ...Azure.Batch.DeallocateNodeOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Deallocate Node operation.")
@route("/pools/{poolId}/nodes/{nodeId}/deallocate")
op deallocateNodeCustomization is Azure.Batch.PostOperationNew<
  {
    ...Azure.Batch.DeallocateNodeRequiredParameters;

    @doc("Optional parameters for Deallocate Node operation.")
    options?: DeallocateBatchNodeOptions;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Nodes.deallocateNode,
  deallocateNodeCustomization,
  "java"
);
