namespace Microsoft.Migrate;

@doc("Readiness for Azure.")
union Readiness {
  @doc("Unknown Readiness.")
  Unknown: "Unknown",

  @doc("Not Ready.")
  NotReady: "NotReady",

  @doc("Ready with conditions.")
  ReadyWithConditions: "ReadyWithConditions",

  @doc("Ready for migration.")
  Ready: "Ready",

  string,
}

@doc("Operating System Type.")
union OSType {
  @doc("Linux OS Type.")
  Linux: "Linux",

  @doc("Windows OS Type.")
  Windows: "Windows",

  string,
}

@doc("Azure VM Category.")
union AzureVmCategory {
  @doc("Indicates All categories of VM.")
  All: "All",

  @doc("Compute Optimized.")
  ComputeOptimized: "ComputeOptimized",

  @doc("General Purpose.")
  GeneralPurpose: "GeneralPurpose",

  @doc("GPU Optimized.")
  GpuOptimized: "GpuOptimized",

  @doc("High Performance Compute.")
  HighPerformanceCompute: "HighPerformanceCompute",

  @doc("Memory Optimized.")
  MemoryOptimized: "MemoryOptimized",

  @doc("Storage Optimized.")
  StorageOptimized: "StorageOptimized",

  @doc("Isolated VM.")
  Isolated: "Isolated",

  string,
}

@doc("Consolidation Type.")
union ConsolidationType {
  @doc("Full Consolidation.")
  Full: "Full",

  @doc("As On Source or On Premises Consolidation.")
  AsOnSource: "AsOnSource",

  string,
}

@doc("Pricing Tier for Azure.")
union PricingTier {
  @doc("Standard Pricing Tier.")
  Standard: "Standard",

  @doc("Free Pricing Tier.")
  Free: "Free",

  string,
}

@doc("Node Pool Mode.")
union NodePoolMode {
  @doc("Indicates User node pool.")
  User: "User",

  @doc("Indicates System node pool.")
  System: "System",

  string,
}
