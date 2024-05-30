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
  @clientName("listApplicationsInternal", "java")
  listApplications is Azure.Batch.Application.listApplications;
  @clientName("getApplicationInternal", "java")
  getApplication is Azure.Batch.Application.getApplication;

  @clientName("listPoolUsageMetricsInternal", "java")
  listPoolUsageMetrics is Azure.Batch.Pool.listPoolUsageMetrics;
  @clientName("createPoolInternal", "java")
  createPool is Azure.Batch.Pool.createPool;
  @clientName("listPoolsInternal", "java")
  listPools is Azure.Batch.Pool.listPools;
  @clientName("deletePoolInternal", "java")
  deletePool is Azure.Batch.Pool.deletePool;
  @clientName("poolExistsInternal", "java")
  poolExists is Azure.Batch.Pool.poolExists;
  @clientName("getPoolInternal", "java")
  getPool is Azure.Batch.Pool.getPool;
  @clientName("updatePoolInternal", "java")
  updatePool is Azure.Batch.Pool.updatePool;
  @clientName("disablePoolAutoScaleInternal", "java")
  disablePoolAutoScale is Azure.Batch.Pool.disablePoolAutoScale;
  @clientName("enablePoolAutoScaleInternal", "java")
  enablePoolAutoScale is Azure.Batch.Pool.enablePoolAutoScale;
  @clientName("evaluatePoolAutoScaleInternal", "java")
  evaluatePoolAutoScale is Azure.Batch.Pool.evaluatePoolAutoScale;
  @clientName("resizePoolInternal", "java")
  resizePool is Azure.Batch.Pool.resizePool;
  @clientName("stopPoolResizeInternal", "java")
  stopPoolResize is Azure.Batch.Pool.stopPoolResize;
  @clientName("replacePoolPropertiesInternal", "java")
  replacePoolProperties is Azure.Batch.Pool.replacePoolProperties;
  @clientName("removeNodesInternal", "java")
  removeNodes is Azure.Batch.Pool.removeNodes;
  @clientName("listSupportedImagesInternal", "java")
  listSupportedImages is Azure.Batch.Pool.listSupportedImages;
  @clientName("listPoolNodeCountsInternal", "java")
  listPoolNodeCounts is Azure.Batch.Pool.listPoolNodeCounts;

  @clientName("deleteJobInternal", "java")
  deleteJob is Azure.Batch.Job.deleteJob;
  @clientName("getJobInternal", "java")
  getJob is Azure.Batch.Job.getJob;
  @clientName("updateJobInternal", "java")
  updateJob is Azure.Batch.Job.updateJob;
  @clientName("replaceJobInternal", "java")
  replaceJob is Azure.Batch.Job.replaceJob;
  @clientName("disableJobInternal", "java")
  disableJob is Azure.Batch.Job.disableJob;
  @clientName("enableJobInternal", "java")
  enableJob is Azure.Batch.Job.enableJob;
  @clientName("terminateJobInternal", "java")
  terminateJob is Azure.Batch.Job.terminateJob;
  @clientName("createJobInternal", "java")
  createJob is Azure.Batch.Job.createJob;
  @clientName("listJobsInternal", "java")
  listJobs is Azure.Batch.Job.listJobs;
  @clientName("listJobsFromScheduleInternal", "java")
  listJobsFromSchedule is Azure.Batch.Job.listJobsFromSchedule;
  @clientName("listJobPreparationAndReleaseTaskStatusInternal", "java")
  listJobPreparationAndReleaseTaskStatus is Azure.Batch.Job.listJobPreparationAndReleaseTaskStatus;
  @clientName("getJobTaskCountsInternal", "java")
  getJobTaskCounts is Azure.Batch.Job.getJobTaskCounts;

  @clientName("jobScheduleExistsInternal", "java")
  jobScheduleExists is Azure.Batch.JobSchedule.jobScheduleExists;
  @clientName("deleteJobScheduleInternal", "java")
  deleteJobSchedule is Azure.Batch.JobSchedule.deleteJobSchedule;
  @clientName("getJobScheduleInternal", "java")
  getJobSchedule is Azure.Batch.JobSchedule.getJobSchedule;
  @clientName("updateJobScheduleInternal", "java")
  updateJobSchedule is Azure.Batch.JobSchedule.updateJobSchedule;
  @clientName("replaceJobScheduleInternal", "java")
  replaceJobSchedule is Azure.Batch.JobSchedule.replaceJobSchedule;
  @clientName("disableJobScheduleInternal", "java")
  disableJobSchedule is Azure.Batch.JobSchedule.disableJobSchedule;
  @clientName("enableJobScheduleInternal", "java")
  enableJobSchedule is Azure.Batch.JobSchedule.enableJobSchedule;
  @clientName("terminateJobScheduleInternal", "java")
  terminateJobSchedule is Azure.Batch.JobSchedule.terminateJobSchedule;
  @clientName("createJobScheduleInternal", "java")
  createJobSchedule is Azure.Batch.JobSchedule.createJobSchedule;
  @clientName("listJobSchedulesInternal", "java")
  listJobSchedules is Azure.Batch.JobSchedule.listJobSchedules;

  @clientName("createTaskInternal", "java")
  createTask is Azure.Batch.Task.createTask;
  @clientName("listTasksInternal", "java")
  listTasks is Azure.Batch.Task.listTasks;
  @clientName("createTaskCollectionInternal", "java")
  createTaskCollection is Azure.Batch.Task.createTaskCollection;
  @clientName("deleteTaskInternal", "java")
  deleteTask is Azure.Batch.Task.deleteTask;
  @clientName("getTaskInternal", "java")
  getTask is Azure.Batch.Task.getTask;
  @clientName("replaceTaskInternal", "java")
  replaceTask is Azure.Batch.Task.replaceTask;
  @clientName("listSubTasksInternal", "java")
  listSubTasks is Azure.Batch.Task.listSubTasks;
  @clientName("terminateTaskInternal", "java")
  terminateTask is Azure.Batch.Task.terminateTask;
  @clientName("reactivateTaskInternal", "java")
  reactivateTask is Azure.Batch.Task.reactivateTask;
  @clientName("deleteTaskFileInternal", "java")
  deleteTaskFile is Azure.Batch.Task.deleteTaskFile;
  @clientName("getTaskFileInternal", "java")
  getTaskFile is Azure.Batch.Task.getTaskFile;
  @clientName("getTaskFilePropertiesInternal", "java")
  getTaskFileProperties is Azure.Batch.Task.getTaskFileProperties;
  @clientName("listTaskFilesInternal", "java")
  listTaskFiles is Azure.Batch.Task.listTaskFiles;

  @clientName("createNodeUserInternal", "java")
  createNodeUser is Azure.Batch.Node.createNodeUser;
  @clientName("deleteNodeUserInternal", "java")
  deleteNodeUser is Azure.Batch.Node.deleteNodeUser;
  @clientName("replaceNodeUserInternal", "java")
  replaceNodeUser is Azure.Batch.Node.replaceNodeUser;
  @clientName("getNodeInternal", "java")
  getNode is Azure.Batch.Node.getNode;
  @clientName("rebootNodeInternal", "java")
  rebootNode is Azure.Batch.Node.rebootNode;
  @clientName("disableNodeSchedulingInternal", "java")
  disableNodeScheduling is Azure.Batch.Node.disableNodeScheduling;
  @clientName("enableNodeSchedulingInternal", "java")
  enableNodeScheduling is Azure.Batch.Node.enableNodeScheduling;
  @clientName("getNodeRemoteLoginSettingsInternal", "java")
  getNodeRemoteLoginSettings is Azure.Batch.Node.getNodeRemoteLoginSettings;
  @clientName("uploadNodeLogsInternal", "java")
  uploadNodeLogs is Azure.Batch.Node.uploadNodeLogs;
  @clientName("listNodesInternal", "java")
  listNodes is Azure.Batch.Node.listNodes;
  @clientName("getNodeExtensionInternal", "java")
  getNodeExtension is Azure.Batch.Node.getNodeExtension;
  @clientName("listNodeExtensionsInternal", "java")
  listNodeExtensions is Azure.Batch.Node.listNodeExtensions;
  @clientName("deleteNodeFileInternal", "java")
  deleteNodeFile is Azure.Batch.Node.deleteNodeFile;
  @clientName("getNodeFileInternal", "java")
  getNodeFile is Azure.Batch.Node.getNodeFile;
  @clientName("getNodeFilePropertiesInternal", "java")
  getNodeFileProperties is Azure.Batch.Node.getNodeFileProperties;
  @clientName("listNodeFilesInternal", "java")
  listNodeFiles is Azure.Batch.Node.listNodeFiles;
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
