import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.Compute" })
@doc("Microsoft.Compute ScheduledActions Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.Compute;

/** Microsoft.Compute ScheduledActions API versions */
enum Versions {
  /** 2026-06-24-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  `2026-06-24-preview`,
}
