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
model BatchApplicationGetOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Application operation.")
@route("/applications/{applicationId}")
op getApplicationCustomization is Azure.Batch.ReadOperation<
  {
    ...Azure.Batch.GetApplicationRequiredParameters;

    @doc("Optional parameters for Get Application operation.")
    options?: BatchApplicationGetOptions;
  },
  Azure.Batch.BatchApplication
>;

@@override(Azure.Batch.Applications.getApplication,
  getApplicationCustomization,
  "java"
);

// List Applications Operation

@doc("Optional parameters for List Applications operation.")
model BatchApplicationsListOptions {
  ...Azure.Batch.CommonListParameters;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Custom override for List Applications operation.")
@route("/applications")
op listApplicationsCustomization is Azure.Batch.ListOperation<
  {
    @doc("Optional parameters for List Applications operation.")
    options?: BatchApplicationsListOptions;
  },
  Azure.Batch.BatchApplicationListResult
>;

@@override(Azure.Batch.Applications.listApplications,
  listApplicationsCustomization,
  "java"
);

// List Pool Usage Metrics Operation
@doc("Optional parameters for List Pool Usage Metrics operation.")
model BatchPoolUsageMetricsListOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListPoolUsageMetricsOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Custom override for List Pool Usage Metrics operation.")
@route("/poolusagemetrics")
op listPoolUsageMetricsCustomization is Azure.Batch.ListOperation<
  {
    @doc("Optional parameters for List Pool Usage Metrics operation.")
    options?: BatchPoolUsageMetricsListOptions;
  },
  Azure.Batch.BatchPoolListUsageMetricsResult
>;

@@override(Azure.Batch.Pools.listPoolUsageMetrics,
  listPoolUsageMetricsCustomization,
  "java"
);

// Create Pool Operation
@doc("Optional parameters for Create Pool operation.")
model BatchPoolCreateOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Custom override for Create Pool operation.")
@route("/pools")
op createPoolCustomization is Azure.Batch.CreateOperation<
  {
    ...Azure.Batch.CreatePoolRequiredParameters;

    @doc("Optional parameters for Create Pool operation.")
    options?: BatchPoolCreateOptions;
  },
  void
>;

@@override(Azure.Batch.Pools.createPool, createPoolCustomization, "java");

// List Pools Operation
@doc("Optional parameters for List Pools operation.")
model BatchPoolsListOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListPoolsOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Custom override for List Pools operation.")
@route("/pools")
op listPoolsCustomization is Azure.Batch.ListOperation<
  {
    @doc("Optional parameters for List Pools operation.")
    options?: BatchPoolsListOptions;
  },
  Azure.Batch.BatchPoolListResult
>;

@@override(Azure.Batch.Pools.listPools, listPoolsCustomization, "java");

// Delete Pool Operation
@doc("Optional parameters for Delete Pool operation.")
model BatchPoolDeleteOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Delete Pool operation.")
@route("/pools/{poolId}")
op deletePoolCustomization is Azure.Batch.DeleteOperation<
  {
    ...Azure.Batch.DeletePoolRequiredParameters;

    @doc("Optional parameters for Delete Pool operation.")
    options?: BatchPoolDeleteOptions;

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
op poolExistsCustomization is Azure.Batch.ResourceInfoOperationWithAdditionalResponse<
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
model BatchPoolGetOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.GetPoolOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Pool operation.")
@route("/pools/{poolId}")
op getPoolCustomization is Azure.Batch.ReadOperation<
  {
    ...Azure.Batch.GetPoolRequiredParameters;

    @doc("Optional parameters for Get Pool operation.")
    options?: BatchPoolGetOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.BatchPool
>;

@@override(Azure.Batch.Pools.getPool, getPoolCustomization, "java");

// Update Pool Operation
@doc("Optional parameters for Update Pool operation.")
model BatchPoolUpdateOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Update Pool operation.")
@route("/pools/{poolId}")
op updatePoolCustomization is Azure.Batch.UpdateOperation<
  {
    ...Azure.Batch.UpdatePoolRequiredParameters;

    @doc("Optional parameters for Update Pool operation.")
    options?: BatchPoolUpdateOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.Pools.updatePool, updatePoolCustomization, "java");

// Disable Pool Autoscale Operation
@doc("Optional parameters for Disable Pool AutoScale operation.")
model BatchPoolAutoScaleDisableOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Disable Pool AutoScale operation.")
@route("/pools/{poolId}/disableautoscale")
op disablePoolAutoScaleCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.DisablePoolAutoscaleRequiredParameters;

    @doc("Optional parameters for Disable Pool AutoScale operation.")
    options?: BatchPoolAutoScaleDisableOptions;
  },
  Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.Pools.disablePoolAutoScale,
  disablePoolAutoScaleCustomization,
  "java"
);

// Enable Pool Autoscale Operation
@doc("Optional parameters for Enable Pool AutoScale operation.")
model BatchPoolAutoScaleEnableOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Enable Pool AutoScale operation.")
@route("/pools/{poolId}/enableautoscale")
op enablePoolAutoScaleCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.EnablePoolAutoscaleRequiredParameters;

    @doc("Optional parameters for Enable Pool AutoScale operation.")
    options?: BatchPoolAutoScaleEnableOptions;

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
model BatchPoolAutoScaleEvaluateOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Evaluate Pool AutoScale operation.")
@route("/pools/{poolId}/evaluateautoscale")
op evaluatePoolAutoScaleCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.EvaluatePoolAutoScaleRequiredParameters;

    @doc("Optional parameters for Evaluate Pool AutoScale operation.")
    options?: BatchPoolAutoScaleEvaluateOptions;
  },
  Azure.Batch.AutoScaleRun & Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.Pools.evaluatePoolAutoScale,
  evaluatePoolAutoScaleCustomization,
  "java"
);

// Resize Pool Operation
@doc("Optional parameters for Resize Pool operation.")
model BatchPoolResizeOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Resize Pool operation.")
@route("/pools/{poolId}/resize")
op resizePoolCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.ResizePoolRequiredParameters;

    @doc("Optional parameters for Resize Pool operation.")
    options?: BatchPoolResizeOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Pools.resizePool, resizePoolCustomization, "java");

// Stop Pool Resize Operation
@doc("Optional parameters for Stop Pool Resize operation.")
model BatchPoolResizeStopOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Stop Pool Resize operation.")
@route("/pools/{poolId}/stopresize")
op stopPoolResizeCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.StopPoolResizeRequiredParameters;

    @doc("Optional parameters for Stop Pool Resize operation.")
    options?: BatchPoolResizeStopOptions;

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
model BatchPoolPropertiesReplaceOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Replace Pool Properties operation.")
@route("/pools/{poolId}/updateproperties")
op replacePoolPropertiesCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.ReplacePoolPropertiesRequiredParameters;

    @doc("Optional parameters for Replace Pool Properties operation.")
    options?: BatchPoolPropertiesReplaceOptions;
  },
  Azure.Batch.NoContentSuccessResponseHeaders
>;

@@override(Azure.Batch.Pools.replacePoolProperties,
  replacePoolPropertiesCustomization,
  "java"
);

// Remove Nodes Operation
@doc("Optional parameters for Remove Nodes operation.")
model BatchNodesRemoveOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Remove Nodes operation.")
@route("/pools/{poolId}/removenodes")
op removeNodesCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.RemoveNodesRequiredParameters;

    @doc("Optional parameters for Remove Nodes operation.")
    options?: BatchNodesRemoveOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Pools.removeNodes, removeNodesCustomization, "java");

// List Supported Images Operation
@doc("Optional parameters for List Supported Images operation.")
model SupportedBatchImagesListOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListSupportedImagesOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Supported Images operation.")
@route("/supportedimages")
op listSupportedImagesCustomization is Azure.Batch.ListOperation<
  {
    @doc("Optional parameters for List Supported Images operation.")
    options?: SupportedBatchImagesListOptions;
  },
  Azure.Batch.BatchAccountListSupportedImagesResult
>;

@@override(Azure.Batch.Pools.listSupportedImages,
  listSupportedImagesCustomization,
  "java"
);

// List Pool Node Counts Operation
@doc("Optional parameters for List Pool Node Counts operation.")
model BatchPoolNodeCountsListOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListPoolNodeCountsOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Pool Node Counts operation.")
@route("/nodecounts")
op listPoolNodeCountsCustomization is Azure.Batch.ListOperation<
  {
    @doc("Optional parameters for List Pool Node Counts operation.")
    options?: BatchPoolNodeCountsListOptions;
  },
  Azure.Batch.BatchPoolNodeCountsListResult
>;

@@override(Azure.Batch.Pools.listPoolNodeCounts,
  listPoolNodeCountsCustomization,
  "java"
);

// Delete Job Operation
@doc("Optional parameters for Delete Job operation.")
model BatchJobDeleteOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.DeleteJobOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Delete Job operation.")
@route("/jobs/{jobId}")
op deleteJobCustomization is Azure.Batch.DeleteOperation<
  {
    ...Azure.Batch.DeleteJobRequiredParameters;

    @doc("Optional parameters for Delete Job operation.")
    options?: BatchJobDeleteOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.DeleteResponseHeaders
>;

@@override(Azure.Batch.Jobs.deleteJob, deleteJobCustomization, "java");

// Get Job Operation
@doc("Optional parameters for Get Job operation.")
model BatchJobGetOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.GetJobOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Job operation.")
@route("/jobs/{jobId}")
op getJobCustomization is Azure.Batch.ReadOperation<
  {
    ...Azure.Batch.GetJobRequiredParameters;

    @doc("Optional parameters for Get Job operation.")
    options?: BatchJobGetOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.BatchJob
>;

@@override(Azure.Batch.Jobs.getJob, getJobCustomization, "java");

// Update Job Operation
@doc("Optional parameters for Update Job operation.")
model BatchJobUpdateOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Update Job operation.")
@route("/jobs/{jobId}")
op updateJobCustomization is Azure.Batch.UpdateOperation<
  {
    ...Azure.Batch.UpdateJobRequiredParameters;

    @doc("Optional parameters for Update Job operation.")
    options?: BatchJobUpdateOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.Jobs.updateJob, updateJobCustomization, "java");

// Replace Job Operation
@doc("Optional parameters for Replace Job operation.")
model BatchJobReplaceOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Replace Job operation.")
@route("/jobs/{jobId}")
op replaceJobCustomization is Azure.Batch.ReplaceOperation<
  {
    ...Azure.Batch.ReplaceJobRequiredParameters;

    @doc("Optional parameters for Replace Job operation.")
    options?: BatchJobReplaceOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.Jobs.replaceJob, replaceJobCustomization, "java");

// Disable Job Operation
@doc("Optional parameters for Disable Job operation.")
model BatchJobDisableOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Disable Job operation.")
@route("/jobs/{jobId}/disable")
op disableJobCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.DisableJobRequiredParameters;

    @doc("Optional parameters for Disable Job operation.")
    options?: BatchJobDisableOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Jobs.disableJob, disableJobCustomization, "java");

// Enable Job Operation
@doc("Optional parameters for Enable Job operation.")
model BatchJobEnableOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Enable Job operation.")
@route("/jobs/{jobId}/enable")
op enableJobCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.EnableJobRequiredParameters;

    @doc("Optional parameters for Enable Job operation.")
    options?: BatchJobEnableOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Jobs.enableJob, enableJobCustomization, "java");

// Terminate Job Operation
@doc("Optional parameters for Terminate Job operation.")
model BatchJobTerminateOptions {
  ...Azure.Batch.CommonJsonParameters;
  ...Azure.Batch.TerminateJobOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Terminate Job operation.")
@route("/jobs/{jobId}/terminate")
op terminateJobCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.TerminateJobRequiredParameters;

    @doc("Optional parameters for Terminate Job operation.")
    options?: BatchJobTerminateOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Jobs.terminateJob, terminateJobCustomization, "java");

// Create Job Operation
@doc("Optional parameters for Create Job operation.")
model BatchJobCreateOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Create Job operation.")
@route("/jobs")
op createJobCustomization is Azure.Batch.CreateOperation<
  {
    ...Azure.Batch.CreateJobRequiredParameters;

    @doc("Optional parameters for Create Job operation.")
    options?: BatchJobCreateOptions;
  },
  void
>;

@@override(Azure.Batch.Jobs.createJob, createJobCustomization, "java");

// List Jobs Operation
@doc("Optional parameters for List Jobs operation.")
model BatchJobsListOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListJobsOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Jobs operation.")
@route("/jobs")
op listJobsCustomization is Azure.Batch.ListOperation<
  {
    @doc("Optional parameters for List Jobs operation.")
    options?: BatchJobsListOptions;
  },
  Azure.Batch.BatchJobListResult
>;

@@override(Azure.Batch.Jobs.listJobs, listJobsCustomization, "java");

// List Jobs From Schedule Operation
@doc("Optional parameters for List Jobs From Schedule operation.")
model BatchJobsFromScheduleListOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListJobsFromScheduleOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Jobs From Schedule operation.")
@route("/jobschedules/{jobScheduleId}/jobs")
op listJobsFromScheduleCustomization is Azure.Batch.ListOperation<
  {
    ...Azure.Batch.ListJobsFromScheduleRequiredParameters;

    @doc("Optional parameters for List Jobs From Schedule operation.")
    options?: BatchJobsFromScheduleListOptions;
  },
  Azure.Batch.BatchJobListResult
>;

@@override(Azure.Batch.Jobs.listJobsFromSchedule,
  listJobsFromScheduleCustomization,
  "java"
);

// List Jobs Preparation and Release Task Status Operation
@doc("Optional parameters for List Jobs From Schedule operation.")
model BatchJobPreparationAndReleaseTaskStatusListOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListJobPreparationAndReleaseTaskStatusOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Jobs Preparation and Release Task Status operation.")
@route("/jobs/{jobId}/jobpreparationandreleasetaskstatus")
op listJobPreparationAndReleaseTaskStatusCustomization is Azure.Batch.ListOperation<
  {
    ...Azure.Batch.ListJobPreparationAndReleaseTaskStatusRequiredParameters;

    @doc("Optional parameters for List Jobs Preparation and Release Task Status operation.")
    options?: BatchJobPreparationAndReleaseTaskStatusListOptions;
  },
  Azure.Batch.BatchJobPreparationAndReleaseTaskStatusListResult
>;

@@override(Azure.Batch.Jobs.listJobPreparationAndReleaseTaskStatus,
  listJobPreparationAndReleaseTaskStatusCustomization,
  "java"
);

// Get Job Task Counts Operation
@doc("Optional parameters for Get Job Task Counts operation.")
model BatchJobTaskCountsGetOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Job Task Counts operation.")
@route("/jobs/{jobId}/taskcounts")
op getJobTaskCountsCustomization is Azure.Batch.ReadOperation<
  {
    ...Azure.Batch.GetJobTaskCountsRequiredParameters;

    @doc("Optional parameters for Get Job Task Counts operation.")
    options?: BatchJobTaskCountsGetOptions;
  },
  Azure.Batch.BatchTaskCountsResult
>;

@@override(Azure.Batch.Jobs.getJobTaskCounts,
  getJobTaskCountsCustomization,
  "java"
);

// Create Certificate Operation
@doc("Optional parameters for Create Certificate operation.")
model BatchCertificateCreateOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Create Certificate operation.")
@route("/certificates")
op createCertificateCustomization is Azure.Batch.CreateOperation<
  {
    ...Azure.Batch.CreateCertificateRequiredParameters;

    @doc("Optional parameters for Create Certificate operation.")
    options?: BatchCertificateCreateOptions;
  },
  void
>;

@@override(Azure.Batch.Certificates.createCertificate,
  createCertificateCustomization,
  "java"
);

// List Certificates Operation
@doc("Optional parameters for List Certificates operation.")
model BatchCertificatesListOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListCertificatesOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Certificates operation.")
@route("/certificates")
op listCertificatesCustomization is Azure.Batch.ListOperation<
  {
    @doc("Optional parameters for List Certificates operation.")
    options?: BatchCertificatesListOptions;
  },
  Azure.Batch.BatchCertificateListResult
>;

@@override(Azure.Batch.Certificates.listCertificates,
  listCertificatesCustomization,
  "java"
);

// Cancel Certificate Deletion Operation
@doc("Optional parameters for Cancel Certificate Deletion operation.")
model BatchCertificateCancelDeletionOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Cancel Certificate Deletion operation.")
@route("/certificates(thumbprintAlgorithm={thumbprintAlgorithm},thumbprint={thumbprint})/canceldelete")
op cancelCertificateDeletionCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.CancelCertificateDeletionRequiredParameters;

    @doc("Optional parameters for Cancel Certificate Deletion operation.")
    options?: BatchCertificateCancelDeletionOptions;
  },
  Azure.Batch.NoContentSuccessResponseHeaders
>;

@@override(Azure.Batch.Certificates.cancelCertificateDeletion,
  cancelCertificateDeletionCustomization,
  "java"
);

// Delete Certificate Operation
@doc("Optional parameters for Delete Certificate operation.")
model BatchCertificateDeleteOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Delete Certificate operation.")
@route("/certificates(thumbprintAlgorithm={thumbprintAlgorithm},thumbprint={thumbprint})")
op deleteCertificateCustomization is Azure.Batch.DeleteOperation<
  {
    ...Azure.Batch.DeleteCertificateRequiredParameters;

    @doc("Optional parameters for Delete Certificate operation.")
    options?: BatchCertificateDeleteOptions;
  },
  Azure.Batch.DeleteCertificateResponse
>;

@@override(Azure.Batch.Certificates.deleteCertificate,
  deleteCertificateCustomization,
  "java"
);

// Get Certificate Operation
@doc("Optional parameters for Get Certificate operation.")
model BatchCertificateGetOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.GetCertificateOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Certificate operation.")
@route("/certificates(thumbprintAlgorithm={thumbprintAlgorithm},thumbprint={thumbprint})")
op getCertificateCustomization is Azure.Batch.ReadOperation<
  {
    ...Azure.Batch.GetCertificateRequiredParameters;

    @doc("Optional parameters for Get Certificate operation.")
    options?: BatchCertificateGetOptions;
  },
  Azure.Batch.BatchCertificate
>;

@@override(Azure.Batch.Certificates.getCertificate,
  getCertificateCustomization,
  "java"
);

// Job Schedule Exists Operation
@doc("Optional parameters for Job Schedule Exists operation.")
model BatchJobScheduleExistsOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Custom override for Job Schedule Exists operation.")
@route("/jobschedules/{jobScheduleId}")
op jobScheduleExistsCustomization is Azure.Batch.ResourceInfoOperationWithAdditionalResponse<
  {
    ...Azure.Batch.JobScheduleExistsRequiredParameters;

    @doc("Optional parameters for Job Schedule Exists operation.")
    options?: BatchJobScheduleExistsOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.JobScheduleDoesExistResponseHeaders,
  Azure.Batch.JobScheduleDoesNotExistResponseHeaders
>;

@@override(Azure.Batch.JobSchedules.jobScheduleExists,
  jobScheduleExistsCustomization,
  "java"
);

// Delete Job Schedule Operation
@doc("Optional parameters for Delete Job Schedule operation.")
model BatchJobScheduleDeleteOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.DeleteJobScheduleOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Delete Job Schedule operation.")
@route("/jobschedules/{jobScheduleId}")
op deleteJobScheduleCustomization is Azure.Batch.DeleteOperation<
  {
    ...Azure.Batch.DeleteJobScheduleRequiredParameters;

    @doc("Optional parameters for Delete Job Schedule operation.")
    options?: BatchJobScheduleDeleteOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.DeleteResponseHeaders
>;

@@override(Azure.Batch.JobSchedules.deleteJobSchedule,
  deleteJobScheduleCustomization,
  "java"
);

// Get Job Schedule Operation
@doc("Optional parameters for Get Job Schedule operation.")
model BatchJobScheduleGetOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.GetJobScheduleOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Job Schedule operation.")
@route("/jobschedules/{jobScheduleId}")
op getJobScheduleCustomization is Azure.Batch.ReadOperation<
  {
    ...Azure.Batch.GetJobScheduleRequiredParameters;

    @doc("Optional parameters for Get Job Schedule operation.")
    options?: BatchJobScheduleGetOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.BatchJobSchedule
>;

@@override(Azure.Batch.JobSchedules.getJobSchedule,
  getJobScheduleCustomization,
  "java"
);

// Update Job Schedule Operation
@doc("Optional parameters for Get Job Schedule operation.")
model BatchJobScheduleUpdateOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Update Job Schedule operation.")
@route("/jobschedules/{jobScheduleId}")
op updateJobScheduleCustomization is Azure.Batch.UpdateOperation<
  {
    ...Azure.Batch.UpdateJobScheduleRequiredParameters;

    @doc("Optional parameters for Update Job Schedule operation.")
    options?: BatchJobScheduleUpdateOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.JobSchedules.updateJobSchedule,
  updateJobScheduleCustomization,
  "java"
);

// Replace Job Schedule Operation
@doc("Optional parameters for Replace Job Schedule operation.")
model BatchJobScheduleReplaceOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Replace Job Schedule operation.")
@route("/jobschedules/{jobScheduleId}")
op replaceJobScheduleCustomization is Azure.Batch.ReplaceOperation<
  {
    ...Azure.Batch.ReplaceJobScheduleRequiredParameters;

    @doc("Optional parameters for Replace Job Schedule operation.")
    options?: BatchJobScheduleReplaceOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.JobSchedules.replaceJobSchedule,
  replaceJobScheduleCustomization,
  "java"
);

// Disable Job Schedule Operation
@doc("Optional parameters for Disable Job Schedule operation.")
model BatchJobScheduleDisableOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Disable Job Schedule operation.")
@route("/jobschedules/{jobScheduleId}/disable")
op disableJobScheduleCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.DisableJobScheduleRequiredParameters;

    @doc("Optional parameters for Disable Job Schedule operation.")
    options?: BatchJobScheduleDisableOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.NoContentSuccessResponseHeaders
>;

@@override(Azure.Batch.JobSchedules.disableJobSchedule,
  disableJobScheduleCustomization,
  "java"
);

// Enable Job Schedule Operation
@doc("Optional parameters for Enable Job Schedule operation.")
model BatchJobScheduleEnableOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Enable Job Schedule operation.")
@route("/jobschedules/{jobScheduleId}/enable")
op enableJobScheduleCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.EnableJobScheduleRequiredParameters;

    @doc("Optional parameters for Enable Job Schedule operation.")
    options?: BatchJobScheduleEnableOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.NoContentSuccessResponseHeaders
>;

@@override(Azure.Batch.JobSchedules.enableJobSchedule,
  enableJobScheduleCustomization,
  "java"
);

// Terminate Job Schedule Operation
@doc("Optional parameters for Terminate Job Schedule operation.")
model BatchJobScheduleTerminateOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.TerminateJobScheduleOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Terminate Job Schedule operation.")
@route("/jobschedules/{jobScheduleId}/terminate")
op terminateJobScheduleCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.TerminateJobScheduleRequiredParameters;

    @doc("Optional parameters for Terminate Job Schedule operation.")
    options?: BatchJobScheduleTerminateOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.JobSchedules.terminateJobSchedule,
  terminateJobScheduleCustomization,
  "java"
);

// Create Job Schedule Operation
@doc("Optional parameters for Create Job Schedule operation.")
model BatchJobScheduleCreateOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Custom override for Create Job Schedule operation.")
@route("/jobschedules")
op createJobScheduleCustomization is Azure.Batch.CreateOperation<
  {
    ...Azure.Batch.CreateJobScheduleRequiredParameters;

    @doc("Optional parameters for Create Job Schedule operation.")
    options?: BatchJobScheduleCreateOptions;
  },
  void
>;

@@override(Azure.Batch.JobSchedules.createJobSchedule,
  createJobScheduleCustomization,
  "java"
);

// List Job Schedules Operation
@doc("Optional parameters for List Job Schedules operation.")
model BatchJobSchedulesListOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListJobSchedulesOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Custom override for List Job Schedules operation.")
@route("/jobschedules")
op listJobSchedulesCustomization is Azure.Batch.ListOperation<
  {
    @doc("Optional parameters for List Job Schedules operation.")
    options?: BatchJobSchedulesListOptions;
  },
  Azure.Batch.BatchJobScheduleListResult
>;

@@override(Azure.Batch.JobSchedules.listJobSchedules,
  listJobSchedulesCustomization,
  "java"
);

// Create Task Operation
@doc("Optional parameters for Create Task operation.")
model BatchTaskCreateOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Create Task operation.")
@route("/jobs/{jobId}/tasks")
op createTaskCustomization is Azure.Batch.CreateOperation<
  {
    ...Azure.Batch.CreateTaskRequiredParameters;

    @doc("Optional parameters for Create Task operation.")
    options?: BatchTaskCreateOptions;
  },
  void
>;

@@override(Azure.Batch.Tasks.createTask, createTaskCustomization, "java");

// List Tasks Operation
@doc("Optional parameters for List Tasks operation.")
model BatchTasksListOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListTasksOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Tasks operation.")
@route("/jobs")
op listTasksCustomization is Azure.Batch.ListOperation<
  {
    ...Azure.Batch.ListTasksRequiredParameters;

    @doc("Optional parameters for List Tasks operation.")
    options?: BatchTasksListOptions;
  },
  Azure.Batch.BatchTaskListResult
>;

@@override(Azure.Batch.Tasks.listTasks, listTasksCustomization, "java");

// Create Task Collection Operation
@doc("Optional parameters for Create Task Collection operation.")
model BatchTaskCollectionCreateOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Create Task Collection operation.")
@route("/jobs/{jobId}/addtaskcollection")
op createTaskCollectionCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.CreateTaskCollectionRequiredParameters;

    @doc("Optional parameters for Create Task Collection operation.")
    options?: BatchTaskCollectionCreateOptions;
  },
  Azure.Batch.BatchCreateTaskCollectionResult
>;

@@override(Azure.Batch.Tasks.createTaskCollection,
  createTaskCollectionCustomization,
  "java"
);

// Delete Task Operation
@doc("Optional parameters for Delete Task operation.")
model BatchTaskDeleteOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Delete Task operation.")
@route("/jobs/{jobId}/tasks/{taskId}")
op deleteTaskCustomization is Azure.Batch.DeleteOperation<
  {
    ...Azure.Batch.DeleteTaskRequiredParameters;

    @doc("Optional parameters for Delete Task operation.")
    options?: BatchTaskDeleteOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.DeleteTaskResponse
>;

@@override(Azure.Batch.Tasks.deleteTask, deleteTaskCustomization, "java");

// Get Task Operation
@doc("Optional parameters for Get Task operation.")
model BatchTaskGetOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.GetTaskOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Task operation.")
@route("/jobs/{jobId}/tasks/{taskId}")
op getTaskCustomization is Azure.Batch.ReadOperation<
  {
    ...Azure.Batch.GetTaskRequiredParameters;

    @doc("Optional parameters for Get Task operation.")
    options?: BatchTaskGetOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.BatchTask & Azure.Batch.DataServiceResponseHeaders
>;

@@override(Azure.Batch.Tasks.getTask, getTaskCustomization, "java");

// Replace Task Operation
@doc("Optional parameters for Replace Task operation.")
model BatchTaskReplaceOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Replace Task operation.")
@route("/jobs/{jobId}/tasks/{taskId}")
op replaceTaskCustomization is Azure.Batch.ReplaceOperation<
  {
    ...Azure.Batch.ReplaceTaskRequiredParameters;

    @doc("Optional parameters for Replace Task operation.")
    options?: BatchTaskReplaceOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.Tasks.replaceTask, replaceTaskCustomization, "java");

// List SubTasks Operation
@doc("Optional parameters for List SubTasks operation.")
model BatchSubTasksListOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.ListSubTasksOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List SubTasks operation.")
@route("/jobs/{jobId}/tasks/{taskId}/subtasksinfo")
op listSubTasksCustomization is Azure.Batch.ReadOperation<
  {
    ...Azure.Batch.ListSubTasksRequiredParameters;

    @doc("Optional parameters for List SubTasks operation.")
    options?: BatchSubTasksListOptions;
  },
  Azure.Batch.BatchTaskListSubtasksResult
>;

@@override(Azure.Batch.Tasks.listSubTasks, listSubTasksCustomization, "java");

// Terminate Task Operation
@doc("Optional parameters for Terminate Task operation.")
model BatchTaskTerminateOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Terminate Task operation.")
@route("/jobs/{jobId}/tasks/{taskId}/terminate")
op terminateTaskCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.TerminateTaskRequiredParameters;

    @doc("Optional parameters for Terminate Task operation.")
    options?: BatchTaskTerminateOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  NoContentResponse & Azure.Batch.DataServiceResponseHeaders
>;

@@override(Azure.Batch.Tasks.terminateTask, terminateTaskCustomization, "java");

// Reactivate Task Operation
@doc("Optional parameters for Reactivate Task operation.")
model BatchTaskReactivateOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Reactivate Task operation.")
@route("/jobs/{jobId}/tasks/{taskId}/reactivate")
op reactivateTaskCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.ReactivateTaskRequiredParameters;

    @doc("Optional parameters for Reactivate Task operation.")
    options?: BatchTaskReactivateOptions;

    ...Azure.Batch.BatchMatchHeaders;
  },
  NoContentResponse & Azure.Batch.DataServiceResponseHeaders
>;

@@override(Azure.Batch.Tasks.reactivateTask,
  reactivateTaskCustomization,
  "java"
);

// Delete Task File Operation
@doc("Optional parameters for Delete Task File operation.")
model BatchTaskFileDeleteOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.DeleteTaskFileOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Delete Task File operation.")
@route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
op deleteTaskFileCustomization is Azure.Batch.DeleteOperation<
  {
    ...Azure.Batch.BatchTaskFileClientPathContent;

    @doc("Optional parameters for Delete Task File operation.")
    options?: BatchTaskFileDeleteOptions;
  },
  Azure.Batch.DeleteTaskFileResponse
>;

@@override(Azure.Batch.Tasks.deleteTaskFile,
  deleteTaskFileCustomization,
  "java"
);

// Get Task File Operation
@doc("Optional parameters for Get Task File operation.")
model BatchTaskFileGetOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.BatchModifiedSinceHeaders;
  ...Azure.Batch.GetTaskFileOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Task File operation.")
@route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
op getTaskFileCustomization is Azure.Batch.FileOperation<
  {
    ...Azure.Batch.BatchTaskFileClientPathContent;

    @doc("Optional parameters for Get Task File operation.")
    options?: BatchTaskFileGetOptions;
  },
  Azure.Batch.GetTaskFileResponse
>;

@@override(Azure.Batch.Tasks.getTaskFile, getTaskFileCustomization, "java");

// Get Task File Properties Operation
@doc("Optional parameters for Get Task File Properties operation.")
model BatchTaskFilePropertiesGetOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.BatchModifiedSinceHeaders;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Task File Properties operation.")
@route("/jobs/{jobId}/tasks/{taskId}/files/{filePath}")
op getTaskFilePropertiesCustomization is Azure.Batch.HeadFileOperation<
  {
    ...Azure.Batch.BatchTaskFileClientPathContent;

    @doc("Optional parameters for Get Task File Properties operation.")
    options?: BatchTaskFilePropertiesGetOptions;
  },
  {}
>;

@@override(Azure.Batch.Tasks.getTaskFileProperties,
  getTaskFilePropertiesCustomization,
  "java"
);

// List Task Files Operation
@doc("Optional parameters for List Task Files operation.")
model BatchTaskFilesListOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListTaskFilesOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Task Files operation.")
@route("/jobs/{jobId}/tasks/{taskId}/files")
op listTaskFilesCustomization is Azure.Batch.ListOperation<
  {
    ...Azure.Batch.ListTaskFilesRequiredParameters;

    @doc("Optional parameters for List Task Files operation.")
    options?: BatchTaskFilesListOptions;
  },
  Azure.Batch.BatchNodeFileListResult
>;

@@override(Azure.Batch.Tasks.listTaskFiles, listTaskFilesCustomization, "java");

// Create Node User Operation
@doc("Optional parameters for Create Node User operation.")
model BatchNodeUserCreateOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Create Node User operation.")
@route("/pools/{poolId}/nodes/{nodeId}/users")
op createNodeUserCustomization is Azure.Batch.CreateOperation<
  {
    ...Azure.Batch.CreateNodeUserRequiredParameters;

    @doc("Optional parameters for Create Node User operation.")
    options?: BatchNodeUserCreateOptions;
  },
  void
>;

@@override(Azure.Batch.Nodes.createNodeUser,
  createNodeUserCustomization,
  "java"
);

// Delete Node User Operation
@doc("Optional parameters for Delete Node User operation.")
model BatchNodeUserDeleteOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Delete Node User operation.")
@route("/pools/{poolId}/nodes/{nodeId}/users/{userName}")
op deleteNodeUserCustomization is Azure.Batch.DeleteOperation<
  {
    ...Azure.Batch.DeleteNodeUserRequiredParameters;

    @doc("Optional parameters for Delete Node User operation.")
    options?: BatchNodeUserDeleteOptions;
  },
  Azure.Batch.DeleteNodeUserResponse
>;

@@override(Azure.Batch.Nodes.deleteNodeUser,
  deleteNodeUserCustomization,
  "java"
);

// Replace Node User Operation
@doc("Optional parameters for Replace Node User operation.")
model BatchNodeUserReplaceOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Replace Node User operation.")
@route("/pools/{poolId}/nodes/{nodeId}/users/{userName}")
op replaceNodeUserCustomization is Azure.Batch.ReplaceOperation<
  {
    ...Azure.Batch.ReplaceNodeUserRequiredParameters;

    @doc("Optional parameters for Replace Node User operation.")
    options?: BatchNodeUserReplaceOptions;
  },
  Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.Nodes.replaceNodeUser,
  replaceNodeUserCustomization,
  "java"
);

// Get Node Operation
@doc("Optional parameters for Get Node operation.")
model BatchNodeGetOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.GetNodeOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Node operation.")
@route("/pools/{poolId}/nodes/{nodeId}")
op getNodeCustomization is Azure.Batch.ReadOperation<
  {
    ...Azure.Batch.GetNodeRequiredParameters;

    @doc("Optional parameters for Get Node operation.")
    options?: BatchNodeGetOptions;
  },
  Azure.Batch.BatchNode
>;

@@override(Azure.Batch.Nodes.getNode, getNodeCustomization, "java");

// Reboot Node Operation
@doc("Optional parameters for Reboot Node operation.")
model BatchNodeRebootOptions {
  ...Azure.Batch.CommonJsonParameters;
  ...Azure.Batch.RebootNodeOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Reboot Node operation.")
@route("/pools/{poolId}/nodes/{nodeId}/reboot")
op rebootNodeCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.RebootNodeRequiredParameters;

    @doc("Optional parameters for Reboot Node operation.")
    options?: BatchNodeRebootOptions;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Nodes.rebootNode, rebootNodeCustomization, "java");

// Start Node Operation
@doc("Optional parameters for Start Node operation.")
model BatchNodeStartOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Start Node operation.")
@route("/pools/{poolId}/nodes/{nodeId}/start")
op startNodeCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.StartNodeRequiredParameters;

    @doc("Optional parameters for Start Node operation.")
    options?: BatchNodeStartOptions;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Nodes.startNode, startNodeCustomization, "java");

// Deallocate Node Operation
@doc("Optional parameters for Deallocate Node operation.")
model BatchNodeDeallocateOptions {
  ...Azure.Batch.CommonJsonParameters;
  ...Azure.Batch.DeallocateNodeOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Deallocate Node operation.")
@route("/pools/{poolId}/nodes/{nodeId}/deallocate")
op deallocateNodeCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.DeallocateNodeRequiredParameters;

    @doc("Optional parameters for Deallocate Node operation.")
    options?: BatchNodeDeallocateOptions;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Nodes.deallocateNode,
  deallocateNodeCustomization,
  "java"
);

// Reimage Node Operation
@doc("Optional parameters for Reimage Node operation.")
model BatchNodeReimageOptions {
  ...Azure.Batch.CommonJsonParameters;
  ...Azure.Batch.ReimageNodeOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Reimage Node operation.")
@route("/pools/{poolId}/nodes/{nodeId}/reimage")
op reimageNodeCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.ReimageNodeRequiredParameters;

    @doc("Optional parameters for Reimage Node operation.")
    options?: BatchNodeReimageOptions;
  },
  Azure.Batch.AcceptedProcessingResponseHeaders
>;

@@override(Azure.Batch.Nodes.reimageNode, reimageNodeCustomization, "java");

// Disable Node Scheduling Operation
@doc("Optional parameters for Disable Node Scheduling operation.")
model BatchNodeSchedulingDisableOptions {
  ...Azure.Batch.CommonJsonParameters;
  ...Azure.Batch.DisableNodeSchedulingOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Disable Node Scheduling operation.")
@route("/pools/{poolId}/nodes/{nodeId}/disablescheduling")
op disableNodeSchedulingCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.DisableNodeSchedulingRequiredParameters;

    @doc("Optional parameters for Disable Node Scheduling operation.")
    options?: BatchNodeSchedulingDisableOptions;
  },
  Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.Nodes.disableNodeScheduling,
  disableNodeSchedulingCustomization,
  "java"
);

// Enable Node Scheduling Operation
@doc("Optional parameters for Enable Node Scheduling operation.")
model BatchNodeSchedulingEnableOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Enable Node Scheduling operation.")
@route("/pools/{poolId}/nodes/{nodeId}/enablescheduling")
op enableNodeSchedulingCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.EnableNodeSchedulingRequiredParameters;

    @doc("Optional parameters for Enable Node Scheduling operation.")
    options?: BatchNodeSchedulingEnableOptions;
  },
  Azure.Batch.RequestSuccessResponseHeaders
>;

@@override(Azure.Batch.Nodes.enableNodeScheduling,
  enableNodeSchedulingCustomization,
  "java"
);

// Get Node Remote Login Settings Operation
@doc("Optional parameters for Get Node Remote Login Settings operation.")
model BatchNodeRemoteLoginSettingsGetOptions {
  ...Azure.Batch.CommonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Node Remote Login Settings operation.")
@route("/pools/{poolId}/nodes/{nodeId}/remoteloginsettings")
op getNodeRemoteLoginSettingsCustomization is Azure.Batch.ReadOperation<
  {
    ...Azure.Batch.GetNodeRemoteLoginSettingsRequiredParameters;

    @doc("Optional parameters for Get Node Remote Login Settings operation.")
    options?: BatchNodeRemoteLoginSettingsGetOptions;
  },
  Azure.Batch.BatchNodeRemoteLoginSettings
>;

@@override(Azure.Batch.Nodes.getNodeRemoteLoginSettings,
  getNodeRemoteLoginSettingsCustomization,
  "java"
);

// Upload Node Logs Operation
@doc("Optional parameters for Upload Node Logs operation.")
model BatchNodeLogsUploadOptions {
  ...Azure.Batch.CommonJsonParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Upload Node Logs operation.")
@route("/pools/{poolId}/nodes/{nodeId}/uploadbatchservicelogs")
op uploadNodeLogsCustomization is Azure.Batch.PostOperation<
  {
    ...Azure.Batch.UploadNodeLogsRequiredParameters;

    @doc("Optional parameters for Upload Node Logs operation.")
    options?: BatchNodeLogsUploadOptions;
  },
  Azure.Batch.UploadBatchServiceLogsResult
>;

@@override(Azure.Batch.Nodes.uploadNodeLogs,
  uploadNodeLogsCustomization,
  "java"
);

// List Nodes Operation
@doc("Optional parameters for List Nodes operation.")
model BatchNodesListOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListNodesOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Nodes operation.")
@route("/pools/{poolId}/nodes")
op listNodesCustomization is Azure.Batch.ListOperation<
  {
    ...Azure.Batch.ListNodesRequiredParameters;

    @doc("Optional parameters for List Nodes operation.")
    options?: BatchNodesListOptions;
  },
  Azure.Batch.BatchNodeListResult
>;

@@override(Azure.Batch.Nodes.listNodes, listNodesCustomization, "java");

// Get Node Extension Operation
@doc("Optional parameters for Get Node Extension operation.")
model BatchNodeExtensionGetOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.GetNodeExtensionOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Node Extension operation.")
@route("/pools/{poolId}/nodes/{nodeId}/extensions/{extensionName}")
op getNodeExtensionCustomization is Azure.Batch.ReadOperation<
  {
    ...Azure.Batch.GetNodeExtensionRequiredParameters;

    @doc("Optional parameters for Get Node Extension operation.")
    options?: BatchNodeExtensionGetOptions;
  },
  Azure.Batch.BatchNodeVMExtension
>;

@@override(Azure.Batch.Nodes.getNodeExtension,
  getNodeExtensionCustomization,
  "java"
);

// List Node Extensions Operation
@doc("Optional parameters for List Node Extensions operation.")
model BatchNodeExtensionsListOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListNodeExtensionsOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Node Extensions operation.")
@route("/pools/{poolId}/nodes/{nodeId}/extensions")
op listNodeExtensionsCustomization is Azure.Batch.ListOperation<
  {
    ...Azure.Batch.ListNodeExtensionsRequiredParameters;

    @doc("Optional parameters for List Node Extensions operation.")
    options?: BatchNodeExtensionsListOptions;
  },
  Azure.Batch.BatchNodeVMExtensionListResult
>;

@@override(Azure.Batch.Nodes.listNodeExtensions,
  listNodeExtensionsCustomization,
  "java"
);

// Delete Node File Operation
@doc("Optional parameters for Delete Node File operation.")
model BatchNodeFileDeleteOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.DeleteNodeFileOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Delete Node File operation.")
@route("/pools/{poolId}/nodes/{nodeId}/files/{filePath}")
op deleteNodeFileCustomization is Azure.Batch.DeleteOperation<
  {
    ...Azure.Batch.BatchNodeFileClientPathContent;

    @doc("Optional parameters for Delete Node File operation.")
    options?: BatchNodeFileDeleteOptions;
  },
  Azure.Batch.DeleteNodeFileResponse
>;

@@override(Azure.Batch.Nodes.deleteNodeFile,
  deleteNodeFileCustomization,
  "java"
);

// Get Node File Operation
@doc("Optional parameters for Get Node File operation.")
model BatchNodeFileGetOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.BatchModifiedSinceHeaders;
  ...Azure.Batch.GetNodeFileOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Node File operation.")
@route("/pools/{poolId}/nodes/{nodeId}/files/{filePath}")
op getNodeFileCustomization is Azure.Batch.FileOperation<
  {
    ...Azure.Batch.BatchNodeFileClientPathContent;

    @doc("Optional parameters for Get Node File operation.")
    options?: BatchNodeFileGetOptions;
  },
  Azure.Batch.GetNodeFileResponse
>;

@@override(Azure.Batch.Nodes.getNodeFile, getNodeFileCustomization, "java");

// Get Node File Properties Operation
@doc("Optional parameters for Get Node File Properties operation.")
model BatchNodeFilePropertiesGetOptions {
  ...Azure.Batch.CommonParameters;
  ...Azure.Batch.BatchModifiedSinceHeaders;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for Get Node File Properties operation.")
@route("/pools/{poolId}/nodes/{nodeId}/files/{filePath}")
op getNodeFilePropertiesCustomization is Azure.Batch.HeadFileOperation<
  {
    ...Azure.Batch.BatchNodeFileClientPathContent;

    @doc("Optional parameters for Get Node File Properties operation.")
    options?: BatchNodeFilePropertiesGetOptions;
  },
  {}
>;

@@override(Azure.Batch.Nodes.getNodeFileProperties,
  getNodeFilePropertiesCustomization,
  "java"
);

// List Node Files Operation
@doc("Optional parameters for List Node Files operation.")
model BatchNodeFilesListOptions {
  ...Azure.Batch.CommonListParameters;
  ...Azure.Batch.ListNodeFilesOptionalParameters;
}

#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@doc("Custom override for List Node Files operation.")
@route("/pools/{poolId}/nodes/{nodeId}/files")
op listNodeFilesCustomization is Azure.Batch.ListOperation<
  {
    ...Azure.Batch.ListNodeFilesRequiredParameters;

    @doc("Optional parameters for List Node Files operation.")
    options?: BatchNodeFilesListOptions;
  },
  Azure.Batch.BatchNodeFileListResult
>;

@@override(Azure.Batch.Nodes.listNodeFiles, listNodeFilesCustomization, "java");
