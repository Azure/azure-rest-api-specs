import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.Sovereign;

@doc("The Microsoft Sovereign Provider version.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @doc("Preview version.")
  Preview20230928: "2023-09-28-preview",
}
