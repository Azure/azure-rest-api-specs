import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./shared.tsp";
import "./common.tsp";
import "./_project.tsp";
import "./_investigation.tsp";
import "./_conversation.tsp";
import "./_conversation_message.tsp";
import "./_conversation_suggestions.tsp";
import "./_conversation_message_logs.tsp";
import "./_tool.tsp";
import "./_task.tsp";
import "./_discovery_agent.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://discovery.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Microsoft.Discovery.Workspace service" })
@versioned(Microsoft.Discovery.Workspace.Versions)
@server(
  "{endpoint}",
  "Discovery Workspace API",
  {
    @doc("""
      Supported Discovery Workspace Services endpoints (protocol and hostname, for example: https://{workspaceName}.discovery.azure.com).
      """)
    endpoint: url,
  }
)
namespace Microsoft.Discovery.Workspace;
