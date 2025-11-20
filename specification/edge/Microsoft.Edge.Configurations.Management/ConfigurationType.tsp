namespace Microsoft.Edge;

@doc("Available configuration types")
union ConfigurationType {
  @doc("Configuration type Shared")
  Shared: "Shared",

  @doc("Configuration type Hierarchy")
  Hierarchy: "Hierarchy",

  string,
}
