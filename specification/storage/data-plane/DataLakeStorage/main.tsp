import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://storage.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Azure Data Lake Storage REST API" })
@server(
  "{url}",
  "The URL of the service account, container, or blob that is the target of the desired operation.",
  {
    @doc("The URL of the service account, container, or blob that is the target of the desired operation.")
    url: url,
  }
)
@versioned(Versions)
namespace Storage.DataLake;

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Following standard typespec recommendation"
#suppress "@azure-tools/typespec-azure-core/no-enum" "Following standard typespec recommendation"
@doc("The Azure Data Lake Storage service versions.")
enum Versions {
  @doc("The 2026-06-06 version of the Azure Data Lake Storage service.")
  v2026_06_06: "2026-06-06",
}
