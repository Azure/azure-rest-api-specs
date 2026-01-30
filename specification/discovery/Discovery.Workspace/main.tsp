import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
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

      // TODO: Work with backend team to determine authorizationUrl and scopes.
      authorizationUrl: "https://login.discovery.azure.com/common/oauth2/v2.0/authorize",

      scopes: ["https://workspace.discovery.azure.com/.default"],
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

@doc("The Microsoft.Discovery.Workspace service versions.")
enum Versions {
  @useDependency(
    Microsoft.Discovery.DataPlane.Shared.Versions.`2025-07-01-preview`
  )
  @doc("The 2025-07-01-preview version of the Microsoft.Discovery.Workspace service data plane.")
  `2025-07-01-preview`,

  @useDependency(
    Microsoft.Discovery.DataPlane.Shared.Versions.`2025-12-01-preview`
  )
  @doc("The 2025-12-01-preview version of the Microsoft.Discovery.Workspace service data plane.")
  `2025-12-01-preview`,

  @useDependency(
    Microsoft.Discovery.DataPlane.Shared.Versions.`2026-02-01-preview`
  )
  @doc("The 2026-02-01-preview version of the Microsoft.Discovery.Workspace service data plane.")
  `2026-02-01-preview`,
}
