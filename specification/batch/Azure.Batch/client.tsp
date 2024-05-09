import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// operation overrides
@@access(Azure.Batch.ListOperation, Access.internal, "java");
@@access(Azure.Batch.ReadOperation, Access.internal, "java");
@@access(Azure.Batch.DeleteOperation, Access.internal, "java");
@@access(Azure.Batch.CreateOperation, Access.internal, "java");
@@access(Azure.Batch.UpdateOperation, Access.internal, "java");
@@access(Azure.Batch.ReplaceOperation, Access.internal, "java");
@@access(Azure.Batch.PostOperation, Access.internal, "java");
@@access(Azure.Batch.FileOperation, Access.internal, "java");
@@access(Azure.Batch.HeadFileOperation, Access.internal, "java");
@@access(Azure.Batch.ResourceInfoOperationWithAdditionalResponse,
  Access.internal,
  "java"
);

// Api overrides
@@access(Azure.Batch.BatchClient.poolExists, Access.internal, "csharp");
@@access(Azure.Batch.BatchClient.jobScheduleExists, Access.internal, "csharp");
@@access(Azure.Batch.BatchClient.getTaskFileProperties,
  Access.internal,
  "csharp"
);
@@access(Azure.Batch.BatchClient.getNodeFileProperties,
  Access.internal,
  "csharp"
);

// model overrides
@@access(Azure.Batch.BatchApplicationListResult, Access.public, "java");
@@access(Azure.Batch.BatchApplication, Access.public, "java");
@@access(Azure.Batch.BatchPoolListUsageMetricsResult, Access.public, "java");
@@access(Azure.Batch.BatchPoolCreateContent, Access.public, "java");
@@access(Azure.Batch.BatchPoolListResult, Access.public, "java");
@@access(Azure.Batch.BatchPool, Access.public, "java");
@@access(Azure.Batch.BatchPoolUpdateContent, Access.public, "java");
@@access(Azure.Batch.BatchPoolEnableAutoScaleContent, Access.public, "java");
@@access(Azure.Batch.BatchPoolEvaluateAutoScaleContent, Access.public, "java");
@@access(Azure.Batch.AutoScaleRun, Access.public, "java");
@@access(Azure.Batch.BatchPoolResizeContent, Access.public, "java");
@@access(Azure.Batch.BatchPoolReplaceContent, Access.public, "java");
@@access(Azure.Batch.BatchNodeRemoveContent, Access.public, "java");
@@access(Azure.Batch.BatchAccountListSupportedImagesResult,
  Access.public,
  "java"
);
@@access(Azure.Batch.BatchPoolNodeCountsListResult, Access.public, "java");
@@access(Azure.Batch.BatchJob, Access.public, "java");
@@access(Azure.Batch.BatchJobUpdateContent, Access.public, "java");
@@access(Azure.Batch.BatchJobDisableContent, Access.public, "java");
@@access(Azure.Batch.BatchJobTerminateContent, Access.public, "java");
@@access(Azure.Batch.BatchJobCreateContent, Access.public, "java");
@@access(Azure.Batch.BatchJobListResult, Access.public, "java");
@@access(Azure.Batch.BatchJobPreparationAndReleaseTaskStatusListResult,
  Access.public,
  "java"
);
@@access(Azure.Batch.BatchTaskCountsResult, Access.public, "java");
@@access(Azure.Batch.BatchJobSchedule, Access.public, "java");
@@access(Azure.Batch.BatchJobScheduleUpdateContent, Access.public, "java");
@@access(Azure.Batch.BatchJobScheduleCreateContent, Access.public, "java");
@@access(Azure.Batch.BatchJobScheduleListResult, Access.public, "java");
@@access(Azure.Batch.BatchTaskCreateContent, Access.public, "java");
@@access(Azure.Batch.BatchTaskListResult, Access.public, "java");
@@access(Azure.Batch.BatchTaskGroup, Access.public, "java");
@@access(Azure.Batch.BatchTaskAddCollectionResult, Access.public, "java");
@@access(Azure.Batch.BatchTask, Access.public, "java");
@@access(Azure.Batch.BatchTaskListSubtasksResult, Access.public, "java");
@@access(Azure.Batch.BatchTaskFileClientPathContent, Access.public, "java");
@@access(Azure.Batch.BatchNodeFileListResult, Access.public, "java");
@@access(Azure.Batch.BatchNodeUserCreateContent, Access.public, "java");
@@access(Azure.Batch.BatchNodeUserUpdateContent, Access.public, "java");
@@access(Azure.Batch.BatchNode, Access.public, "java");
@@access(Azure.Batch.BatchNodeRebootContent, Access.public, "java");
@@access(Azure.Batch.BatchNodeDisableSchedulingContent, Access.public, "java");
@@access(Azure.Batch.BatchNodeRemoteLoginSettings, Access.public, "java");
@@access(Azure.Batch.UploadBatchServiceLogsContent, Access.public, "java");
@@access(Azure.Batch.UploadBatchServiceLogsResult, Access.public, "java");
@@access(Azure.Batch.BatchNodeListResult, Access.public, "java");
@@access(Azure.Batch.BatchNodeVMExtension, Access.public, "java");
@@access(Azure.Batch.BatchNodeVMExtensionListResult, Access.public, "java");
@@access(Azure.Batch.BatchNodeFileClientPathContent, Access.public, "java");
@@access(Azure.Batch.BatchNodeFileListResult, Access.public, "java");
@@access(Azure.Batch.BatchError, Access.public, "java");
