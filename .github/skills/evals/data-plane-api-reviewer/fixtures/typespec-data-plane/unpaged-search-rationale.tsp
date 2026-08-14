import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "Evidence Search" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://evidencesearch.azure.com/.default"],
    }
  ]>
)
@server(
  "{endpoint}",
  "Evidence Search service",
  {
    endpoint: url,
  }
)
namespace EvidenceSearch;

@doc("Service API versions.")
enum Versions {
  @doc("The 2026-01-01 stable version.")
  v2026_01_01: "2026-01-01",
}

@doc("""
  Criteria for searching the caller's indexed documents.

  Search text is tokenized as Unicode words. When `categories` is supplied, a
  document must belong to at least one listed category before it is ranked.
  """)
model SearchRequest {
  @doc("Text to find in indexed document content. Maximum 4,096 characters.")
  @maxLength(4096)
  text: string;

  @doc("Categories in which to search. When omitted, every category is searched.")
  categories?: string[];
}

@doc("""
  A ranked projection of one indexed document.

  Search hits are computed for the request and are not retained as independent
  resources. `documentId` refers to the source document; the hit itself has no
  lifecycle or addressable URL.
  """)
model SearchHit {
  @doc("Opaque identifier of the matching source document.")
  documentId: string;

  @doc("Relevance score from 0.0 to 1.0, where 1.0 is the strongest match.")
  @minValue(0)
  @maxValue(1)
  relevanceScore: float64;

  @doc("Excerpt containing the terms that contributed most strongly to the match.")
  excerpt: string;

  @doc("Time at which the source document was most recently indexed, in UTC.")
  indexedAt: utcDateTime;
}

@doc("""
  Complete ranked results for one search.

  `totalCount` is the number of hits in `value`. Results are returned as one
  snapshot rather than as independently mutable resources.
  """)
model SearchResults {
  @doc("Matching documents ordered from highest to lowest relevance.")
  value: SearchHit[];

  @doc("Number of matching documents in this response.")
  totalCount: int64;
}

@doc("""
  Search operations over the caller's indexed documents.

  Searching is a stateless computation: it neither changes a source document nor
  creates a durable search resource.
  """)
interface Search {
  @doc("""
    Searches indexed documents and returns every match in one response.

    The single response is intentional. Ranking is evaluated against one
    immutable index snapshot, and clients merge the complete ranked set with
    local policy; a continuation cursor would either pin that snapshot or allow
    ranks to shift between calls. More than 99.9 percent of production searches
    return fewer than 250 hits. If a serialized result would exceed 4 MiB, the
    service returns `QueryResultTooLarge` so the caller can narrow the search.
    This keeps the common path atomic and avoids cursor state for nearly every
    caller.
    """)
  @route("/documents:search")
  search is Azure.Core.RpcOperation<SearchRequest, SearchResults>;
}
