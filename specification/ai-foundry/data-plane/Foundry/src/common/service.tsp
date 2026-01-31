import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-autorest/unsupported-http-auth-scheme"
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://ai.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Microsoft Foundry" })
@server(
  "{endpoint}",
  "Microsoft Foundry",
  {
    @doc("""
      Foundry Project endpoint in the form
      "https://{ai-services-account-name}.services.ai.azure.com/api/projects/{project-name}".
      If you only have one Project in your Foundry Hub, or to target the default Project
      in your Hub, use the form
      "https://{ai-services-account-name}.services.ai.azure.com/api/projects/_project"
      """)
    endpoint: url,
  }
)
@versioned(Versions)
namespace Azure.AI.Projects {
  @doc("Microsoft Foundry API versions")
  enum Versions {
    /**
     * An interim virtual API version representing backwards compatibility changes moving from public preview to general availability.
     */
    PuPr: "virtual-public-preview",

    @doc("Microsoft Foundry API version v1.")
    v1: "v1",
  }
}
