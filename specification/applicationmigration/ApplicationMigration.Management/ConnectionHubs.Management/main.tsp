import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ConnectionHub.tsp";
import "./connectionHubRoutes.tsp";
import "./GitHubConnection.tsp";
import "./GitHubIssue.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.ApplicationMigration ConnectionHubs Resource Provider management API. */
@armProviderNamespace
@service(#{
  title: "Microsoft.ApplicationMigration ConnectionHubs management service",
})
@versioned(Microsoft.ApplicationMigration.Versions)
namespace Microsoft.ApplicationMigration;

/** The available API versions. */
enum Versions {
  /** 2025-09-09-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_09_09_preview: "2025-09-09-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
