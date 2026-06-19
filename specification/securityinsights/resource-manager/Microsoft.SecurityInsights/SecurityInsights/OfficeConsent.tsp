import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Consent for Office365 tenant that already made.
 */
model OfficeConsent
  is Azure.ResourceManager.ProxyResource<OfficeConsentProperties> {
  ...ResourceNameParameter<
    Resource = OfficeConsent,
    KeyName = "consentId",
    SegmentName = "officeConsents",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface OfficeConsents {
  /**
   * Gets an office365 consent.
   */
  @tag("Office Consents")
  get is Extension.Read<
    workspaceExternalResource,
    OfficeConsent,
    Error = CloudError
  >;

  /**
   * Delete the office365 consent.
   */
  @tag("Office Consents")
  delete is Extension.DeleteSync<
    workspaceExternalResource,
    OfficeConsent,
    Error = CloudError
  >;

  /**
   * Gets all office365 consents.
   */
  @tag("Office Consents")
  list is Extension.ListByTarget<
    workspaceExternalResource,
    OfficeConsent,
    Response = ArmResponse<OfficeConsentList>,
    Error = CloudError
  >;
}

@@doc(OfficeConsent.name, "consent ID");
@@doc(OfficeConsent.properties, "Office consent properties");
