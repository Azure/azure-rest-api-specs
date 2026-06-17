import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Versioning;

/**
 * Creates a data plane client for Purview Data Access.
 */
@service(#{ title: "PurviewDataAccess" })
@server(
  "{endpoint}/datagovernance/access",
  "Purview Data Access Service manages data subscriptions, workflows, and policy sets for governing access to data products within Microsoft Purview.",
  {
    @doc("The endpoint of the Purview Data Access service. Example: https://api.purview-service.microsoft.com/")
    endpoint: "https://api.purview-service.microsoft.com/",
  }
)
@doc("""
  Purview Data Access Service manages data subscriptions, workflows, and policy sets
  for governing access to data products within Microsoft Purview. It provides APIs
  for requesting, approving, and managing data access across an organization.
  """)
@useAuth(AuthToken)
@versioned(ApiVersions)
namespace PurviewDataAccess;

@doc("Service API versions")
enum ApiVersions {
  @doc("2023-10-01-preview service API version")
  v2023_10_01_preview: "2023-10-01-preview",
}

alias AuthToken = OAuth2Auth<[
  {
    type: OAuth2FlowType.implicit;
    authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
    scopes: ["https://purview.azure.net/.default"];
  }
]>;
