import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(Azure.Batch.Versions.v2024_07_01)
namespace Client;
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
@client({
  name: "BatchClient",
  service: Azure.Batch,
})
interface BatchClient {
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
  startNode is Azure.Batch.Nodes.startNode;
  reimageNode is Azure.Batch.Nodes.reimageNode;
  deallocateNode is Azure.Batch.Nodes.deallocateNode;
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
@@clientName(BatchClient.getTaskFileProperties,
  "getTaskFilePropertiesInternal",
  "csharp"
);
@@access(Azure.Batch.Nodes.getNodeFileProperties, Access.internal, "csharp");
@@clientName(BatchClient.getNodeFileProperties,
  "getNodeFilePropertiesInternal",
  "csharp"
);

/* JAVA OVERRIDES */
// client name overrides
@@clientName(BatchClient.listApplications, "listApplicationsInternal", "java");
@@clientName(BatchClient.getApplication, "getApplicationInternal", "java");

@@clientName(BatchClient.listPoolUsageMetrics,
  "listPoolUsageMetricsInternal",
  "java"
);
@@clientName(BatchClient.createPool, "createPoolInternal", "java");
@@clientName(BatchClient.listPools, "listPoolsInternal", "java");
@@clientName(BatchClient.deletePool, "deletePoolInternal", "java");
@@clientName(BatchClient.poolExists, "poolExistsInternal", "java");
@@clientName(BatchClient.getPool, "getPoolInternal", "java");
@@clientName(BatchClient.updatePool, "updatePoolInternal", "java");
@@clientName(BatchClient.disablePoolAutoScale,
  "disablePoolAutoScaleInternal",
  "java"
);
@@clientName(BatchClient.enablePoolAutoScale,
  "enablePoolAutoScaleInternal",
  "java"
);
@@clientName(BatchClient.evaluatePoolAutoScale,
  "evaluatePoolAutoScaleInternal",
  "java"
);
@@clientName(BatchClient.resizePool, "resizePoolInternal", "java");
@@clientName(BatchClient.stopPoolResize, "stopPoolResizeInternal", "java");
@@clientName(BatchClient.replacePoolProperties,
  "replacePoolPropertiesInternal",
  "java"
);
@@clientName(BatchClient.removeNodes, "removeNodesInternal", "java");
@@clientName(BatchClient.listSupportedImages,
  "listSupportedImagesInternal",
  "java"
);
@@clientName(BatchClient.listPoolNodeCounts,
  "listPoolNodeCountsInternal",
  "java"
);

@@clientName(BatchClient.deleteJob, "deleteJobInternal", "java");
@@clientName(BatchClient.getJob, "getJobInternal", "java");
@@clientName(BatchClient.updateJob, "updateJobInternal", "java");
@@clientName(BatchClient.replaceJob, "replaceJobInternal", "java");
@@clientName(BatchClient.disableJob, "disableJobInternal", "java");
@@clientName(BatchClient.enableJob, "enableJobInternal", "java");
@@clientName(BatchClient.terminateJob, "terminateJobInternal", "java");
@@clientName(BatchClient.createJob, "createJobInternal", "java");
@@clientName(BatchClient.listJobs, "listJobsInternal", "java");
@@clientName(BatchClient.listJobsFromSchedule,
  "listJobsFromScheduleInternal",
  "java"
);
@@clientName(BatchClient.listJobPreparationAndReleaseTaskStatus,
  "listJobPreparationAndReleaseTaskStatusInternal",
  "java"
);
@@clientName(BatchClient.getJobTaskCounts, "getJobTaskCountsInternal", "java");

@@clientName(BatchClient.jobScheduleExists,
  "jobScheduleExistsInternal",
  "java"
);
@@clientName(BatchClient.deleteJobSchedule,
  "deleteJobScheduleInternal",
  "java"
);
@@clientName(BatchClient.getJobSchedule, "getJobScheduleInternal", "java");
@@clientName(BatchClient.updateJobSchedule,
  "updateJobScheduleInternal",
  "java"
);
@@clientName(BatchClient.replaceJobSchedule,
  "replaceJobScheduleInternal",
  "java"
);
@@clientName(BatchClient.disableJobSchedule,
  "disableJobScheduleInternal",
  "java"
);
@@clientName(BatchClient.enableJobSchedule,
  "enableJobScheduleInternal",
  "java"
);
@@clientName(BatchClient.terminateJobSchedule,
  "terminateJobScheduleInternal",
  "java"
);
@@clientName(BatchClient.createJobSchedule,
  "createJobScheduleInternal",
  "java"
);
@@clientName(BatchClient.listJobSchedules, "listJobSchedulesInternal", "java");

@@clientName(BatchClient.createTask, "createTaskInternal", "java");
@@clientName(BatchClient.listTasks, "listTasksInternal", "java");
@@clientName(BatchClient.createTaskCollection,
  "createTaskCollectionInternal",
  "java"
);
@@clientName(BatchClient.deleteTask, "deleteTaskInternal", "java");
@@clientName(BatchClient.getTask, "getTaskInternal", "java");
@@clientName(BatchClient.replaceTask, "replaceTaskInternal", "java");
@@clientName(BatchClient.listSubTasks, "listSubTasksInternal", "java");
@@clientName(BatchClient.terminateTask, "terminateTaskInternal", "java");
@@clientName(BatchClient.reactivateTask, "reactivateTaskInternal", "java");
@@clientName(BatchClient.deleteTaskFile, "deleteTaskFileInternal", "java");
@@clientName(BatchClient.getTaskFile, "getTaskFileInternal", "java");
@@clientName(BatchClient.getTaskFileProperties,
  "getTaskFilePropertiesInternal",
  "java"
);
@@clientName(BatchClient.listTaskFiles, "listTaskFilesInternal", "java");

@@clientName(BatchClient.createNodeUser, "createNodeUserInternal", "java");
@@clientName(BatchClient.deleteNodeUser, "deleteNodeUserInternal", "java");
@@clientName(BatchClient.replaceNodeUser, "replaceNodeUserInternal", "java");
@@clientName(BatchClient.getNode, "getNodeInternal", "java");
@@clientName(BatchClient.rebootNode, "rebootNodeInternal", "java");
@@clientName(BatchClient.startNode, "startNodeInternal", "java");
@@clientName(BatchClient.reimageNode, "reimageNodeInternal", "java");
@@clientName(BatchClient.deallocateNode, "deallocateNodeInternal", "java");
@@clientName(BatchClient.disableNodeScheduling,
  "disableNodeSchedulingInternal",
  "java"
);
@@clientName(BatchClient.enableNodeScheduling,
  "enableNodeSchedulingInternal",
  "java"
);
@@clientName(BatchClient.getNodeRemoteLoginSettings,
  "getNodeRemoteLoginSettingsInternal",
  "java"
);
@@clientName(BatchClient.uploadNodeLogs, "uploadNodeLogsInternal", "java");
@@clientName(BatchClient.listNodes, "listNodesInternal", "java");
@@clientName(BatchClient.getNodeExtension, "getNodeExtensionInternal", "java");
@@clientName(BatchClient.listNodeExtensions,
  "listNodeExtensionsInternal",
  "java"
);
@@clientName(BatchClient.deleteNodeFile, "deleteNodeFileInternal", "java");
@@clientName(BatchClient.getNodeFile, "getNodeFileInternal", "java");
@@clientName(BatchClient.getNodeFileProperties,
  "getNodeFilePropertiesInternal",
  "java"
);
@@clientName(BatchClient.listNodeFiles, "listNodeFilesInternal", "java");

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
@@access(Azure.Batch.BatchNodeDeallocateContent, Access.public, "java");
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
