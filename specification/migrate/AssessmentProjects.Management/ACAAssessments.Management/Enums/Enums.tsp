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

  string,
}
