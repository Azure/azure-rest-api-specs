@doc("Class to represent the component of the cost.")
model CostComponent {
    @doc("Gets the name of the component.")
    @visibility("read")
    name?: CostComponentName;

    @doc("The value of the component.")
    value?: float32;

    @doc("The textual description of the component.")
    description?: string;
}

enum CostComponentName {
    "Unknown",
    "MonthlyAzureHybridCostSavings",
}
