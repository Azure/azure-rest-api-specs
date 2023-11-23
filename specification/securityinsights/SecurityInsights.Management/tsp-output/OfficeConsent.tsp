import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
@doc("Consent for Office365 tenant that already made.")
model OfficeConsent is ProxyResource<OfficeConsentProperties> {
  @doc("consent ID")
  @path
  @key("consentId")
  @segment("officeConsents")
  name: string;
}

@armResourceOperations
interface OfficeConsents {
  @doc("Gets an office365 consent.")
  get is ArmResourceRead<OfficeConsent>;
  @doc("Delete the office365 consent.")
  delete is ArmResourceDeleteSync<OfficeConsent>;
  @doc("Gets all office365 consents.")
  list is ArmResourceListByParent<OfficeConsent>;
}
