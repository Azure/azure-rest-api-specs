import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://ml.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Feed Management Service APIs" })
@server(
  "{endpoint}",
  "Registry Management Service APIs",
  {
    /** Supported Azure ML endpoints. */
    endpoint: url,
  }
)
@versioned(Versions)
namespace Microsoft.MachineLearningServices.RegistryDiscovery;

/** Service API versions. */
enum Versions {
  /** The v1.0 API version. */
  v1_0: "v1.0",
}
