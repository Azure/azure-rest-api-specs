import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./customoperations.tsp";
import "./volumetypes.tsp";
import "./helpers.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.ContainerService;

/** App resource */
model ManagedApp is Azure.ResourceManager.TrackedResource<AppProperties> {
  ...ResourceNameParameter<ManagedApp>;
}

@parentResource(ManagedApp)
model Revision is Azure.ResourceManager.ProxyResource<AppRevisionProperties> {
  ...ResourceNameParameter<Revision>;
}

/** App properties */
model AppProperties {
  /** Template for the app */
  template: AppTemplate;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Properties of the App Revision */
model AppRevisionProperties {
  /** Template for the app. This represents a point in time snapshot of the app template */
  template: AppTemplate;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Patch model for ManagedApp */
model ManagedAppPatch {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}

/** Template for the app or app deployment */
model AppTemplate {
  /** Represents the permissions for k8s resources that this app has, restricted to the same namespace the app is deployed in. This will create kubernetes Roles and RoleBindings for the app when it is deployed into a managed namespace */
  @identifiers(#["apiGroups", "resources", "verbs"])
  namespacedPermissions?: Permissions[];

  /** Represents the permissions for k8s resources that this app has, cluster wide. Do not set this field if the app is not supposed to read resources outside of the namespace it is deployed in. This will create kubernetes ClusterRoles and ClusterRoleBindings for the app when it is deployed into a managed namespace */
  @identifiers(#["apiGroups", "resources", "verbs"])
  clusterWidePermissions?: Permissions[];

  /** An array of container probes for the app. If not specified, the default is an http request to /healthz */
  @identifiers(#["type"])
  containerProbes?: ContainerProbes[];

  /** An array of prometheus expressions to evaluate to determine if the app is healthy. Multiple expressions in this list are logically AND-ed together, so all must return true in order for the app to be considered healthy */
  @identifiers(#["name"])
  healthChecks?: HealthCheck[];

  /** Scaling type for the app. Default is manual scaling */
  scaling?: ScalingType;

  /** Ingress configuration for the app */
  ingressConfiguration?: IngressProperties;

  /** Deployment Template for the app. Specify any configuration that will be needed or used for every deployment */
  template: DeploymentTemplate;
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

  /** The primary port your application listens on, where it receives traffic. Required if ingress configuration is set */
  primaryPort?: ContainerPort;

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
}

/** Represents an exposed port on a container */
model ContainerPort {
  /** Name of the port */
  name: string;

  /** Port number */
  port: int32;

  /** Protocol for the port. Defaults to TCP */
  protocol?: string;
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

  /** An array of health checks for the container */
  @identifiers(#["type"])
  healthChecks: ContainerProbes[];

  /** Container Resource Requirements. If not specified, defaults will be applied */
  resources?: ResourceRequirements;

  /** Volume mounts for the container */
  @identifiers(#["name"])
  volumeMounts?: VolumeMount[];
}

/** Resource requirements for a container */
model ResourceRequirements {
  /** CPU resource request and limit */
  cpu: string;

  /** Memory resource request and limit */
  memory: string;
}

/** Ingress configuration for the app */
union IngressType {
  /** HTTP Ingress */
  Http: "http",

  /** gRPC Ingress */
  Grpc: "grpc",

  string,
}

/** Ingress visibility */
union IngressVisibility {
  /** Public visibility, accessible from the internet */
  Public: "public",

  /** Private visibility, only accessible within the cluster */
  Private: "private",

  string,
}

/** Ingress state enum */
union IngressState {
  /** Ingress is enabled */
  Enabled: "enabled",

  /** Ingress is disabled */
  Disabled: "disabled",

  string,
}

/** Ingress properties */
model IngressProperties {
  /** Ingress state, enabled or disabled. Intended to answer the question 'does my app accept public traffic?'. Use TrafficRules to configure traffic routing */
  state: IngressState;

  /** Ingress type needed. I.e. http, grpc, */
  ingressType: IngressType;
}

/** Scaling type for the app */
union ScalingType {
  /** Auto scale */
  Autoscale: "autoscale",

  /** Manual scale */
  Manual: "manual",

  string,
}

scalar logAnalyticsWorkspaceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces",
    }
  ]>;
scalar azureManagedPrometheusWorkspaceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Monitor/accounts",
    }
  ]>;

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

  /** Prometheus expression to evaluate. Expression must evaluate to true if the app is healthy */
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

@armResourceOperations
interface Apps {
  // Managed App Operations
  get is ArmResourceRead<ManagedApp>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedApp>;
  delete is ArmResourceDeleteWithoutOkAsync<ManagedApp>;
  patch is ArmCustomPatchSync<
    ManagedApp,
    ManagedAppPatch,
    Azure.ResourceManager.Foundations.BaseParameters<ManagedAppPatch> &
      IfMatchParameters<ManagedApp>
  >;

  listByResourceGroup is ArmResourceListByParent<ManagedApp>;
  listBySubscription is ArmListBySubscription<ManagedApp>;
  @list
  deployments is ListDeployments<ManagedApp>;
}

@armResourceOperations
interface Revisions {
  // App Revision Operations
  @list
  list is ArmResourceListByParent<Revision>;
  get is ArmResourceRead<Revision>;
  /** List deployments for an app revision */
  @list
  deployments is ListDeployments<Revision>;
}

@armResourceOperations
interface FleetAppDeployments {
  // Fleet App Deployment Operations
  @list
  list is ArmResourceListByParent<FleetAppDeployment>;
  get is ArmResourceRead<FleetAppDeployment>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FleetAppDeployment,
    Azure.ResourceManager.Foundations.BaseParameters<FleetAppDeployment>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<FleetAppDeployment>;

  /** Renders the app deployment kubernetes manifests */
  render is RenderManifests<FleetAppDeployment, RenderResponse>;
}

@armResourceOperations
interface AppDeployments {
  // App Deployment Operations
  @list
  list is ArmResourceListByParent<AppDeployment>;
  get is ArmResourceRead<AppDeployment>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AppDeployment,
    Azure.ResourceManager.Foundations.BaseParameters<AppDeployment>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<AppDeployment>;

  /** Renders the app deployment kubernetes manifests */
  render is RenderManifests<AppDeployment, RenderResponse>;
}

@armResourceOperations
interface TrafficRules {
  // Traffic Rule Operations
  @list
  list is ArmResourceListByParent<TrafficRule>;
  get is ArmResourceRead<TrafficRule>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    TrafficRule,
    Azure.ResourceManager.Foundations.BaseParameters<TrafficRule>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<TrafficRule>;
}
