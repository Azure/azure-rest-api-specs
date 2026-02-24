import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./ManagedAppVolumeTypes.tsp";
import "./ManagedAppAutoscalingTriggers.tsp";
import "./ManagedNamespace.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.ContainerService;

@armResourceOperations
interface Apps {
  // Managed App Operations
  get is ArmResourceRead<ManagedApp>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedApp>;
  delete is ArmResourceDeleteWithoutOkAsync<ManagedApp>;
  listByManagedNamespace is ArmResourceListByParent<ManagedApp>;
  rollback is ArmResourceActionAsync<
    ManagedApp,
    ManagedAppRollbackPostParameters,
    ManagedApp
  >;
}

@armResourceOperations
// Managed App Revision Operations
interface ManagedAppRevisions {
  get is ArmResourceRead<ManagedAppRevision>;
  listByManagedApp is ArmResourceListByParent<ManagedAppRevision>;
}

/** App resource */
@parentResource(ManagedNamespace)
model ManagedApp is Azure.ResourceManager.ProxyResource<ManagedAppProperties> {
  ...ResourceNameParameter<ManagedApp>;
  ...EntityTagProperty;
}

model ManagedAppRevision
  is Azure.ResourceManager.ExtensionResource<AppRevisionProperties> {
  @key("managedAppRevisionName")
  @doc("The name of the managed app revision resource.")
  @segment("managedAppRevisions")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  name: string;

  ...EntityTagProperty;
}

/** Parameters for rolling back a managed app to a previous revision */
model ManagedAppRollbackPostParameters {
  /** The name of the managed app revision to rollback to */
  managedAppRevisionName: string;
}

/** Properties of the managed app */
model ManagedAppProperties {
  /** The name of the active revision */
  @visibility(Lifecycle.Read)
  activeRevisionName: string;

  /** Maximum number of revisions to retain. Oldest revisions are automatically deleted when exceeded. */
  maxRevisionCount?: int32 = 50;

  /** Unique identifier for the managed app */
  @visibility(Lifecycle.Read)
  uniqueIdentifier: string;

  /** The deployment template for the managed app */
  template: AppTemplate;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Properties of the managed app revision */
model AppRevisionProperties {
  /** Time the revision was created */
  @visibility(Lifecycle.Read)
  createdTime: string;

  /** The deployment template for the managed app revision */
  template: AppTemplate;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** App Template */
model AppTemplate {
  /** Additional k8s resources (in yaml format) to deploy along with the app
   * This can include things like ConfigMaps, Secrets, PersistentVolumeClaims, etc.
   * Do we split this out into separate fields? Easier to maintain as raw yaml, but harder to validate
   */
  additionalK8sResources?: string[];

  /** Represents the permissions for k8s resources that this app has, restricted to the same namespace the app is deployed in. This will create kubernetes Roles and RoleBindings for the app when it is deployed into a managed namespace */
  @identifiers(#["apiGroups", "resources", "verbs"])
  namespacedPermissions?: Permissions[];

  /** Represents the permissions for k8s resources that this app has, cluster wide. Do not set this field if the app is not supposed to read resources outside of the namespace it is deployed in. This will create kubernetes ClusterRoles and ClusterRoleBindings for the app when it is deployed into a managed namespace */
  @identifiers(#["apiGroups", "resources", "verbs"])
  clusterWidePermissions?: Permissions[];

  /** Scaling type for the app. Default is manual scaling */
  scaling?: ScalingConfiguration;

  /** User assigned identity for the app deployment to use */
  @visibility(Lifecycle.Read)
  identity?: AppDeploymentUserAssignedIdentity;

  /** Deployment Template for the app. Specify any configuration that will be needed or used for every deployment */
  template: DeploymentTemplate;

  /** The name of the generated service account. This is generated from the app deployment name, and namespace name */
  @visibility(Lifecycle.Read)
  generatedServiceAccountName: string;

  /** The name of the generated kubernetes service. This is generated from the app deployment name and namespace name */
  @visibility(Lifecycle.Read)
  generatedKubernetesServiceName: string;
}

/** Deployment template for the app */
model DeploymentTemplate {
  /** Container image of App. This represents a fully qualified container image name, including the registry and tag. i.e. myregistry.azurecr.io/myapp:v1 */
  image: string;

  /** Number of replicas. Only needed if the ScalingType is Manual. Defaults to 3 */
  replicas?: int32;

  /** Command to run in the container */
  command: string;

  /** Arguments to the command */
  arguments?: string[];

  /** The primary port your application listens on, where it receives traffic. */
  primaryPort?: ContainerPort;

  /** The resource requirements for the app */
  resources?: ResourceRequirements;

  /** An array of container probes for the app. If not specified, the default is an http request to /healthz */
  @identifiers(#["type"])
  containerProbes?: ContainerProbes[];

  /** Additional ports your application listens on */
  @identifiers(#["port", "name"])
  additionalPorts?: ContainerPort[];

  /** Labels for the app */
  @identifiers(#["key"])
  labels?: KeyValuePair[];

  /** Annotations for the app */
  @identifiers(#["key"])
  annotations?: KeyValuePair[];

  /** Environment variables for the app */
  @identifiers(#["name"])
  environmentVariables?: EnvironmentVariable[];

  /** Init containers for the app */
  @identifiers(#["name"])
  initContainers?: Container[];

  /** Sidecar containers for the app */
  @identifiers(#["name"])
  sidecarContainers?: Container[];

  /** Volumes for the app */
  @identifiers(#["name"])
  volumes?: Volume[];

  /** Volume mounts for the app */
  @identifiers(#["name"])
  volumeMounts?: VolumeMount[];
}

/** App Deployment User Assigned Identity */
model AppDeploymentUserAssignedIdentity {
  /** The resource id of the user assigned identity */
  userAssignedIdentityId?: UserAssignedIdentity;

  /** The client id of the user assigned identity */
  clientId?: string;

  /** The principal id of the user assigned identity */
  principalId?: string;
}

/** Represents an exposed port on a container */
model ContainerPort {
  /** Name of the port */
  name: string;

  /** Port number */
  port?: int32 = 8080;

  /** Protocol for the port. Defaults to TCP */
  protocol?: string = "TCP";
}

/** Key Value Pair for labels/annotations */
model KeyValuePair {
  /** Key of the pair */
  key: string;

  /** Value of the pair */
  value: string;
}

/** Environment variable for a container */
model EnvironmentVariable {
  /** Name of the environment variable */
  name: string;

  /** Value of the environment variable */
  value: string;

  /** Reference to a secret for the environment variable */
  secretRef?: string;
}

/** Container definition */
model Container {
  /** Name of the container */
  name: string;

  /** Container image including tag */
  image: string;

  /** Command to run in the container */
  command: string;

  /** Arguments to the command */
  arguments: string[];

  /** An array of probes for the container */
  @identifiers(#["type"])
  probes: ContainerProbes[];

  /** Container Resource Requirements. If not specified, defaults will be applied */
  resources?: ResourceRequirements;

  /** Environment variables for the container */
  @identifiers(#["name"])
  environmentVariables?: EnvironmentVariable[];

  /** Ports exposed by the container */
  @identifiers(#["port", "name"])
  ports?: ContainerPort[];

  /** Volume mounts for the container */
  @identifiers(#["name"])
  volumeMounts?: VolumeMount[];
}

/** Volume mount definition */
model VolumeMount {
  /** Name of the volume */
  name: string;

  /** Mount path for the volume */
  mountPath: string;

  /** Volume is ReadOnly or not */
  readOnly: boolean;
}

/** Resource requirements for a container */
model ResourceRequirements {
  /** CPU resource request and limit */
  cpu?: string = "2";

  /** Memory resource request and limit */
  memory?: string = "2Gi";

  /** Approximate T-Shirt size. Mutually exclusive with cpu and memory */
  tShirtSize?: TShirtSize;
}

/** T-Shirt size for resource requirements */
union TShirtSize {
  /** Small T-Shirt size */
  Small: "Small",

  /** Medium T-Shirt size */
  Medium: "Medium",

  /** Large T-Shirt size */
  Large: "Large",

  /** Extra Large T-Shirt size */
  XLarge: "XLarge",

  string,
}

/** Role definition for k8s resources that the app needs to access */
model Permissions {
  /** API groups */
  apiGroups?: string[];

  /** Resources in the api groups */
  resources?: string[];

  /** Verbs that are allowed for these groups/resources. i.e. "GET", "CREATE", etc */
  verbs?: string[];
}

/** Type of health check */
union ProbeType {
  /** Liveness probe */
  Liveness: "liveness",

  /** Readiness probe */
  Readiness: "readiness",

  /** Startup probe */
  Startup: "startup",

  string,
}

/** Protocol for the health check */
union ProbeProtocol {
  /** HTTP protocol */
  HTTP: "HTTP",

  /** TCP protocol */
  TCP: "TCP",

  /** gRPC protocol */
  gRPC: "gRPC",

  string,
}

/** Health check configuration */
model ContainerProbes {
  /** Type of health check */
  type: ProbeType;

  /** Protocol for the health check */
  protocol?: ProbeProtocol;

  /** Path for HTTP health checks */
  path?: string;

  /** Port to check */
  port: int32;

  /** Number of seconds after the container has started before health checks are initiated */
  initialDelaySeconds?: int32 = 0;

  /** How often (in seconds) to perform the health check */
  periodSeconds?: int32 = 10;

  /** Number of seconds after which the health check times out */
  timeoutSeconds?: int32 = 1;

  /** Minimum consecutive successes for the health check to be considered successful after having failed */
  successThreshold?: int32 = 1;

  /** Minimum consecutive failures for the health check to be considered failed after having succeeded */
  failureThreshold?: int32 = 3;
}

/** Health check for the app */
model HealthCheck {
  /** Name of the health check */
  name: string;

  /** Port to fetch metrics. Default is 8080 */
  port?: int32 = 8080;

  /** Metrics path for Prometheus to scrape. Default is /metrics */
  metricsPath?: string = "/metrics";

  /** Prometheus expression to evaluate. Expression must return no results if the app is healthy */
  query: string;

  /** Duration in seconds for which the query must be true to consider the app healthy */
  durationSeconds: int32 = 30;

  /** The frequency in seconds at which the query is evaluated */
  frequencySeconds: int32 = 5;

  /** The evaluated state of this health check */
  @visibility(Lifecycle.Read)
  state?: HealthCheckState;
}
/** Health check state */
union HealthCheckState {
  /** Health check is healthy */
  Healthy: "healthy",

  /** Health check is unhealthy */
  Unhealthy: "unhealthy",

  /** Health check is unknown */
  Unknown: "unknown",

  string,
}

/** The resource provisioning state. */
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  string,
}
