import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./customoperations.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ContainerService;

/** App resource */
model ManagedApp is Azure.ResourceManager.TrackedResource<AppProperties> {
  ...ResourceNameParameter<ManagedApp>;
}

/** App properties */
model AppProperties {
  /** Type of App */
  appType?: string;

  /** Image Base of App. This represents the container registry and image name. i.e. myregistry.azurecr.io/myapp */
  imageBase: string;

  /** An array of permissions for k8s resources in the same namespace associated with the app */
  @identifiers(#["apiGroups", "resources", "verbs"])
  permissionsInSameNamespace?: Permissions[];

  /** An array of permissions for k8s resources, cluster wide, associated with the app */
  @identifiers(#["apiGroups", "resources", "verbs"])
  permissionsClusterWide?: Permissions[];

  /** An array of health checks for the app */
  @identifiers(#["type"])
  healthChecks: HealthCheck[];

  /** Observability properties for the app */
  observability?: ObservabilityProperties;

  /** Scaling type for the app */
  scaling: ScalingType;

  /** Ingress configuration for the app */
  ingressConfiguration?: IngressProperties;

  /** Deployment Template for the app. Specify any configuration that will be needed or used for every deployment */
  template: AppTemplate;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Deployment template for the app */
model AppTemplate {
  /** Number of replicas. Only needed if the ScalingType is Manual. Defaults to 3 */
  replicas?: int32;

  /** Command to run in the container */
  command: string;

  /** Arguments to the command */
  arguments: string[];

  /** Init containers for the app */
  @identifiers(#["name"])
  initContainers?: Container[];

  /** Sidecar containers for the app */
  @identifiers(#["name"])
  sidecarContainers?: Container[];
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

/** Ingress properties */
model IngressProperties {
  /** Ingress state, enabled or disabled */
  state: string;

  /** Ingress type needed. I.e. http, grpc, */
  ingressType: IngressType;

  /** Visibility of the ingress, either public or private */
  visibility: IngressVisibility;
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

  getAppRevisions is ArmResourceListByParent<AppRevision>;
  getAppDeployments is ArmResourceListByParent<AppDeployment>;
  createOrUpdateAppRevision is ArmResourceCreateOrReplaceAsync<
    AppRevision,
    Azure.ResourceManager.Foundations.BaseParameters<AppRevision>
  >;
  createOrUpdateAppDeployment is ArmResourceCreateOrReplaceAsync<
    AppDeployment,
    Azure.ResourceManager.Foundations.BaseParameters<AppDeployment>
  >;

  deleteAppRevision is ArmResourceDeleteWithoutOkAsync<AppRevision>;
  deleteAppDeployment is ArmResourceDeleteWithoutOkAsync<AppDeployment>;
  revisionDeployments is ListDeployments<AppRevision>;

  getTrafficSplits is ArmResourceListByParent<TrafficSplit>;
  createOrUpdateTrafficSplit is ArmResourceCreateOrReplaceAsync<
    TrafficSplit,
    Azure.ResourceManager.Foundations.BaseParameters<TrafficSplit>
  >;
  deleteTrafficSplit is ArmResourceDeleteWithoutOkAsync<TrafficSplit>;
}
