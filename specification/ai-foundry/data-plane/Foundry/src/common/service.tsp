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
  "https://{accountName}.services.ai.azure.com/api/projects/{projectName}",
  "Microsoft Foundry",
  {
    @doc("The AI services account name.")
    accountName: string,

    @doc("The Foundry project name, or _project for the default project.")
    projectName: string = "_project",
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
