import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "./devices.tsp";
import "./deviceCapabilities.tsp";
import "./deviceAuthenticationProfiles.tsp";
import "./deviceAttributes.tsp";
import "./groups.tsp";
import "./namespaces.tsp";
import "./operations.tsp";

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
      scopes: ["6ce3f5ab-5f16-4633-a660-21ceb8d74c01"],
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

  /** The 2026-11-02-preview API version. */
  v2026_11_02_preview: "2026-11-02-preview",
}

alias ResourceOperations = Azure.Core.ResourceOperations<NoConditionalRequests &
  NoRepeatableRequests &
  NoClientRequestId>;
