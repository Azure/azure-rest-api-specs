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
  listApplications is Azure.Batch.Applications.listApplications;
  @clientName("getApplicationInternal", "java")
  getApplication is Azure.Batch.Applications.getApplication;

  @clientName("listPoolUsageMetricsInternal", "java")
  listPoolUsageMetrics is Azure.Batch.Pools.listPoolUsageMetrics;
  @clientName("createPoolInternal", "java")
  createPool is Azure.Batch.Pools.createPool;
  @clientName("listPoolsInternal", "java")
  listPools is Azure.Batch.Pools.listPools;
  @clientName("deletePoolInternal", "java")
  deletePool is Azure.Batch.Pools.deletePool;
  @clientName("poolExistsInternal", "java")
  poolExists is Azure.Batch.Pools.poolExists;
  @clientName("getPoolInternal", "java")
  getPool is Azure.Batch.Pools.getPool;
  @clientName("updatePoolInternal", "java")
  updatePool is Azure.Batch.Pools.updatePool;
  @clientName("disablePoolAutoScaleInternal", "java")
  disablePoolAutoScale is Azure.Batch.Pools.disablePoolAutoScale;
  @clientName("enablePoolAutoScaleInternal", "java")
  enablePoolAutoScale is Azure.Batch.Pools.enablePoolAutoScale;
  @clientName("evaluatePoolAutoScaleInternal", "java")
  evaluatePoolAutoScale is Azure.Batch.Pools.evaluatePoolAutoScale;
  @clientName("resizePoolInternal", "java")
  resizePool is Azure.Batch.Pools.resizePool;
  @clientName("stopPoolResizeInternal", "java")
  stopPoolResize is Azure.Batch.Pools.stopPoolResize;
  @clientName("replacePoolPropertiesInternal", "java")
  replacePoolProperties is Azure.Batch.Pools.replacePoolProperties;
  @clientName("removeNodesInternal", "java")
  removeNodes is Azure.Batch.Pools.removeNodes;
  @clientName("listSupportedImagesInternal", "java")
  listSupportedImages is Azure.Batch.Pools.listSupportedImages;
  @clientName("listPoolNodeCountsInternal", "java")
  listPoolNodeCounts is Azure.Batch.Pools.listPoolNodeCounts;

  @clientName("deleteJobInternal", "java")
  deleteJob is Azure.Batch.Jobs.deleteJob;
  @clientName("getJobInternal", "java")
  getJob is Azure.Batch.Jobs.getJob;
  @clientName("updateJobInternal", "java")
  updateJob is Azure.Batch.Jobs.updateJob;
  @clientName("replaceJobInternal", "java")
  replaceJob is Azure.Batch.Jobs.replaceJob;
  @clientName("disableJobInternal", "java")
  disableJob is Azure.Batch.Jobs.disableJob;
  @clientName("enableJobInternal", "java")
  enableJob is Azure.Batch.Jobs.enableJob;
  @clientName("terminateJobInternal", "java")
  terminateJob is Azure.Batch.Jobs.terminateJob;
  @clientName("createJobInternal", "java")
  createJob is Azure.Batch.Jobs.createJob;
  @clientName("listJobsInternal", "java")
  listJobs is Azure.Batch.Jobs.listJobs;
  @clientName("listJobsFromScheduleInternal", "java")
  listJobsFromSchedule is Azure.Batch.Jobs.listJobsFromSchedule;
  @clientName("listJobPreparationAndReleaseTaskStatusInternal", "java")
  listJobPreparationAndReleaseTaskStatus is Azure.Batch.Jobs.listJobPreparationAndReleaseTaskStatus;
  @clientName("getJobTaskCountsInternal", "java")
  getJobTaskCounts is Azure.Batch.Jobs.getJobTaskCounts;

  @clientName("jobScheduleExistsInternal", "java")
  jobScheduleExists is Azure.Batch.JobSchedules.jobScheduleExists;
  @clientName("deleteJobScheduleInternal", "java")
  deleteJobSchedule is Azure.Batch.JobSchedules.deleteJobSchedule;
  @clientName("getJobScheduleInternal", "java")
  getJobSchedule is Azure.Batch.JobSchedules.getJobSchedule;
  @clientName("updateJobScheduleInternal", "java")
  updateJobSchedule is Azure.Batch.JobSchedules.updateJobSchedule;
  @clientName("replaceJobScheduleInternal", "java")
  replaceJobSchedule is Azure.Batch.JobSchedules.replaceJobSchedule;
  @clientName("disableJobScheduleInternal", "java")
  disableJobSchedule is Azure.Batch.JobSchedules.disableJobSchedule;
  @clientName("enableJobScheduleInternal", "java")
  enableJobSchedule is Azure.Batch.JobSchedules.enableJobSchedule;
  @clientName("terminateJobScheduleInternal", "java")
  terminateJobSchedule is Azure.Batch.JobSchedules.terminateJobSchedule;
  @clientName("createJobScheduleInternal", "java")
  createJobSchedule is Azure.Batch.JobSchedules.createJobSchedule;
  @clientName("listJobSchedulesInternal", "java")
  listJobSchedules is Azure.Batch.JobSchedules.listJobSchedules;

  @clientName("createTaskInternal", "java")
  createTask is Azure.Batch.Tasks.createTask;
  @clientName("listTasksInternal", "java")
  listTasks is Azure.Batch.Tasks.listTasks;
  @clientName("createTaskCollectionInternal", "java")
  createTaskCollection is Azure.Batch.Tasks.createTaskCollection;
  @clientName("deleteTaskInternal", "java")
  deleteTask is Azure.Batch.Tasks.deleteTask;
  @clientName("getTaskInternal", "java")
  getTask is Azure.Batch.Tasks.getTask;
  @clientName("replaceTaskInternal", "java")
  replaceTask is Azure.Batch.Tasks.replaceTask;
  @clientName("listSubTasksInternal", "java")
  listSubTasks is Azure.Batch.Tasks.listSubTasks;
  @clientName("terminateTaskInternal", "java")
  terminateTask is Azure.Batch.Tasks.terminateTask;
  @clientName("reactivateTaskInternal", "java")
  reactivateTask is Azure.Batch.Tasks.reactivateTask;
  @clientName("deleteTaskFileInternal", "java")
  deleteTaskFile is Azure.Batch.Tasks.deleteTaskFile;
  @clientName("getTaskFileInternal", "java")
  getTaskFile is Azure.Batch.Tasks.getTaskFile;
  @clientName("getTaskFilePropertiesInternal", "java")
  getTaskFileProperties is Azure.Batch.Tasks.getTaskFileProperties;
  @clientName("listTaskFilesInternal", "java")
  listTaskFiles is Azure.Batch.Tasks.listTaskFiles;

  @clientName("createNodeUserInternal", "java")
  createNodeUser is Azure.Batch.Nodes.createNodeUser;
  @clientName("deleteNodeUserInternal", "java")
  deleteNodeUser is Azure.Batch.Nodes.deleteNodeUser;
  @clientName("replaceNodeUserInternal", "java")
  replaceNodeUser is Azure.Batch.Nodes.replaceNodeUser;
  @clientName("getNodeInternal", "java")
  getNode is Azure.Batch.Nodes.getNode;
  @clientName("rebootNodeInternal", "java")
  rebootNode is Azure.Batch.Nodes.rebootNode;
  @clientName("disableNodeSchedulingInternal", "java")
  disableNodeScheduling is Azure.Batch.Nodes.disableNodeScheduling;
  @clientName("enableNodeSchedulingInternal", "java")
  enableNodeScheduling is Azure.Batch.Nodes.enableNodeScheduling;
  @clientName("getNodeRemoteLoginSettingsInternal", "java")
  getNodeRemoteLoginSettings is Azure.Batch.Nodes.getNodeRemoteLoginSettings;
  @clientName("uploadNodeLogsInternal", "java")
  uploadNodeLogs is Azure.Batch.Nodes.uploadNodeLogs;
  @clientName("listNodesInternal", "java")
  listNodes is Azure.Batch.Nodes.listNodes;
  @clientName("getNodeExtensionInternal", "java")
  getNodeExtension is Azure.Batch.Nodes.getNodeExtension;
  @clientName("listNodeExtensionsInternal", "java")
  listNodeExtensions is Azure.Batch.Nodes.listNodeExtensions;
  @clientName("deleteNodeFileInternal", "java")
  deleteNodeFile is Azure.Batch.Nodes.deleteNodeFile;
  @clientName("getNodeFileInternal", "java")
  getNodeFile is Azure.Batch.Nodes.getNodeFile;
  @clientName("getNodeFilePropertiesInternal", "java")
  getNodeFileProperties is Azure.Batch.Nodes.getNodeFileProperties;
  @clientName("listNodeFilesInternal", "java")
  listNodeFiles is Azure.Batch.Nodes.listNodeFiles;
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
@@access(Azure.Batch.Pools.poolExists, Access.internal, "csharp");
@@access(Azure.Batch.JobSchedules.jobScheduleExists, Access.internal, "csharp");
@@access(Azure.Batch.Tasks.getTaskFileProperties, Access.internal, "csharp");
@@access(Azure.Batch.Nodes.getNodeFileProperties, Access.internal, "csharp");

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
@@access(Azure.Batch.BatchNodeReimageContent, Access.public, "java");
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
