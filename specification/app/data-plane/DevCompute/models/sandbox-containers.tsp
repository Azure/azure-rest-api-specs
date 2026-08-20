using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

/** Probe configuration for checking a container's startup, liveness, or readiness state. */
model ContainerProbe {
  @oneOf httpGet?: null | ProbeHttpGetAction;
  @oneOf exec?: null | ProbeExecAction;
  @oneOf tcpSocket?: null | ProbeTcpSocketAction;
  initialDelaySeconds?: NullableInt32OrString;
  periodSeconds?: NullableInt32OrString;
  timeoutSeconds?: NullableInt32OrString;
  failureThreshold?: NullableInt32OrString;
  successThreshold?: NullableInt32OrString;
  terminationGracePeriodSeconds?: NullableInt32OrString;
}

union ContainerProbeResult {
  "Success",
  "Failure",
  "Unknown",
  null,
}

/** Runtime status for a configured container probe. */
model ContainerProbeStatusView {
  @oneOf lastResult?: null | ContainerProbeResult;
  consecutiveFailures?: Int32OrString = 0;
  consecutiveSuccesses?: Int32OrString = 0;
  lastCheckedAt?: null | utcDateTime;
  lastTransitionAt?: null | utcDateTime;
  message?: null | string;
}

/**
 * Per-container resource configuration.
 * CPU and Memory set cgroup limits inside the VM. Disk controls writable layer sizing.
 */
model ContainerResourcesView {
  /** Kubernetes-style CPU resource quantity string (e.g. "500m", "2", "0.5"). */
  cpu?: unknown;

  /** Kubernetes-style memory resource quantity string (e.g. "256Mi", "1Gi", "2048"). */
  memory?: unknown;

  /** Kubernetes-style storage/disk resource quantity string (e.g. "256Mi", "1Gi", "2048"). */
  disk?: unknown;
}

union ContainerRestartPolicy {
  "Always",
  "OnFailure",
  "Never",
  null,
}

/** Customer-facing container runtime state. */
union ContainerRuntimeState {
  "Unknown",
  "Waiting",
  "Running",
  "Terminated",
}

/**
 * Container-level security context — overrides pod-level settings where applicable.
 * Follows Kubernetes container securityContext semantics.
 */
model ContainerSecurityContext {
  runAsUser?: NullableInt32OrString;
  runAsGroup?: NullableInt32OrString;
  runAsNonRoot?: null | boolean;
  privileged?: boolean;
  @oneOf capabilities?: null | LinuxCapabilities;
  allowPrivilegeEscalation?: boolean = true;
  readOnlyRootFilesystem?: boolean;
  @oneOf seccompProfile?: null | SeccompProfile;
}

/** Per-container specification within a pod source. */
model ContainerSpecView {
  name: PodContainerName;
  diskImage: SandboxSourceDiskImageView;
  command?: null | string[];
  args?: null | string[];
  env?: null | Record<string>;
  @oneOf resources?: null | ContainerResourcesView;
  volumeMounts?: null | ContainerVolumeMountView[];
  contentPackageDownloads?: null | SandboxContentPackageDownloadView[];
  @oneOf securityContext?: null | ContainerSecurityContext;
  @oneOf startupProbe?: null | ContainerProbe;
  @oneOf livenessProbe?: null | ContainerProbe;
  @oneOf readinessProbe?: null | ContainerProbe;
}

union ContainerStatusReason {
  "Completed",
  "Error",
  "CrashLoopBackOff",
  "RootfsResetPending",
  "RootfsResetFailed",
  null,
}

/** Runtime status for one pod container. */
model ContainerStatusView {
  name: PodContainerName;
  state: ContainerRuntimeState;
  ready: boolean;
  started: boolean;
  restartCount: Int32OrString;
  @oneOf reason?: null | ContainerStatusReason;
  message?: null | string;
  lastExitCode?: NullableInt32OrString;
  lastStartedAt?: null | utcDateTime;
  lastFinishedAt?: null | utcDateTime;
  probes?: null | Record<ContainerProbeStatusView>;
}

/**
 * User-provided container name within a pod.
 * DNS label format: lowercase alphanumeric + hyphens, 1-63 chars, must start and end with alphanumeric.
 */
scalar PodContainerName;

/**
 * Pod-level security context — applies to all containers unless overridden at the container level.
 * Follows Kubernetes pod securityContext semantics.
 */
model PodSecurityContext {
  runAsUser?: NullableInt32OrString;
  runAsGroup?: NullableInt32OrString;
  runAsNonRoot?: null | boolean;
  supplementalGroups?: NullableInt32OrStringArray;
  fsGroup?: NullableInt32OrString;
  @oneOf fsGroupChangePolicy?: null | FsGroupChangePolicy;
}

/** Exec probe handler that runs a command in the container. */
model ProbeExecAction {
  command: string[];
}

/** HTTP GET probe handler executed from inside the container VM. */
model ProbeHttpGetAction {
  port: SandboxPort;
  path?: null | string;
  host?: null | string;
  scheme?: null | string;
  httpHeaders?: null | ProbeHttpHeader[];
}

/** HTTP header sent with a probe HTTP GET request. */
model ProbeHttpHeader {
  name: string;
  value: string;
}

/** TCP socket probe handler that checks whether a port accepts connections. */
model ProbeTcpSocketAction {
  port: SandboxPort;
  host?: null | string;
}

/** Pod source for sandbox creation. */
model SandboxSourcePodView {
  containers: ContainerSpecView[];
  volumes?: null | PodVolumeView[];
  contentPackages?: null | PodContentPackageView[];
  @oneOf securityContext?: null | PodSecurityContext;
  @oneOf restartPolicy?: null | ContainerRestartPolicy;
}
