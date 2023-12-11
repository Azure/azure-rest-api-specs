import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Publishing Credentials Policies parameters.")
@parentResource(WebSite)
@singleton("ftp")
model WebSiteFtpPublishingCredentialsPolicy
  is ProxyResource<CsmPublishingCredentialsPoliciesEntityProperties> {
  @key("ftp")
  @segment("basicPublishingCredentialsPolicies")
  name: string;
}

@armResourceOperations
interface WebSiteFtpPublishingCredentialsPolicies {
  @doc("Description for Returns whether FTP is allowed on the site or not.")
  getFtpAllowed is ArmResourceRead<WebSiteFtpPublishingCredentialsPolicy>;
  @doc("Description for Updates whether FTP is allowed on the site or not.")
  updateFtpAllowed is ArmResourceCreateOrReplaceSync<WebSiteFtpPublishingCredentialsPolicy>;
  @doc("Description for Returns whether Scm basic auth is allowed and whether Ftp is allowed for a given site.")
  listByWebSite is ArmResourceListByParent<WebSiteFtpPublishingCredentialsPolicy>;
}
