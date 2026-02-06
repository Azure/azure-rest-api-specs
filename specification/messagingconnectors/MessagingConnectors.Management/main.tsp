import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./operations/connectors.tsp";
import "./operations/dataPreview.tsp";
import "./operations/fetchCdcSchema.tsp";
import "./operations/validation.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@doc("Microsoft.MessagingConnectors Resource Provider management API.")
@armProviderNamespace
@service(#{ title: "Microsoft.MessagingConnectors management service" })
@versioned(Versions)
namespace Microsoft.MessagingConnectors;

@doc("Microsoft.MessagingConnectors api versions.")
enum Versions {
  @doc("2026-01-01-preview version")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2026_01_01_preview: "2026-01-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
