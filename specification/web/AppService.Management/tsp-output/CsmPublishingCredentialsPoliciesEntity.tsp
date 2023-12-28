import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Publishing Credentials Policies parameters.")
@singleton("ftp")
@parentResource(Site)
model CsmPublishingCredentialsPoliciesEntity
  is ProxyResource<CsmPublishingCredentialsPoliciesEntityProperties> {
  @key("ftp")
  @segment("basicPublishingCredentialsPolicies")
  name: string;
}

@armResourceOperations
interface WebApps {
  @doc("Description for Returns whether FTP is allowed on the site or not.")
  getFtpAllowed is ArmResourceRead<CsmPublishingCredentialsPoliciesEntity>;
  @doc("Description for Updates whether FTP is allowed on the site or not.")
  updateFtpAllowed is ArmResourceCreateOrReplaceSync<CsmPublishingCredentialsPoliciesEntity>;
  @doc("Description for Returns whether Scm basic auth is allowed and whether Ftp is allowed for a given site.")
  listBasicPublishingCredentialsPolicies is ArmResourceListByParent<CsmPublishingCredentialsPoliciesEntity>;
}
