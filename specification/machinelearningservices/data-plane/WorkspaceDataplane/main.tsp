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
@service(#{ title: "Azure Machine Learning Service" })
@server(
  "{endpoint}",
  "Azure Machine Learning Workspace Data Plane APIs",
  {
    /** Supported Azure ML endpoints. */
    endpoint: url,
  }
)
@versioned(Versions)
namespace Microsoft.MachineLearningServices.WorkspaceDataplane;

/** Service API versions. */
enum Versions {
  /** The 2023-06-01-preview API version. */
  v2023_06_01_preview: "2023-06-01-preview",
}
