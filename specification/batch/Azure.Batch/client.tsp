import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(Azure.Batch.Versions.v2024_02_01)
namespace Client;
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@client({
    name: "BatchClient",
    service: Azure.Batch,
  })
  interface Batch {
    listApplicationsInternal is Azure.Batch.Applications.listApplications;
    getApplicationInternal is Azure.Batch.Applications.getApplication;

    listPoolUsageMetricsInternal is Azure.Batch.Pool.listPoolUsageMetrics;
    createPoolInternal is Azure.Batch.Pool.createPool;
    listPoolsInternal is Azure.Batch.Pool.listPools;
    deletePoolInternal is Azure.Batch.Pool.deletePool;
    poolExistsInternal is Azure.Batch.Pool.poolExists;
    getPoolInternal is Azure.Batch.Pool.getPool;
    updatePoolInternal is Azure.Batch.Pool.updatePool;
    disablePoolAutoScaleInternal is Azure.Batch.Pool.disablePoolAutoScale;
    enablePoolAutoScaleInternal is Azure.Batch.Pool.enablePoolAutoScale;
    evaluatePoolAutoScaleInternal is Azure.Batch.Pool.evaluatePoolAutoScale;
    resizePoolInternal is Azure.Batch.Pool.resizePool;
    stopPoolResizeInternal is Azure.Batch.Pool.stopPoolResize;
    replacePoolPropertiesInternal is Azure.Batch.Pool.replacePoolProperties;
    removeNodesInternal is Azure.Batch.Pool.removeNodes;
    listSupportedImagesInternal is Azure.Batch.Pool.listSupportedImages;
    listPoolNodeCountsInternal is Azure.Batch.Pool.listPoolNodeCounts;

    deleteJobInternal is Azure.Batch.Job.deleteJob;
    getJobInternal is Azure.Batch.Job.getJob;
    updateJobInternal is Azure.Batch.Job.updateJob;
    replaceJobInternal is Azure.Batch.Job.replaceJob;
    disableJobInternal is Azure.Batch.Job.disableJob;
    enableJobInternal is Azure.Batch.Job.enableJob;
    terminateJobInternal is Azure.Batch.Job.terminateJob;
    createJobInternal is Azure.Batch.Job.createJob;
    listJobsInternal is Azure.Batch.Job.listJobs;
    listJobsFromScheduleInternal is Azure.Batch.Job.listJobsFromSchedule;
    listJobPreparationAndReleaseTaskStatusInternal is Azure.Batch.Job.listJobPreparationAndReleaseTaskStatus;
    getJobTaskCountsInternal is Azure.Batch.Job.getJobTaskCounts;

    jobScheduleExistsInternal is Azure.Batch.JobSchedule.jobScheduleExists;
    deleteJobScheduleInternal is Azure.Batch.JobSchedule.deleteJobSchedule;
    getJobScheduleInternal is Azure.Batch.JobSchedule.getJobSchedule;
    updateJobScheduleInternal is Azure.Batch.JobSchedule.updateJobSchedule;
    replaceJobScheduleInternal is Azure.Batch.JobSchedule.replaceJobSchedule;
    disableJobScheduleInternal is Azure.Batch.JobSchedule.disableJobSchedule;
    enableJobScheduleInternal is Azure.Batch.JobSchedule.enableJobSchedule;
    terminateJobScheduleInternal is Azure.Batch.JobSchedule.terminateJobSchedule;
    createJobScheduleInternal is Azure.Batch.JobSchedule.createJobSchedule;
    listJobSchedulesInternal is Azure.Batch.JobSchedule.listJobSchedules;

    createTaskInternal is Azure.Batch.Task.createTask;
    listTasksInternal is Azure.Batch.Task.listTasks;
    createTaskCollectionInternal is Azure.Batch.Task.createTaskCollection;
    deleteTaskInternal is Azure.Batch.Task.deleteTask;
    getTaskInternal is Azure.Batch.Task.getTask;
    replaceTaskInternal is Azure.Batch.Task.replaceTask;
    listSubTasksInternal is Azure.Batch.Task.listSubTasks;
    terminateTaskInternal is Azure.Batch.Task.terminateTask;
    reactivateTaskInternal is Azure.Batch.Task.reactivateTask;
    deleteTaskFileInternal is Azure.Batch.Task.deleteTaskFile;
    getTaskFileInternal is Azure.Batch.Task.getTaskFile;
    getTaskFilePropertiesInternal is Azure.Batch.Task.getTaskFileProperties;
    listTaskFilesInternal is Azure.Batch.Task.listTaskFiles;

    createNodeUserInternal is Azure.Batch.Node.createNodeUser;
    deleteNodeUserInternal is Azure.Batch.Node.deleteNodeUser;
    replaceNodeUserInternal is Azure.Batch.Node.replaceNodeUser;
    getNodeInternal is Azure.Batch.Node.getNode;
    rebootNodeInternal is Azure.Batch.Node.rebootNode;
    disableNodeSchedulingInternal is Azure.Batch.Node.disableNodeScheduling;
    enableNodeSchedulingInternal is Azure.Batch.Node.enableNodeScheduling;
    getNodeRemoteLoginSettingsInternal is Azure.Batch.Node.getNodeRemoteLoginSettings;
    uploadNodeLogsInternal is Azure.Batch.Node.uploadNodeLogs;
    listNodesInternal is Azure.Batch.Node.listNodes;
    getNodeExtensionInternal is Azure.Batch.Node.getNodeExtension;
    listNodeExtensionsInternal is Azure.Batch.Node.listNodeExtensions;
    deleteNodeFileInternal is Azure.Batch.Node.deleteNodeFile;
    getNodeFileInternal is Azure.Batch.Node.getNodeFile;
    getNodeFilePropertiesInternal is Azure.Batch.Node.getNodeFileProperties;
    listNodeFilesInternal is Azure.Batch.Node.listNodeFiles;
  }

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
@@access(Azure.Batch.Pool.poolExists, Access.internal, "csharp");
@@access(Azure.Batch.JobSchedule.jobScheduleExists, Access.internal, "csharp");
@@access(Azure.Batch.Task.getTaskFileProperties, Access.internal, "csharp");
@@access(Azure.Batch.Node.getNodeFileProperties, Access.internal, "csharp");

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
