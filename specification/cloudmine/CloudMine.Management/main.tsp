import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./resources/operation.tsp";
import "./resources/organization.tsp";
import "./resources/project.tsp";
import "./resources/builddefinition.tsp";
import "./resources/builddefinitionrevision.tsp";
import "./resources/release.tsp";
import "./resources/releasedefinition.tsp";
import "./resources/releasedefinitionrevision.tsp";
import "./resources/repository.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.CloudMine Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.CloudMine management service" })
@versioned(Versions)
namespace Microsoft.CloudMine;

enum Versions {
  /** 2025-02-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_02_01_preview: "2025-02-01-preview",
}
