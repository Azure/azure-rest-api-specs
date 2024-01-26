import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// operation overrides
@@access(Azure.Batch.Ops.ListOperation, Access.internal, "java");
@@access(Azure.Batch.Ops.ReadOperation, Access.internal, "java");
@@access(Azure.Batch.Ops.DeleteOperation, Access.internal, "java");
@@access(Azure.Batch.Ops.CreateOperation, Access.internal, "java");
@@access(Azure.Batch.Ops.UpdateOperation, Access.internal, "java");
@@access(Azure.Batch.Ops.ReplaceOperation, Access.internal, "java");
@@access(Azure.Batch.Ops.PostOperation, Access.internal, "java");
@@access(Azure.Batch.Ops.ResourceInfoOperation, Access.internal, "java");
@@access(Azure.Batch.Ops.ResourceInfoOperationWithAdditionalResponse,
  Access.internal,
  "java"
);

// model overrides
@@access(Azure.Batch.BatchApplicationListResult, Access.public, "java");
@@access(Azure.Batch.BatchApplication, Access.public, "java");
@@access(Azure.Batch.BatchPoolListUsageMetricsResult, Access.public, "java");
@@access(Azure.Batch.BatchPoolCreateParameters, Access.public, "java");
@@access(Azure.Batch.BatchPoolListResult, Access.public, "java");
@@access(Azure.Batch.BatchPool, Access.public, "java");
@@access(Azure.Batch.BatchPoolUpdateParameters, Access.public, "java");
@@access(Azure.Batch.BatchPoolEnableAutoScaleParameters, Access.public, "java");
@@access(Azure.Batch.BatchPoolEvaluateAutoScaleParameters,
  Access.public,
  "java"
);
@@access(Azure.Batch.AutoScaleRun, Access.public, "java");
@@access(Azure.Batch.BatchPoolResizeParameters, Access.public, "java");
@@access(Azure.Batch.BatchPoolReplaceParameters, Access.public, "java");
@@access(Azure.Batch.BatchNodeRemoveParameters, Access.public, "java");
@@access(Azure.Batch.BatchAccountListSupportedImagesResult,
  Access.public,
  "java"
);
@@access(Azure.Batch.BatchPoolNodeCountsListResult, Access.public, "java");
@@access(Azure.Batch.BatchJob, Access.public, "java");
@@access(Azure.Batch.BatchJobUpdateParameters, Access.public, "java");
@@access(Azure.Batch.BatchJobDisableParameters, Access.public, "java");
@@access(Azure.Batch.BatchJobTerminateParameters, Access.public, "java");
@@access(Azure.Batch.BatchJobCreateParameters, Access.public, "java");
@@access(Azure.Batch.BatchJobListResult, Access.public, "java");
@@access(Azure.Batch.BatchJobPreparationAndReleaseTaskStatusListResult,
  Access.public,
  "java"
);
@@access(Azure.Batch.BatchTaskCountsResult, Access.public, "java");
@@access(Azure.Batch.BatchCertificate, Access.public, "java");
@@access(Azure.Batch.BatchCertificateListResult, Access.public, "java");
@@access(Azure.Batch.BatchJobSchedule, Access.public, "java");
@@access(Azure.Batch.BatchJobScheduleUpdateParameters, Access.public, "java");
@@access(Azure.Batch.BatchJobScheduleCreateParameters, Access.public, "java");
@@access(Azure.Batch.BatchJobScheduleListResult, Access.public, "java");
@@access(Azure.Batch.BatchTaskCreateParameters, Access.public, "java");
@@access(Azure.Batch.BatchTaskListResult, Access.public, "java");
@@access(Azure.Batch.BatchTaskCollection, Access.public, "java");
@@access(Azure.Batch.BatchTaskAddCollectionResult, Access.public, "java");
@@access(Azure.Batch.BatchTask, Access.public, "java");
@@access(Azure.Batch.BatchTaskListSubtasksResult, Access.public, "java");
@@access(Azure.Batch.BatchTaskFileClientPathParameters, Access.public, "java");
@@access(Azure.Batch.BatchNodeFileListResult, Access.public, "java");
@@access(Azure.Batch.BatchNodeUserCreateParameters, Access.public, "java");
@@access(Azure.Batch.BatchNodeUserUpdateParameters, Access.public, "java");
@@access(Azure.Batch.BatchNode, Access.public, "java");
@@access(Azure.Batch.BatchNodeRebootParameters, Access.public, "java");
@@access(Azure.Batch.BatchNodeReimageParameters, Access.public, "java");
@@access(Azure.Batch.BatchNodeDisableSchedulingParameters,
  Access.public,
  "java"
);
@@access(Azure.Batch.BatchNodeRemoteLoginSettings, Access.public, "java");
@@access(Azure.Batch.UploadBatchServiceLogsParameters, Access.public, "java");
@@access(Azure.Batch.UploadBatchServiceLogsResult, Access.public, "java");
@@access(Azure.Batch.BatchNodeListResult, Access.public, "java");
@@access(Azure.Batch.BatchNodeVMExtension, Access.public, "java");
@@access(Azure.Batch.BatchNodeVMExtensionListResult, Access.public, "java");
@@access(Azure.Batch.BatchNodeFileClientPathParameters, Access.public, "java");
@@access(Azure.Batch.BatchNodeFileListResult, Access.public, "java");
@@access(Azure.Batch.BatchError, Access.public, "java");
