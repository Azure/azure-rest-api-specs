import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./BillingProfile.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Billing;

/**
 * Invoicing preferences.
 */
@added(Versions.v2024_08_01_preview)
@singleton("default")
@tenantResource
@parentResource(BillingProfile)
model InvoicingPreferences
  is Azure.ResourceManager.ProxyResource<InvoicingPreferencesProperties> {
  ...ResourceNameParameter<
    Resource = InvoicingPreferences,
    KeyName = "invoicingPreference",
    SegmentName = "invoicingPreferences",
    NamePattern = ""
  >;
}

alias InvoicingPreferenceByBillingAccountOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The resource provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing";

    /** The ID that uniquely identifies a billing account. */
    @path
    @segment("billingAccounts")
    @key
    @pattern(BillingAccountNamePattern)
    billingAccountName: string;
  },
  {},
  {},
  "BillingAccount"
>;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Invoicing preferences are updated in place and do not support deletion."
@Azure.ClientGenerator.Core.clientName("InvoicingPreferences")
@armResourceOperations(#{ omitTags: true })
interface InvoicingPreferenceOperations {
  /**
   * Gets the invoicing preferences for a billing profile.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("InvoicingPreferences")
  getByBillingProfile is ArmResourceRead<
    InvoicingPreferences,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Updates the invoicing preferences for a billing profile.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The existing invoicing preferences endpoint returns only 200."
  @added(Versions.v2024_08_01_preview)
  @tag("InvoicingPreferences")
  updateByBillingProfile is ArmResourceCreateOrReplaceAsync<
    InvoicingPreferences,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResponse<InvoicingPreferences>
  >;

  /**
   * Gets the invoicing preferences for a billing account. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("InvoicingPreferences")
  @action("invoicingPreferences/default")
  getByBillingAccount is InvoicingPreferenceByBillingAccountOps.Read<InvoicingPreferences>;

  /**
   * Updates the invoicing preferences for a billing account. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("InvoicingPreferences")
  @action("invoicingPreferences/default")
  updateByBillingAccount is InvoicingPreferenceByBillingAccountOps.CreateOrUpdateSync<
    InvoicingPreferences,
    Response = ArmResponse<InvoicingPreferences>
  >;
}

@@doc(InvoicingPreferences.name, "");
@@doc(InvoicingPreferences.properties, "Invoicing preferences.");
@@doc(
  InvoicingPreferenceOperations.updateByBillingProfile::parameters.resource,
  "Invoicing preferences."
);
@@doc(
  InvoicingPreferenceOperations.updateByBillingAccount::parameters.resource,
  "Invoicing preferences."
);
