import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

/** The secret key for your Azure AI Language resource. */
alias AzureKey = ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">;

/**
 * These are the [Azure Active Directory OAuth2](https://learn.microsoft.com/azure/active-directory/develop/v1-overview) Flows.
 * When paired with [Azure role-based access](https://learn.microsoft.com/azure/role-based-access-control/overview) control it can be used to control access to Azure Maps REST APIs.
 * Azure role-based access controls are used to designate access to one or more Azure Language resource account or sub-resources. Any user, group, or service principal can be granted access
 * via a  built-in role or a custom role composed of one or more permissions to Azure Language REST APIs.
 *
 * To implement scenarios, we recommend viewing [authentication concepts](https://aka.ms/amauth).
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
alias AADToken = OAuth2Auth<[
  {
    type: OAuth2FlowType.implicit;
    authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
    scopes: ["https://cognitiveservices.azure.com/.default"];
  }
]>;

@useAuth(AzureKey | AADToken)
@service(#{ title: "Language MCP Server" })
@server(
  "{Endpoint}/language",
  "Language MCP Server",
  {
    @doc("Supported Cognitive Services endpoint (e.g., https://<resource-name>.api.cognitiveservices.azure.com).")
    Endpoint: url,
  }
)
@versioned(Versions)
namespace Language.Mcp {
  /**
   * The available API versions.
   */
  enum Versions {
    /** Version 2025-11-15-preview */
    v2025_11_15_preview: "2025-11-15-preview",
  }

  /**
   * Entrypoint for all mcp calls
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Still in preview"
  @route("/mcp")
  @post
  op invokeMcp is Foundations.Operation<
    {
      #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Still in preview"
      @doc("Request body")
      @body
      body: Record<unknown>;
    },
    Record<unknown> | NoContentResponse,
    {},
    Azure.Core.Foundations.ErrorResponse
  >;
}
