import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./volumetypes.tsp";
import "./helpers.tsp";
import "./autoscalingtriggers.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.ContainerService;

/** Represents a managed cluster. Just a placeholder until rest of aks is converted to typespec */
model ManagedCluster is TrackedResource<ManagedClusterProperties> {
  ...ResourceNameParameter<ManagedCluster>;
}

/** Managed Cluster properties. Just a placeholder */
model ManagedClusterProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Managed Namespace resource. Just a placeholder for now */
@parentResource(ManagedCluster)
model ManagedNamespace is ProxyResource<ManagedNamespaceProperties> {
  ...ResourceNameParameter<ManagedNamespace>;
}

/** Managed Namespace properties. Just a placeholder */
model ManagedNamespaceProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** App resource */
@parentResource(ManagedNamespace)
model ManagedApp is Azure.ResourceManager.ProxyResource<AppProperties> {
  ...ResourceNameParameter<ManagedApp>;
}

/** App properties */
model AppProperties {
  /** Determines the application type. This influences the base set of kubernetes manifests that will be used */
  applicationType: ApplicationType;

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

  /** An array of prometheus expressions to evaluate to determine if the app is healthy. Multiple expressions in this list are logically AND-ed together, so all must return true in order for the app to be considered healthy */
  @identifiers(#["name"])
  healthChecks?: HealthCheck[];

  /** Observability configuration for the app */
  observability?: ObservabilityProperties;

  /** Scaling type for the app. Default is manual scaling */
  scaling?: ScalingConfiguration;

  /** Ingress configuration for the app */
  ingressConfiguration?: IngressProperties;

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

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
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

/** Observability properties for the app */
model ObservabilityProperties {
  /** Log Analytics Workspace ID */
  logAnalyticsWorkspaceId?: logAnalyticsWorkspaceId;

  /** Azure Managed Prometheus Workspace ID */
  azureMonitorAccount?: azureManagedPrometheusWorkspaceId;
}

scalar UserAssignedIdentity
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities",
    }
  ]>;

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

/** Type of application */
union ApplicationType {
  /** Web application */
  WebApp: "webApp",

  /** AI training application */
  AITraining: "aiTraining",

  /** AI inference application */
  AIInference: "aiInference",

  /** Background worker application */
  BackgroundWorker: "backgroundWorker",

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
