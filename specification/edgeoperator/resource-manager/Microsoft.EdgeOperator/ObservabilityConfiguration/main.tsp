import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./observabilityConfiguration.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.EdgeOperator Resource Provider management API for Azure Local Disconnected Operations (ALDO) observability configuration. */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is published as part of same RP in SystemReadiness folder."
@armProviderNamespace
@service(#{
  title: "Microsoft.EdgeOperator - Azure Local Disconnected Operations observability configuration",
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
