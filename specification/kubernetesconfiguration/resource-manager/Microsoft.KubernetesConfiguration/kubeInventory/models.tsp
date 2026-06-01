import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ClientGenerator.Core;

namespace Microsoft.KubernetesConfiguration;

// ─── UpgradeAssessment enums ──────────────────────────────────────────────────

/** Severity of an upgrade-assessment finding or readiness check. */
union Severity {
  string,

  /** No issues found. */
  Pass: "Pass",

  /** Non-blocking issues found; upgrade is possible but action is recommended. */
  Warning: "Warning",

  /** Blocking issues found; upgrade should not proceed without remediation. */
  Critical: "Critical",

  /** Severity could not be determined. */
  Unknown: "Unknown",
}

/** Compatibility status of a cluster component with the target Kubernetes version. */
union CompatibilityStatus {
  string,

  /** Component is compatible with the target version. */
  Compatible: "Compatible",

  /** Compatibility with the target version has not been tested. */
  Untested: "Untested",

  /** Component is incompatible with the target version. */
  Incompatible: "Incompatible",

  /** Compatibility status is unknown. */
  Unknown: "Unknown",
}

/** Category of a cluster readiness check. */
union ReadinessCategory {
  string,

  /** Node status check. */
  NodeStatus: "NodeStatus",

  /** API server health check. */
  APIServerHealth: "APIServerHealth",

  /** Pod disruption budget check. */
  PodDisruptionBudget: "PodDisruptionBudget",

  /** Addon compatibility check. */
  Addon: "Addon",

  /** Storage compatibility check. */
  Storage: "Storage",

  /** Networking compatibility check. */
  Networking: "Networking",
}

// ─── UpgradeAssessment typed sub-models ──────────────────────────────────────

/** Compatibility status of a single cluster component with the target Kubernetes version. */
model ComponentCompatibility {
  /** Component name (e.g., 'containerd', 'calico'). */
  name: string;

  /** Installed component version. */
  version: string;

  /** Compatibility of the component with the target Kubernetes version. */
  compatibilityStatus: CompatibilityStatus;

  /** Severity associated with this compatibility result. */
  severity: Severity;

  /** Minimum component version known to be compatible with targetKubernetesVersion. */
  minCompatibleVersion?: string;

  /** Additional notes about compatibility. */
  notes?: string;
}

/** Observed call counts per HTTP verb for a deprecated Kubernetes API. */
model HttpVerbUsageMetrics {
  /** Number of GET requests observed. */
  get?: int64;

  /** Number of LIST requests observed. */
  list?: int64;

  /** Number of POST (create) requests observed. */
  post?: int64;

  /** Number of PUT (replace) requests observed. */
  put?: int64;

  /** Number of PATCH requests observed. */
  patch?: int64;

  /** Number of DELETE requests observed. */
  delete?: int64;

  /** Number of WATCH requests observed. */
  watch?: int64;
}

/** A deprecated Kubernetes API still in use in the cluster. */
model DeprecatedApiUsage {
  /** API group (e.g., 'flowcontrol.apiserver.k8s.io'). */
  group: string;

  /** API version (e.g., 'v1beta3'). */
  version: string;

  /** Resource plural name (e.g., 'flowschemas'). */
  resource: string;

  /** Kubernetes release in which this API is removed (e.g., '1.32'). */
  removedRelease?: string;

  /** HTTP verb call counts observed for this deprecated API. */
  usageMetrics?: HttpVerbUsageMetrics;

  /** UTC timestamp of the last observed usage. */
  lastUsageObservedAt?: utcDateTime;

  /** Severity of continued use of this deprecated API. */
  severity: Severity;
}

/** A single cluster readiness check result. */
model ReadinessCheck {
  /** Category of the readiness check. */
  category: ReadinessCategory;

  /**
   * Subject of the check (node name, workload namespace/name, etc.).
   * Optional for cluster-wide checks.
   */
  name?: string;

  /** Severity of the check result. */
  severity: Severity;

  /** Human-readable reason when severity is not 'pass'. */
  details?: string;
}

/** A single Kubernetes label (key/value pair used for selection and grouping). */
model KubernetesLabel {
  /** Label key (e.g., 'app.kubernetes.io/name'). */
  @key
  @visibility(Lifecycle.Read)
  name: string;

  /** Label value. */
  value: string;
}

/** A single Kubernetes annotation (key/value pair for non-identifying auxiliary metadata). */
model KubernetesAnnotation {
  /** Annotation key (e.g., 'kubectl.kubernetes.io/last-applied-configuration'). */
  @key
  @visibility(Lifecycle.Read)
  name: string;

  /** Annotation value. */
  value: string;
}

// ─── Common Kubernetes types ──────────────────────────────────────────────────

/** A reference from a Kubernetes object to its owner (e.g., a ReplicaSet owning a Pod). */
model OwnerReference {
  /** API version of the owner (e.g., 'apps/v1'). */
  apiVersion: string;

  /** Kind of the owner (e.g., 'ReplicaSet'). */
  kind: string;

  /** Name of the owner object. */
  name: string;

  /** UID of the owner object. */
  uid: string;

  /** True when this owner manages the lifecycle of the referencing object. */
  controller?: boolean;

  /** If true, deletion of the owner is blocked until this reference is removed. */
  blockOwnerDeletion?: boolean;
}

/** Metadata common to all Kubernetes objects (subset of ObjectMeta). */
model KubernetesObjectMeta {
  /** Name of the Kubernetes object, unique within its namespace. */
  name: string;

  /**
   * Namespace the object belongs to.
   * Empty for cluster-scoped resources such as Node and Namespace.
   */
  namespaceName?: string;

  /** Immutable UID assigned by the Kubernetes API server. */
  uid?: string;

  /**
   * Opaque version string used for optimistic concurrency.
   * Clients must treat this as opaque and pass it unmodified on updates.
   */
  resourceVersion?: string;

  /** Sequence number incremented each time the object spec changes. */
  generation?: int64;

  /** UTC timestamp when the object was created. */
  creationTimestamp?: utcDateTime;

  /**
   * UTC timestamp set when a graceful deletion has been requested.
   * Absent when the object is not being deleted.
   */
  deletionTimestamp?: utcDateTime;

  /** User-defined key/value pairs used for selection and grouping. */
  @identifiers(#["name"])
  labels?: KubernetesLabel[];

  /** Key/value pairs for non-identifying auxiliary metadata. */
  @identifiers(#["name"])
  annotations?: KubernetesAnnotation[];

  /** References to the objects that own this object (e.g., the ReplicaSet that owns a Pod). */
  ownerReferences?: OwnerReference[];

  /** Named lifecycle hooks that must be resolved before the object is deleted. */
  finalizers?: string[];
}

/** Whether a Kubernetes condition is currently active. */
union ConditionStatus {
  string,

  /** Condition is currently true. */
  True: "True",

  /** Condition is currently false. */
  False: "False",

  /** Condition state cannot be determined. */
  Unknown: "Unknown",
}

/** A Kubernetes-style status condition reported by a controller. */
model KubernetesCondition {
  /** Type of the condition (e.g., 'Ready', 'Available', 'Progressing'). */
  type: string;

  /** Whether the condition is currently active. */
  status: ConditionStatus;

  /** Machine-readable reason code for the current status. */
  reason?: string;

  /** Human-readable explanation of the current status. */
  message?: string;

  /** UTC timestamp of the last status transition. */
  lastTransitionTime?: utcDateTime;
}

// ─── Generic overflow field ───────────────────────────────────────────────────

/**
 * A generic recursive field node used to represent resource-specific fields
 * that are not captured by the typed properties on KubernetesResourceSpec
 * or KubernetesResourceStatus (e.g., uncommon fields and CRD-specific data).
 */
model KubernetesGenericField {
  /** Field name. */
  @key
  @visibility(Lifecycle.Read)
  name: string;

  /** Value */
  value: string;
}

// ─── Container support models ─────────────────────────────────────────────────

/** A volume mount inside a container. */
model VolumeMount {
  /** Name matching a volume declared in the pod spec. */
  name: string;

  /** Absolute path inside the container where the volume is mounted. */
  mountPath: string;

  /** Mount the volume as read-only when true. */
  readOnly?: boolean;

  /** Sub-path within the volume to mount instead of the volume root. */
  subPath?: string;
}

/** Linux capability set to add to or drop from a container's default capabilities. */
model Capabilities {
  /** Capabilities to add (e.g., 'NET_ADMIN'). */
  add?: string[];

  /** Capabilities to remove (e.g., 'ALL'). */
  drop?: string[];
}

/** Security context applied to a single container. */
model ContainerSecurityContext {
  /** Linux capability adjustments for this container. */
  capabilities?: Capabilities;

  /** Mount the container's root filesystem as read-only when true. */
  readOnlyRootFilesystem?: boolean;

  /** Prevent the container process from gaining more privileges than its parent when false. */
  allowPrivilegeEscalation?: boolean;

  /** Require the container to run as a non-root user when true. */
  runAsNonRoot?: boolean;

  /** UID to run the container process as. */
  runAsUser?: int64;

  /** GID to run the container process as. */
  runAsGroup?: int64;
}

/** Network protocol used by a container port. */
union NetworkProtocol {
  string,

  /** Transmission Control Protocol. */
  TCP: "TCP",

  /** User Datagram Protocol. */
  UDP: "UDP",

  /** Stream Control Transmission Protocol. */
  SCTP: "SCTP",
}

/** A port exposed by a container. */
model ContainerPort {
  /** Port number exposed inside the container. */
  @clientName("portNumber", "csharp")
  containerPort: int32;

  /** Network protocol for this port. */
  protocol?: NetworkProtocol;

  /** Optional name for this port. */
  name?: string;
}

/** An environment variable set in a container. */
model EnvVar {
  /** Name of the environment variable. */
  name: string;

  /** Literal string value. */
  value?: string;
}

/**
 * CPU and memory resource quantities for a container.
 * Values use Kubernetes resource notation: CPU as millicores (e.g., '500m', '2')
 * and memory as byte-unit strings (e.g., '256Mi', '1Gi').
 * See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
 */
model ContainerResourceQuantity {
  /** CPU quantity (e.g., '500m' for 500 millicores, '2' for 2 cores). */
  cpu?: string;

  /** Memory quantity (e.g., '256Mi', '1Gi'). */
  memory?: string;
}

/** CPU and memory resource declarations for a container. */
model ContainerResourceRequirements {
  /** Maximum resources the container may consume. */
  limits?: ContainerResourceQuantity;

  /** Minimum resources the container requires to be scheduled. */
  requests?: ContainerResourceQuantity;
}

/** Specification of a single container within a pod. */
model ContainerSpec {
  /** Name of the container, unique within the pod. */
  name: string;

  /** Container image reference (e.g., 'nginx:1.25'). */
  image: string;

  /** Ports to expose from the container. */
  @identifiers(#["name"])
  ports?: ContainerPort[];

  /** Environment variables to set in the container. */
  @identifiers(#["name"])
  env?: EnvVar[];

  /** Compute resource requests and limits. */
  resources?: ContainerResourceRequirements;

  /** Command to override the container default ENTRYPOINT. */
  command?: string[];

  /** Arguments to override the container default CMD. */
  args?: string[];

  /** Volume paths to mount inside the container. */
  @identifiers(#["name"])
  volumeMounts?: VolumeMount[];

  /** Security context applied to this container. */
  securityContext?: ContainerSecurityContext;
}

// ─── Pod-level support models ─────────────────────────────────────────────────

/**
 * A volume available to containers in a pod.
 * The sourceType field identifies the kind of volume source
 * (e.g., 'emptyDir', 'configMap', 'secret', 'persistentVolumeClaim', 'projected').
 */
model Volume {
  /** Name of the volume, referenced by container volumeMounts. */
  name: string;

  /**
   * Kind of volume source
   * (e.g., 'emptyDir', 'configMap', 'secret', 'persistentVolumeClaim', 'projected').
   */
  sourceType?: string;

  /** Primary reference for the volume source (e.g., ConfigMap name or PVC name). */
  source?: string;

  /** Storage size limit for emptyDir volumes (e.g., '50Mi'). */
  sizeLimit?: string;
}

/** A toleration allows a pod to be scheduled on a node with a matching taint. */
model Toleration {
  /** Taint key the toleration applies to. Empty matches all keys. */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Toleration key is a Kubernetes taint key identifier, not a secret"
  @key
  @visibility(Lifecycle.Read)
  key: string;

  /**
   * Operator to use when matching: 'Equal' matches when key and value both match;
   * 'Exists' matches when the key is present regardless of value.
   */
  operator?: string;

  /** Taint value matched when operator is 'Equal'. */
  value?: string;

  /**
   * Taint effect this toleration applies to
   * ('NoSchedule', 'PreferNoSchedule', or 'NoExecute'). Empty matches all effects.
   */
  effect?: string;

  /** Seconds a pod tolerates a NoExecute taint before being evicted. */
  tolerationSeconds?: int64;
}

/** Security context applied at the pod level, affecting all containers. */
model PodSecurityContext {
  /** GID of the owning group for volume mounts; processes also run as this GID. */
  fsGroup?: int64;

  /** UID to run all containers as. Overridden per-container by ContainerSecurityContext.runAsUser. */
  runAsUser?: int64;

  /** GID to run all containers as. */
  runAsGroup?: int64;

  /** Require all containers to run as non-root when true. */
  runAsNonRoot?: boolean;

  /** Supplemental GIDs applied to each container in addition to the primary GID. */
  supplementalGroups?: int64[];
}

/** State of a currently running container. */
model ContainerStateRunning {
  /** UTC timestamp when the container started. */
  startedAt?: utcDateTime;
}

/** State of a terminated container. */
model ContainerStateTerminated {
  /** Exit code of the container process. */
  exitCode: int32;

  /** Signal that caused the container to terminate, if applicable. */
  signal?: int32;

  /** Machine-readable reason for termination (e.g., 'OOMKilled', 'Completed'). */
  reason?: string;

  /** Human-readable message about the termination. */
  message?: string;

  /** UTC timestamp when the container started its last execution. */
  startedAt?: utcDateTime;

  /** UTC timestamp when the container terminated. */
  finishedAt?: utcDateTime;
}

/** State of a container that is not yet running. */
model ContainerStateWaiting {
  /** Machine-readable reason the container is not running (e.g., 'ContainerCreating', 'ImagePullBackOff'). */
  reason?: string;

  /** Human-readable message about the waiting state. */
  message?: string;
}

/** Current or previous state of a container; exactly one of the three fields is populated. */
model ContainerState {
  /** Populated when the container is currently executing. */
  running?: ContainerStateRunning;

  /** Populated when the container has exited. */
  terminated?: ContainerStateTerminated;

  /** Populated when the container is not yet running. */
  waiting?: ContainerStateWaiting;
}

/** Runtime status of a single container as reported in the pod status. */
model ContainerStatus {
  /** Name of the container. */
  name: string;

  /** True when the container has passed its readiness probe. */
  ready: boolean;

  /** Number of times the container has restarted since the pod was started. */
  restartCount: int32;

  /** Container image including digest as resolved by the runtime. */
  image?: string;

  /** Whether the container has passed its startup probe and is considered started. */
  started?: boolean;

  /** Current state of the container. */
  state?: ContainerState;

  /** Previous termination state of the container; populated after a restart. */
  lastState?: ContainerState;

  /** Opaque container runtime identifier (e.g., 'containerd://sha256:...'). */
  containerId?: string;
}

// ─── Generic flat spec and status ────────────────────────────────────────────

/**
 * Desired state (spec) of a Kubernetes resource.
 *
 * Well-known fields for native workloads (Pod, Deployment, Service, etc.) are typed
 * directly. UpgradeAssessment spec fields are merged in as optional typed properties.
 * Fields not covered by any typed property can be placed in additionalFields.
 */
model KubernetesResourceSpec {
  // ── Pod / workload ──────────────────────────────────────────────────────────

  /** Name of the node the pod is scheduled on. Populated for Pod resources. */
  nodeName?: string;

  /** Pod restart policy (e.g., 'Always', 'OnFailure', 'Never'). Populated for Pod resources. */
  restartPolicy?: string;

  /**
   * Containers belonging to the pod or pod template.
   * Populated for Pod, Deployment, StatefulSet, and DaemonSet resources.
   */
  @identifiers(#["name"])
  containers?: ContainerSpec[];

  /**
   * Init containers that run before app containers start.
   * Populated for Pod, Deployment, StatefulSet, and DaemonSet resources.
   */
  @identifiers(#["name"])
  initContainers?: ContainerSpec[];

  /** Grace period in seconds before forcibly terminating the pod on deletion. */
  terminationGracePeriodSeconds?: int64;

  // ── Deployment / StatefulSet / DaemonSet ────────────────────────────────────

  /** Desired number of pod replicas. Populated for Deployment and StatefulSet resources. */
  replicas?: int32;

  /**
   * Headless service name governing StatefulSet pod network identity.
   * Populated for StatefulSet resources.
   */
  serviceName?: string;

  // ── Service ─────────────────────────────────────────────────────────────────

  /**
   * How the service is exposed (e.g., 'ClusterIP', 'NodePort', 'LoadBalancer').
   * Populated for Service resources.
   */
  serviceType?: string;

  /** Cluster-internal IP assigned to the service. Populated for Service resources. */
  clusterIp?: string;

  // ── Pod security and scheduling ─────────────────────────────────────────────

  /**
   * Name of the ServiceAccount the pod runs as.
   * Populated for Pod, Deployment, StatefulSet, and DaemonSet resources.
   */
  serviceAccountName?: string;

  /**
   * Tolerations allowing the pod to be scheduled on nodes with matching taints.
   * Populated for Pod, Deployment, StatefulSet, and DaemonSet resources.
   */
  @identifiers(#[])
  tolerations?: Toleration[];

  /**
   * Volumes available to containers in the pod or pod template.
   * Populated for Pod, Deployment, StatefulSet, and DaemonSet resources.
   */
  @identifiers(#["name"])
  volumes?: Volume[];

  /**
   * DNS policy for the pod (e.g., 'ClusterFirst', 'Default', 'None').
   * Populated for Pod resources.
   */
  dnsPolicy?: string;

  /**
   * Security context applied at the pod level.
   * Populated for Pod, Deployment, StatefulSet, and DaemonSet resources.
   */
  securityContext?: PodSecurityContext;

  // ── UpgradeAssessment (kind = "UpgradeAssessment") ──────────────────────────

  /**
   * Current Kubernetes version running on the cluster (e.g., '1.29').
   * Populated for UpgradeAssessment resources.
   */
  currentKubernetesVersion?: string;

  /**
   * Target Kubernetes version to evaluate for upgrade (e.g., '1.30').
   * Populated for UpgradeAssessment resources.
   */
  targetKubernetesVersion?: string;

  // ── Generic overflow ────────────────────────────────────────────────────────

  /**
   * Additional resource-specific fields not represented by the typed properties above.
   * Used for uncommon fields and custom resource definition instances.
   */
  @identifiers(#["name"])
  additionalFields?: KubernetesGenericField[];
}

/**
 * Observed state (status) of a Kubernetes resource, written by the controller.
 *
 * Well-known fields for native workloads (Pod, Deployment, Service, etc.) are typed
 * directly. UpgradeAssessment status fields are merged in as optional typed properties.
 * Fields not covered by any typed property can be placed in additionalFields.
 */
model KubernetesResourceStatus {
  // ── Universal ───────────────────────────────────────────────────────────────

  /** Conditions reported by the controller managing this resource. */
  @identifiers(#["type"])
  conditions?: KubernetesCondition[];

  /**
   * High-level lifecycle phase of the resource.
   * Examples: 'Running' / 'Pending' / 'Succeeded' / 'Failed' for Pod;
   * 'Bound' / 'Pending' / 'Lost' for PersistentVolumeClaim;
   * 'Active' / 'Terminating' for Namespace.
   */
  phase?: string;

  /** Human-readable message summarizing the resource state. */
  message?: string;

  // ── Workload replica counters ────────────────────────────────────────────────

  /** Number of pods ready to serve requests. Populated for Deployment, StatefulSet, DaemonSet. */
  readyReplicas?: int32;

  /** Number of pods available for at least minReadySeconds. Populated for Deployment, DaemonSet. */
  availableReplicas?: int32;

  // ── Pod ─────────────────────────────────────────────────────────────────────

  /** IP address allocated to the pod within the cluster. Populated for Pod resources. */
  podIp?: string;

  /** IP address of the node hosting the pod. Populated for Pod resources. */
  hostIp?: string;

  /** UTC timestamp when the pod was accepted by the scheduler. Populated for Pod resources. */
  startTime?: utcDateTime;

  /**
   * Runtime status of each container in the pod.
   * Populated for Pod resources.
   */
  @identifiers(#["name"])
  containerStatuses?: ContainerStatus[];

  /**
   * QoS class assigned by Kubernetes based on resource requests and limits.
   * One of 'Guaranteed', 'Burstable', or 'BestEffort'. Populated for Pod resources.
   */
  qosClass?: string;

  /**
   * Most recent generation observed by the controller.
   * Populated for Deployment, StatefulSet, DaemonSet, and Pod resources.
   */
  observedGeneration?: int64;

  // ── UpgradeAssessment (kind = "UpgradeAssessment") ──────────────────────────

  /**
   * UTC timestamp when the in-cluster agent last computed this assessment.
   * Populated for UpgradeAssessment resources.
   */
  @visibility(Lifecycle.Read)
  assessmentTime?: utcDateTime;

  /**
   * Rolled-up severity across all checks; highest severity wins.
   * Populated for UpgradeAssessment resources.
   */
  overallSeverity?: Severity;

  /**
   * Per-component compatibility results with the target Kubernetes version.
   * Populated for UpgradeAssessment resources.
   */
  componentCompatibility?: ComponentCompatibility[];

  /**
   * Deprecated Kubernetes APIs still in use in the cluster.
   * Populated for UpgradeAssessment resources.
   */
  @identifiers(#[])
  deprecatedApis?: DeprecatedApiUsage[];

  /**
   * Cluster readiness check results.
   * Populated for UpgradeAssessment resources.
   */
  readinessChecks?: ReadinessCheck[];

  // ── Generic overflow ────────────────────────────────────────────────────────

  /**
   * Additional resource-specific status fields not represented by the typed properties above.
   * Used for uncommon fields and custom resource definition instances.
   */
  @identifiers(#["name"])
  additionalFields?: KubernetesGenericField[];
}

// ─── Kubernetes event ─────────────────────────────────────────────────────────

/** A Kubernetes event recorded against a resource (equivalent to `kubectl describe` Events). */
model KubernetesEvent {
  /** Event type: 'Normal' or 'Warning'. */
  type: string;

  /** Short machine-readable reason for the event (e.g., 'Scheduled', 'Pulled', 'Failed'). */
  reason: string;

  /**
   * Human-readable elapsed time since the event last occurred
   * as reported by the Kubernetes API (e.g., '2m28s', '5h').
   */
  age: string;

  /**
   * Component that emitted the event
   * (e.g., 'default-scheduler', 'kubelet').
   */
  from: string;

  /** Human-readable description of the event. */
  message: string;
}

// ─── ARM resource properties ──────────────────────────────────────────────────

/**
 * Properties of a single KubeInventory ARM resource.
 * Each ARM resource represents one Kubernetes object from the cluster inventory.
 * The ARM resource name encodes the kind, Kubernetes name, and namespace
 * (e.g., 'pod-nginx-6d4cf56db6-x7q2p-default', 'upgrade-assessment-current-kube-system').
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This resource does not have a provisioning state per the original Swagger design"
model KubeInventoryProperties {
  /**
   * Kubernetes API version of the represented resource
   * (e.g., 'v1', 'apps/v1', 'upgrade.config.io/v1alpha1').
   */
  apiVersion?: string;

  /** Kind of the Kubernetes resource (e.g., 'Pod', 'Deployment', 'Service', 'UpgradeAssessment'). */
  kind?: string;

  /** Standard Kubernetes object metadata. */
  metadata?: KubernetesObjectMeta;

  /** Desired state of the Kubernetes resource. */
  spec?: KubernetesResourceSpec;

  /** Observed state of the Kubernetes resource, written by the controller. */
  status?: KubernetesResourceStatus;

  /** Kubernetes events recorded against this resource. */
  @identifiers(#[])
  events?: KubernetesEvent[];
}
