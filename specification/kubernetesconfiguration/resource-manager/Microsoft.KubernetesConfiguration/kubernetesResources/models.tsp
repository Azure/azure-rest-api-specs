import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.KubernetesConfiguration;

/** A single Kubernetes map entry (key/value pair). */
model KubernetesMapEntry {
  /** Map key. */
  @key
  @visibility(Lifecycle.Read)
  name: string;

  /** Map value. */
  value?: string;
}

// ─── Common Kubernetes types ──────────────────────────────────────────────────

/** A reference from a Kubernetes object to its owner (e.g., a ReplicaSet owning a Pod). */
model OwnerReference {
  /** API version of the owner (e.g., 'apps/v1'). */
  apiVersion?: string;

  /** Kind of the owner (e.g., 'ReplicaSet'). */
  kind?: string;

  /** Name of the owner object. */
  name?: string;

  /** UID of the owner object. */
  @key
  @visibility(Lifecycle.Read)
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
  labels?: KubernetesMapEntry[];

  /** Key/value pairs for non-identifying auxiliary metadata. */
  @identifiers(#["name"])
  annotations?: KubernetesMapEntry[];

  /** References to the objects that own this object (e.g., the ReplicaSet that owns a Pod). */
  @identifiers(#["uid"])
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
  status?: ConditionStatus;

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

  /** The string value of the field. */
  value?: string;
}

// ─── Container support models ─────────────────────────────────────────────────

/** A volume mount inside a container. */
model VolumeMount {
  /** Name matching a volume declared in the pod spec. */
  name: string;

  /** Absolute path inside the container where the volume is mounted. */
  mountPath?: string;

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

  /** When true, the container runs with full host privileges (root + all Linux capabilities). */
  privileged?: boolean;

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

  /** Seccomp profile type applied to this container ('RuntimeDefault', 'Unconfined', or 'Localhost'). */
  seccompProfile?: string;
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
model ContainerPortInfo {
  /** Port number exposed inside the container. */
  containerPort: int32;

  /** Network protocol for this port. */
  protocol?: NetworkProtocol;

  /** Optional name for this port. */
  name?: string;

  /** Port number to expose on the host node. */
  hostPort?: int32;

  /** Host IP to bind the hostPort on. */
  hostIp?: string;
}

/** An environment variable set in a container. */
model EnvVar {
  /** Name of the environment variable. */
  name: string;

  /** Literal string value. Non-secret environment variables only. */
  value?: string;
}

/** A source for bulk-importing environment variables into a container from a ConfigMap or Secret. */
model EnvFromSource {
  /** Name of the ConfigMap whose keys are imported as environment variables. */
  configMapRef?: string;

  /** Name of the Secret whose keys are imported as environment variables. */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "secretRef holds the name of a Kubernetes Secret object, not a secret value"
  secretRef?: string;

  /** Optional prefix prepended to each imported environment variable name. */
  prefix?: string;
}

/**
 * CPU and memory resource quantities for a container.
 * See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
 */
model ContainerResourceQuantity {
  /** CPU quantity (e.g., '500m', '2'). */
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

/**
 * Simplified health probe configuration for a container.
 * Captures the probe mechanism type and the primary target (path or port).
 * Detailed timing parameters (initialDelaySeconds, periodSeconds, etc.) can be stored in additionalFields.
 */
model ContainerProbe {
  /** Probe mechanism: 'HTTPGet', 'TCPSocket', 'Exec', or 'GRPC'. */
  type?: string;

  /** URL path for HTTPGet probes. */
  path?: string;

  /** Port number for HTTPGet or TCPSocket probes. */
  port?: int32;
}

/** Specification of a single container within a pod. */
model ContainerSpec {
  /** Name of the container, unique within the pod. */
  name: string;

  /** Container image reference (e.g., 'nginx:1.25'). */
  image?: string;

  /** Image pull policy for this container ('Always', 'IfNotPresent', or 'Never'). */
  imagePullPolicy?: string;

  /** Ports to expose from the container. */
  @identifiers(#["name"])
  ports?: ContainerPortInfo[];

  /** Environment variables to set in the container. */
  @identifiers(#["name"])
  env?: EnvVar[];

  /** Sources that populate environment variables in bulk from ConfigMaps or Secrets. */
  @identifiers(#[])
  envFrom?: EnvFromSource[];

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

  /** Liveness probe that determines when to restart the container. */
  livenessProbe?: ContainerProbe;

  /** Readiness probe that determines when the container is ready to accept traffic. */
  readinessProbe?: ContainerProbe;
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

  /** Seccomp profile type applied to all containers ('RuntimeDefault', 'Unconfined', or 'Localhost'). */
  seccompProfile?: string;

  /** AppArmor profile type applied to all containers ('RuntimeDefault', 'Unconfined', or 'Localhost'). */
  appArmorProfile?: string;
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
  ready?: boolean;

  /** Number of times the container has restarted since the pod was started. */
  restartCount?: int32;

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

// ─── Service models ───────────────────────────────────────────────────────────

/** A port exposed by a Kubernetes Service. */
model ServicePort {
  /** Port number the Service listens on (cluster-internal). */
  port: int32;

  /** Port or named port on the target pod the traffic is forwarded to. */
  targetPort?: string;

  /** NodePort allocated for NodePort and LoadBalancer Services. */
  nodePort?: int32;

  /** Network protocol for this port. */
  protocol?: NetworkProtocol;

  /** Optional name for this port, unique within the Service. */
  name?: string;

  /** Application-level protocol hint (e.g., 'http', 'https', 'grpc'). */
  appProtocol?: string;
}

// ─── Node models ─────────────────────────────────────────────────────────────

/** Effect applied to pods that do not tolerate a node taint. */
union NodeTaintEffect {
  string,

  /** New pods will not be scheduled on the tainted node. */
  NoSchedule: "NoSchedule",

  /** The scheduler tries to avoid placing new pods on the tainted node. */
  PreferNoSchedule: "PreferNoSchedule",

  /** Existing pods without a matching toleration are evicted from the tainted node. */
  NoExecute: "NoExecute",
}

/** A taint applied to a Kubernetes Node that repels pods without a matching toleration. */
model NodeTaint {
  /** Taint key (e.g., 'node.kubernetes.io/not-ready'). */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Taint key is a Kubernetes taint key identifier, not a secret"
  key: string;

  /** Taint value matched by tolerations using the 'Equal' operator. */
  value?: string;

  /** Effect applied to non-tolerating pods. */
  effect?: NodeTaintEffect;
}

/** A network address associated with a Kubernetes Node. */
model NodeAddress {
  /** Address type (e.g., 'InternalIP', 'ExternalIP', 'Hostname'). */
  type?: string;

  /** The address value (IP address or hostname). */
  address: string;
}

/** Operating system and runtime information for a Node. */
model NodeSystemInfo {
  /** Kernel version of the node OS (e.g., '5.15.0-1041-azure'). */
  kernelVersion?: string;

  /** Human-readable OS image string (e.g., 'Ubuntu 22.04.3 LTS'). */
  osImage?: string;

  /** Container runtime name and version (e.g., 'containerd://1.7.2'). */
  containerRuntimeVersion?: string;

  /** Node agent version running on the node (e.g., 'v1.29.2'). */
  kubeletVersion?: string;

  /** kube-proxy version running on the node. */
  kubeProxyVersion?: string;

  /** CPU architecture of the node (e.g., 'amd64', 'arm64'). */
  architecture?: string;

  /** Operating system family ('linux' or 'windows'). */
  operatingSystem?: string;
}

/** Resource quantities reported for a Kubernetes Node (capacity or allocatable). */
model NodeResourceMap {
  /** CPU quantity (e.g., '4', '3850m'). */
  cpu?: string;

  /** Memory quantity (e.g., '16Gi', '14902Mi'). */
  memory?: string;

  /** Maximum number of pods the node supports. */
  pods?: string;

  /** Ephemeral storage quantity (e.g., '119Gi'). */
  ephemeralStorage?: string;
}

/** A volume attached to a Kubernetes Node by the attach/detach controller. */
model AttachedVolume {
  /** Name of the attached volume (matches the PersistentVolume name). */
  name: string;

  /** Device path on the node where the volume is attached (e.g., '/dev/sdc'). */
  devicePath?: string;
}

// ─── StatefulSet models ───────────────────────────────────────────────────────

/** A PersistentVolumeClaim template in a StatefulSet that provisions stable storage per replica. */
model VolumeClaimTemplate {
  /** Name of the volume claim template, referenced by container volumeMounts. */
  name: string;

  /** Requested storage access modes (e.g., 'ReadWriteOnce'). */
  accessModes?: string[];

  /** StorageClass used for dynamic provisioning. */
  storageClassName?: string;

  /** Storage quantity requested per replica (e.g., '10Gi'). */
  storageRequest?: string;

  /** Volume mode ('Filesystem' or 'Block'). */
  volumeMode?: string;
}

// ─── EndpointSlice models ─────────────────────────────────────────────────────

/** A single endpoint within an EndpointSlice (address + readiness + scheduling hints). */
model EndpointSliceEndpoint {
  /** IP addresses (IPv4/IPv6) or FQDNs serving this endpoint. */
  addresses: string[];

  /** True when the endpoint is ready to receive traffic. */
  ready?: boolean;

  /** Name of the node hosting this endpoint. */
  nodeName?: string;

  /** Kind of the backing object (typically 'Pod'). */
  targetRefKind?: string;

  /** Name of the backing object. */
  targetRefName?: string;

  /** Namespace of the backing object. */
  targetRefNamespace?: string;
}

/** A port entry in an EndpointSlice. */
model EndpointSlicePort {
  /** Port number. */
  port: int32;

  /** Network protocol ('TCP', 'UDP', or 'SCTP'). */
  protocol?: NetworkProtocol;

  /** Optional name for this port. */
  name?: string;
}

// ─── RBAC models ─────────────────────────────────────────────────────────────

/** A single RBAC permission rule granting verbs on Kubernetes API resources. */
model PolicyRule {
  /** API groups the rule applies to (use '' for the core group). */
  apiGroups?: string[];

  /** Resource types the rule applies to (e.g., 'pods', 'deployments', 'secrets'). */
  resources?: string[];

  /** Actions permitted (e.g., 'get', 'list', 'watch', 'create', 'update', 'patch', 'delete'). */
  verbs: string[];

  /** Specific resource names this rule applies to. Empty means all instances. */
  resourceNames?: string[];
}

/** A subject (user, group, or service account) in a RoleBinding or ClusterRoleBinding. */
model RbacSubject {
  /** Kind of the subject: 'User', 'Group', or 'ServiceAccount'. */
  kind?: string;

  /** Name of the subject. */
  name: string;

  /** Namespace of the ServiceAccount. Required when kind is ServiceAccount. */
  namespaceName?: string;
}

// ─── Ingress models ───────────────────────────────────────────────────────────

/** An HTTP path rule within an Ingress host entry, mapping a URL path to a backend Service. */
model IngressPath {
  /** URL path to match (e.g., '/api', '/'). */
  path?: string;

  /** Path matching semantics ('Exact', 'Prefix', or 'ImplementationSpecific'). */
  pathType?: string;

  /** Name of the backend Service receiving matched traffic. */
  serviceName: string;

  /** Port of the backend Service (numeric string or named port). */
  servicePort?: string;
}

/** A host-level routing rule in an Ingress resource. */
model IngressRule {
  /** Fully qualified domain name or wildcard host (e.g., 'api.example.com', '*.example.com'). */
  host?: string;

  /** HTTP path rules mapping URL paths to backend Services. */
  @identifiers(#[])
  paths?: IngressPath[];
}

/** TLS configuration entry for an Ingress resource. */
model IngressTls {
  /** Hostnames covered by this TLS certificate. */
  hosts?: string[];

  /** Name of the Secret containing the TLS certificate and private key. */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "secretName is a Kubernetes Secret object name reference, not a secret value."
  secretName?: string;
}

// ─── Generic flat spec and status ────────────────────────────────────────────

/**
 * Desired state (spec) of a Kubernetes resource.
 *
 * Well-known fields for native workloads (Pod, Deployment, Service, etc.) are typed
 * directly. Fields not covered by any typed property can be placed in additionalFields.
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

  /**
   * Node label selector constraining which nodes this pod may be scheduled on.
   * Populated for Pod, Deployment, StatefulSet, and DaemonSet resources.
   */
  @identifiers(#["name"])
  nodeSelector?: KubernetesMapEntry[];

  /**
   * Name of the PriorityClass governing scheduling priority and preemption for this pod.
   * Populated for Pod, Deployment, StatefulSet, and DaemonSet resources.
   */
  priorityClassName?: string;

  /**
   * When true, the pod uses the host network namespace (disables pod network isolation).
   * Populated for Pod resources.
   */
  hostNetwork?: boolean;

  /** When true, the pod shares the host PID namespace. Populated for Pod resources. */
  hostPid?: boolean;

  /** When true, the pod shares the host IPC namespace. Populated for Pod resources. */
  hostIpc?: boolean;

  /** Name of the RuntimeClass for specialized container runtimes. Populated for Pod resources. */
  runtimeClassName?: string;

  /**
   * Names of Secrets used to authenticate image pulls from private registries.
   * Populated for Pod, Deployment, StatefulSet, and DaemonSet resources.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "imagePullSecrets holds Kubernetes Secret object names (references), not secret values."
  imagePullSecrets?: string[];

  /**
   * Operating system of the containers ('linux' or 'windows').
   * Populated for Pod resources.
   */
  podOs?: string;

  // ── Deployment / StatefulSet / DaemonSet ────────────────────────────────────

  /** Desired number of pod replicas. Populated for Deployment and StatefulSet resources. */
  replicas?: int32;

  /**
   * Headless service name governing StatefulSet pod network identity.
   * Populated for StatefulSet resources.
   */
  serviceName?: string;

  /**
   * Label selector identifying which pods are managed by this workload.
   * Populated for Deployment, StatefulSet, DaemonSet, and ReplicaSet resources.
   */
  @identifiers(#["name"])
  selector?: KubernetesMapEntry[];

  /**
   * Rollout strategy type.
   * 'RollingUpdate' or 'Recreate' for Deployment;
   * 'RollingUpdate' or 'OnDelete' for StatefulSet and DaemonSet.
   */
  strategyType?: string;

  /**
   * Maximum number of pods that can be unavailable during a rolling update
   * (absolute number or percentage string, e.g., '25%').
   * Populated for Deployment and DaemonSet resources.
   */
  maxUnavailable?: string;

  /**
   * Maximum number of pods that can be created above the desired count during a rolling update
   * (absolute number or percentage string, e.g., '25%').
   * Populated for Deployment resources.
   */
  maxSurge?: string;

  /** When true, the Deployment rollout is paused. Populated for Deployment resources. */
  paused?: boolean;

  /**
   * Pod creation and deletion ordering policy for a StatefulSet
   * ('OrderedReady' for sequential or 'Parallel' for simultaneous).
   * Populated for StatefulSet resources.
   */
  podManagementPolicy?: string;

  /**
   * PVC templates stamped out per StatefulSet replica to provide stable per-pod storage.
   * Populated for StatefulSet resources.
   */
  @identifiers(#["name"])
  volumeClaimTemplates?: VolumeClaimTemplate[];

  /**
   * Maximum number of pods that can be unavailable during a StatefulSet rolling update
   * (absolute number or percentage string, e.g., '1', '25%'). Beta as of Kubernetes 1.24.
   * Populated for StatefulSet resources.
   */
  maxUnavailableReplicas?: string;

  // ── Service ─────────────────────────────────────────────────────────────────

  /**
   * How the service is exposed (e.g., 'ClusterIP', 'NodePort', 'LoadBalancer').
   * Populated for Service resources.
   */
  serviceType?: string;

  /** Cluster-internal IP assigned to the service. Populated for Service resources. */
  clusterIp?: string;

  /** Ports exposed by the Service. Populated for Service resources. */
  @identifiers(#["name"])
  servicePorts?: ServicePort[];

  /**
   * Label selector routing traffic to pods backing this Service.
   * Populated for Service resources.
   */
  @identifiers(#["name"])
  serviceSelector?: KubernetesMapEntry[];

  /** External IP addresses accepted by cluster nodes for this Service. Populated for Service resources. */
  externalIps?: string[];

  /** DNS CNAME alias target for ExternalName Services. Populated for Service resources. */
  externalName?: string;

  /**
   * Traffic routing policy for externally-facing addresses ('Cluster' or 'Local').
   * Populated for Service resources.
   */
  externalTrafficPolicy?: string;

  /** Load balancer implementation class identifier. Populated for LoadBalancer Service resources. */
  loadBalancerClass?: string;

  /**
   * Static IP address requested from the cloud provider for a LoadBalancer Service.
   * Deprecated in Kubernetes 1.24 in favor of spec.loadBalancerIP on the Service.
   * Populated for LoadBalancer Service resources.
   */
  loadBalancerIp?: string;

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

  // ── Job / CronJob ─────────────────────────────────────────────────────────────

  /**
   * Total successful pod completions required for the Job to succeed.
   * Populated for Job resources.
   */
  completions?: int32;

  /**
   * Maximum number of pods running concurrently for a Job.
   * Populated for Job resources.
   */
  parallelism?: int32;

  /**
   * Number of retries before marking the Job as failed.
   * Populated for Job resources.
   */
  backoffLimit?: int32;

  /**
   * Cron schedule expression.
   * Populated for CronJob resources.
   */
  schedule?: string;

  /**
   * Concurrency policy for simultaneous CronJob runs ('Allow', 'Forbid', or 'Replace').
   * Populated for CronJob resources.
   */
  concurrencyPolicy?: string;

  /**
   * When true, future executions are suspended.
   * Populated for CronJob and Job resources.
   */
  suspend?: boolean;

  /**
   * Maximum duration in seconds before the Job is terminated regardless of its success.
   * Populated for Job resources.
   */
  activeDeadlineSeconds?: int32;

  /**
   * Completion tracking mode for Job pods: 'NonIndexed' (default) or 'Indexed'.
   * Populated for Job resources.
   */
  completionMode?: string;

  /**
   * Seconds after Job completion before the Job and its pods are deleted automatically.
   * Populated for Job resources.
   */
  ttlSecondsAfterFinished?: int32;

  /**
   * IANA time zone name for CronJob scheduling (e.g., 'America/New_York', 'UTC').
   * Populated for CronJob resources.
   */
  timeZone?: string;

  /**
   * Deadline in seconds for a CronJob run to start if missed; missed runs are ignored beyond this window.
   * Populated for CronJob resources.
   */
  startingDeadlineSeconds?: int32;

  // ── Storage (PVC / PV / StorageClass) ─────────────────────────────────────────

  /**
   * Storage access modes requested or granted
   * (e.g., 'ReadWriteOnce', 'ReadOnlyMany', 'ReadWriteMany').
   * Populated for PersistentVolumeClaim and PersistentVolume resources.
   */
  accessModes?: string[];

  /**
   * Name of the StorageClass for dynamic provisioning or PVC-to-PV binding.
   * Populated for PVC, PV, and StorageClass resources.
   */
  storageClassName?: string;

  /**
   * Storage quantity requested by a PVC (e.g., '10Gi').
   * Populated for PersistentVolumeClaim resources.
   */
  storageRequest?: string;

  /**
   * Total storage capacity of a PV (e.g., '100Gi').
   * Populated for PersistentVolume resources.
   */
  storageCapacity?: string;

  /**
   * Reclaim policy for a PV after its claim is released ('Retain', 'Delete', or 'Recycle').
   * Populated for PersistentVolume and StorageClass resources.
   */
  reclaimPolicy?: string;

  /**
   * Volume mode describing how the volume is used ('Filesystem' or 'Block').
   * Populated for PVC and PV resources.
   */
  volumeMode?: string;

  /**
   * For a PVC: the name of the PV it is bound to.
   * For a PV: the name of the PVC bound to it.
   */
  boundVolumeName?: string;

  /**
   * Namespace of the PVC bound to a PV (populated in PV claimRef).
   * Populated for PersistentVolume resources.
   */
  claimRefNamespace?: string;

  /**
   * CSI driver name managing this PersistentVolume (e.g., 'disk.csi.azure.com').
   * Populated for PersistentVolume resources backed by a CSI driver.
   */
  csiDriver?: string;

  /**
   * Unique volume handle assigned by the CSI driver.
   * Populated for PersistentVolume resources backed by a CSI driver.
   */
  csiVolumeHandle?: string;

  /**
   * CSI driver (provisioner) name for a StorageClass (e.g., 'disk.csi.azure.com').
   * Populated for StorageClass resources.
   */
  provisioner?: string;

  /**
   * When to bind a PV to a PVC: 'Immediate' binds on creation;
   * 'WaitForFirstConsumer' delays until a pod claims the PVC.
   * Populated for StorageClass resources.
   */
  volumeBindingMode?: string;

  /**
   * When true, PVCs using this StorageClass may be expanded after provisioning.
   * Populated for StorageClass resources.
   */
  allowVolumeExpansion?: boolean;

  /**
   * Kubernetes Secret type (e.g., 'Opaque', 'kubernetes.io/tls', 'kubernetes.io/service-account-token').
   * Populated for Secret resources.
   */
  secretType?: string;

  // ── ConfigMap ──────────────────────────────────────────────────────────────

  /**
   * String key-value pairs from the Kubernetes ConfigMap data field (mirrors ConfigMap.data).
   * Each entry is a UTF-8 string key and its value.
   * Populated for ConfigMap resources.
   */
  @identifiers(#["name"])
  configMapData?: KubernetesMapEntry[];

  /**
   * String key-value pairs from the Kubernetes ConfigMap binaryData field (mirrors ConfigMap.binaryData).
   * BinaryData can contain byte sequences that are not in the UTF-8 range.
   */
  @identifiers(#["name"])
  configMapBinaryData?: KubernetesMapEntry[];

  /**
   * When true, the ConfigMap is immutable and cannot be updated after creation.
   * Populated for ConfigMap resources.
   */
  configMapImmutable?: boolean;

  // ── ServiceAccount ─────────────────────────────────────────────────────────

  /**
   * When false, prevents the default Kubernetes service account token from being
   * auto-mounted into pods running as this ServiceAccount.
   * Populated for ServiceAccount resources.
   */
  automountServiceAccountToken?: boolean;

  // ── VolumeAttachment ────────────────────────────────────────────────────────

  /**
   * Name of the CSI driver that should attach/detach the volume (e.g., 'disk.csi.azure.com').
   * Populated for VolumeAttachment resources.
   */
  attacherName?: string;

  /**
   * Name of the PersistentVolume being attached.
   * Populated for VolumeAttachment resources.
   */
  attachedVolumeName?: string;

  // ── Ingress / NetworkPolicy ───────────────────────────────────────────────────

  /**
   * Name of the IngressClass that governs this Ingress resource.
   * Populated for Ingress resources.
   */
  ingressClassName?: string;

  /**
   * Routing rules mapping hostnames and URL paths to backend Services.
   * Populated for Ingress resources.
   */
  @identifiers(#[])
  ingressRules?: IngressRule[];

  /**
   * TLS termination configuration for Ingress resources.
   * Populated for Ingress resources.
   */
  @identifiers(#[])
  ingressTls?: IngressTls[];

  /**
   * Backend Service name to route traffic when no rule matches.
   * Populated for Ingress resources.
   */
  defaultBackendServiceName?: string;

  /**
   * Backend Service port to route traffic when no rule matches (number or named port).
   * Populated for Ingress resources.
   */
  defaultBackendServicePort?: string;

  /**
   * Controller class reference for an IngressClass (e.g., 'nginx.ingress.kubernetes.io/controller').
   * Populated for IngressClass resources.
   */
  ingressController?: string;

  /**
   * Label selector identifying the pods this NetworkPolicy applies to.
   * Populated for NetworkPolicy resources.
   */
  @identifiers(#["name"])
  podSelectorLabels?: KubernetesMapEntry[];

  /**
   * Policy directions enforced ('Ingress', 'Egress', or both).
   * Populated for NetworkPolicy resources.
   */
  networkPolicyTypes?: string[];

  // ── RBAC (Role / RoleBinding / ClusterRole / ClusterRoleBinding) ──────────────

  /**
   * RBAC permission rules granting access to Kubernetes API resources.
   * Populated for Role and ClusterRole resources.
   */
  @identifiers(#[])
  rbacRules?: PolicyRule[];

  /**
   * Subjects (users, groups, service accounts) granted permissions by this binding.
   * Populated for RoleBinding and ClusterRoleBinding resources.
   */
  @identifiers(#[])
  rbacSubjects?: RbacSubject[];

  /**
   * Kind of the role referenced by a binding ('Role' or 'ClusterRole').
   * Populated for RoleBinding and ClusterRoleBinding resources.
   */
  rbacRoleRefKind?: string;

  /**
   * Name of the role referenced by a binding.
   * Populated for RoleBinding and ClusterRoleBinding resources.
   */
  rbacRoleRefName?: string;

  // ── HPA / PDB / PriorityClass ────────────────────────────────────────────────

  /**
   * Kind of the resource being autoscaled (e.g., 'Deployment', 'StatefulSet').
   * Populated for HorizontalPodAutoscaler resources.
   */
  scaleTargetRefKind?: string;

  /**
   * Name of the resource being autoscaled.
   * Populated for HorizontalPodAutoscaler resources.
   */
  scaleTargetRefName?: string;

  /**
   * Minimum replica count for autoscaling.
   * Populated for HorizontalPodAutoscaler resources.
   */
  minReplicas?: int32;

  /**
   * Maximum replica count for autoscaling.
   * Populated for HorizontalPodAutoscaler resources.
   */
  maxReplicas?: int32;

  /**
   * Minimum number of pods that must remain available during voluntary disruptions
   * (absolute number or percentage string, e.g., '2', '50%').
   * Populated for PodDisruptionBudget resources.
   */
  minAvailable?: string;

  /**
   * Maximum number of pods that may be simultaneously unavailable during voluntary disruptions.
   * Populated for PodDisruptionBudget resources.
   */
  maxUnavailablePods?: string;

  /**
   * Numeric scheduling priority value for a PriorityClass.
   * Populated for PriorityClass resources.
   */
  priorityValue?: int32;

  /**
   * When true, this PriorityClass is the cluster default for pods without an explicit priorityClassName.
   * Populated for PriorityClass resources.
   */
  globalDefault?: boolean;

  /**
   * Preemption policy for pods with this priority class when system resources are scarce
   * ('PreemptLowerPriority' or 'Never').
   * Populated for PriorityClass resources.
   */
  preemptionPolicy?: string;

  // ── Node ──────────────────────────────────────────────────────────────────────

  /**
   * Taints applied to the node, repelling pods that lack a matching toleration.
   * Populated for Node resources.
   */
  @identifiers(#[])
  taints?: NodeTaint[];

  /**
   * When true, the node is cordoned and will not accept new pod scheduling.
   * Populated for Node resources.
   */
  unschedulable?: boolean;

  /**
   * Cloud provider identifier for the node
   * (e.g., 'azure:///subscriptions/.../virtualMachines/vm-0').
   * Populated for Node resources.
   */
  providerId?: string;

  /**
   * IP range assigned to pods running on this node.
   * Populated for Node resources.
   */
  podCidr?: string;

  // ── EndpointSlice ──────────────────────────────────────────────────────────

  /**
   * Address family for all endpoints in this EndpointSlice ('IPv4', 'IPv6', or 'FQDN').
   * Populated for EndpointSlice resources.
   */
  endpointSliceAddressType?: string;

  /**
   * Endpoints contained in this EndpointSlice.
   * Populated for EndpointSlice resources.
   */
  @identifiers(#[])
  endpointSliceEndpoints?: EndpointSliceEndpoint[];

  /**
   * Ports exposed by the endpoints in this EndpointSlice.
   * Populated for EndpointSlice resources.
   */
  @identifiers(#["name"])
  endpointSlicePorts?: EndpointSlicePort[];

  // ── CertificateSigningRequest ──────────────────────────────────────────────

  /**
   * Name of the signer that will sign the certificate (e.g., 'kubernetes.io/kube-apiserver-client').
   * Populated for CertificateSigningRequest resources.
   */
  csrSignerName?: string;

  /**
   * Name of the user that created the CertificateSigningRequest.
   * Populated for CertificateSigningRequest resources.
   */
  csrUsername?: string;

  /**
   * Key usages requested for the certificate (e.g., 'client auth', 'server auth', 'digital signature').
   * Populated for CertificateSigningRequest resources.
   */
  csrUsages?: string[];

  /**
   * Requested duration in seconds for the issued certificate.
   * Populated for CertificateSigningRequest resources.
   */
  csrExpirationSeconds?: int32;

  // ── CSIStorageCapacity ────────────────────────────────────────────────────

  /**
   * Available storage capacity for the StorageClass in this topology segment (e.g., '500Gi').
   * Populated for CSIStorageCapacity resources.
   */
  storageCapacityAvailable?: string;

  /**
   * Maximum size of a single volume that can be created in this topology segment.
   * Populated for CSIStorageCapacity resources.
   */
  maximumVolumeSize?: string;

  // ── ValidatingAdmissionPolicy ─────────────────────────────────────────────

  /**
   * What happens when a policy evaluation fails: 'Fail' rejects the request; 'Ignore' allows it.
   * Populated for ValidatingAdmissionPolicy resources.
   */
  admissionPolicyFailurePolicy?: string;

  /**
   * API resource rules that trigger this ValidatingAdmissionPolicy
   * (e.g., 'CREATE pods', 'UPDATE deployments').
   * Each entry is a human-readable summary of a resource rule.
   * Populated for ValidatingAdmissionPolicy resources.
   */
  admissionPolicyMatchConstraints?: string[];

  // ── ValidatingAdmissionPolicyBinding ─────────────────────────────────────

  /**
   * Name of the ValidatingAdmissionPolicy this binding applies.
   * Populated for ValidatingAdmissionPolicyBinding resources.
   */
  admissionPolicyBindingPolicyName?: string;

  /**
   * How validation failures are enforced: 'Deny', 'Warn', or 'Audit'.
   * Populated for ValidatingAdmissionPolicyBinding resources.
   */
  admissionPolicyValidationActions?: string[];

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
 * directly. Fields not covered by any typed property can be placed in additionalFields.
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

  /** Total non-terminating pods targeted by this workload. Populated for Deployment, StatefulSet, ReplicaSet. */
  replicas?: int32;

  /** Number of pods ready to serve requests. Populated for Deployment, StatefulSet, DaemonSet. */
  readyReplicas?: int32;

  /** Number of pods available for at least minReadySeconds. Populated for Deployment, DaemonSet, StatefulSet. */
  availableReplicas?: int32;

  /** Pods running the current (desired) template spec. Populated for Deployment, StatefulSet, DaemonSet. */
  updatedReplicas?: int32;

  /** Pods required but not yet available. Populated for Deployment resources. */
  unavailableReplicas?: int32;

  /**
   * Pods running the previous revision (before update completes).
   * Populated for StatefulSet resources.
   */
  currentReplicas?: int32;

  /**
   * Name of the StatefulSet revision corresponding to currentReplicas.
   * Populated for StatefulSet resources.
   */
  currentRevision?: string;

  /**
   * Name of the StatefulSet revision applied to updatedReplicas.
   * Populated for StatefulSet resources.
   */
  updateRevision?: string;

  /**
   * Desired replica count calculated by the HorizontalPodAutoscaler.
   * Populated for HorizontalPodAutoscaler resources.
   */
  desiredReplicas?: int32;

  /**
   * Pods that are terminating but not yet removed from the endpoints.
   * Populated for Deployment and ReplicaSet resources.
   */
  terminatingReplicas?: int32;

  // ── DaemonSet scheduling counters ────────────────────────────────────────────

  /** Total nodes that should run the daemon pod. Populated for DaemonSet resources. */
  desiredNumberScheduled?: int32;

  /** Nodes running at least one daemon pod. Populated for DaemonSet resources. */
  currentNumberScheduled?: int32;

  /** Nodes with a Ready daemon pod. Populated for DaemonSet resources. */
  numberReady?: int32;

  /**
   * Nodes running the daemon pod that should not be running it.
   * Populated for DaemonSet resources.
   */
  numberMisscheduled?: int32;

  /** Nodes missing an available daemon pod. Populated for DaemonSet resources. */
  numberUnavailable?: int32;

  // ── Pod ─────────────────────────────────────────────────────────────────────

  /** IP address allocated to the pod within the cluster. Populated for Pod resources. */
  podIp?: string;

  /** Additional pod IPs assigned in multi-network or dual-stack clusters. Populated for Pod resources. */
  podIps?: string[];

  /** IP address of the node hosting the pod. Populated for Pod resources. */
  hostIp?: string;

  /** Additional host IPs for dual-stack nodes. Populated for Pod resources. */
  hostIps?: string[];

  /** UTC timestamp when the pod was accepted by the scheduler. Populated for Pod resources. */
  startTime?: utcDateTime;

  /**
   * Runtime status of each container in the pod.
   * Populated for Pod resources.
   */
  @identifiers(#["name"])
  containerStatuses?: ContainerStatus[];

  /**
   * Runtime status of each init container in the pod.
   * Populated for Pod resources.
   */
  @identifiers(#["name"])
  initContainerStatuses?: ContainerStatus[];

  /**
   * QoS class assigned by Kubernetes based on resource requests and limits.
   * One of 'Guaranteed', 'Burstable', or 'BestEffort'. Populated for Pod resources.
   */
  qosClass?: string;

  /**
   * Brief CamelCase reason for the pod's current state (e.g., 'Evicted', 'OOMKilled').
   * Populated for Pod resources.
   */
  reason?: string;

  /**
   * Most recent generation observed by the controller.
   * Populated for Deployment, StatefulSet, DaemonSet, and Pod resources.
   */
  observedGeneration?: int64;

  // ── Job / CronJob ─────────────────────────────────────────────────────────────

  /** Number of currently active (running or pending) pods. Populated for Job resources. */
  activeJobCount?: int32;

  /** Number of pods that completed successfully. Populated for Job resources. */
  succeededJobCount?: int32;

  /** Number of pods that failed. Populated for Job resources. */
  failedJobCount?: int32;

  /** Number of pods in ready state for a Job. Populated for Job resources. */
  readyPods?: int32;

  /** UTC timestamp when the Job started executing. Populated for Job resources. */
  jobStartTime?: utcDateTime;

  /** UTC timestamp when the Job completed successfully. Populated for Job resources. */
  jobCompletionTime?: utcDateTime;

  /** UTC timestamp when the CronJob last successfully scheduled a Job. */
  lastScheduleTime?: utcDateTime;

  /** UTC timestamp when the last Job triggered by this CronJob completed successfully. */
  lastSuccessfulTime?: utcDateTime;

  // ── Service / Ingress ─────────────────────────────────────────────────────────

  /**
   * External IP addresses or hostnames assigned to LoadBalancer Services or Ingress resources.
   * Populated for Service (type LoadBalancer) and Ingress resources.
   */
  loadBalancerIngress?: string[];

  /**
   * UTC timestamp of the most recent scaling event triggered by the HPA.
   * Populated for HorizontalPodAutoscaler resources.
   */
  lastScaleTime?: utcDateTime;

  // ── Node ──────────────────────────────────────────────────────────────────────

  /**
   * Network addresses of the node (InternalIP, ExternalIP, Hostname).
   * Populated for Node resources.
   */
  @identifiers(#["address"])
  nodeAddresses?: NodeAddress[];

  /**
   * Operating system and runtime information for the node.
   * Populated for Node resources.
   */
  nodeInfo?: NodeSystemInfo;

  /**
   * Total hardware resources of the node (cpu, memory, pods, ephemeral-storage).
   * Populated for Node resources.
   */
  nodeCapacity?: NodeResourceMap;

  /**
   * Resources available for scheduling after system reservation.
   * Populated for Node resources.
   */
  nodeAllocatable?: NodeResourceMap;

  /**
   * Volumes that have been successfully attached to the node by the attach/detach controller.
   * Populated for Node resources.
   */
  @identifiers(#["name"])
  volumesAttached?: AttachedVolume[];

  // ── PDB ───────────────────────────────────────────────────────────────────────

  /** Currently healthy (Ready) pods counted by the PodDisruptionBudget. */
  currentHealthy?: int32;

  /** Minimum healthy pods required by the PodDisruptionBudget. */
  desiredHealthy?: int32;

  /** Number of pod disruptions currently allowed by the PodDisruptionBudget. */
  disruptionsAllowed?: int32;

  /** Total number of pods counted by the PodDisruptionBudget (ready + not ready). */
  expectedPods?: int32;

  // ── PVC ───────────────────────────────────────────────────────────────────────

  /**
   * Actual provisioned storage capacity for the PVC after binding (e.g., '10Gi').
   * Populated for PersistentVolumeClaim resources.
   */
  pvcCapacity?: string;

  /**
   * Access modes granted to the PVC after it is bound to a PV.
   * Populated for PersistentVolumeClaim resources.
   */
  pvcAccessModes?: string[];

  // ── VolumeAttachment ────────────────────────────────────────────────────────

  /**
   * When true, the volume is successfully attached to the target node.
   * Populated for VolumeAttachment resources.
   */
  volumeAttached?: boolean;

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
  type?: string;

  /** Short machine-readable reason for the event (e.g., 'Scheduled', 'Pulled', 'Failed'). */
  reason: string;

  /**
   * Human-readable elapsed time since the event last occurred
   * as reported by the Kubernetes API (e.g., '2m28s', '5h').
   */
  age?: string;

  /** Component that emitted the event. */
  from?: string;

  /** Human-readable description of the event. */
  message?: string;
}

// ─── ARM resource properties ──────────────────────────────────────────────────

/**
 * Properties of a single KubernetesResources ARM resource.
 * Each ARM resource represents one Kubernetes object from the cluster inventory.
 * The ARM resource name encodes the kind, Kubernetes name, and namespace
 * (e.g., 'pod-nginx-6d4cf56db6-x7q2p-default', 'upgrade-assessment-current-kube-system').
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "KubernetesResources is a read-only resource (GET/LIST only, no PUT) with no provisioning lifecycle, so provisioningState is intentionally omitted."
model KubernetesResourceProperties {
  /**
   * Kubernetes API version of the represented resource
   * (e.g., 'v1', 'apps/v1', 'upgrade.config.io/v1alpha1').
   */
  @visibility(Lifecycle.Read)
  apiVersion?: string;

  /** Kind of the Kubernetes resource (e.g., 'Pod', 'Deployment', 'Service'). */
  @visibility(Lifecycle.Read)
  kind?: string;

  /** Standard Kubernetes object metadata. */
  @visibility(Lifecycle.Read)
  metadata?: KubernetesObjectMeta;

  /** Desired state of the Kubernetes resource. */
  @visibility(Lifecycle.Read)
  spec?: KubernetesResourceSpec;

  /** Observed state of the Kubernetes resource, written by the controller. */
  @visibility(Lifecycle.Read)
  status?: KubernetesResourceStatus;

  /** Kubernetes events recorded against this resource. */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  events?: KubernetesEvent[];

  /** Name of the extension this inventory resource is attached to. */
  @visibility(Lifecycle.Read)
  attachedToExtension?: string;
}
