import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

/**
 * Azure File Storage provides scalable file shares in the cloud using SMB and NFS protocols.
 */
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://storage.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Azure File Storage" })
@versioned(Versions)
@server(
  "{url}",
  "Azure File Storage endpoints",
  {
    /**
     * The URL of the service account, share, directory or file that is the target of the desired operation.
     */
    url: url,
  }
)
namespace Storage.File;

/**
 * The available API versions
 */
enum Versions {
  /**
   * API Version 2026-06-06
   */
  v2026_06_06: "2026-06-06",
}
