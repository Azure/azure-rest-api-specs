import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "../common/models.tsp";
import "../main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union instead of a plain string"
@doc("Distribution configuration of the job. If set, this should be one of Mpi, Tensorflow, PyTorch, or null.")
@discriminator("distributionType")
@added(Versions.v2025_05_15_preview)
model DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distributionType: string;
}

@doc("PyTorch distribution configuration.")
@added(Versions.v2025_05_15_preview)
model PyTorchDistribution extends DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distributionType: "PyTorch";

  @doc("Number of processes per node.")
  processCountPerInstance?: int32;
}

@doc("MPI distribution configuration.")
@added(Versions.v2025_05_15_preview)
model MpiDistribution extends DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distributionType: "Mpi";

  @doc("Number of processes per MPI node.")
  processCountPerNode?: int32;
}

@doc("TensorFlow distribution configuration.")
@added(Versions.v2025_05_15_preview)
model TensorFlowDistribution extends DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distributionType: "TensorFlow";

  @doc("Number of workers. If not specified, will default to the instance count.")
  workerCount?: int32;

  @doc("Number of parameter server tasks.")
  parameterServerCount?: int32;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union instead of a plain string"
@doc("Mapping of input data bindings used in the job.")
@discriminator("jobInputType")
@added(Versions.v2025_05_15_preview)
model JobInput {
  @doc("Specifies the type of job.")
  jobInputType: string;

  @doc("Description for the input.")
  description?: string;
}

@doc("Uri file job input.")
@added(Versions.v2025_05_15_preview)
model UriFileJobInput extends JobInput {
  @doc("Specifies the type of job.")
  jobInputType: "uri_file";

  @doc("Input Asset URI.")
  uri: string;

  @doc("Input Asset Delivery Mode.")
  mode?: string;
}

@doc("Uri folder job input.")
@added(Versions.v2025_05_15_preview)
model UriFolderJobInput extends JobInput {
  @doc("Specifies the type of job.")
  jobInputType: "uri_folder";

  @doc("Input Asset URI.")
  uri: string;

  @doc("Input Asset Delivery Mode.")
  mode?: string;
}

@doc("Literal input type.")
@added(Versions.v2025_05_15_preview)
model LiteralJobInput extends JobInput {
  @doc("Specifies the type of job.")
  jobInputType: "literal";

  @doc("Literal value for the input.")
  value: string;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union instead of a plain string"
@doc("Mapping of output data bindings used in the job.")
@discriminator("jobOutputType")
@added(Versions.v2025_05_15_preview)
model JobOutput {
  @doc("Specifies the type of job.")
  jobOutputType: string;

  @doc("Description for the output.")
  description?: string;
}

@doc("Uri file job output.")
@added(Versions.v2025_05_15_preview)
model UriFileJobOutput extends JobOutput {
  @doc("Specifies the type of job.")
  jobOutputType: "uri_file";

  @doc("Output Asset URI.")
  uri?: string;

  @doc("Output Asset Delivery Mode.")
  mode?: string;

  @doc("Name of the output data asset to register.")
  assetName?: string;
}

@doc("Uri folder job output.")
@added(Versions.v2025_05_15_preview)
model UriFolderJobOutput extends JobOutput {
  @doc("Specifies the type of job.")
  jobOutputType: "uri_folder";

  @doc("Output Asset URI.")
  uri?: string;

  @doc("Output Asset Delivery Mode.")
  mode?: string;

  @doc("Name of the output data asset to register.")
  assetName?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union instead of a plain string"
@doc("Nodes that user would like to start the service on.")
@discriminator("nodesValueType")
@added(Versions.v2025_05_15_preview)
model NodeCollection {
  @doc("Type of the Nodes value.")
  nodesValueType: string;
}

@doc("All nodes means the service will be running on all of the nodes of the job.")
@added(Versions.v2025_05_15_preview)
model AllNodes extends NodeCollection {
  @doc("Type of the Nodes value.")
  nodesValueType: "All";
}

@doc("Job endpoint definition.")
@added(Versions.v2025_05_15_preview)
model JobService {
  @doc("Endpoint type.")
  jobServiceType?: string;

  @doc("Port for endpoint.")
  port?: int32;

  @doc("Url for endpoint.")
  endpoint?: string;

  @doc("Additional properties to set on the endpoint.")
  properties?: Record<string>;

  @doc("Nodes that user would like to start the service on. If Nodes is not set or set to null, the service will only be started on leader node.")
  nodes?: AllNodes;

  @doc("Status of endpoint.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("Any error in the service.")
  @visibility(Lifecycle.Read)
  errorMessage?: string;
}

@doc("Compute Resource configuration for the job.")
@added(Versions.v2025_05_15_preview)
model JobResourceConfiguration {
  @doc("Optional number of instances or nodes used by the compute target.")
  instanceCount?: int32;

  @doc("Optional type of VM used as supported by the compute target.")
  instanceType?: string;

  @doc("Additional properties bag.")
  properties?: Record<unknown>;

  @doc("Size of the docker container's shared memory block. This should be in the format of (number)(unit) where number as to be greater than 0 and the unit can be one of b(bytes), k(kilobytes), m(megabytes), or g(gigabytes).")
  shmSize?: string;

  @doc("Extra arguments to pass to the Docker run command. This would override any parameters that have already been set by the system, or in this section. This parameter is only supported for Azure ML compute types.")
  dockerArgs?: string;
}

@doc("Command Job limit class.")
@added(Versions.v2025_05_15_preview)
model CommandJobLimits {
  @doc("JobLimit type.")
  @visibility(Lifecycle.Read)
  jobLimitsType: "Command";

  @doc("The max run duration in ISO 8601 format, after which the job will be cancelled. Only supports duration with precision as low as Seconds.")
  timeout?: duration;
}

@doc("Queue settings for the job.")
@added(Versions.v2025_05_15_preview)
model QueueSettings {
  @doc("Controls the compute job tier.")
  jobTier?: string;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
@added(Versions.v2025_05_15_preview)
model JobSystemData {
  @doc("The identity that created the resource.")
  @visibility(Lifecycle.Read)
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  @visibility(Lifecycle.Read)
  createdByType?: string;

  @doc("The timestamp of resource creation (UTC).")
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  @visibility(Lifecycle.Read)
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  @visibility(Lifecycle.Read)
  lastModifiedByType?: string;

  @doc("The timestamp of resource last modification (UTC).")
  @visibility(Lifecycle.Read)
  lastModifiedAt?: utcDateTime;
}

@doc("Command job definition.")
@resource("jobs")
@added(Versions.v2025_05_15_preview)
model CommandJob {
  @doc("The name and identifier for the Job. This is case-sensitive.")
  @visibility(Lifecycle.Read)
  @key
  id: string;

  @doc("The name of the resource.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Specifies the type of job.")
  @visibility(Lifecycle.Read)
  jobType: "Command";

  @doc("The command to execute on startup of the job.")
  command: string;

  @doc("ACR path of environment")
  environmentId: string;

  @doc("Display name of job.")
  displayName?: string;

  @doc("The asset description text.")
  description?: string;

  @doc("Tag dictionary. Tags can be added, removed, and updated.")
  tags?: Record<string>;

  @doc("The asset property dictionary.")
  properties?: Record<string>;

  @doc("Datasets Id")
  codeId?: string;

  @doc("Compute resource ID.")
  computeId?: string;

  @doc("Mapping of input data bindings used in the job.")
  inputs?: Record<JobInput>;

  @doc("Mapping of output data bindings used in the job.")
  outputs?: Record<JobOutput>;

  @doc("Environment variables included in the job.")
  environmentVariables?: Record<string>;

  @doc("Compute Resource configuration for the job.")
  resources?: JobResourceConfiguration;

  @doc("Distribution configuration of the job. If set, this should be one of Mpi, Tensorflow, PyTorch, or null.")
  distribution?: DistributionConfiguration;

  @doc("Command Job limit.")
  limits?: CommandJobLimits;

  @doc("List of JobEndpoints. For local jobs, a job endpoint will have an endpoint value of FileStreamObject.")
  services?: Record<JobService>;

  @doc("Queue settings for the job.")
  queueSettings?: QueueSettings;

  @doc("Is the asset archived?")
  isArchived?: boolean;

  @doc("Status of the job.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility(Lifecycle.Read)
  creationContext?: JobSystemData;
}

// =============================================
// List filter parameters
// =============================================

@doc("Query parameters for filtering the job list.")
@added(Versions.v2025_05_15_preview)
model ListJobsQueryParameters {
  @doc("Number of records to skip for pagination.")
  @query
  skip?: int32;

  @doc("Filter jobs by type (e.g., 'Command').")
  @query
  jobType?: string;

  @doc("Filter jobs by tag in the format 'key=value' (e.g., 'framework=pytorch').")
  @query
  tag?: string;

  @doc("Specifies which view type to apply when listing jobs.")
  @query
  listViewType?: ListViewType;
}

@doc("Specifies which jobs to include in a list result based on their lifecycle state.")
@added(Versions.v2025_05_15_preview)
union ListViewType {
  string,

  @doc("Show only active (non-archived) jobs.")
  ActiveOnly: "ActiveOnly",

  @doc("Show only archived jobs.")
  ArchivedOnly: "ArchivedOnly",

  @doc("Show all jobs regardless of archived state.")
  All: "All",
}
