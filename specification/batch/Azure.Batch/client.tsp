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
  listApplications is Azure.Batch.Applications.listApplications;
  getApplication is Azure.Batch.Applications.getApplication;

  listPoolUsageMetrics is Azure.Batch.Pools.listPoolUsageMetrics;
  createPool is Azure.Batch.Pools.createPool;
  listPools is Azure.Batch.Pools.listPools;
  deletePool is Azure.Batch.Pools.deletePool;
  poolExists is Azure.Batch.Pools.poolExists;
  getPool is Azure.Batch.Pools.getPool;
  updatePool is Azure.Batch.Pools.updatePool;
  disablePoolAutoScale is Azure.Batch.Pools.disablePoolAutoScale;
  enablePoolAutoScale is Azure.Batch.Pools.enablePoolAutoScale;
  evaluatePoolAutoScale is Azure.Batch.Pools.evaluatePoolAutoScale;
  resizePool is Azure.Batch.Pools.resizePool;
  stopPoolResize is Azure.Batch.Pools.stopPoolResize;
  replacePoolProperties is Azure.Batch.Pools.replacePoolProperties;
  removeNodes is Azure.Batch.Pools.removeNodes;
  listSupportedImages is Azure.Batch.Pools.listSupportedImages;
  listPoolNodeCounts is Azure.Batch.Pools.listPoolNodeCounts;

  deleteJob is Azure.Batch.Jobs.deleteJob;
  getJob is Azure.Batch.Jobs.getJob;
  updateJob is Azure.Batch.Jobs.updateJob;
  replaceJob is Azure.Batch.Jobs.replaceJob;
  disableJob is Azure.Batch.Jobs.disableJob;
  enableJob is Azure.Batch.Jobs.enableJob;
  terminateJob is Azure.Batch.Jobs.terminateJob;
  createJob is Azure.Batch.Jobs.createJob;
  listJobs is Azure.Batch.Jobs.listJobs;
  listJobsFromSchedule is Azure.Batch.Jobs.listJobsFromSchedule;
  listJobPreparationAndReleaseTaskStatus is Azure.Batch.Jobs.listJobPreparationAndReleaseTaskStatus;
  getJobTaskCounts is Azure.Batch.Jobs.getJobTaskCounts;

  jobScheduleExists is Azure.Batch.JobSchedules.jobScheduleExists;
  deleteJobSchedule is Azure.Batch.JobSchedules.deleteJobSchedule;
  getJobSchedule is Azure.Batch.JobSchedules.getJobSchedule;
  updateJobSchedule is Azure.Batch.JobSchedules.updateJobSchedule;
  replaceJobSchedule is Azure.Batch.JobSchedules.replaceJobSchedule;
  disableJobSchedule is Azure.Batch.JobSchedules.disableJobSchedule;
  enableJobSchedule is Azure.Batch.JobSchedules.enableJobSchedule;
  terminateJobSchedule is Azure.Batch.JobSchedules.terminateJobSchedule;
  createJobSchedule is Azure.Batch.JobSchedules.createJobSchedule;
  listJobSchedules is Azure.Batch.JobSchedules.listJobSchedules;

  createTask is Azure.Batch.Tasks.createTask;
  listTasks is Azure.Batch.Tasks.listTasks;
  createTaskCollection is Azure.Batch.Tasks.createTaskCollection;
  deleteTask is Azure.Batch.Tasks.deleteTask;
  getTask is Azure.Batch.Tasks.getTask;
  replaceTask is Azure.Batch.Tasks.replaceTask;
  listSubTasks is Azure.Batch.Tasks.listSubTasks;
  terminateTask is Azure.Batch.Tasks.terminateTask;
  reactivateTask is Azure.Batch.Tasks.reactivateTask;
  deleteTaskFile is Azure.Batch.Tasks.deleteTaskFile;
  getTaskFile is Azure.Batch.Tasks.getTaskFile;
  getTaskFileProperties is Azure.Batch.Tasks.getTaskFileProperties;
  listTaskFiles is Azure.Batch.Tasks.listTaskFiles;

  createNodeUser is Azure.Batch.Nodes.createNodeUser;
  deleteNodeUser is Azure.Batch.Nodes.deleteNodeUser;
  replaceNodeUser is Azure.Batch.Nodes.replaceNodeUser;
  getNode is Azure.Batch.Nodes.getNode;
  rebootNode is Azure.Batch.Nodes.rebootNode;
  disableNodeScheduling is Azure.Batch.Nodes.disableNodeScheduling;
  enableNodeScheduling is Azure.Batch.Nodes.enableNodeScheduling;
  getNodeRemoteLoginSettings is Azure.Batch.Nodes.getNodeRemoteLoginSettings;
  uploadNodeLogs is Azure.Batch.Nodes.uploadNodeLogs;
  listNodes is Azure.Batch.Nodes.listNodes;
  getNodeExtension is Azure.Batch.Nodes.getNodeExtension;
  listNodeExtensions is Azure.Batch.Nodes.listNodeExtensions;
  deleteNodeFile is Azure.Batch.Nodes.deleteNodeFile;
  getNodeFile is Azure.Batch.Nodes.getNodeFile;
  getNodeFileProperties is Azure.Batch.Nodes.getNodeFileProperties;
  listNodeFiles is Azure.Batch.Nodes.listNodeFiles;
}

/* C SHARP OVERRIDES */
// Api overrides
@@access(Azure.Batch.Pools.poolExists, Access.internal, "csharp");
@@access(Azure.Batch.JobSchedules.jobScheduleExists, Access.internal, "csharp");
@@access(Azure.Batch.Tasks.getTaskFileProperties, Access.internal, "csharp");
@@access(Azure.Batch.Nodes.getNodeFileProperties, Access.internal, "csharp");

/* JAVA OVERRIDES */
// client name overrides
@@clientName(Batch.listApplications, "listApplicationsInternal", "java");
@@clientName(Batch.getApplication, "getApplicationInternal", "java");

@@clientName(Batch.listPoolUsageMetrics, "listPoolUsageMetricsInternal", "java");
@@clientName(Batch.createPool, "createPoolInternal", "java");
@@clientName(Batch.listPools, "listPoolsInternal", "java");
@@clientName(Batch.deletePool, "deletePoolInternal", "java");
@@clientName(Batch.poolExists, "poolExistsInternal", "java");
@@clientName(Batch.getPool, "getPoolInternal", "java");
@@clientName(Batch.updatePool, "updatePoolInternal", "java");
@@clientName(Batch.disablePoolAutoScale, "disablePoolAutoScaleInternal", "java");
@@clientName(Batch.enablePoolAutoScale, "enablePoolAutoScaleInternal", "java");
@@clientName(Batch.evaluatePoolAutoScale, "evaluatePoolAutoScaleInternal", "java");
@@clientName(Batch.resizePool, "resizePoolInternal", "java");
@@clientName(Batch.stopPoolResize, "stopPoolResizeInternal", "java");
@@clientName(Batch.replacePoolProperties, "replacePoolPropertiesInternal", "java");
@@clientName(Batch.removeNodes, "removeNodesInternal", "java");
@@clientName(Batch.listSupportedImages, "listSupportedImagesInternal", "java");
@@clientName(Batch.listPoolNodeCounts, "listPoolNodeCountsInternal", "java");

@@clientName(Batch.deleteJob, "deleteJobInternal", "java");
@@clientName(Batch.getJob, "getJobInternal", "java");
@@clientName(Batch.updateJob, "updateJobInternal", "java");
@@clientName(Batch.replaceJob, "replaceJobInternal", "java");
@@clientName(Batch.disableJob, "disableJobInternal", "java");
@@clientName(Batch.enableJob, "enableJobInternal", "java");
@@clientName(Batch.terminateJob, "terminateJobInternal", "java");
@@clientName(Batch.createJob, "createJobInternal", "java");
@@clientName(Batch.listJobs, "listJobsInternal", "java");
@@clientName(Batch.listJobsFromSchedule, "listJobsFromScheduleInternal", "java");
@@clientName(Batch.listJobPreparationAndReleaseTaskStatus, "listJobPreparationAndReleaseTaskStatusInternal", "java");
@@clientName(Batch.getJobTaskCounts, "getJobTaskCountsInternal", "java");

@@clientName(Batch.jobScheduleExists, "jobScheduleExistsInternal", "java");
@@clientName(Batch.deleteJobSchedule, "deleteJobScheduleInternal", "java");
@@clientName(Batch.getJobSchedule, "getJobScheduleInternal", "java");
@@clientName(Batch.updateJobSchedule, "updateJobScheduleInternal", "java");
@@clientName(Batch.replaceJobSchedule, "replaceJobScheduleInternal", "java");
@@clientName(Batch.disableJobSchedule, "disableJobScheduleInternal", "java");
@@clientName(Batch.enableJobSchedule, "enableJobScheduleInternal", "java");
@@clientName(Batch.terminateJobSchedule, "terminateJobScheduleInternal", "java");
@@clientName(Batch.createJobSchedule, "createJobScheduleInternal", "java");
@@clientName(Batch.listJobSchedules, "listJobSchedulesInternal", "java");

@@clientName(Batch.createTask, "createTaskInternal", "java");
@@clientName(Batch.listTasks, "listTasksInternal", "java");
@@clientName(Batch.createTaskCollection, "createTaskCollectionInternal", "java");
@@clientName(Batch.deleteTask, "deleteTaskInternal", "java");
@@clientName(Batch.getTask, "getTaskInternal", "java");
@@clientName(Batch.replaceTask, "replaceTaskInternal", "java");
@@clientName(Batch.listSubTasks, "listSubTasksInternal", "java");
@@clientName(Batch.terminateTask, "terminateTaskInternal", "java");
@@clientName(Batch.reactivateTask, "reactivateTaskInternal", "java");
@@clientName(Batch.deleteTaskFile, "deleteTaskFileInternal", "java");
@@clientName(Batch.getTaskFile, "getTaskFileInternal", "java");
@@clientName(Batch.getTaskFileProperties, "getTaskFilePropertiesInternal", "java");
@@clientName(Batch.listTaskFiles, "listTaskFilesInternal", "java");

@@clientName(Batch.createNodeUser, "createNodeUserInternal", "java");
@@clientName(Batch.deleteNodeUser, "deleteNodeUserInternal", "java");
@@clientName(Batch.replaceNodeUser, "replaceNodeUserInternal", "java");
@@clientName(Batch.getNode, "getNodeInternal", "java");
@@clientName(Batch.rebootNode, "rebootNodeInternal", "java");
@@clientName(Batch.disableNodeScheduling, "disableNodeSchedulingInternal", "java");
@@clientName(Batch.enableNodeScheduling, "enableNodeSchedulingInternal", "java");
@@clientName(Batch.getNodeRemoteLoginSettings, "getNodeRemoteLoginSettingsInternal", "java");
@@clientName(Batch.uploadNodeLogs, "uploadNodeLogsInternal", "java");
@@clientName(Batch.listNodes, "listNodesInternal", "java");
@@clientName(Batch.getNodeExtension, "getNodeExtensionInternal", "java");
@@clientName(Batch.listNodeExtensions, "listNodeExtensionsInternal", "java");
@@clientName(Batch.deleteNodeFile, "deleteNodeFileInternal", "java");
@@clientName(Batch.getNodeFile, "getNodeFileInternal", "java");
@@clientName(Batch.getNodeFileProperties, "getNodeFilePropertiesInternal", "java");
@@clientName(Batch.listNodeFiles, "listNodeFilesInternal", "java");

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
