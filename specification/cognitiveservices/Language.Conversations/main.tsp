import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./routes.tsp";
import "./models/luis.tsp";
import "./models/qna.tsp";
import "./models/summarization.tsp";
import "./models/pii.tsp";
import "./models/common.tsp";
import "./models/common.union.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

/** The language service conversations API is a suite of natural language processing (NLP) skills that can be used to analyze structured conversations (textual or spoken). The synchronous API in this suite accepts a request and mediates among multiple language projects, such as LUIS Generally Available, Question Answering, Conversational Language Understanding, and then calls the best candidate service to handle the request. At last, it returns a response with the candidate service's response as a payload.\n\n In some cases, this API needs to forward requests and responses between the caller and an upstream service. The asynchronous APIs in this suite enable tasks like Conversation Summarization and Conversational PII detection. */
@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.authorizationCode,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/token",
      scopes: ["https://cognitiveservices.azure.com/.default"],
    }
  ]>
)
@service(#{
  title: "Microsoft Cognitive Language Service - Analyze Conversations",
})
@server(
  "{Endpoint}/language",
  "Single server endpoint",
  {
    /** Supported Cognitive Services endpoint (e.g., https://<resource-name>.api.cognitiveservices.azure.com). */
    Endpoint: string,
  }
)
@versioned(Versions)
namespace Language.Conversations;

/** Analyze Conversations Service Versions */
enum Versions {
  /** Version 2022-05-01 */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2022_05_01: "2022-05-01",

  /** Version 2023-04-01 */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_04_01: "2023-04-01",

  /** Version 2024-05-01 */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_05_01: "2024-05-01",

  /** Version 2024-11-01 */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_11_01: "2024-11-01",

  /** Version 2024-11-15-preview" */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_11_15_preview: "2024-11-15-preview",

  /** Version 2025-05-15 */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2025_05_15_preview: "2025-05-15-preview",
}

/** These are the [Azure Active Directory OAuth2](https://learn.microsoft.com/azure/active-directory/develop/v1-overview) Flows. When paired with [Azure role-based access](https://learn.microsoft.com/azure/role-based-access-control/overview) control it can be used to control access to Azure Maps REST APIs. Azure role-based access controls are used to designate access to one or more Azure Maps resource account or sub-resources. Any user, group, or service principal can be granted access via a  built-in role or a custom role composed of one or more permissions to Azure Maps REST APIs.\n\nTo implement scenarios, we recommend viewing [authentication concepts](https://aka.ms/amauth). In summary, this security definition provides a solution for modeling application(s) via objects capable of access control on specific APIs and scopes.\n\n#### Notes\n* This security definition **requires** the use of the `x-ms-client-id` header to indicate which Azure Maps resource the application is requesting access to. This can be acquired from the [Maps management API](https://aka.ms/amauthdetails).\n* \nThe `Authorization URL` is specific to the Azure public cloud instance. Sovereign clouds have unique Authorization URLs and Azure Active directory configurations. \n* \nThe Azure role-based access control is configured from the [Azure management plane](https://aka.ms/amrbac) via Azure portal, PowerShell, CLI, Azure SDKs, or REST APIs.\n* \nUsage of the [Azure Maps Web SDK](https://aka.ms/amaadmc) allows for configuration based setup of an application for multiple use cases.\n* Currently, Azure Active Directory [v1.0 or v2.0](https://learn.microsoft.com/azure/active-directory/develop/azure-ad-endpoint-comparison) supports Work, School, and Guests but does not support Personal accounts. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model AADToken
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit;
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
      scopes: ["https://cognitiveservices.azure.com/.default"];
    }
  ]>;
