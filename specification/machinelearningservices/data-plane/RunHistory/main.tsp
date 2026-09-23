import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "./routes-runs.tsp";
import "./routes-experiments.tsp";
import "./routes-artifacts.tsp";
import "./routes-events.tsp";
import "./routes-metrics.tsp";
import "./routes-private.tsp";

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
@service(#{ title: "Run History APIs" })
@server(
  "{endpoint}",
  "Run History APIs",
  {
    /** Supported Azure ML endpoints. */
    endpoint: url,
  }
)
@versioned(Versions)
namespace Microsoft.MachineLearningServices.RunHistory;

/** Service API versions. */
enum Versions {
  /** The v1.0 API version. */
  v1_0: "v1.0",
}
