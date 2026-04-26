import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

/** Azure Web PubSub Chat REST API */
@service(#{ title: "Azure Web PubSub Chat REST API" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://webpubsub.azure.com/.default"],
    }
  ]>
)
@server(
  "{endpoint}",
  "Azure Web PubSub Chat Service",
  {
    /** HTTP or HTTPS endpoint for the Web PubSub service instance. */
    endpoint: url,
  }
)
namespace WebPubSubChat;

/** Service API versions. */
enum Versions {
  /** The 2026-02-01-preview API version. */
  v2026_02_01_preview: "2026-02-01-preview",
}
