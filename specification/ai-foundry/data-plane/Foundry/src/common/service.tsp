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
  "https://{accountName}.{cloud}/api/projects/{projectName}",
  "Microsoft Foundry",
  {
    @doc("The AI services account name.")
    accountName: string,

    @doc("The cloud where the AI services account is located.")
    cloud: AzureClouds = AzureClouds.Public,

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
  #suppress "@azure-tools/typespec-azure-core/no-enum" "We need to use an enum for this to be represented as enum for the server variable"
  @doc("The clouds where Microsoft Foundry is available")
  enum AzureClouds {
    @doc("The public Azure cloud.")
    Public: "services.ai.azure.com",

    @doc("The Azure US government cloud.")
    USGov: "services.ai.azure.us",
  }
}
