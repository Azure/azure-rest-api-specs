import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";
import "./client.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;

/** Azure Data AI provides semantic reranking operations. */
#suppress "@azure-tools/typespec-autorest/unsupported-http-auth-scheme" "The existing API supports HTTP bearer authentication, which the AutoRest emitter does not model directly."
@service(#{ title: "Azure Data AI" })
@useAuth(AzureDataAIAadAuth | AzureDataAIApiKeyAuth)
@server(
  "{endpoint}",
  "The Azure Data AI endpoint.",
  {
    /** The Azure Data AI endpoint. */
    endpoint: url,
  }
)
@versioned(Versions)
namespace Azure.Data.AI;

/** Authenticates requests using a bearer token. */
alias AzureDataAIAadAuth = AadOauth2Auth<[
  "https://dbinference.azure.com/.default"
]>;

/** Authenticates requests using an Azure API subscription key. */
alias AzureDataAIApiKeyAuth = ApiKeyAuth<
  ApiKeyLocation.header,
  "Ocp-Apim-Subscription-Key"
>;

/** The Azure Data AI API versions. */
enum Versions {
  /** 2026-10-30 generally available version. */
  v2026_10_30: "2026-10-30",
}
