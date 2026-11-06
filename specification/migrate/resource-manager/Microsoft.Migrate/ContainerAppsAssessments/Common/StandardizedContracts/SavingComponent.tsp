@doc("Class to represent the component of the cost.")
model SavingComponent {
  @doc("Gets the name of the component.")
  @visibility(Lifecycle.Read)
  name?: SavingComponentName;

  @doc("The value of the component.")
  value?: float32;

  @doc("The textual description of the component.")
  description?: string;
}

@doc("Saving Component Name")
union SavingComponentName {
  @doc("MonthlyLinuxAzureHybridCostSavings - Savings Component")
  MonthlyLinuxAzureHybridCostSavings: "MonthlyLinuxAzureHybridCostSavings",

  @doc("MonthlyAzureHybridCostSavings - Savings Component")
  MonthlyAzureHybridCostSavings: "MonthlyAzureHybridCostSavings",

  string,
}
