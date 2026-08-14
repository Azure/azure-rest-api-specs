import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Microsoft.Edge;

@added(Versions.v2025_08_01)
@doc("Configuration State Enums")
union ConfigurationState {
  @doc("Configuration Completed")
  ConfigurationCompleted: "ConfigurationCompleted",

  @doc("Configuration Completed")
  ConfigurationPending: "ConfigurationPending",

  string,
}
