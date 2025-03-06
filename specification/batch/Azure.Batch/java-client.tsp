import "./common.tsp";
import "./main.tsp";
import "./routes.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";

using global.Azure.Core.Foundations;
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
