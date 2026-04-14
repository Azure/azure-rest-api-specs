import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./computeConfig.tsp";
import "./versions.tsp";
import "./project.tsp";

using Rest;
using Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Anyscale.Platform;

@added(Versions.v2026_02_01_preview)
@parentResource(Project)
@resource("jobs")
model Job is ProxyResource<JobProperties> {
  /** The name of the job. */
  @pattern("^[a-zA-Z0-9_-]*$")
  @key("jobName")
  @path
  @segment("jobs")
  name: string;
}

/** The properties of the job. */
@added(Versions.v2026_02_01_preview)
model JobProperties {
  /** The configuration for the job. */
  config: JobConfig;

  /** The current state of the job. */
  @visibility(Lifecycle.Read)
  state?: JobState;

  /** The URL to the job overview page in the Anyscale console. */
  @visibility(Lifecycle.Read)
  url?: string;

  /** The provisioning state of the job. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** The current state of a job. */
@added(Versions.v2026_02_01_preview)
union JobState {
  /** The job is being started and is not yet running. */
  Starting: "Starting",

  /** The job is running. */
  Running: "Running",

  /** The job did not finish running or the entrypoint returned a non-zero exit code after retrying up to max_retries times. */
  Failed: "Failed",

  /** The job finished running and its entrypoint returned exit code 0. */
  Succeeded: "Succeeded",

  /** The job state is unknown. */
  Unknown: "Unknown",

  string,
}

/** The configuration of the job. */
@added(Versions.v2026_02_01_preview)
model JobConfig {
  /** The URI of the Ray image to use for the job. */
  imageUri?: string;

  /** The compute configuration for the job, either the name of predefined compute config or an inline compute configs object. */
  computeConfig?: ComputeConfigSpecOrReference;

  /** Command that will be run to execute the job, e.g. 'python main.py'. */
  entrypoint?: string;

  /** The working directory that your code will run in. Must be a remote URI like an Azure blob object or git path. */
  workingDir?: string;

  /** Python modules that will be installed along with your runtime env. These must be remote URIs. */
  pyModules?: string[];

  /** A list of pip requirements to install on top of the image. */
  pipRequirements?: string[];

  /** Environment variables to set. */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Intended to be key value pairs."
  envVars?: {};

  /** Maximum number of times the job will be retried before being marked failed. */
  maxRetries?: int32;

  /** The timeout in seconds for each job run. */
  @encode("seconds", int32)
  timeout?: duration;
}

@added(Versions.v2026_02_01_preview)
@armResourceOperations
interface Jobs {
  get is ArmResourceRead<Job>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Job>;
  update is ArmCustomPatchSync<
    Job,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<Job, JobProperties>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Job>;
  listByResourceGroup is ArmResourceListByParent<Job>;
  listBySubscription is ArmListBySubscription<Job>;
}
