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
@service(#{ title: "Azure Storage Blob service" })
@server(
  "{url}",
  "The host name of the blob storage account, e.g. accountName.blob.core.windows.net",
  {
    @doc("The host name of the blob storage account, e.g. accountName.blob.core.windows.net")
    url: url,
  }
)
@versioned(Versions)
namespace Storage.Blob;

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Following standard typespec recommendation"
#suppress "@azure-tools/typespec-azure-core/no-enum" "Following standard typespec recommendation"
@doc("The Azure.Storage.Blob service versions.")
enum Versions {
  @doc("The 2019-02-02 version of the Azure.Storage.Blob service.")
  v2019_02_02: "2019-02-02",

  @doc("The 2019-07-07 version of the Azure.Storage.Blob service.")
  v2019_07_07: "2019-07-07",

  @doc("The 2019-10-10 version of the Azure.Storage.Blob service.")
  v2019_10_10: "2019-10-10",

  @doc("The 2019-12-12 version of the Azure.Storage.Blob service.")
  v2019_12_12: "2019-12-12",

  @doc("The 2020-02-10 version of the Azure.Storage.Blob service.")
  v2020_02_10: "2020-02-10",

  @doc("The 2020-04-08 version of the Azure.Storage.Blob service.")
  v2020_04_08: "2020-04-08",

  @doc("The 2020-06-12 version of the Azure.Storage.Blob service.")
  v2020_06_12: "2020-06-12",

  @doc("The 2020-08-04 version of the Azure.Storage.Blob service.")
  v2020_08_04: "2020-08-04",

  @doc("The 2020-10-02 version of the Azure.Storage.Blob service.")
  v2020_10_02: "2020-10-02",

  @doc("The 2020-12-06 version of the Azure.Storage.Blob service.")
  v2020_12_06: "2020-12-06",

  @doc("The 2021-02-12 version of the Azure.Storage.Blob service.")
  v2021_02_12: "2021-02-12",

  @doc("The 2021-04-10 version of the Azure.Storage.Blob service.")
  v2021_04_10: "2021-04-10",

  @doc("The 2021-06-08 version of the Azure.Storage.Blob service.")
  v2021_06_08: "2021-06-08",

  @doc("The 2021-08-06 version of the Azure.Storage.Blob service.")
  v2021_08_06: "2021-08-06",

  @doc("The 2021-12-02 version of the Azure.Storage.Blob service.")
  v2021_12_02: "2021-12-02",

  @doc("The 2022-11-02 version of the Azure.Storage.Blob service.")
  v2022_11_02: "2022-11-02",

  @doc("The 2023-01-03 version of the Azure.Storage.Blob service.")
  v2023_01_03: "2023-01-03",

  @doc("The 2023-05-03 version of the Azure.Storage.Blob service.")
  v2023_05_03: "2023-05-03",

  @doc("The 2023-08-03 version of the Azure.Storage.Blob service.")
  v2023_08_03: "2023-08-03",

  @doc("The 2023-11-03 version of the Azure.Storage.Blob service.")
  v2023_11_03: "2023-11-03",

  @doc("The 2024-05-04 version of the Azure.Storage.Blob service.")
  v2024_05_04: "2024-05-04",

  @doc("The 2024-08-04 version of the Azure.Storage.Blob service.")
  v2024_08_04: "2024-08-04",

  @doc("The 2024-11-04 version of the Azure.Storage.Blob service.")
  v2024_11_04: "2024-11-04",

  @doc("The 2025-01-05 version of the Azure.Storage.Blob service.")
  v2025_01_05: "2025-01-05",

  @doc("The 2025-05-05 version of the Azure.Storage.Blob service.")
  v2025_05_05: "2025-05-05",

  @doc("The 2025-07-05 version of the Azure.Storage.Blob service.")
  v2025_07_05: "2025-07-05",

  @doc("The 2025-11-05 version of the Azure.Storage.Blob service.")
  v2025_11_05: "2025-11-05",
}
