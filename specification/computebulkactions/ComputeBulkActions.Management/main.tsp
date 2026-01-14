import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./routes.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.ComputeBulkActions" })
@doc("Microsoft.ComputeBulkActions Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.ComputeBulkActions;

/** BulkActions API versions */
// Order matters here as versions lower in the enum list will inherit models and routes from versions above it
enum Versions {
  /** 2026-02-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  `2026-02-01-preview`,
}
