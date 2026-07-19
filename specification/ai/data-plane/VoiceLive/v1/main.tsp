import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/openai-typespec/models/realtime";

import "./models.tsp";
import "./events.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-autorest/unsupported-http-auth-scheme" "Voice Live supports header-based API key and Microsoft Entra ID authentication."
@useAuth(

    | ApiKeyAuth<ApiKeyLocation.header, "api-key">
    | OAuth2Auth<[
        {
          type: OAuth2FlowType.implicit,
          authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
          scopes: ["https://cognitiveservices.azure.com/.default"],
        }
      ]>
)
@service(#{ title: "Voice Live" })
@server(
  "{endpoint}",
  "Voice Live data-plane endpoint.",
  {
    /** The Voice Live resource endpoint, including its scheme and host name. */
    endpoint: url,
  }
)
@versioned(Versions)
namespace VoiceLive.V1;

/** The stable Voice Live API labels. */
enum Versions {
  /** The stable OpenAI Realtime GA-compatible contract. */
  v1: "v1",
}

/** Operations for establishing Voice Live realtime connections. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "A WebSocket upgrade is not a standard REST operation."
@route("/voice-live/realtime")
interface RealtimeConnections {
  /** Establishes a realtime WebSocket connection using header-only authentication. */
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "The explicit api-version query is the label-based Versions parameter below."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Connect describes the WebSocket upgrade operation."
  @get
  connect(
    /** The stable label-based API version. */
    @query("api-version")
    apiVersion: Versions,

    /** The configured model or deployment alias to use for the session. */
    @query
    `model`: string,
  ): {
    /** The successful WebSocket protocol-switch response. */
    @statusCode
    statusCode: 101;

    /** The schemas exchanged as WebSocket frames after the protocol switch, not an HTTP entity body. */
    @body
    protocol?: RealtimeProtocolSchemas;
  };
}
