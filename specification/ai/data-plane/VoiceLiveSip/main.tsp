import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

import "./models.tsp";
import "./routes.tsp";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

/**
 * The Voice Live SIP control-plane API. This HTTP data-plane surface manages inbound SIP call
 * control (accept, reject, transfer, hangup), webhook registrations for SIP call lifecycle events,
 * and resource-level SIP configuration. Real-time media and the `realtime.call.*` call lifecycle
 * events are delivered over the separate WebSocket-based `VoiceLive` data-plane contract.
 */
@service(#{ title: "VoiceLiveSip" })
@versioned(Versions)
@server(
  "{endpoint}",
  "The Voice Live SIP control-plane endpoint.",
  {
    /**
     * Supported Voice Live resource endpoint (protocol and hostname, for example
     * `https://my-resource.services.ai.azure.com`).
     */
    endpoint: url,
  }
)
@useAuth(SipEntraOAuth2)
namespace VoiceLiveSip;

/** Microsoft Entra ID OAuth2 authentication. */
alias SipEntraOAuth2 = OAuth2Auth<[
  {
    type: OAuth2FlowType.implicit;
    authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize";
    scopes: ["https://cognitiveservices.azure.com/.default"];
  }
]>;

/** The available API versions for the Voice Live SIP control-plane API. */
enum Versions {
  /** Version 2026-07-31-preview. */
  v2026_07_31_preview: "2026-07-31-preview",
}
