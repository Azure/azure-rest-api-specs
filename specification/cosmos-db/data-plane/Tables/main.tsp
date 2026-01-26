import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://storage.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Azure Tables service" })
@server(
  "{endpoint}",
  "The host name of the tables account, e.g. accountName.table.core.windows.net",
  {
    @doc("The host name of the tables account, e.g. accountName.table.core.windows.net")
    endpoint: url,
  }
)
@versioned(Versions)
namespace Data.Tables;

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Following standard typespec recommendation"
#suppress "@azure-tools/typespec-azure-core/no-enum" "Following standard typespec recommendation"
@doc("The Azure Tables service versions.")
enum Versions {
  @doc("The 2020-12-06 version of the Azure.Data.Tables service.")
  v2020_12_06: "2020-12-06",
}
