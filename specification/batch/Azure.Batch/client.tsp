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
@@clientName(ComputeBatchModelFactory, "BatchModelFactory", "csharp");

/* PYTHON OVERRIDES */
@@access(Azure.Batch.Tasks.getTaskFileProperties, Access.internal, "python");
@@clientName(BatchClient.getTaskFileProperties,
  "getTaskFilePropertiesInternal",
  "python"
);
@@access(Azure.Batch.Nodes.getNodeFileProperties, Access.internal, "python");
@@clientName(BatchClient.getNodeFileProperties,
  "getNodeFilePropertiesInternal",
  "python"
);
