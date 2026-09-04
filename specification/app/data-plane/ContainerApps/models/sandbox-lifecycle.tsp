#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Response identifies a JSON response body; Result is reserved for HTTP response envelopes."
namespace ContainerAppsSandbox {
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

  /** ExecuteSandboxCommandContent wire model. */
  model ExecuteSandboxCommandContent {
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

  /** Execute-command response body. */
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

  /** ExecuteSandboxShellCommandContent wire model. */
  model ExecuteSandboxShellCommandContent {
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

  /** Execute-shell-command response body. */
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

  /** SandboxGroupId wire model. */
  scalar SandboxGroupId extends string;

  /** Sandbox statistics response body. */
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
