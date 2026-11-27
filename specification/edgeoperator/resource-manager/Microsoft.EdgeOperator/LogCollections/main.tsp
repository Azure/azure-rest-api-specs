import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./logCollections.tsp";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.EdgeOperator management API for Azure Local Disconnected Operations log collection. */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "The shared provider Operations API is published by the sibling SystemReadiness project."
@armProviderNamespace
@service(#{
  title: "Microsoft.EdgeOperator - Azure Local Disconnected Operations log collection",
})
@versioned(Microsoft.EdgeOperator.Versions)
namespace Microsoft.EdgeOperator;

/** The available API versions. */
enum Versions {
  /** The 2026-06-01-preview API version. */
  @Azure.Core.previewVersion
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_06_01_preview: "2026-06-01-preview",
}
