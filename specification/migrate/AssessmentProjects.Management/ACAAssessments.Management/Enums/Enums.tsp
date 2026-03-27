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

@doc("Pricing Tier for Azure.")
union PricingTier {
  @doc("Standard Pricing Tier.")
  Standard: "Standard",

  @doc("Free Pricing Tier.")
  Free: "Free",

  string,
}

@doc("Workload Profile Type for Azure Container Apps.")
union ACAWorkloadProfileType {
  @doc("Consumption workload profile — up to 4 vCPUs, 8 GiB memory.")
  Consumption: "Consumption",

  @doc("Dedicated workload profile.")
  Dedicated: "Dedicated",

  string,
}

@doc("Workload Profile SKU for Azure Container Apps.")
union ACAWorkloadProfileSku {
  @doc("Consumption workload profile.")
  Consumption: "Consumption",

  @doc("Dedicated D4 — General purpose D-series.")
  DedicatedD4: "Dedicated-D4",

  @doc("Dedicated D8 — General purpose D-series.")
  DedicatedD8: "Dedicated-D8",

  @doc("Dedicated D16 — General purpose D-series.")
  DedicatedD16: "Dedicated-D16",

  @doc("Dedicated D32 — General purpose D-series.")
  DedicatedD32: "Dedicated-D32",

  @doc("Dedicated E4 — Memory optimized E-series.")
  DedicatedE4: "Dedicated-E4",

  @doc("Dedicated E8 — Memory optimized E-series.")
  DedicatedE8: "Dedicated-E8",

  @doc("Dedicated E16 — Memory optimized E-series.")
  DedicatedE16: "Dedicated-E16",

  @doc("Dedicated E32 — Memory optimized E-series.")
  DedicatedE32: "Dedicated-E32",

  string,
}
