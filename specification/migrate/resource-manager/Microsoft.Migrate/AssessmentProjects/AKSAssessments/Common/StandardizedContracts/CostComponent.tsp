@doc("Class to represent the component of the cost.")
model CostComponent {
  @doc("Gets the name of the component.")
  @visibility(Lifecycle.Read)
  name?: CostComponentName;

  @doc("The value of the component.")
  value?: float32;

  @doc("The textual description of the component.")
  description?: string;
}

@doc("Cost Component Name")
union CostComponentName {
  @doc("Unknown Cost Component")
  Unknown: "Unknown",

  @doc("Monthly Azure Hybrid Cost Savings")
  MonthlyAzureHybridCostSavings: "MonthlyAzureHybridCostSavings",

  @doc("Monthly Security Cost")
  MonthlySecurityCost: "MonthlySecurityCost",

  @doc("Monthly Premium V2 Storage Cost")
  MonthlyPremiumV2StorageCost: "MonthlyPremiumV2StorageCost",

  @doc("Monthly Linux Azure Hybrid Cost Savings")
  MonthlyLinuxAzureHybridCostSavings: "MonthlyLinuxAzureHybridCostSavings",

  @doc("Monthly Avs Node Cost")
  MonthlyAvsNodeCost: "MonthlyAvsNodeCost",

  @doc("Monthly External Storage Cost")
  MonthlyExternalStorageCost: "MonthlyExternalStorageCost",

  @doc("Monthly Network Cost")
  MonthlyNetworkCost: "MonthlyNetworkCost",

  @doc("Monthly Vcf Byol Cost Difference")
  MonthlyVcfByolCostDifference: "MonthlyVcfByolCostDifference",

  string,
}
