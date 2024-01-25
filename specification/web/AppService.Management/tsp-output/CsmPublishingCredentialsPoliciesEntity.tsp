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
/**
 * Publishing Credentials Policies parameters.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("ftp")
@parentResource(Site)
@includeInapplicableMetadataInPayload(false)
model CsmPublishingCredentialsPoliciesEntity extends ProxyOnlyResource {
  @key("basicPublishingCredentialsPolicy")
  @segment("basicPublishingCredentialsPolicies")
  @visibility("read")
  name: string;

  /**
   * CsmPublishingCredentialsPoliciesEntity resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: CsmPublishingCredentialsPoliciesEntityProperties;
}

@armResourceOperations
interface CsmPublishingCredentialsPoliciesEntities {
  /**
   * Description for Returns whether FTP is allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetFtpAllowed")
  getFtpAllowed is ArmResourceRead<CsmPublishingCredentialsPoliciesEntity>;

  /**
   * Description for Updates whether FTP is allowed on the site or not.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_UpdateFtpAllowed")
  updateFtpAllowed is ArmResourceCreateOrReplaceSync<CsmPublishingCredentialsPoliciesEntity>;

  /**
   * Description for Returns whether Scm basic auth is allowed and whether Ftp is allowed for a given site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
