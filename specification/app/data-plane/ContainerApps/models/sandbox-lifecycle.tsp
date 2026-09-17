namespace ContainerAppsSandbox {
  /** CPU usage counters and load averages. */
  model CpuStats {
    /** CPU time spent in user mode. */
    user?: int64;

    /** CPU time spent running prioritized user processes. */
    nice?: int64;

    /** CPU time spent in system mode. */
    system?: int64;

    /** CPU time spent idle. */
    idle?: int64;

    /** CPU time spent waiting for I/O. */
    iowait?: int64;

    /** CPU time spent handling hardware interrupts. */
    irq?: int64;

    /** CPU time spent handling software interrupts. */
    softirq?: int64;

    /** CPU time taken by the hypervisor. */
    steal?: int64;

    /** The one-minute load average. */
    loadAvg1?: float64;

    /** The five-minute load average. */
    loadAvg5?: float64;

    /** The fifteen-minute load average. */
    loadAvg15?: float64;
  }

  /** Filesystem usage for a single mount point. */
  model DiskStatsEntry {
    /** Mount path (e.g., "/containers/container-0/bundle/rootfs"). Deprecated: use Label instead. */
    mountPoint?: string;

    /** The filesystem type. */
    filesystem?: string;

    /** The total filesystem capacity in bytes. */
    totalBytes?: int64;

    /** The used filesystem capacity in bytes. */
    usedBytes?: int64;

    /** The available filesystem capacity in bytes. */
    availableBytes?: int64;

    /** Human-friendly display label (e.g., "container-0"). If set, UI should prefer this over MountPoint. */
    label?: string;
  }

  /** Memory statistics in bytes. */
  model MemoryStats {
    /** The total memory in bytes. */
    totalBytes?: int64;

    /** The available memory in bytes. */
    availableBytes?: int64;

    /** The used memory in bytes. */
    usedBytes?: int64;
  }

  /** Network I/O counters. */
  model NetworkStats {
    /** The number of bytes received. */
    rxBytes?: int64;

    /** The number of bytes transmitted. */
    txBytes?: int64;

    /** The number of packets received. */
    rxPackets?: int64;

    /** The number of packets transmitted. */
    txPackets?: int64;
  }

  /** A command to execute directly in a running sandbox. */
  model ExecuteSandboxCommandContent {
    /** The executable to run. */
    command: string;

    /** Arguments passed to the executable. */
    args?: string[];

    /** Environment variables for the command. */
    environment?: Record<string>;

    /** The working directory for the command. */
    workingDirectory?: string;

    /** The user that runs the command. */
    user?: string;

    /** The port activation behavior while the command runs. */
    activationMode?: PortActivationMode;
  }

  /** Result of executing a command in a sandbox. */
  model SandboxExecuteCommandResponse {
    /** The process exit code. */
    exitCode: int32;

    /** Text written to standard output. */
    stdout: string;

    /** Text written to standard error. */
    stderr: string;

    /** The command execution time in milliseconds. */
    executionTimeMs: int64;
  }

  /** A shell command to execute in a running sandbox. */
  model ExecuteSandboxShellCommandContent {
    /** The command line evaluated by the shell. */
    command: string;

    /** The shell executable to use. */
    shell?: string;

    /** Environment variables for the shell command. */
    environment?: Record<string>;

    /** The working directory for the shell command. */
    workingDirectory?: string;

    /** The user that runs the shell command. */
    user?: string;

    /** The port activation behavior while the command runs. */
    activationMode?: PortActivationMode;
  }

  /** Result of executing a shell command in a sandbox. */
  model SandboxExecuteShellCommandResponse {
    /** The process exit code. */
    exitCode: int32;

    /** Text written to standard output. */
    stdout: string;

    /** Text written to standard error. */
    stderr: string;

    /** The command execution time in milliseconds. */
    executionTimeMs: int64;
  }

  /** A sandbox group identifier. */
  scalar SandboxGroupId extends string;

  /** Current resource and network statistics for a sandbox. */
  model SandboxStatsResponse {
    /** Token usage reported by the sandbox. */
    tokenUsage?: TokenUsageStats;

    /** CPU usage and load statistics. */
    cpu?: CpuStats;

    /** Memory usage statistics. */
    memory?: MemoryStats;

    /** Network I/O statistics. */
    network?: NetworkStats;

    /** Filesystem usage by mount point. */
    disk?: DiskStatsEntry[];

    /** The sandbox uptime in seconds. */
    uptimeSecs?: float64;
  }

  /** A snapshot identifier. */
  scalar SnapshotId extends string;

  /** Token usage statistics for a sandbox. */
  model TokenUsageStats {
    /** The total number of input tokens processed. */
    totalInputTokens?: int64;

    /** The total number of output tokens generated. */
    totalOutputTokens?: int64;

    /** The number of requests included in the totals. */
    requestCount?: int32;
  }
}
