import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "Index Service" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://indexservice.azure.com/.default"],
    }
  ]>
)
@server("https://{endpoint}", "Index service", { endpoint: string })
namespace IndexService;

enum Versions {
  v2026_01_01: "2026-01-01",
}

@doc("An index.")
@resource("indexes")
model Index {
  @doc("The name.")
  @key
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The timeout.")
  timeout: int32;

  @doc("The status.")
  status: IndexStatus;

  @doc("The filter.")
  filter?: string;

  @doc("The query.")
  query?: string;

  @doc("Maximum size of the index.")
  maxSize: int64;
}

@doc("The status of an index.")
union IndexStatus {
  string,
  Ready: "Ready",
  Building: "Building",
  Failed: "Failed",
  Stopped: "Stopped",
}

interface Indexes {
  @doc("Gets an index.")
  get is StandardResourceOperations.ResourceRead<Index>;

  @doc("Creates or updates an index.")
  createOrUpdate is StandardResourceOperations.ResourceCreateOrUpdate<Index>;

  @doc("Deletes an index.")
  delete is StandardResourceOperations.ResourceDelete<Index>;

  @doc("Lists indexes.")
  list is StandardResourceOperations.ResourceList<Index>;
}
