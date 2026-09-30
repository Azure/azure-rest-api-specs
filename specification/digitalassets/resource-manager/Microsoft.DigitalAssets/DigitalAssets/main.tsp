import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./versions.tsp";
import "./models.tsp";
import "./rollup.tsp";
import "./partition.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace("Microsoft.DigitalAssets")
@service(#{ title: "Microsoft.DigitalAssets" })
@versioned(ApiVersion)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.DigitalAssets;
