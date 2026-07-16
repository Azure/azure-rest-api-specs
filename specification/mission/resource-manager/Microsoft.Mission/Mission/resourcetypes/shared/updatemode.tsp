using Azure.ResourceManager;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Update Mode")
union UpdateMode {
  string,

  @doc("UpdateMode Type Automatic")
  Automatic: "Automatic",

  @doc("UpdateMode Type Manual")
  Manual: "Manual",
}
