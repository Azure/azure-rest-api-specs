import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./discoveryHub.tsp";
import "./models.tsp";
import "./application.tsp";
import "./common.tsp";
import "./member.tsp";
import "./routes.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Private.ApplicationMigration Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Private.ApplicationMigration management service" })
@versioned(PrivateApplicationMigration.Versions)
namespace PrivateApplicationMigration;

/** The available API versions. */
enum Versions {
  /** 2025-02-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_02_01_preview: "2025-02-01-preview",

  /** 2026-01-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_01_01_preview: "2026-01-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

// Re-export interfaces from Microsoft.ApplicationMigration namespace in private namespace
interface DiscoveryHubs extends Microsoft.ApplicationMigration.DiscoveryHubs {}
interface Applications extends Microsoft.ApplicationMigration.Applications {}
interface Members extends Microsoft.ApplicationMigration.Members {}
