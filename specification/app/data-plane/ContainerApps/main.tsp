import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models/common.tsp";
import "./models/sandboxes.tsp";
import "./models/connections.tsp";
import "./models/contentpackages.tsp";
import "./models/credentials.tsp";
import "./models/diskimages.tsp";
import "./models/egressPolicies.tsp";
import "./models/sandbox-files.tsp";
import "./models/sandbox-streams.tsp";
import "./models/sandbox-networking.tsp";
import "./models/sandbox-storage.tsp";
import "./models/sandbox-lifecycle.tsp";
import "./models/snapshots.tsp";
import "./models/secrets.tsp";
import "./models/volumes.tsp";
import "./routes/sandboxes.tsp";
import "./routes/connections.tsp";
import "./routes/contentpackages.tsp";
import "./routes/credentials.tsp";
import "./routes/diskimages.tsp";
import "./routes/egressPolicies.tsp";
import "./routes/sandbox-files.tsp";
import "./routes/sandbox-streams.tsp";
import "./routes/sandbox-networking.tsp";
import "./routes/sandbox-storage.tsp";
import "./routes/sandbox-lifecycle.tsp";
import "./routes/secrets.tsp";
import "./routes/snapshots.tsp";
import "./routes/volumes.tsp";
import "./client.tsp";

using Http;
using Rest;
using Versioning;
using Azure.Core;

/** Azure Container Apps Sandbox data plane API. */
@service(#{ title: "Azure Container Apps Sandbox" })
@versioned(ApiVersions)
@server(
  "{endpoint}",
  "Azure Container Apps Sandbox data plane endpoint.",
  {
    endpoint: url,
  }
)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.authorizationCode,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",

      // Entra resource identifier for the service, not a branding string. Changing it
      // requires a matching change to the service's app registration and will break
      // token acquisition for every existing client.
      scopes: ["https://management.azuredevcompute.io/.default"],
    }
  ]>
)
namespace ContainerAppsSandbox;

/** Supported Azure Container Apps Sandbox API versions. */
enum ApiVersions {
  /** The 2026-09-01-preview API version. */
  @Azure.Core.previewVersion
  v2026_09_01_preview: "2026-09-01-preview",
}
