import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "Authorization"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://storage.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Azure Tables" })
@server(
  "{url}",
  "The host name of the tables account, e.g. accountName.table.core.windows.net",
  {
    @doc("The host name of the tables account, e.g. accountName.table.core.windows.net")
    url: url,
  }
)
@versioned(Versions)
namespace Data.Tables;

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Following standard typespec recommendation"
#suppress "@azure-tools/typespec-azure-core/no-enum" "Following standard typespec recommendation"
@doc("The Azure Tables service versions.")
enum Versions {
  @doc("The 2019-02-02 version of the Azure.Data.Tables service.")
  v2019_02_02: "2019-02-02",
}
