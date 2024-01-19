import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
@doc("Publishing Credentials Policies parameters.")
@singleton("ftp")
@parentResource(Site)
model CsmPublishingCredentialsPoliciesEntity
  is ProxyResource<CsmPublishingCredentialsPoliciesEntityProperties> {
  @key("basicPublishingCredentialsPolicy")
  @segment("basicPublishingCredentialsPolicies")
  name: string;
}

@armResourceOperations
interface CsmPublishingCredentialsPoliciesEntities {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Returns whether FTP is allowed on the site or not.")
  @operationId("WebApps_GetFtpAllowed")
  getFtpAllowed is ArmResourceRead<CsmPublishingCredentialsPoliciesEntity>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Updates whether FTP is allowed on the site or not.")
  @operationId("WebApps_UpdateFtpAllowed")
  updateFtpAllowed is ArmResourceCreateOrReplaceSync<CsmPublishingCredentialsPoliciesEntity>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Returns whether Scm basic auth is allowed and whether Ftp is allowed for a given site.")
  @operationId("WebApps_ListBasicPublishingCredentialsPolicies")
  listBasicPublishingCredentialsPolicies is ArmResourceListByParent<CsmPublishingCredentialsPoliciesEntity>;
}

@@projectedName(CsmPublishingCredentialsPoliciesEntities.updateFtpAllowed::parameters.resource,
  "json",
  "csmPublishingAccessPoliciesEntity"
);
@@extension(CsmPublishingCredentialsPoliciesEntities.updateFtpAllowed::parameters.resource,
  "x-ms-client-name",
  "csmPublishingAccessPoliciesEntity"
);
@@doc(CsmPublishingCredentialsPoliciesEntities.updateFtpAllowed::parameters.resource,
  ""
);
