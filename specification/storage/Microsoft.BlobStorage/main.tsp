import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://storage.azure.com/.default"],
    }
  ]>
)
@service({
  title: "Azure.Storage.Blob service",
})
@server(
  "{endpoint}",
  "The host name of the blob storage account, e.g. accountName.blob.core.windows.net",
  {
    @doc("The host name of the blob storage account, e.g. accountName.blob.core.windows.net")
    endpoint: url,
  }
)
namespace Azure.Storage.Blob;

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Following standard typespec recommendation"
#suppress "@azure-tools/typespec-azure-core/no-enum" "Following standard typespec recommendation"
@doc("The Azure.Storage.Blob service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2020-10-02-preview version of the Azure.Storage.Blob service.")
  `2020-10-02-preview`,

  @doc("The 2020-12-06-preview version of the Azure.Storage.Blob service.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2020-12-06-preview`,

  @doc("The 2021-02-12-preview version of the Azure.Storage.Blob service.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2021-02-12-preview`,

  @doc("The 2021-04-10-preview version of the Azure.Storage.Blob service.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2021-04-10-preview`,

  @doc("The 2021-08-06-preview version of the Azure.Storage.Blob service.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2021-08-06-preview`,

  @doc("The 2021-12-02-preview version of the Azure.Storage.Blob service.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2021-12-02-preview`,
}
