import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
import "./java-client.tsp";

using Azure.ClientGenerator.Core;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(Azure.Batch.Versions.v2024_07_01)
namespace Client;
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" ""
#suppress "deprecated" ""
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

  createCertificate is Azure.Batch.Certificates.createCertificate;
  listCertificates is Azure.Batch.Certificates.listCertificates;
  cancelCertificateDeletion is Azure.Batch.Certificates.cancelCertificateDeletion;
  deleteCertificate is Azure.Batch.Certificates.deleteCertificate;
  getCertificate is Azure.Batch.Certificates.getCertificate;

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

/* GO OVERRIDES */
// don't export API for this operation because it retired before the first Go SDK release
@@access(Azure.Batch.Pools.listPoolUsageMetrics, Access.internal, "go");
// ODataNextLink -> NextLink
@@clientName(Azure.Batch.BatchAccountListSupportedImagesResult.`odata.nextLink`,
  "NextLink",
  "go"
);
@@clientName(Azure.Batch.BatchApplicationListResult.`odata.nextLink`,
  "NextLink",
  "go"
);
@@clientName(Azure.Batch.BatchCertificateListResult.`odata.nextLink`,
  "NextLink",
  "go"
);
@@clientName(Azure.Batch.BatchJobListResult.`odata.nextLink`, "NextLink", "go");
@@clientName(Azure.Batch.BatchJobPreparationAndReleaseTaskStatusListResult.`odata.nextLink`,
  "NextLink",
  "go"
);
@@clientName(Azure.Batch.BatchJobScheduleListResult.`odata.nextLink`,
  "NextLink",
  "go"
);
@@clientName(Azure.Batch.BatchNodeFileListResult.`odata.nextLink`,
  "NextLink",
  "go"
);
@@clientName(Azure.Batch.BatchNodeListResult.`odata.nextLink`,
  "NextLink",
  "go"
);
@@clientName(Azure.Batch.BatchNodeVMExtensionListResult.`odata.nextLink`,
  "NextLink",
  "go"
);
@@clientName(Azure.Batch.BatchPoolListResult.`odata.nextLink`,
  "NextLink",
  "go"
);
@@clientName(Azure.Batch.BatchPoolListUsageMetricsResult.`odata.nextLink`,
  "NextLink",
  "go"
);
@@clientName(Azure.Batch.BatchPoolNodeCountsListResult.`odata.nextLink`,
  "NextLink",
  "go"
);
@@clientName(Azure.Batch.BatchTaskListResult.`odata.nextLink`,
  "NextLink",
  "go"
);
@@clientName(Azure.Batch.BatchTaskListSubtasksResult.`odata.nextLink`,
  "NextLink",
  "go"
);
// capitalize initialisms
@@clientName(Azure.Batch.AutomaticOsUpgradePolicy,
  "AutomaticOSUpgradePolicy",
  "go"
);
@@clientName(Azure.Batch.AzureBlobFileSystemConfiguration.sasKey,
  "SASKey",
  "go"
);
@@clientName(Azure.Batch.BatchCertificate.certificateFormat, "Format", "go");
@@clientName(Azure.Batch.BatchCertificateFormat.Cer, "CER", "go");
@@clientName(Azure.Batch.BatchCertificateFormat.Pfx, "PFX", "go");
@@clientName(Azure.Batch.BatchJobScheduleStatistics.readIOps, "ReadIOPS", "go");
@@clientName(Azure.Batch.BatchJobScheduleStatistics.writeIOps,
  "WriteIOPS",
  "go"
);
@@clientName(Azure.Batch.BatchPoolResourceStatistics.diskReadIOps,
  "DiskReadIOPS",
  "go"
);
@@clientName(Azure.Batch.BatchPoolResourceStatistics.diskWriteIOps,
  "DiskWriteIOPS",
  "go"
);
@@clientName(Azure.Batch.BatchTaskStatistics.readIOps, "ReadIOPS", "go");
@@clientName(Azure.Batch.BatchTaskStatistics.writeIOps, "WriteIOPS", "go");
@@clientName(Azure.Batch.CifsMountConfiguration,
  "CIFSMountConfiguration",
  "go"
);
@@clientName(Azure.Batch.CommonListParameters.maxresults, "MaxResults", "go");
@@clientName(Azure.Batch.HttpHeader, "HTTPHeader", "go");
@@clientName(Azure.Batch.InboundNatPool, "InboundNATPool", "go");
@@clientName(Azure.Batch.IpAddressProvisioningType,
  "IPAddressProvisioningType",
  "go"
);
@@clientName(Azure.Batch.LinuxUserConfiguration.gid, "GID", "go");
@@clientName(Azure.Batch.NfsMountConfiguration, "NFSMountConfiguration", "go");
@@clientName(Azure.Batch.PublicIpAddressConfiguration,
  "PublicIPAddressConfiguration",
  "go"
);
@@clientName(Azure.Batch.UefiSettings, "UEFISettings", "go");
@@clientName(Azure.Batch.UefiSettings.vTpmEnabled, "VTPMEnabled", "go");
// align model names with method names
@@clientName(Azure.Batch.BatchJobCreateContent, "CreateJobContent", "go");
@@clientName(Azure.Batch.BatchJobDisableContent, "DisableJobContent", "go");
@@clientName(Azure.Batch.BatchJobScheduleCreateContent,
  "CreateJobScheduleContent",
  "go"
);
@@clientName(Azure.Batch.BatchJobTerminateContent, "TerminateJobContent", "go");
@@clientName(Azure.Batch.BatchJobUpdateContent, "UpdateJobContent", "go");
@@clientName(Azure.Batch.BatchJobScheduleUpdateContent,
  "UpdateJobScheduleContent",
  "go"
);
@@clientName(Azure.Batch.BatchNodeDeallocateContent,
  "DeallocateNodeContent",
  "go"
);
@@clientName(Azure.Batch.BatchNodeDisableSchedulingContent,
  "DisableNodeSchedulingContent",
  "go"
);
@@clientName(Azure.Batch.BatchPoolCreateContent, "CreatePoolContent", "go");
@@clientName(Azure.Batch.BatchPoolEnableAutoScaleContent,
  "EnablePoolAutoScaleContent",
  "go"
);
@@clientName(Azure.Batch.BatchPoolEvaluateAutoScaleContent,
  "EvaluatePoolAutoScaleContent",
  "go"
);
@@clientName(Azure.Batch.BatchPoolListUsageMetricsResult,
  "ListPoolUsageMetricsResult",
  "go"
);
@@clientName(Azure.Batch.BatchPoolNodeCountsListResult,
  "ListPoolNodeCountsResult",
  "go"
);
@@clientName(Azure.Batch.BatchPoolReplaceContent, "ReplacePoolContent", "go");
@@clientName(Azure.Batch.BatchPoolResizeContent, "ResizePoolContent", "go");
@@clientName(Azure.Batch.BatchPoolUpdateContent, "UpdatePoolContent", "go");
@@clientName(Azure.Batch.BatchTaskAddCollectionResult,
  "AddTaskCollectionResult",
  "go"
);
@@clientName(Azure.Batch.BatchTaskCreateContent, "CreateTaskContent", "go");
@@clientName(Azure.Batch.BatchNodeRebootContent, "RebootNodeContent", "go");
@@clientName(Azure.Batch.BatchNodeReimageContent, "ReimageNodeContent", "go");
@@clientName(Azure.Batch.BatchNodeRemoveContent, "RemoveNodeContent", "go");
@@clientName(Azure.Batch.BatchNodeUserCreateContent,
  "CreateNodeUserContent",
  "go"
);
@@clientName(Azure.Batch.BatchNodeUserUpdateContent,
  "UpdateNodeUserContent",
  "go"
);
@@clientName(Azure.Batch.DeleteBatchCertificateError,
  "DeleteCertificateError",
  "go"
);
@@clientName(Azure.Batch.UploadBatchServiceLogsContent,
  "UploadNodeLogsContent",
  "go"
);
@@clientName(Azure.Batch.UploadBatchServiceLogsResult,
  "UploadNodeLogsResult",
  "go"
);
// remove "Batch" from field names
@@clientName(Azure.Batch.ContainerHostBatchBindMountEntry,
  "ContainerHostBindMountEntry",
  "go"
);
@@clientName(Azure.Batch.DisableBatchJobOption, "DisableJobOption", "go");
@@clientName(Azure.Batch.OnAllBatchTasksComplete, "OnAllTasksComplete", "go");
@@clientName(Azure.Batch.OnBatchTaskFailure, "OnTaskFailure", "go");
@@clientName(Azure.Batch.RecentBatchJob, "RecentJob", "go");
