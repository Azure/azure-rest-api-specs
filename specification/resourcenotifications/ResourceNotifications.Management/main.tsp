import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";
import "@typespec/openapi";
import "./ArnSubscriberApi.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

/** Microsoft.ResourceNotifications Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.ResourceNotifications Management Service" })
@versioned(Versions)
namespace Microsoft.ResourceNotifications;

/** The available API versions. */
enum Versions {
  /** The 2025-11-11-preview API version. */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_11_11_preview: "2025-11-11-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
