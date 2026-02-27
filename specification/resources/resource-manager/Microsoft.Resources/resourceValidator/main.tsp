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
@service(#{ title: "Resource Validation Client" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace ResourceValidationClient;

enum Versions {
  v2022_06_01: "2022-06-01",
}
