import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

/**
 * Microsoft Azure Resources Client
 */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API defined separately - namespace is shared between multiple services."
@armProviderNamespace("Microsoft.Resources")
@service(#{
  title: "Microsoft Azure Resources Client",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@doc("Provides operations for working with resources and resource groups.")
namespace Microsoft.Resources {

/** The API version. */
enum Versions {
  /** The 2025-04-01 stable API version. */
  v2025_04_01: "2025-04-01",

  /** The 2025-08-01-preview API version with batch operations. */
  v2025_08_01_preview: "2025-08-01-preview",
}

// Include all operations and models
}