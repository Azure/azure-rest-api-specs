import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-portal-core";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Portal;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Suppress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service(#{ title: "Microsoft.GcpConnector" })
@doc("Microsoft.GcpConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.GcpConnector;

/** Api versions */
enum Versions {
  /** 2025-12-01-preview api version */
  `2025-12-01-preview`,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the name is defined in GCP."
@about({
  displayNames: {
    singular: "Cloud Function",
    plural: "Cloud Functions",
  },
  keywords: ["Microsoft.GcpConnector", "Function"],
})
@doc("A Microsoft.GcpConnector resource")
model CloudFunction is TrackedResource<FunctionProperties> {
  @doc("Name of CloudFunction")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("cloudFunctions")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the property name is defined in GCP."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in GCP"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "GCPConnector will not generate SDK. So, Suppressing this error"
@doc("Definition of FunctionProperties")
model FunctionProperties {
  @doc("GCP Properties")
  gcpProperties?: GcpFunctionProperties;

  ...GcpCommonProperties;
}

/**
 * Security patches are applied automatically to the runtime without requiring the function to be redeployed.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "This model is intentionally empty and used as a base type."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in gcp"
model AutomaticUpdatePolicy {}

/**
 * Describes the Build step of the function that builds a container from the given source.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in gcp"
model BuildConfig {
  /**
   * AutomaticUpdatePolicy of BuildConfig.
   */
  automaticUpdatePolicy?: AutomaticUpdatePolicy;

  /**
   * Output only. The Cloud Build name of the latest successful deployment of the function.
   */
  build?: string;

  /**
   * Docker Registry to use for this deployment. This configuration is only applicable to 1st Gen functions, 2nd Gen functions can only use Artifact Registry. If `docker_repository` field is specified, this field will be automatically set as `ARTIFACT_REGISTRY`. If unspecified, it currently defaults to `CONTAINER_REGISTRY`. This field may be overridden by the backend for eligible deployments.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Maintaining compatibility with current SDKs."
  dockerRegistry?:
    | "DOCKER_REGISTRY_UNSPECIFIED"
    | "CONTAINER_REGISTRY"
    | "ARTIFACT_REGISTRY"
    | string;

  /**
   * Repository in Artifact Registry to which the function docker image will be pushed after it is built by Cloud Build. If specified by user, it is created and managed by user with a customer managed encryption key. Otherwise, GCF will create and use a repository named 'gcf-artifacts' for every deployed region. It must match the pattern `projects/{project}/locations/{location}/repositories/{repository}`. Cross-project repositories are not supported. Cross-location repositories are not supported. Repository format must be 'DOCKER'.
   */
  dockerRepository?: string;

  /**
   * The name of the function (as defined in source code) that will be executed. Defaults to the resource name suffix, if not specified. For backward compatibility, if function with given name is not found, then the system will try to use function named "function". For Node.js this is name of a function exported by the module specified in `source_location`.
   */
  entryPoint?: string;

  /**
   * User-provided build-time environment variables for the function
   */
  environmentVariables?: Record<string>;

  /**
   * OnDeployUpdatePolicy of BuildConfig.
   */
  onDeployUpdatePolicy?: OnDeployUpdatePolicy;

  /**
   * The runtime in which to run the function. Required when deploying a new function, optional when updating an existing function. For a complete list of possible choices, see the [`gcloud` command reference](https://cloud.google.com/sdk/gcloud/reference/functions/deploy#--runtime).
   */
  runtime?: string;

  /**
   * [Preview] Service account to be used for building the container
   */
  serviceAccount?: string;

  /**
   * The location of the function source code.
   */
  source?: Source;

  /**
   * Output only. A permanent fixed identifier for source.
   */
  sourceProvenance?: SourceProvenance;

  /**
   * An identifier for Firebase function sources. Disclaimer: This field is only supported for Firebase function deployments.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  sourceToken?: string;

  @doc("Name of the Cloud Build Custom Worker Pool that should be used to build the function. The format of this field is `projects/{project}/locations/{region}/workerPools/{workerPool}` where {project} and {region} are the project id and region respectively where the worker pool is defined and {workerPool} is the short name of the worker pool. If the project id is not the same as the function, then the Cloud Functions Service Agent (service-@gcf-admin-robot.iam.gserviceaccount.com) must be granted the role Cloud Build Custom Workers Builder (roles/cloudbuild.customworkers.builder) in the project.")
  workerPool?: string;
}

/**
 * Filters events based on exact matches on the CloudEvents attributes.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in gcp"
model EventFilter {
  /**
   * Required. The name of a CloudEvents attribute.
   */
  attribute?: string;

  /**
   * Optional. The operator used for matching the events with the value of the filter. If not specified, only events that have an exact key-value pair specified in the filter are matched. The only allowed value is `match-path-pattern`.
   */
  operator?: string;

  /**
   * Required. The value for the attribute.
   */
  value?: string;
}

/**
 * Describes EventTrigger, used to request events to be sent from another service.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in gcp"
model EventTrigger {
  /**
   * Optional. The name of the channel associated with the trigger in `projects/{project}/locations/{location}/channels/{channel}` format. You must provide a channel to receive events from Eventarc SaaS partners.
   */
  channel?: string;

  /**
   * Criteria used to filter events.
   */
  @identifiers(#[])
  eventFilters?: EventFilter[];

  /**
   * Required. The type of event to observe. For example: `google.cloud.audit.log.v1.written` or `google.cloud.pubsub.topic.v1.messagePublished`.
   */
  eventType?: string;

  /**
   * Optional. The name of a Pub/Sub topic in the same project that will be used as the transport topic for the event delivery. Format: `projects/{project}/topics/{topic}`. This is only valid for events of type `google.cloud.pubsub.topic.v1.messagePublished`. The topic provided here will not be deleted at function deletion.
   */
  pubsubTopic?: string;

  /**
   * Optional. If unset, then defaults to ignoring failures (i.e. not retrying them).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Maintaining compatibility with current SDKs."
  retryPolicy?:
    | "RETRY_POLICY_UNSPECIFIED"
    | "RETRY_POLICY_DO_NOT_RETRY"
    | "RETRY_POLICY_RETRY"
    | string;

  /**
   * Optional. The hostname of the service that 1st Gen function should be observed. If no string is provided, the default service implementing the API will be used. For example, `storage.googleapis.com` is the default for all event types in the `google.storage` namespace. The field is only applicable to 1st Gen functions.
   */
  service?: string;

  @doc("Optional. The email of the trigger's service account. The service account must have permission to invoke Cloud Run services, the permission is `run.routes.invoke`. If empty, defaults to the Compute Engine default service account: `{project_number}-compute@developer.gserviceaccount.com`.")
  serviceAccountEmail?: string;

  /**
   * Output only. The resource name of the Eventarc trigger. The format of this field is `projects/{project}/locations/{region}/triggers/{trigger}`.
   */
  trigger?: string;

  /**
   * The region that the trigger will be in. The trigger will only receive events originating in this region. It can be the same region as the function, a different region or multi-region, or the global region. If not provided, defaults to the same region as the function.
   */
  triggerRegion?: string;
}

/**
 * Describes a Cloud Function that contains user computation executed in response to an event. It encapsulates function and trigger configurations.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in gcp"
model GcpFunctionProperties {
  /**
   * Describes the Build step of the function that builds a container from the given source.
   */
  buildConfig?: BuildConfig;

  /**
   * Output only. The create timestamp of a Cloud Function. This is only applicable to 2nd Gen functions.
   */
  createTime?: string;

  /**
   * User-provided description of a function.
   */
  description?: string;

  /**
   * Describe whether the function is 1st Gen or 2nd Gen.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Maintaining compatibility with current SDKs."
  environment?: "ENVIRONMENT_UNSPECIFIED" | "GEN_1" | "GEN_2" | string;

  /**
   * An Eventarc trigger managed by Google Cloud Functions that fires events in response to a condition in another service.
   */
  eventTrigger?: EventTrigger;

  /**
   * [Preview] Resource name of a KMS crypto key (managed by the user) used to encrypt/decrypt function resources. It must match the pattern `projects/{project}/locations/{location}/keyRings/{key_ring}/cryptoKeys/{crypto_key}`.
   */
  kmsKeyName?: string;

  /**
   * Labels associated with this Cloud Function.
   */
  labels?: Record<string>;

  @doc("A user-defined name of the function. Function names must be unique globally and match pattern `projects/*/locations/*/functions/*`")
  name?: string;

  /**
   * Output only. Reserved for future use.
   */
  satisfiesPzs?: boolean;

  /**
   * Output only. Reserved for future use.
   */
  satisfiesPzi?: boolean;

  /**
   * Describes the Service being deployed. Currently deploys services to Cloud Run (fully managed).
   */
  serviceConfig?: ServiceConfig;

  /**
   * Output only. State of the function.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Maintaining compatibility with current SDKs."
  state?:
    | "STATE_UNSPECIFIED"
    | "ACTIVE"
    | "FAILED"
    | "DEPLOYING"
    | "DELETING"
    | "UNKNOWN"
    | string;

  /**
   * Output only. State Messages for this Cloud Function.
   */
  @identifiers(#[])
  stateMessages?: GoogleCloudFunctionsV2StateMessage[];

  /**
   * Output only. The last update timestamp of a Cloud Function.
   */
  updateTime?: string;

  /**
   * Output only. The deployed url for the function.
   */
  url?: string;
}

/**
 * Informational messages about the state of the Cloud Function or Operation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in gcp"
model GoogleCloudFunctionsV2StateMessage {
  /**
   * The message.
   */
  message?: string;

  /**
   * Severity of the state message.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Maintaining compatibility with current SDKs."
  severity?: "SEVERITY_UNSPECIFIED" | "ERROR" | "WARNING" | "INFO" | string;

  /**
   * One-word CamelCase type of the state message.
   */
  type?: string;
}

/**
 * Security patches are only applied when a function is redeployed.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in gcp"
model OnDeployUpdatePolicy {
  /**
   * Output only. contains the runtime version which was used during latest function deployment.
   */
  runtimeVersion?: string;
}
/**
 * Location of the source in a Google Cloud Source Repository.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in gcp"
model RepoSource {
  /**
   * Regex matching branches to build. The syntax of the regular expressions accepted is the syntax accepted by RE2 and described at https://github.com/google/re2/wiki/Syntax
   */
  branchName?: string;

  /**
   * Explicit commit SHA to build.
   */
  commitSha?: string;

  /**
   * Directory, relative to the source root, in which to run the build. This must be a relative path. If a step's `dir` is specified and is an absolute path, this value is ignored for that step's execution. eg. helloworld (no leading slash allowed)
   */
  dir?: string;

  /**
   * ID of the project that owns the Cloud Source Repository. If omitted, the project ID requesting the build is assumed.
   */
  projectId?: string;

  /**
   * Name of the Cloud Source Repository.
   */
  repoName?: string;

  /**
   * Regex matching tags to build. The syntax of the regular expressions accepted is the syntax accepted by RE2 and described at https://github.com/google/re2/wiki/Syntax
   */
  tagName?: string;
}

/**
 * Configuration for a secret environment variable. It has the information necessary to fetch the secret value from secret manager and expose it as an environment variable.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in gcp"
model SecretEnvVar {
  /**
   * Name of the environment variable.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  key?: string;

  /**
   * Project identifier (preferably project number but can also be the project ID) of the project that contains the secret. If not set, it is assumed that the secret is in the same project as the function.
   */
  projectId?: string;

  /**
   * Name of the secret in secret manager (not the full resource name).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  secret?: string;

  /**
   * Version of the secret (version number or the string 'latest'). It is recommended to use a numeric version for secret environment variables as any updates to the secret value is not reflected until new instances start.
   */
  version?: string;
}

/**
 * Configuration for a single version.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in gcp"
model SecretVersion {
  /**
   * Relative path of the file under the mount path where the secret value for this version will be fetched and made available. For example, setting the mount_path as '/etc/secrets' and path as `secret_foo` would mount the secret value file at `/etc/secrets/secret_foo`.
   */
  path?: string;

  /**
   * Version of the secret (version number or the string 'latest'). It is preferable to use `latest` version with secret volumes as secret value changes are reflected immediately.
   */
  version?: string;
}

/**
 * Configuration for a secret volume. It has the information necessary to fetch the secret value from secret manager and make it available as files mounted at the requested paths within the application container.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in gcp"
model SecretVolume {
  /**
   * The path within the container to mount the secret volume. For example, setting the mount_path as `/etc/secrets` would mount the secret value files under the `/etc/secrets` directory. This directory will also be completely shadowed and unavailable to mount any other secrets. Recommended mount path: /etc/secrets
   */
  mountPath?: string;

  /**
   * Project identifier (preferably project number but can also be the project ID) of the project that contains the secret. If not set, it is assumed that the secret is in the same project as the function.
   */
  projectId?: string;

  /**
   * Name of the secret in secret manager (not the full resource name).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  secret?: string;

  /**
   * List of secret versions to mount for this secret. If empty, the `latest` version of the secret will be made available in a file named after the secret under the mount point.
   */
  @identifiers(#[])
  versions?: SecretVersion[];
}

/**
 * Describes the Service being deployed. Currently Supported : Cloud Run (fully managed).
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in gcp"
model ServiceConfig {
  /**
   * Whether 100% of traffic is routed to the latest revision. On CreateFunction and UpdateFunction, when set to true, the revision being deployed will serve 100% of traffic, ignoring any traffic split settings, if any. On GetFunction, true will be returned if the latest revision is serving 100% of traffic.
   */
  allTrafficOnLatestRevision?: boolean;

  /**
   * The number of CPUs used in a single container instance. Default value is calculated from available memory. Supports the same values as Cloud Run, see https://cloud.google.com/run/docs/reference/rest/v1/Container#resourcerequirements Example: "1" indicates 1 vCPU
   */
  availableCpu?: string;

  /**
   * The amount of memory available for a function. Defaults to 256M. Supported units are k, M, G, Mi, Gi. If no unit is supplied the value is interpreted as bytes. See https://github.com/kubernetes/kubernetes/blob/master/staging/src/k8s.io/apimachinery/pkg/api/resource/quantity.go a full description.
   */
  availableMemory?: string;

  /**
   * Environment variables that shall be available during function execution.
   */
  environmentVariables?: Record<string>;

  /**
   * The ingress settings for the function, controlling what traffic can reach it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Maintaining compatibility with current SDKs."
  ingressSettings?:
    | "INGRESS_SETTINGS_UNSPECIFIED"
    | "ALLOW_ALL"
    | "ALLOW_INTERNAL_ONLY"
    | "ALLOW_INTERNAL_AND_GCLB"
    | string;

  /**
   * The limit on the maximum number of function instances that may coexist at a given time. In some cases, such as rapid traffic surges, Cloud Functions may, for a short period of time, create more instances than the specified max instances limit. If your function cannot tolerate this temporary behavior, you may want to factor in a safety margin and set a lower max instances value than your function can tolerate. See the [Max Instances](https://cloud.google.com/functions/docs/max-instances) Guide for more details.
   */
  maxInstanceCount?: int32;

  /**
   * Sets the maximum number of concurrent requests that each instance can receive. Defaults to 1.
   */
  maxInstanceRequestConcurrency?: int32;

  /**
   * The limit on the minimum number of function instances that may coexist at a given time. Function instances are kept in idle state for a short period after they finished executing the request to reduce cold start time for subsequent requests. Setting a minimum instance count will ensure that the given number of instances are kept running in idle state always. This can help with cold start times when jump in incoming request count occurs after the idle instance would have been stopped in the default case.
   */
  minInstanceCount?: int32;

  /**
   * Output only. The name of service revision.
   */
  revision?: string;

  /**
   * Secret environment variables configuration.
   */
  @identifiers(#[])
  secretEnvironmentVariables?: SecretEnvVar[];

  /**
   * Secret volumes configuration.
   */
  @identifiers(#[])
  secretVolumes?: SecretVolume[];

  /**
   * Security level configure whether the function only accepts https. This configuration is only applicable to 1st Gen functions with Http trigger. By default https is optional for 1st Gen functions; 2nd Gen functions are https ONLY.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Maintaining compatibility with current SDKs."
  securityLevel?:
    | "SECURITY_LEVEL_UNSPECIFIED"
    | "SECURE_ALWAYS"
    | "SECURE_OPTIONAL"
    | string;

  /**
   * Output only. Name of the service associated with a Function. The format of this field is `projects/{project}/locations/{region}/services/{service}`
   */
  service?: string;

  @doc("The email of the service's service account. If empty, defaults to `{project_number}-compute@developer.gserviceaccount.com`.")
  serviceAccountEmail?: string;

  /**
   * The function execution timeout. Execution is considered failed and can be terminated if the function is not completed at the end of the timeout period. Defaults to 60 seconds.
   */
  timeoutSeconds?: int32;

  /**
   * Output only. URI of the Service deployed.
   */
  uri?: string;

  @doc("The Serverless VPC Access connector that this cloud function can connect to. The format of this field is `projects/*/locations/*/connectors/*`.")
  vpcConnector?: string;

  /**
   * The egress settings for the connector, controlling what traffic is diverted through it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Maintaining compatibility with current SDKs."
  vpcConnectorEgressSettings?:
    | "VPC_CONNECTOR_EGRESS_SETTINGS_UNSPECIFIED"
    | "PRIVATE_RANGES_ONLY"
    | "ALL_TRAFFIC"
    | string;
}

/**
 * The location of the function source code.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in gcp"
model Source {
  /**
   * If provided, get the source from GitHub repository. This option is valid only for GCF 1st Gen function. Example: https://github.com///blob//
   */
  gitUri?: string;

  /**
   * If provided, get the source from this location in a Cloud Source Repository.
   */
  repoSource?: RepoSource;

  /**
   * If provided, get the source from this location in Google Cloud Storage.
   */
  storageSource?: StorageSource;
}

/**
 * Provenance of the source. Ways to find the original source, or verify that some source was used for this build.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in gcp"
model SourceProvenance {
  /**
   * A copy of the build's `source.git_uri`, if exists, with any commits resolved.
   */
  gitUri?: string;

  /**
   * A copy of the build's `source.repo_source`, if exists, with any revisions resolved.
   */
  resolvedRepoSource?: RepoSource;

  /**
   * A copy of the build's `source.storage_source`, if exists, with any generations resolved.
   */
  resolvedStorageSource?: StorageSource;
}

/**
 * Location of the source in an archive file in Google Cloud Storage.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in gcp"
model StorageSource {
  /**
   * Google Cloud Storage bucket containing the source (see [Bucket Name Requirements](https://cloud.google.com/storage/docs/bucket-naming#requirements)).
   */
  bucket?: string;

  /**
   * Google Cloud Storage generation for the object. If the generation is omitted, the latest generation will be used.
   */
  generation?: string;

  /**
   * Google Cloud Storage object containing the source. This object must be a gzipped archive file (`.tar.gz`) containing source to build.
   */
  object?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the name is defined in GCP."
@armResourceOperations
interface CloudFunctions {
  get is ArmResourceRead<CloudFunction>;
  @doc("Create a CloudFunction. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<CloudFunction>;
  update is ArmCustomPatchAsync<
    CloudFunction,
    Azure.ResourceManager.Foundations.TagsUpdateModel<CloudFunction>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<CloudFunction>;
  listByResourceGroup is ArmResourceListByParent<CloudFunction>;
  listBySubscription is ArmListBySubscription<CloudFunction>;
}
