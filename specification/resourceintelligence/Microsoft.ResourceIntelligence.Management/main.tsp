import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./agent.tsp";
import "./thread.tsp";
import "./run.tsp";
import "./message.tsp";
import "./query.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "Microsoft.ResourceIntelligence" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.ResourceIntelligence;

enum Versions {
  v2026_02_01_preview: "2026-02-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
