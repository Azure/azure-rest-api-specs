import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">
)
@service({
  title: "Azure.AI.DocumentTranslation service",
})
@versioned(DocumentTranslation.Versions)
namespace DocumentTranslation;

@doc("The Azure.AI.DocumentTranslation service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2023-11-01-preview version of the Azure.AI.DocumentTranslation service.")
  `2023-11-01-preview`,
}
