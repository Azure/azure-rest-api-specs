import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./Account.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/**
 * An existing Azure Kubernetes Service cluster attached to a Cognitive Services account.
 */
@added(Versions.v2026_11_15_preview)
@parentResource(Account)
model AttachedAksCluster is ProxyResource<AttachedAksClusterProperties, false> {
  ...ResourceNameParameter<
    Resource = AttachedAksCluster,
    KeyName = "attachedAksClusterName",
    SegmentName = "attachedAksClusters",
    NamePattern = "^[a-zA-Z0-9]([a-zA-Z0-9._-]*[a-zA-Z0-9])?$"
  >;
}

@@maxLength(AttachedAksCluster.name, 63);
@@minLength(AttachedAksCluster.name, 1);
@@doc(
  AttachedAksCluster.name,
  "The name of the account-level AKS attachment. It must contain 1-63 letters, digits, periods, underscores, or hyphens, and start and end with a letter or digit."
);

/**
 * Manages account-level attachments to existing AKS clusters.
 */
@added(Versions.v2026_11_15_preview)
@armResourceOperations
interface AttachedAksClusters {
  /**
   * Gets an AKS attachment and its current provisioning and health status.
   */
  @tag("AttachedAksClusters")
  get is ArmResourceRead<AttachedAksCluster>;

  /**
   * Attaches an existing AKS cluster to the account, or updates its attachment.
   * A 202 response contains the current attachment; poll GET and inspect
   * properties.status.stage for progress. A 200 response also contains the
   * current attachment state and does not by itself guarantee workload readiness.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The existing service returns 200 or 202 with an attachment body, not 201 or standard LRO polling headers."
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "The existing service supports resource GET polling and does not return a Location polling header."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The existing service returns the current attachment resource in its 202 response."
  @tag("AttachedAksClusters")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AttachedAksCluster,
    Response =
      | ArmResponse<AttachedAksCluster>
      | AttachedAksClusterAcceptedResult
  >;

  /**
   * Detaches an AKS cluster while retaining the physical AKS and AI Manager
   * resources. A 202 response contains the current attachment; poll GET until
   * the attachment is no longer found. A 204 response indicates that the
   * attachment has been removed or did not exist.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "The existing service returns 202 with the pending attachment or 204 without a body, not 200."
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "The existing service supports resource GET polling and does not return a Location polling header."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "The existing service returns the pending attachment resource in its 202 response."
  @tag("AttachedAksClusters")
  delete is ArmResourceDeleteSync<
    AttachedAksCluster,
    Parameters = {
      /** Retains the physical AKS and AI Manager resources. Only Keep is supported. */
      @query
      clusterDisposition?: "Keep";
    },
    Response = NoContentResponse | AttachedAksClusterAcceptedResult
  >;

  /**
   * Lists lightweight AKS attachment summaries for the account.
   * Use GET on an individual attachment to retrieve its full status and bindings.
   */
  @tag("AttachedAksClusters")
  list is ArmResourceListByParent<
    AttachedAksCluster,
    Parameters = AttachedAksClusterListQueryParameters,
    Response = ArmResponse<AttachedAksClusterListResult>
  >;
}

/** An attachment whose requested operation is still in progress. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterAcceptedResult {
  /** The attachment operation was accepted. */
  @statusCode
  statusCode: 202;

  /** Current attachment state. */
  @bodyRoot
  body: AttachedAksCluster;
}

/** Properties of an account-level AKS attachment. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "The existing attachment contract reports provisioning progress through properties.status.stage."
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterProperties {
  /** ARM resource ID of the existing AKS cluster. This value is immutable. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  clusterResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/managedClusters";
    }
  ]>;

  /**
   * The complete set of capabilities for this attachment, without duplicates.
   * PUT replaces the set. foundryNative is added automatically unless aiManager
   * is the only capability. After attach, the only supported change is adding
   * kuberay; other changes return 409 Conflict and require detaching first.
   */
  @minItems(1)
  @maxItems(3)
  capabilities: AttachedAksClusterCapability[];

  /** Configuration of the training extension on the attached cluster. */
  extensionProfile?: AttachedAksClusterExtensionProfile;

  /** Server-managed project bindings on the attached cluster. */
  @visibility(Lifecycle.Read)
  @identifiers(#["projectId"])
  projectBindings?: AttachedAksClusterProjectBinding[];

  /** Server-reported attachment provisioning, integration, and health status. */
  @visibility(Lifecycle.Read)
  status?: AttachedAksClusterStatus;
}

/** A capability supported by an AKS attachment. */
@added(Versions.v2026_11_15_preview)
union AttachedAksClusterCapability {
  string,

  /** Foundry-native training workloads. */
  foundryNative: "foundryNative",

  /** KubeRay workloads. */
  kuberay: "kuberay",

  /** AI Manager inference workloads. */
  aiManager: "aiManager",
}

/** Configuration of the training extension. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterExtensionProfile {
  /**
   * Extension installation mode. Defaults to Managed.
   * Manual installation requires service enablement and an exact chart version.
   */
  installationMode?: AttachedAksClusterExtensionInstallationMode;

  /** Extension package version, or the exact chart version for Manual installation. */
  version?: string;

  /** Extension package release train. */
  releaseTrain?: string;

  /** Whether to use an existing KubeRay operator instead of installing one. */
  useExistingKubeRayOperator?: boolean;

  /** Supported extension configuration. Other Helm settings are service-managed. */
  configuration?: AttachedAksClusterExtensionConfiguration;
}

/** How the training extension is installed. */
@added(Versions.v2026_11_15_preview)
union AttachedAksClusterExtensionInstallationMode {
  string,

  /** The service manages installation of the extension. */
  Managed: "Managed",

  /** The extension is installed manually, when enabled by the service. */
  Manual: "Manual",
}

/** User-configurable training extension settings. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterExtensionConfiguration {
  /** Ray version used by the training extension. */
  @minLength(1)
  rayVersion?: string;
}

/** A server-managed project binding on the attached cluster. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterProjectBinding {
  /** Identifier of the bound Foundry project. */
  projectId?: string;

  /** Name of the bound Foundry project. */
  projectName?: string;

  /** Kubernetes namespace assigned to the project. */
  `namespace`?: string;

  /** Kubernetes service account used by the project. */
  serviceAccountName?: string;

  /** Client ID of the project's workload identity. */
  workloadIdentityClientId?: string;

  /** Capabilities available to the project binding. */
  allowedCapabilities?: AttachedAksClusterCapability[];

  /** Current project binding stage. */
  stage?: AttachedAksClusterProjectBindingStage;

  /** Details of the current binding state. */
  message?: string;

  /** Whether the binding is ready for KubeRay workloads. */
  kubeRayReady?: boolean;

  /** Whether the binding is ready for Foundry-native workloads. */
  foundryNativeReady?: boolean;
}

/** Provisioning stage of a project binding. */
@added(Versions.v2026_11_15_preview)
union AttachedAksClusterProjectBindingStage {
  string,

  /** The binding is being reconciled. */
  Reconciling: "Reconciling",

  /** The binding is ready. */
  Ready: "Ready",

  /** The binding is degraded. */
  Degraded: "Degraded",

  /** The binding is blocked. */
  Blocked: "Blocked",
}

/** Current provisioning and health status of an attachment. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterStatus {
  /** Current attachment provisioning stage. */
  stage?: AttachedAksClusterProvisioningStage;

  /** ARM resource ID of the attached AKS cluster. */
  clusterResourceId?: Azure.Core.armResourceIdentifier;

  /** Identifier of an underlying provider operation, when present. */
  providerOperationId?: string;

  /** Details of the current attachment state. */
  message?: string;

  /** Identity provisioned for training on the attached cluster. */
  identity?: AttachedAksClusterIdentityStatus;

  /** Connector registration associated with the attachment. */
  connectorRegistration?: AttachedAksClusterConnectorRegistration;

  /** Attachment generation observed by the connector. */
  observedGeneration?: int64;

  /** Time at which the connector was last observed. */
  connectorObservedAtUtc?: utcDateTime;

  /** Connector and capability readiness. */
  readiness?: AttachedAksClusterReadinessStatus;

  /** Status of the AI Manager integration. */
  aiManager?: AttachedAksClusterAiManagerStatus;

  /** Status of the training extension resource. */
  extension?: AttachedAksClusterIntegrationResourceStatus;

  /** Evaluated attachment health and workload admission status. */
  health?: AttachedAksClusterHealthStatus;

  /** Last update time of the attachment status. */
  lastUpdatedTimeUtc?: utcDateTime;
}

/** Provisioning stage reported by an attachment. */
@added(Versions.v2026_11_15_preview)
union AttachedAksClusterProvisioningStage {
  string,

  /** The attachment request was accepted. */
  Accepted: "Accepted",

  /** The attachment is being validated. */
  Validating: "Validating",

  /** Cluster provisioning is in progress. */
  ProvisioningCluster: "ProvisioningCluster",

  /** Identity provisioning is in progress. */
  ProvisioningIdentity: "ProvisioningIdentity",

  /** Cluster bootstrap is pending. */
  PendingBootstrap: "PendingBootstrap",

  /** The cluster is ready. */
  ClusterReady: "ClusterReady",

  /** The attachment is ready. */
  Ready: "Ready",

  /** The attachment is degraded. */
  Degraded: "Degraded",

  /** Attachment provisioning failed. */
  Failed: "Failed",

  /** The attachment is being deleted. */
  Deleting: "Deleting",

  /** The attachment is blocked. */
  Blocked: "Blocked",
}

/** Identity status for training on the attached cluster. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterIdentityStatus {
  /** ARM resource ID of the identity. */
  resourceId?: Azure.Core.armResourceIdentifier;

  /** Identity client ID. */
  clientId?: string;

  /** Identity principal ID. */
  principalId?: string;

  /** Identity tenant ID. */
  tenantId?: string;

  /** ARM resource ID of the federated identity credential. */
  federatedIdentityCredentialResourceId?: Azure.Core.armResourceIdentifier;

  /** Kubernetes service account associated with the identity. */
  kubernetesServiceAccountName?: string;
}

/** Registration details of the attachment connector. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterConnectorRegistration {
  /** Connector registration identifier. */
  registrationId?: string;

  /** Project identifier associated with the registration. */
  projectId?: string;

  /** Name of the attachment. */
  attachmentName?: string;

  /** Region associated with the connector registration. */
  projectLocation?: string;

  /** Connector service endpoint. */
  endpoint?: url;

  /** Authentication audience for the connector service. */
  tokenAudience?: string;

  /** ARM resource ID of the connector identity. */
  connectorIdentityResourceId?: Azure.Core.armResourceIdentifier;

  /** Connector identity client ID. */
  connectorClientId?: string;

  /** Connector identity tenant ID. */
  connectorTenantId?: string;
}

/** Readiness of the attachment connector and capabilities. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterReadinessStatus {
  /** Whether the connector is ready. */
  connectorReady?: boolean;

  /** Readiness of individual capabilities. */
  capabilities?: AttachedAksClusterCapabilityStatus[];

  /** Conditions preventing readiness. */
  blockers?: string[];
}

/** Readiness of an individual attachment capability. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterCapabilityStatus {
  /** Capability name. */
  name?: string;

  /** Whether the capability is ready. */
  ready?: boolean;

  /** Details of the capability's readiness. */
  message?: string;
}

/** Status of the AI Manager integration on the attached cluster. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterAiManagerStatus {
  /** Provisioning state of the AI Manager integration. */
  provisioningState?: string;

  /** Details of the integration state. */
  message?: string;

  /** Attachment incarnation associated with this integration. */
  attachmentIncarnation?: string;

  /** ARM resource ID of the AI Manager resource. */
  resourceId?: Azure.Core.armResourceIdentifier;

  /** ARM resource ID of the AKS cluster. */
  clusterResourceId?: Azure.Core.armResourceIdentifier;

  /** ARM resource ID of the owning Cognitive Services account. */
  ownerAccountId?: Azure.Core.armResourceIdentifier;

  /** Deletion policy for the underlying integration resource. */
  deletePolicy?: string;

  /** Account identity used by the integration. */
  effectiveAccountIdentity?: AttachedAksClusterAccountIdentityStatus;

  /** Role assignment status for the integration. */
  roleAssignments?: AttachedAksClusterRoleAssignmentStatus;

  /** Dependency tracking epoch. */
  dependencyEpoch?: int64;

  /** Current integration consumer state, such as Invalid, Degraded, or Ready. */
  consumerState?: string;

  /** Whether new dependency references are admitted, such as Open or Closed. */
  referenceAdmission?: string;

  /** Number of deployments that depend on the integration. */
  dependentDeploymentCount?: int32;
}

/** Account identity associated with the AI Manager integration. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterAccountIdentityStatus {
  /** ARM resource ID of the account identity. */
  resourceId?: Azure.Core.armResourceIdentifier;

  /** Identity principal ID. */
  principalId?: string;

  /** Identity tenant ID. */
  tenantId?: string;

  /** Identity revision. */
  revision?: int64;
}

/** Role assignments associated with the AI Manager integration. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterRoleAssignmentStatus {
  /** ARM resource ID of the contributor role assignment. */
  contributorId?: Azure.Core.armResourceIdentifier;

  /** ARM resource ID of the inference operator role assignment. */
  inferenceOperatorId?: Azure.Core.armResourceIdentifier;

  /** Current role assignment status. */
  status?: string;
}

/** Status of an integration resource associated with the attachment. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterIntegrationResourceStatus {
  /** ARM resource ID of the integration resource. */
  resourceId?: Azure.Core.armResourceIdentifier;

  /** Provisioning state of the integration resource. */
  provisioningState?: string;

  /** Details of the integration state. */
  message?: string;
}

/** Evaluated health of an attachment. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterHealthStatus {
  /** Overall attachment health. */
  state?: AttachedAksClusterHealthState;

  /** Summary of the evaluated health. */
  summary?: string;

  /** Time at which health was last observed. */
  lastObservedAtUtc?: utcDateTime;

  /** Whether the attachment can admit new workloads. */
  newWorkAdmissionAllowed?: boolean;

  /** Health of individual attachment components. */
  components?: AttachedAksClusterHealthComponent[];

  /** Reasons contributing to the evaluated health. */
  @identifiers(#[])
  reasons?: AttachedAksClusterHealthReason[];
}

/** Health state of an attachment or one of its components. */
@added(Versions.v2026_11_15_preview)
union AttachedAksClusterHealthState {
  string,

  /** Health has not yet been established. */
  Unknown: "Unknown",

  /** The attachment or component is healthy. */
  Healthy: "Healthy",

  /** The attachment or component is degraded. */
  Degraded: "Degraded",

  /** The attachment or component is unhealthy. */
  Unhealthy: "Unhealthy",
}

/** Health of an individual attachment component. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterHealthComponent {
  /** Component name. */
  name?: string;

  /** Evaluated component health. */
  state?: AttachedAksClusterHealthState;

  /** Details of the component's health. */
  message?: string;

  /** Time at which component health was last observed. */
  lastObservedAtUtc?: utcDateTime;
}

/** A reason contributing to attachment health. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterHealthReason {
  /** Machine-readable health reason code. */
  code?: string;

  /** Component associated with the reason. */
  component?: string;

  /** Description of the health condition. */
  message?: string;

  /** Recommended action for the health condition. */
  recommendedAction?: string;
}

/** A lightweight attachment resource returned by LIST. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterListItem {
  /** ARM resource ID of the attachment. */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /** Attachment name. */
  @visibility(Lifecycle.Read)
  name?: string;

  /** Resource type of the attachment. */
  @visibility(Lifecycle.Read)
  type?: string;

  /** Lightweight attachment properties. */
  @visibility(Lifecycle.Read)
  properties?: AttachedAksClusterListProperties;
}

/** Lightweight attachment properties returned by LIST. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterListProperties {
  /** ARM resource ID of the attached AKS cluster. */
  clusterResourceId?: Azure.Core.armResourceIdentifier;

  /** Capabilities enabled on the attachment. */
  capabilities?: AttachedAksClusterCapability[];

  /** Current attachment provisioning stage. */
  stage?: AttachedAksClusterProvisioningStage;

  /** Evaluated attachment health. */
  health?: AttachedAksClusterHealthStatus;

  /** Region associated with the attachment. */
  projectLocation?: string;

  /** Attachment creation time. */
  createdTime?: utcDateTime;

  /** Attachment modification time. */
  modifiedTime?: utcDateTime;
}

/** A page of lightweight attachment summaries. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterListResult
  is ResourceListCustomResult<AttachedAksClusterListItem>;

/** OData query options supported by attachment LIST. */
@added(Versions.v2026_11_15_preview)
model AttachedAksClusterListQueryParameters {
  /** OData filter expression for attachment summaries. */
  @query("$filter")
  filter?: string;

  /** OData ordering expression for attachment summaries. */
  @query("$orderby")
  orderby?: string;

  /** Maximum number of attachments per page, from 1 to 100. Defaults to 50. */
  @query("$top")
  @minValue(1)
  @maxValue(100)
  top?: int32;

  /** Number of attachments to skip. Defaults to zero. */
  @query("$skip")
  @minValue(0)
  skip?: int32;
}
