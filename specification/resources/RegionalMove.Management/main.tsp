import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models.tsp";
import "./routes.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API defined separately - namespace is shared between multiple services."
@armProviderNamespace("Microsoft.Resources")
@service(#{ title: "Regional Move Service Client" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace RegionalMoveClient;

enum Versions {
  v2026_01_01_preview: "2026-01-01-preview",
}
