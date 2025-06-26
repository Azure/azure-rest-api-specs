import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./applink.tsp";
import "./applinkmember.tsp";
import "./applinkreleasechannelprofile.tsp";

using Versioning;
using Azure.ResourceManager;

/** Microsoft.AppLink Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.AppLink management service" })
@versioned(Microsoft.AppLink.Versions)
namespace Microsoft.AppLink;

/** The available API versions. */
enum Versions {
  /** 2025-08-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_10_01_preview: "2025-08-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
