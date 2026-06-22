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
@service(#{ title: "Azure Machine Learning Model Registry Service" })
@server(
  "{endpoint}",
  "Azure Machine Learning Model Registry Service",
  {
    /** Supported Azure ML endpoints. */
    endpoint: url,
  }
)
@versioned(Versions)
namespace Microsoft.MachineLearningServices.ModelDataplane;

/** Service API versions. */
enum Versions {
  /** The 1.0.0 API version. */
  v1_0_0: "1.0.0",
}
