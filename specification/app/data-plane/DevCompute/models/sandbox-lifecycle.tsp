using TypeSpec.Versioning;

namespace AzureDevCompute {
  /** BatchSandboxRequest wire model. */
  @removed(ApiVersions.v2026_09_01)
  model BatchSandboxRequest {
    /** count value. */
    @removed(ApiVersions.v2026_09_01)
    @minValue(1)
    @maxValue(1000)
    count: int32;

    /** sandbox value. */
    @removed(ApiVersions.v2026_09_01)
    sandbox: SandboxRequest;
  }

  /** BatchSandboxResponse wire model. */
  @removed(ApiVersions.v2026_09_01)
  model BatchSandboxResponse {
    /** totalRequested value. */
    @removed(ApiVersions.v2026_09_01)
    totalRequested: int32;

    /** succeeded value. */
    @removed(ApiVersions.v2026_09_01)
    succeeded: int32;

    /** failed value. */
    @removed(ApiVersions.v2026_09_01)
    failed: int32;

    /** sandboxes value. */
    @removed(ApiVersions.v2026_09_01)
    sandboxes: SandboxFields[];

    /** errors value. */
    @removed(ApiVersions.v2026_09_01)
    errors: string[];
  }

  /** CPU usage counters and load averages. */
  model CpuStats {
    /** user value. */
    user?: int32;

    /** nice value. */
    nice?: int32;

    /** system value. */
    system?: int32;

    /** idle value. */
    idle?: int32;

    /** iowait value. */
    iowait?: int32;

    /** irq value. */
    irq?: int32;

    /** softirq value. */
    softirq?: int32;

    /** steal value. */
    steal?: int32;

    /** loadAvg1 value. */
    loadAvg1?: float64;

    /** loadAvg5 value. */
    loadAvg5?: float64;

    /** loadAvg15 value. */
    loadAvg15?: float64;
  }

  /** Filesystem usage for a single mount point. */
  model DiskStatsEntry {
    /** Mount path (e.g., "/containers/container-0/bundle/rootfs"). Deprecated: use Label instead. */
    mountPoint?: string;

    /** filesystem value. */
    filesystem?: string;

    /** totalBytes value. */
    totalBytes?: int32;

    /** usedBytes value. */
    usedBytes?: int32;

    /** availableBytes value. */
    availableBytes?: int32;

    /** Human-friendly display label (e.g., "container-0"). If set, UI should prefer this over MountPoint. */
    label?: string;
  }

  /** Memory statistics in bytes. */
  model MemoryStats {
    /** totalBytes value. */
    totalBytes?: int32;

    /** availableBytes value. */
    availableBytes?: int32;

    /** usedBytes value. */
    usedBytes?: int32;
  }

  /** Network I/O counters. */
  model NetworkStats {
    /** rxBytes value. */
    rxBytes?: int32;

    /** txBytes value. */
    txBytes?: int32;

    /** rxPackets value. */
    rxPackets?: int32;

    /** txPackets value. */
    txPackets?: int32;
  }

  /** SandboxExecuteCommandRequest wire model. */
  model SandboxExecuteCommandRequest {
    /** command value. */
    command: string;

    /** args value. */
    args?: string[];

    /** environment value. */
    environment?: Record<string>;

    /** workingDirectory value. */
    workingDirectory?: string;

    /** user value. */
    user?: string;

    /** activationMode value. */
    activationMode?: PortActivationMode;
  }

  /** SandboxExecuteCommandResponse wire model. */
  model SandboxExecuteCommandResponse {
    /** exitCode value. */
    exitCode: int32;

    /** stdout value. */
    stdout: string;

    /** stderr value. */
    stderr: string;

    /** executionTimeMs value. */
    executionTimeMs: int64;
  }

  /** SandboxExecuteShellCommandRequest wire model. */
  model SandboxExecuteShellCommandRequest {
    /** command value. */
    command: string;

    /** shell value. */
    shell?: string;

    /** environment value. */
    environment?: Record<string>;

    /** workingDirectory value. */
    workingDirectory?: string;

    /** user value. */
    user?: string;

    /** activationMode value. */
    activationMode?: PortActivationMode;
  }

  /** SandboxExecuteShellCommandResponse wire model. */
  model SandboxExecuteShellCommandResponse {
    /** exitCode value. */
    exitCode: int32;

    /** stdout value. */
    stdout: string;

    /** stderr value. */
    stderr: string;

    /** executionTimeMs value. */
    executionTimeMs: int64;
  }

  /** SandboxGenerateTokenRequest wire model. */
  @removed(ApiVersions.v2026_09_01)
  model SandboxGenerateTokenRequest {
    /** user value. */
    @removed(ApiVersions.v2026_09_01)
    user?: string;
  }

  /** SandboxGroupId wire model. */
  scalar SandboxGroupId extends string;

  /** SandboxResumeRequest wire model. */
  model SandboxResumeRequest {
    /** executionTokens value. */
    @removed(ApiVersions.v2026_09_01)
    executionTokens?: SandboxExecutionTokensRequest;
  }

  /** SandboxStatsResponse wire model. */
  model SandboxStatsResponse {
    /** tokenUsage value. */
    tokenUsage?: TokenUsageStats;

    /** cpu value. */
    cpu?: CpuStats;

    /** memory value. */
    memory?: MemoryStats;

    /** network value. */
    network?: NetworkStats;

    /** disk value. */
    disk?: DiskStatsEntry[];

    /** uptimeSecs value. */
    uptimeSecs?: float64;
  }

  /** SnapshotId wire model. */
  scalar SnapshotId extends string;

  /** Token usage statistics for a sandbox. */
  model TokenUsageStats {
    /** totalInputTokens value. */
    totalInputTokens?: int64;

    /** totalOutputTokens value. */
    totalOutputTokens?: int64;

    /** requestCount value. */
    requestCount?: int32;
  }
}
