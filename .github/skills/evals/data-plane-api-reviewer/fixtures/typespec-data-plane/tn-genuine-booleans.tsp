import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@service(#{ title: "Feed Ingestion" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://feedingestion.azure.com/.default"],
    }
  ]>
)
@server("{endpoint}", "Feed Ingestion service", { endpoint: url })
namespace FeedIngestion;

@doc("Service API versions.")
enum Versions {
  @doc("The 2026-01-01 stable version.")
  v2026_01_01: "2026-01-01",
}

@doc("Ingestion settings for a single feed.")
@resource("feeds")
model Feed {
  @doc("Name of the feed. Unique within the calling account and immutable after creation.")
  @key("feedName")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Whether ingestion runs for this feed. When false, the service accepts no documents for it and scheduled polls are skipped.")
  enabled: boolean;

  @doc("Whether previously ingested documents are retained when ingestion is disabled.")
  retainOnDisable: boolean;

  @doc("URL the service polls for new documents.")
  sourceUrl: url;

  @doc("Time at which the feed settings were last changed, in UTC.")
  @visibility(Lifecycle.Read)
  updatedAt: utcDateTime;
}

@doc("Operations on feeds.")
interface Feeds {
  @doc("Gets a feed by name.")
  get is StandardResourceOperations.ResourceRead<Feed>;

  @doc("Creates a feed, or replaces an existing feed with the same name.")
  createOrReplace is StandardResourceOperations.ResourceCreateOrReplace<Feed>;

  @doc("Deletes a feed. Deleting a feed that does not exist succeeds.")
  delete is StandardResourceOperations.ResourceDelete<Feed>;

  @doc("Lists the feeds in the calling account.")
  list is StandardResourceOperations.ResourceList<
    Feed,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}
