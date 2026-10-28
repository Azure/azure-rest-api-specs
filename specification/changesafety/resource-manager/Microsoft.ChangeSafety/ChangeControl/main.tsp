import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./stagemap.tsp";
import "./changemodels.tsp";
import "./changerecord.tsp";
import "./changerecordstageprogression.tsp";
import "./changeactivityevent.tsp";
import "./client.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.ChangeSafety Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.ChangeSafety management service" })
@versioned(Microsoft.ChangeSafety.Versions)
namespace Microsoft.ChangeSafety;

/** The available API versions. */
enum Versions {
  /** 2026-11-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @Azure.Core.previewVersion
  v2026_11_01_preview: "2026-11-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
