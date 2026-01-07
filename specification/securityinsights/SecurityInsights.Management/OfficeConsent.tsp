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

alias workspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface OfficeConsents {
  /**
   * Gets an office365 consent.
   */
  get is ArmResourceRead<OfficeConsent>;

  /**
   * Delete the office365 consent.
   */
  delete is ArmResourceDeleteSync<OfficeConsent>;

  /**
   * Gets all office365 consents.
   */
  list is ArmResourceListByParent<
    OfficeConsent,
    Response = ArmResponse<OfficeConsentList>
  >;
}

@@doc(OfficeConsent.name, "consent ID");
@@doc(OfficeConsent.properties, "Office consent properties");
