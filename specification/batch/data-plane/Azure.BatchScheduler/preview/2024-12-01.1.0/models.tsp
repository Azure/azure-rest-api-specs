import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Foundations;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

namespace Azure.BatchScheduler;

@doc("Provides the 'x-ms-request-id' header to enable request correlation in responses.")
@trait("RequestIdResponseHeader")
@access(Access.internal)
model RequestIdResponseHeaderTrait {
  @doc("An opaque, globally-unique, server-generated string identifier for the request.")
  requestId: {
    @traitLocation(TraitLocation.Response)
    response: RequestIdResponseHeader;
  };
}

alias LastModifiedResponseEnvelope = {
  @header("Last-Modified")
  @encode(DateTimeKnownEncoding.rfc7231)
  @doc("The time at which the resource was last modified.")
  lastmodified?: utcDateTime;
};

@doc("An Azure Batch Job.")
@resource("jobs")
model CloudJob {
  @doc("The name is case-preserving and case-insensitive (that is, you may not have two names within an Account that differ only by case).")
  @key("jobName")
  @segment("jobs")
  @path
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]{1,64}$")
  name: string;

  @doc("The ID is like '/jobs/jobName'.")
  id: string;

  @doc("Job property bag")
  properties: JobProperties;
}

@doc("The properties of an Azure Batch Job.")
model JobProperties {
  @doc("The display name for the Job.")
  displayName?: string;

  @doc("The creation time of the Job.")
  creationTime?: utcDateTime;

  @doc("The state of the Job.")
  state?: JobState;

  @doc("The time at which the Job entered its current state.")
  stateTransitionTime?: utcDateTime;

  @doc("This property is not set if the Job is in its initial Active state.")
  previousState?: JobState;

  @doc("This property is not set if the Job is in its initial Active state.")
  previousStateTransitionTime?: utcDateTime;

  @doc("Priority values can range from -1000 to 1000, with -1000 being the lowest priority and 1000 being the highest priority. The default value is 0.")
  priority?: int32;

  @doc("The value of maxParallelTasks must be -1 or greater than 0 if specified. If not specified, the default value is -1, which means there's no limit to the number of tasks that can be run at once. You can update a job's maxParallelTasks after it has been created using the update job API.")
  maxParallelTasks?: int32 = -1;

  @doc("The Job Preparation Task is a special Task run on each Compute Node before any other Task of the Job.")
  jobPreparationTask?: JobPreparationTask;

  @doc("The Job Release Task is a special Task run at the end of the Job on each Compute Node that has run any other Task of the Job.")
  jobReleaseTask?: JobReleaseTask;

  @doc("Specifies how a Job should be assigned to the Pools.")
  poolInfo?: PoolInformation;

  @doc("The object specifies the task group and its dependencies")
  dependencies?: TaskGroupDependency[];

  @doc("Individual Tasks can override an environment setting specified here by specifying the same setting name with a different value.")
  commonEnvironmentSettings?: EnvironmentSetting[];

  @doc("The Batch service does not assign any meaning to metadata; it is solely for the use of user code.")
  metadata?: MetadataItem[];

  @doc("This is an opaque string. You can use it to detect whether the Job has changed between requests. In particular, you can be pass the ETag when updating a Job to specify that your changes should take effect only if nobody else has modified the Job in the meantime.")
  eTag?: string;

  @doc("This is the last time at which the Job level data, such as the Job state or priority, changed. It does not factor in task-level changes such as adding new Tasks or Tasks changing state.")
  lastModified?: utcDateTime;
}

@doc("The definition of the task group dependency relationship.")
model TaskGroupDependency {
  @doc("The task group name.")
  taskGroupName: string;

  @doc("The upstreaming task group and its condition that this task group depend on.")
  dependOn: TaskGroupAndCondition[];
}

@doc("The definition of the task group and condition.")
model TaskGroupAndCondition {
  @doc("The task group name.")
  taskGroupName: string;

  @doc("The condition that this task group depend on.")
  condition: DependencyCondition;
}

@doc("The condition of the dependency.")
enum DependencyCondition {
  @doc("All tasks in the taskGroup are succeeded.")
  succeeded,

  @doc("All tasks in the taskGroup are failed.")
  failed,

  @doc("All tasks in the taskGroup are completed (succeeded or failed).")
  completed,

  @doc("Any one task in the taskGroup is succeeded.")
  succeeded_any,

  @doc("Any one task in the taskGroup is failed.")
  failed_any,

  @doc("Any one task in the taskGroup is completed (succeeded or failed).")
  completed_any,
}

@doc("Specifies how a Job should be assigned to the Pools.")
model PoolInformation {
  @doc("The ID of one or more existing Pool.")
  poolIds: string[];
}

@doc("You can use Job Preparation to prepare a Node to run Tasks for the Job. Activities commonly performed in Job Preparation include: Downloading common resource files used by all the Tasks in the Job. The Job Preparation Task can download these common resource files to the shared location on the Node. (AZ_BATCH_NODE_ROOT_DIR/shared), or starting a local service on the Node so that all Tasks of that Job can communicate with it. If the Job Preparation Task fails (that is, exhausts its retry count before exiting with exit code 0), Batch will not run Tasks of this Job on the Node. The Compute Node remains ineligible to run Tasks of this Job until it is reimaged. The Compute Node remains active and can be used for other Jobs. The Job Preparation Task can run multiple times on the same Node. Therefore, you should write the Job Preparation Task to handle re-execution. If the Node is rebooted, the Job Preparation Task is run again on the Compute Node before scheduling any other Task of the Job, if rerunOnNodeRebootAfterSuccess is true or if the Job Preparation Task did not previously complete. If the Node is reimaged, the Job Preparation Task is run again before scheduling any Task of the Job. Batch will retry Tasks when a recovery operation is triggered on a Node. Examples of recovery operations include (but are not limited to) when an unhealthy Node is rebooted or a Compute Node disappeared due to host failure. Retries due to recovery operations are independent of and are not counted against the maxTaskRetryCount. Even if the maxTaskRetryCount is 0, an internal retry due to a recovery operation may occur. Because of this, all Tasks should be idempotent. This means Tasks need to tolerate being interrupted and restarted without causing any corruption or duplicate data. The best practice for long running Tasks is to use some form of checkpointing.")
model JobPreparationTask {
  @doc("The ID can contain any combination of alphanumeric characters including hyphens and underscores and cannot contain more than 64 characters. If you do not specify this property, the Batch service assigns a default value of 'jobpreparation'. No other Task in the Job can have the same ID as the Job Preparation Task. If you try to submit a Task with the same id, the Batch service rejects the request with error code TaskIdSameAsJobPreparationTask; if you are calling the REST API directly, the HTTP status code is 409 (Conflict).")
  id?: string;

  @doc("The definition of the Task.")
  definition: TaskDefinition;

  @doc("Execution constraints to apply to a Task.")
  constraints?: TaskConstraints;

  @doc("If true and the Job Preparation Task fails on a Node, the Batch service retries the Job Preparation Task up to its maximum retry count (as specified in the constraints element). If the Task has still not completed successfully after all retries, then the Batch service will not schedule Tasks of the Job to the Node. The Node remains active and eligible to run Tasks of other Jobs. If false, the Batch service will not wait for the Job Preparation Task to complete. In this case, other Tasks of the Job can start executing on the Compute Node while the Job Preparation Task is still running; and even if the Job Preparation Task fails, new Tasks will continue to be scheduled on the Compute Node. The default value is true.")
  waitForSuccess?: boolean;

  @doc("The Job Preparation Task is always rerun if a Compute Node is reimaged, or if the Job Preparation Task did not complete (e.g. because the reboot occurred while the Task was running). Therefore, you should always write a Job Preparation Task to be idempotent and to behave correctly if run multiple times. The default value is true.")
  rerunOnNodeRebootAfterSuccess?: boolean;
}

@doc("The Job Release Task runs when the Job ends, because of one of the following: The user calls the Terminate Job API, or the Delete Job API while the Job is still active, the Job's maximum wall clock time constraint is reached, and the Job is still active, or the Job's Job Manager Task completed, and the Job is configured to terminate when the Job Manager completes. The Job Release Task runs on each Node where Tasks of the Job have run and the Job Preparation Task ran and completed. If you reimage a Node after it has run the Job Preparation Task, and the Job ends without any further Tasks of the Job running on that Node (and hence the Job Preparation Task does not re-run), then the Job Release Task does not run on that Compute Node. If a Node reboots while the Job Release Task is still running, the Job Release Task runs again when the Compute Node starts up. The Job is not marked as complete until all Job Release Tasks have completed. The Job Release Task runs in the background. It does not occupy a scheduling slot; that is, it does not count towards the taskSlotsPerNode limit specified on the Pool.")
model JobReleaseTask {
  @doc("The ID can contain any combination of alphanumeric characters including hyphens and underscores and cannot contain more than 64 characters. If you do not specify this property, the Batch service assigns a default value of 'jobrelease'. No other Task in the Job can have the same ID as the Job Release Task. If you try to submit a Task with the same id, the Batch service rejects the request with error code TaskIdSameAsJobReleaseTask; if you are calling the REST API directly, the HTTP status code is 409 (Conflict).")
  id?: string;

  @doc("The definition of the Task.")
  definition: TaskDefinition;

  @doc("The maximum elapsed time that the Job Release Task may run on a given Compute Node, measured from the time the Task starts. If the Task does not complete within the time limit, the Batch service terminates it. The default value is 15 minutes. You may not specify a timeout longer than 15 minutes. If you do, the Batch service rejects it with an error; if you are calling the REST API directly, the HTTP status code is 400 (Bad Request).")
  maxWallClockTime?: duration;

  @doc("The default is 7 days, i.e. the Task directory will be retained for 7 days unless the Compute Node is removed or the Job is deleted.")
  retentionTime?: duration;
}

@doc("The Batch service does not assign any meaning to this metadata; it is solely for the use of user code.")
model MetadataItem {
  @doc("The name of the metadata item.")
  name: string;

  @doc("The value of the metadata item.")
  value: string;
}

@doc("The state of the Job.")
enum JobState {
  @doc("After a job has been created and add tasks into it, then this job has been submitted to Batch.")
  configurating,

  @doc("Batch received the job and put its tasks into queue. In this moment, all tasks’ states are Queued state. If the user cancels the job in this state, then the job goes into CANCELLING state and then CANCELLED.")
  queued,

  @doc("when a task starts running, then mark this job as RUNNING state.")
  running,

  @doc("When a task state changes from RUNNING to FAILED, then mark this job state to FAILED state.")
  failed,

  @doc("When all tasks state change from RUNNING to SUCCEED, then mark this job state to SUCCEED state.")
  succeeded,

  @doc("The user has cancelled the Job, but the cancel operation is still in progress (for example, because Job Release Tasks are running).")
  cancelling,

  @doc("All Tasks have cancelled, and the system will not accept any more Tasks or any further changes to the Job.")
  cancelled,

  @doc("A user has requested that the Job be deleted, but the delete operation is still progress (for example, because the system is still cancelling running Tasks).")
  deleting,
}

@doc("An Azure Batch Job to add.")
model JobAddParameter {
  @doc("The display name need not be unique and can contain any Unicode characters up to a maximum length of 1024.")
  displayName?: string;

  @doc("Priority values can range from -1000 to 1000, with -1000 being the lowest priority and 1000 being the highest priority. The default value is 0.")
  priority?: int32;

  @doc("The value of maxParallelTasks must be -1 or greater than 0 if specified. If not specified, the default value is -1, which means there's no limit to the number of tasks that can be run at once. You can update a job's maxParallelTasks after it has been created using the update job API.")
  maxParallelTasks?: int32 = -1;

  @doc("If a Job has a Job Preparation Task, the Batch service will run the Job Preparation Task on a Node before starting any Tasks of that Job on that Compute Node.")
  jobPreparationTask?: JobPreparationTask;

  @doc("A Job Release Task cannot be specified without also specifying a Job Preparation Task for the Job. The Batch service runs the Job Release Task on the Nodes that have run the Job Preparation Task. The primary purpose of the Job Release Task is to undo changes to Compute Nodes made by the Job Preparation Task. Example activities include deleting local files, or shutting down services that were started as part of Job preparation.")
  jobReleaseTask?: JobReleaseTask;

  @doc("Individual Tasks can override an environment setting specified here by specifying the same setting name with a different value.")
  commonEnvironmentSettings?: EnvironmentSetting[];

  @doc("Specifies how a Job should be assigned to a Pool.")
  poolInfo: PoolInformation;

  @doc("The Batch service does not assign any meaning to metadata; it is solely for theuse of user code.")
  metadata?: MetadataItem[];

  @doc("The object specifies the task group and its dependencies")
  dependencies?: TaskGroupDependency[];
}

@doc("The set of changes to be made to a Job.")
model JobPatchParameter {
  @doc("Priority values can range from -1000 to 1000, with -1000 being the lowest priority and 1000 being the highest priority. If omitted, the priority of the Job is left unchanged.")
  priority?: int32;

  @doc("The value of maxParallelTasks must be -1 or greater than 0 if specified. If not specified, the default value is -1, which means there's no limit to the number of tasks that can be run at once. You can update a job's maxParallelTasks after it has been created using the update job API.")
  maxParallelTasks?: int32;

  @doc("You may change the Pool for a Job only when the Job is disabled. The Patch Job all will fail if you include the poolInfo element and the Job is not disabled. If you specify an autoPoolSpecification in the poolInfo, only the keepAlive property of the autoPoolSpecification can be updated, and then only if the autoPoolSpecification has a poolLifetimeOption of Job (other job properties can be updated as normal). If omitted, the Job continues to run on its current Pool.")
  poolInfo?: PoolInformation;

  @doc("If omitted, the existing Job metadata is left unchanged.")
  metadata?: MetadataItem[];
}

@doc("The set of changes to be made to a Job.")
model JobUpdateParameter {
  @doc("Priority values can range from -1000 to 1000, with -1000 being the lowest priority and 1000 being the highest priority. If omitted, it is set to the default value 0.")
  priority?: int32;

  @doc("The value of maxParallelTasks must be -1 or greater than 0 if specified. If not specified, the default value is -1, which means there's no limit to the number of tasks that can be run at once. You can update a job's maxParallelTasks after it has been created using the update job API.")
  maxParallelTasks?: int32 = -1;

  @doc("You may change the Pool for a Job only when the Job is disabled. The Update Job call will fail if you include the poolInfo element and the Job is not disabled. If you specify an autoPoolSpecification in the poolInfo, only the keepAlive property of the autoPoolSpecification can be updated, and then only if the autoPoolSpecification has a poolLifetimeOption of Job (other job properties can be updated as normal).")
  poolInfo: PoolInformation;

  @doc("If omitted, it takes the default value of an empty list; in effect, any existing metadata is deleted.")
  metadata?: MetadataItem[];
}

@doc("Batch will retry Tasks when a recovery operation is triggered on a Node.   Examples of recovery operations include (but are not limited to) when an   unhealthy Node is rebooted or a Compute Node disappeared due to host failure.   Retries due to recovery operations are independent of and are not counted   against the maxTaskRetryCount. Even if the maxTaskRetryCount is 0, an internal   retry due to a recovery operation may occur. Because of this, all Tasks should   be idempotent. This means Tasks need to tolerate being interrupted and   restarted without causing any corruption or duplicate data. The best practice   for long running Tasks is to use some form of checkpointing.")
@resource("tasks")
@parentResource(CloudJob)
model CloudTask {
  @doc("The name can contain any combination of alphanumeric characters including hyphens and underscores, and cannot contain more than 64 characters.")
  @key("taskName")
  @path
  @segment("tasks")
  name: string;

  @doc("The ID is like '/jobs/jobName/tasks/taskName'.")
  id: string;

  @doc("Task property bag")
  properties: TaskProperties;
}

@doc("The properties of an Azure Batch Task.")
model TaskProperties {
  @doc("The display name need not be unique and can contain any Unicode characters up to a maximum length of 1024.")
  displayName?: string;

  @doc("This is an opaque string. You can use it to detect whether the Task has changed between requests. In particular, you can be pass the ETag when updating a Task to specify that your changes should take effect only if nobody else has modified the Task in the meantime.")
  eTag?: string;

  @doc("The last modified time of the Task.")
  lastModified?: utcDateTime;

  @doc("The TaskGroup belongs to.")
  taskGroup?: string;

  @doc("The scheduler policy for the Task.")
  schedulerPolicy?: TaskSchedulingPolicy;

  @doc("The definition of the Task.")
  definition: TaskDefinition;

  // @doc("How the Batch service should respond when the Task completes.")
  // exitConditions?: ExitConditions;

  @doc("The creation time of the Task.")
  creationTime?: utcDateTime;

  @doc("The state of the Task.")
  state?: TaskState;

  @doc("The time at which the Task entered its current state.")
  stateTransitionTime?: utcDateTime;

  @doc("This property is not set if the Task is in its initial Active state.")
  previousState?: TaskState;

  @doc("This property is not set if the Task is in its initial Active state.")
  previousStateTransitionTime?: utcDateTime;

  @doc("Information about the execution of a Task.")
  executionInfo?: TaskExecutionInformation;

  // @doc("
  //   Information about the Compute Node on which a Task ran.
  //")
  // nodeInfo?: ComputeNodeInformation;

  // @doc("
  //   Multi-instance Tasks are commonly used to support MPI Tasks. In the MPI case,
  //   if any of the subtasks fail (for example due to exiting with a non-zero exit
  //   code) the entire multi-instance Task fails. The multi-instance Task is then
  //   terminated and retried, up to its retry limit.
  //")
  // multiInstanceSettings?: MultiInstanceSettings;
}

@doc("The scheduling policy for the Task.")
model TaskSchedulingPolicy {
  @doc("Priority values can range from -1000 to 1000, with -1000 being the lowest priority and 1000 being the highest priority. The default value is 0.")
  priority?: int32;

  @doc("The resource requirements to use for the Task.")
  resoruceRequirements: ResourceRequirement;

  @doc("Execution constraints to apply to a Task.")
  constraints?: TaskConstraints;

  @doc("The task preemption behaviors.")
  preemptionPolicy?: PreemptionPolicy;
}

@doc("The resource requirements to use for the Task.")
model ResourceRequirement {
  @doc("The number of CPU cores required by the Task.")
  cpu?: float32;

  @doc("The amount of memory required by the Task.")
  memory?: int32;

  @doc("The pool id by the Task.")
  poolId?: string;
}

@doc("Execution constraints to apply to a Task.")
model TaskConstraints {
  @doc("If this is not specified, there is no time limit on how long the Task may run.")
  maxWallClockTime?: duration;

  @doc("The default is 7 days, i.e. the Task directory will be retained for 7 days unless the Compute Node is removed or the Job is deleted.")
  retentionTime?: duration;

  @doc("Note that this value specifically controls the number of retries for the Task executable due to a nonzero exit code. The Batch service will try the Task once, and may then retry up to this limit. For example, if the maximum retry count is 3, Batch tries the Task up to 4 times (one initial try and 3 retries). If the maximum retry count is 0, the Batch service does not retry the Task after the first attempt. If the maximum retry count is -1, the Batch service retries the Task without limit, however this is not recommended for a start task or any task. The default value is 0 (no retries).")
  maxTaskRetryCount?: int32;
}

@doc("Define task preemption behaviors")
model PreemptionPolicy {
  @doc("Whether the task can be preempted.")
  preemptible: boolean;
}

@doc("The definition of the Task.")
model TaskDefinition {
  @doc("""
      For multi-instance Tasks, the command line is executed as the primary Task, after the primary Task and all subtasks have finished executing the
      coordination command line. The command line does not run under a shell, and therefore cannot take advantage of shell features such as environment variable
      expansion. If you want to take advantage of such features, you should invoke the shell in the command line, for example using "cmd /c MyCommand" in Windows
      or "/bin/sh -c MyCommand" in Linux. If the command line refers to file paths, it should use a relative path (relative to the Task working directory), or use
      the Batch provided environment variable (https://docs.microsoft.com/azure/batch/batch-compute-node-environment-variables).
    """)
  commandLine: string;

  // @doc("
  //   If the Pool that will run this Task has containerConfiguration set, this must
  //   be set as well. If the Pool that will run this Task doesn't have
  //   containerConfiguration set, this must not be set. When this is specified, all
  //   directories recursively below the AZ_BATCH_NODE_ROOT_DIR (the root of Azure
  //   Batch directories on the node) are mapped into the container, all Task
  //   environment variables are mapped into the container, and the Task command line
  //   is executed in the container. Files produced in the container outside of
  //   AZ_BATCH_NODE_ROOT_DIR might not be reflected to the host disk, meaning that
  //   Batch file APIs will not be able to access those files.
  //")
  // containerSettings?: TaskContainerSettings;

  @doc("For multi-instance Tasks, the resource files will only be downloaded to the Compute Node on which the primary Task is executed. There is a maximum size for the list of resource files.  When the max size is exceeded, the request will fail and the response error code will be RequestEntityTooLarge. If this occurs, the collection of ResourceFiles must be reduced in size. This can be achieved using .zip files, Application Packages, or Docker Containers.")
  resourceFiles?: ResourceFile[];

  // @doc("
  //   For multi-instance Tasks, the files will only be uploaded from the Compute Node
  //   on which the primary Task is executed.
  //")
  // outputFiles?: OutputFile[];

  @doc("A list of environment variable settings for the Task.")
  environmentSettings?: EnvironmentSetting[];

  @doc("If omitted, the Task runs as a non-administrative user unique to the Task.")
  userIdentity?: UserIdentity;
}

@doc("A single file or multiple files to be downloaded to a Compute Node.")
model ResourceFile {
  @doc("The URL of the blob container within Azure Blob Storage. The autoStorageContainerName, storageContainerUrl and httpUrl properties are mutually exclusive and one of them must be specified. This URL must be readable and listable from compute nodes. There are three ways to get such a URL for a container in Azure storage: include a Shared Access Signature (SAS) granting read and list permissions on the container, use a managed identity with read and list permissions, or set the ACL for the container to allow public access.")
  storageContainerUrl?: string;

  @doc("The URL of the file to download. The autoStorageContainerName, storageContainerUrl and httpUrl properties are mutually exclusive and one of them must be specified. If the URL points to Azure Blob Storage, it must be readable from compute nodes. There are three ways to get such a URL for a blob in Azure storage: include a Shared Access Signature (SAS) granting read permissions on the blob, use a managed identity with read permission, or set the ACL for the blob or its container to allow public access.")
  httpUrl?: string;

  @doc("The blob prefix to use when downloading blobs from an Azure Storage container. Only the blobs whose names begin with the specified prefix will be downloaded. The property is valid only when autoStorageContainerName or storageContainerUrl is used. This prefix can be a partial filename or a subdirectory. If a prefix is not specified, all the files in the container will be downloaded.")
  blobPrefix?: string;

  @doc("The location on the Compute Node to which to download the file(s), relative to the Task's working directory. If the httpUrl property is specified, the filePath is required and describes the path which the file will be downloaded to, including the filename. Otherwise, if the autoStorageContainerName or storageContainerUrl property is specified, filePath is optional and is the directory to download the files to. In the case where filePath is used as a directory, any directory structure already associated with the input data will be retained in full and appended to the specified filePath directory. The specified relative path cannot break out of the Task's working directory (for example by using '..').")
  filePath?: string;

  @doc("The file permission mode attribute in octal format. This property applies only to files being downloaded to Linux Compute Nodes. It will be ignored if it is specified for a resourceFile which will be downloaded to a Windows Compute Node. If this property is not specified for a Linux Compute Node, then a default value of 0770 is applied to the file.")
  fileMode?: string;

  // @doc("The reference to the user assigned identity to use to access Azure Blob Storage specified by storageContainerUrl or httpUrl.")
  // identityReference?: BatchNodeIdentityReference;
}

@doc("The definition of the user identity under which the Task is run. Specify either the userName or autoUser property, but not both.")
model UserIdentity {
  @doc("The name of the user identity under which the Task is run. The userName and autoUser properties are mutually exclusive; you must specify one but not both.")
  username?: string;

  @doc("The auto user under which the Task is run. The userName and autoUser properties are mutually exclusive; you must specify one but not both.")
  autoUser?: AutoUserSpecification;
}

@doc("""
  Specifies the options for the auto user that runs an Azure Batch Task.
  """)
model AutoUserSpecification {
  @doc("The scope for the auto user. The default value is pool. If the pool is running Windows, a value of Task should be specified if stricter isolation between tasks is required, such as if the task mutates the registry in a way which could impact other tasks.")
  scope?: AutoUserScope;

  @doc("The elevation level of the auto user. The default value is nonAdmin.")
  elevationLevel?: ElevationLevel;
}

@doc("AutoUserScope enums")
enum AutoUserScope {
  @doc("Specifies that the service should create a new user for the Task.")
  task,

  @doc("Specifies that the Task runs as the common auto user Account which is created on every Compute Node in a Pool.")
  pool,
}

@doc("ElevationLevel enums")
enum ElevationLevel {
  @doc("The user is a standard user without elevated access.")
  nonAdmin,

  @doc("The user is a user with elevated access and operates with full Administrator permissions.")
  admin,
}

@doc("An environment variable to be set on a Task process.")
model EnvironmentSetting {
  @doc("The name of the environment variable.")
  name: string;

  @doc("The value of the environment variable.")
  value?: string;
}

@doc("The state of the Task.")
enum TaskState {
  @doc("The Task is queued and able to run, but is not currently assigned to a Compute Node. A Task enters this state when it is created, when it is enabled after being disabled, or when it is awaiting a retry after a failed run.")
  active,

  @doc("The Task has been assigned to a Compute Node, but is waiting for a required Job Preparation Task to complete on the Compute Node. If the Job Preparation Task succeeds, the Task will move to running. If the Job Preparation Task fails, the Task will return to active and will be eligible to be assigned to a different Compute Node.")
  preparing,

  @doc("The Task is running on a Compute Node. This includes task-level preparation such as downloading resource files or deploying Packages specified on the Task - it does not necessarily mean that the Task command line has started executing.")
  running,

  @doc("The Task is no longer eligible to run, usually because the Task has finished successfully, or the Task has finished unsuccessfully and has exhausted its retry limit. A Task is also marked as completed if an error occurred launching the Task, or when the Task has been terminated.")
  succeeded,

  @doc("The Task is no longer eligible to run, usually because the Task has finished successfully, or the Task has finished unsuccessfully and has exhausted its retry limit. A Task is also marked as completed if an error occurred launching the Task, or when the Task has been terminated.")
  failed,

  @doc("The Task is no longer eligible to run, usually because the Task has finished successfully, or the Task has finished unsuccessfully and has exhausted its retry limit. A Task is also marked as completed if an error occurred launching the Task, or when the Task has been terminated.")
  cancelled,
}

@doc("Information about the execution of a Task.")
model TaskExecutionInformation {
  @doc("The time at which the Task started running. 'Running' corresponds to the running state, so if the Task specifies resource files or Packages, then the start time reflects the time at which the Task started downloading or deploying these. If the Task has been restarted or retried, this is the most recent time at which the Task started running. This property is present only for Tasks that are in the running or completed state.")
  startTime?: utcDateTime;

  @doc("The time at which the Task completed. This property is set only if the Task is in the Completed state.")
  endTime?: utcDateTime;

  @doc("The exit code of the program specified on the Task command line. This property is set only if the Task is in the completed state. In general, the exit code for a process reflects the specific convention implemented by the application developer for that process. If you use the exit code value to make decisions in your code, be sure that you know the exit code convention used by the application process. However, if the Batch service terminates the Task (due to timeout, or user termination via the API) you may see an operating system-defined exit code.")
  exitCode?: int32;

  // @doc("Information about the container under which the Task is executing. This property is set only if the Task runs in a container context.")
  // containerInfo?: BatchTaskContainerExecutionInfo;

  @doc("Information describing the Task failure, if any. This property is set only if the Task is in the completed state and encountered a failure.")
  failureInfo?: TaskFailureInfo;

  @doc("The number of times the Task has been retried by the Batch service. Task application failures (non-zero exit code) are retried, pre-processing errors (the Task could not be run) and file upload errors are not retried. The Batch service will retry the Task up to the limit specified by the constraints.")
  retryCount: int32;

  @doc("The most recent time at which a retry of the Task started running. This element is present only if the Task was retried (i.e. retryCount is nonzero). If present, this is typically the same as startTime, but may be different if the Task has been restarted for reasons other than retry; for example, if the Compute Node was rebooted during a retry, then the startTime is updated but the lastRetryTime is not.")
  lastRetryTime?: utcDateTime;

  @doc("The number of times the Task has been requeued by the Batch service as the result of a user request. When the user removes Compute Nodes from a Pool (by resizing/shrinking the pool) or when the Job is being disabled, the user can specify that running Tasks on the Compute Nodes be requeued for execution. This count tracks how many times the Task has been requeued for these reasons.")
  requeueCount: int32;

  @doc("The most recent time at which the Task has been requeued by the Batch service as the result of a user request. This property is set only if the requeueCount is nonzero.")
  lastRequeueTime?: utcDateTime;
}

@doc("Information about a Task failure.")
model TaskFailureInfo {
  @doc("The category of the Task error.")
  category: ErrorCategory;

  @doc("An identifier for the Task error. Codes are invariant and are intended to be consumed programmatically.")
  code?: string;

  @doc("A message describing the Task error, intended to be suitable for display in a user interface.")
  message?: string;

  @doc("A list of additional details related to the error.")
  details?: NameValuePair[];
}

@doc("ErrorCategory enums")
enum ErrorCategory {
  @doc("The error is due to a user issue, such as misconfiguration.")
  userError,

  @doc("The error is due to an internal server issue.")
  serverError,
}

@doc("Represents a name-value pair.")
model NameValuePair {
  @doc("The name in the name-value pair.")
  name?: string;

  @doc("The value in the name-value pair.")
  value?: string;
}

@doc("Batch will retry Tasks when a recovery operation is triggered on a Node. Examples of recovery operations include (but are not limited to) when an unhealthy Node is rebooted or a Compute Node disappeared due to host failure. Retries due to recovery operations are independent of and are not counted against the maxTaskRetryCount. Even if the maxTaskRetryCount is 0, an internal retry due to a recovery operation may occur. Because of this, all Tasks should be idempotent. This means Tasks need to tolerate being interrupted and restarted without causing any corruption or duplicate data. The best practice for long running Tasks is to use some form of checkpointing.")
model TaskAddParameter {
  @doc("The display name need not be unique and can contain any Unicode characters up to a maximum length of 1024.")
  displayName?: string;

  @doc("The TaskGroup belongs to.")
  taskGroup?: string;

  @doc("The scheduler policy for the Task.")
  schedulerPolicy?: TaskSchedulingPolicy;

  @doc("The definition of the Task.")
  definition: TaskDefinition;

  // @doc("
  //   How the Batch service should respond when the Task completes.
  //")
  // exitConditions?: ExitConditions;
}

@doc("A collection of Azure Batch Tasks to add.")
model TaskAddCollectionParameter {
  @doc("The total serialized size of this collection must be less than 1MB. If it is greater than 1MB (for example if each Task has 100's of resource files or environment variables), the request will fail with code 'RequestBodyTooLarge' and should be retried again with fewer Tasks.")
  value: TaskAddParameter[];
}

@doc("The result of adding a collection of Tasks to a Job.")
model TaskAddCollectionResult {
  @doc("The results of the add Task collection operation.")
  value?: TaskAddResult[];
}

@doc("Result for a single Task added as part of an add Task collection operation.")
model TaskAddResult {
  @doc("The name of the Task for which this is the result.")
  taskName: string;

  @doc("You can use this to detect whether the Task has changed between requests. In particular, you can be pass the ETag with an Update Task request to specify that your changes should take effect only if nobody else has modified the Job in the meantime.")
  eTag?: string;

  @doc("The last modified time of the Task.")
  lastModified?: utcDateTime;

  @doc("The URL of the Task, if the Task was successfully added.")
  location?: string;

  // @doc("An error response received from the Azure Batch service. ")
  // error?: BatchError;
}

@doc("The set of changes to be made to a Task.")
model TaskUpdateParameter {
  @doc("If omitted, the Task is given the default constraints. For multi-instance Tasks, updating the retention time applies only to the primary Task and not subtasks.")
  constraints?: TaskConstraints;
}

@doc("An Azure Batch Autoscaler.")
@resource("autoscalers")
model Autoscaler {
  @doc("The name is case-preserving and case-insensitive (that is, you may not have two names within an Account that differ only by case).")
  @key("autoscalerName")
  @segment("autoscalers")
  @path
  name: string;

  @doc("The id of the Batch Autoscaler, like '/autoscaler/autoscalerName'.")
  id: string;

  @doc("The properties of the Batch Autoscaler.")
  properties: AutoscalerProperties;
}

@doc("The properties of the Batch Autoscaler.")
model AutoscalerProperties {
  @doc("The list of pool autoscaler.")
  scalers: PoolAutoscaler[];

  @doc("This is an opaque string. You can use it to detect whether the Job has changed between requests. In particular, you can be pass the ETag when updating a Job to specify that your changes should take effect only if nobody else has modified the Job in the meantime.")
  eTag?: string;

  @doc("This is the last time at which the Job level data, such as the Job state or priority, changed. It does not factor in task-level changes such as adding new Tasks or Tasks changing state.")
  lastModified?: utcDateTime;
}

@doc("The individual pool autoscaler. The pool autoscaler is responsible for scaling a single pool.")
model PoolAutoscaler {
  @doc("The ID of the pool to autoscale.")
  poolId: string;

  @doc("The minimum number of compute nodes to allocate for the pool.")
  minNodeCount: int32;

  @doc("The maximum number of compute nodes to allocate for the pool.")
  maxNodeCount: int32;

  @doc("If a node is idle for a certain time (number in seconds), ABS will drain it and tell RM to deallocate it.")
  nodeIdleTimeout?: int32;
}

@doc("An Azure Batch Autoscaler to add.")
model AutoscalerAddParameter {
  @doc("The name is case-preserving and case-insensitive (that is, you may not have two names within an Account that differ only by case).")
  name: string;

  @doc("The list of pool autoscaler.")
  scalers: PoolAutoscaler[];
}

@doc("The set of changes to be made to an Autoscaler.")
model AutoscalerUpdateParameter {
  @doc("The list of pool autoscaler.")
  scalers: PoolAutoscaler[];
}
