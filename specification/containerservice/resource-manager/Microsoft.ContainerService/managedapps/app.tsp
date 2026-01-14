import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./customoperations.tsp";
import "./volumetypes.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ContainerService;

/** App resource */
model ManagedApp is Azure.ResourceManager.TrackedResource<AppProperties> {
  ...ResourceNameParameter<ManagedApp>;

  /** Managed Identity for all deployments of the app, if specified */
  ...ManagedServiceIdentityProperty;
}

/** App properties */
model AppProperties {
  /** Type of App */
  appType?: string;

  /** Image Base of App. This represents the container registry and image name. i.e. myregistry.azurecr.io/myapp */
  imageBase: string;

  /** Represents the permissions for k8s resources that this app has, restricted to the same namespace the app is deployed in. This will create kubernetes Roles and RoleBindings for the app when it is deployed into a managed namespace */
  @identifiers(#["apiGroups", "resources", "verbs"])
  namespacedPermissions?: Permissions[];

  /** Represents the permissions for k8s resources that this app has, cluster wide. Do not set this field if the app is not supposed to read resources outside of the namespace it is deployed in. This will create kubernetes ClusterRoles and ClusterRoleBindings for the app when it is deployed into a managed namespace */
  @identifiers(#["apiGroups", "resources", "verbs"])
  clusterWidePermissions?: Permissions[];

  /** An array of health checks for the app. If not specified, the default is an http request to /healthz */
  @identifiers(#["type"])
  healthChecks?: HealthCheck[];

  /** Observability properties for the app */
  observability?: ObservabilityProperties;

  /** Scaling type for the app. Default is manual scaling */
  scaling?: ScalingType;

  /** Ingress configuration for the app */
  ingressConfiguration?: IngressProperties;

  /** Deployment Template for the app. Specify any configuration that will be needed or used for every deployment */
  template: DeploymentTemplate;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Deployment template for the app */
model DeploymentTemplate {
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
  healthChecks: HealthCheck[];

  /** Container Resource Requirements. If not specified, defaults will be applied */
  resources?: ResourceRequirements;
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
  /** Ingress state, enabled or disabled */
  state: IngressState;

  /** Ingress type needed. I.e. http, grpc, */
  ingressType: IngressType;
}

/** Scaling type for the app */
union ScalingType {
  /** Autoscale */
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

/** Observability properties for the app */
model ObservabilityProperties {
  /** Log Analytics Workspace ID */
  logAnalyticsWorkspaceId?: logAnalyticsWorkspaceId;

  /** Azure Managed Prometheus Workspace ID */
  azureMonitorAccount?: azureManagedPrometheusWorkspaceId;
}

/** Role definition for k8s resources that the app needs to access */
model Permissions {
  /** API groups */
  apiGroups?: string[];

  /** Resources */
  resources?: string[];

  /** Verbs */
  verbs?: string[];
}

/** Type of health check */
union HealthCheckType {
  /** Liveness probe */
  Liveness: "liveness",

  /** Readiness probe */
  Readiness: "readiness",

  /** Startup probe */
  Startup: "startup",

  string,
}

/** Protocol for the health check */
union HealthCheckProtocol {
  /** HTTP protocol */
  HTTP: "HTTP",

  /** TCP protocol */
  TCP: "TCP",

  /** gRPC protocol */
  gRPC: "gRPC",

  string,
}

/** Health check configuration */
model HealthCheck {
  /** Type of health check */
  type: HealthCheckType;

  /** Protocol for the health check */
  protocol?: HealthCheckProtocol;

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
  update is ArmCustomPatchSync<
    ManagedApp,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ManagedApp,
      AppProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ManagedApp>;
  listByResourceGroup is ArmResourceListByParent<ManagedApp>;
  listBySubscription is ArmListBySubscription<ManagedApp>;
  appDeployments is ListDeployments<ManagedApp>;
}

@armResourceOperations
interface AppRevisions {
  // App Revision Operations
  list is ArmResourceListByParent<AppRevision>;
  get is ArmResourceRead<AppRevision>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AppRevision,
    Azure.ResourceManager.Foundations.BaseParameters<AppRevision>
  >;
  /** Deletes an app revision. This will also delete all deployments that reference this revision. WARNING: This operation is destructive */
  delete is ArmResourceDeleteWithoutOkAsync<AppRevision>;
  revisionDeployments is ListDeployments<AppRevision>;
}

@armResourceOperations
interface AppDeployments {
  // App Deployment Operations
  list is ArmResourceListByParent<AppDeployment>;
  get is ArmResourceRead<AppDeployment>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AppDeployment,
    Azure.ResourceManager.Foundations.BaseParameters<AppDeployment>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<AppDeployment>;
  /** Rollback the app deployment to the previous revision */
  rollback is RollbackDeployment<AppDeployment, AppDeployment>;

  /** Renders the app deployment kubernetes manifests */
  render is RenderManifests<AppDeployment, RenderResponse>;
}

@armResourceOperations
interface TrafficRules {
  // Traffic Rule Operations
  list is ArmResourceListByParent<TrafficRule>;
  get is ArmResourceRead<TrafficRule>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    TrafficRule,
    Azure.ResourceManager.Foundations.BaseParameters<TrafficRule>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<TrafficRule>;
}
