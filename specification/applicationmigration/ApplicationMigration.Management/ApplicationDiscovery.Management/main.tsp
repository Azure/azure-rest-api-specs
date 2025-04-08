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

/** Microsoft.ApplicationMigration Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.ApplicationMigration management service" })
@versioned(Microsoft.ApplicationMigration.Versions)
namespace Microsoft.ApplicationMigration;

/** The available API versions. */
enum Versions {
  /** 2025-02-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_02_01_preview: "2025-02-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
