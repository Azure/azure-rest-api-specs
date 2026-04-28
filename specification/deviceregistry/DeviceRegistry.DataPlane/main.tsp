import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "./devices.tsp";
import "./deviceCapabilities.tsp";
import "./deviceStates.tsp";
import "./groups.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.Core.Traits;

@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://deviceregistry.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Azure Device Registry Service" })
@server(
  "{endpoint}",
  "Azure Device Registry data-plane APIs",
  {
    /** Supported Device Registry endpoints (protocol and hostname). */
    endpoint: url,
  }
)
@versioned(Microsoft.DeviceRegistry.Versions)
namespace Microsoft.DeviceRegistry;

/** Azure Device Registry service API versions. */
enum Versions {
  /** The 2026-11-01-preview API version. */
  v2026_11_01_preview: "2026-11-01-preview",
}

alias ResourceOperations = Azure.Core.ResourceOperations<NoConditionalRequests &
  NoRepeatableRequests &
  NoClientRequestId>;
