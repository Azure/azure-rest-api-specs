import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./BillingAccount.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Billing;

/**
 * A billing alert.
 */
@added(Versions.v2024_08_01_preview)
@tenantResource
@parentResource(BillingAccount)
model Alert is Azure.ResourceManager.ProxyResource<AlertProperties> {
  ...ResourceNameParameter<
    Resource = Alert,
    KeyName = "alertName",
    SegmentName = "alerts",
    NamePattern = AlertPattern
  >;
}

alias AlertByBillingAccountOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
  {
    /** The resource ID that uniquely identifies a billing alert resource. */
    @path
    @segment("alerts")
    @key
    @pattern(AlertPattern)
    alertName: string;
  },
  "BillingAccountAlert"
>;

alias AlertByBillingProfileOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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

    /** The ID that uniquely identifies a billing profile. */
    @path
    @segment("billingProfiles")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    billingProfileName: string;
  },
  {},
  {
    /** The resource ID that uniquely identifies a billing alert resource. */
    @path
    @segment("alerts")
    @key
    @pattern(AlertPattern)
    alertName: string;
  },
  "BillingProfileAlert"
>;

@armResourceOperations(#{ omitTags: true })
interface Alerts {
  /**
   * Creates or updates an alert for the specified Billing Account.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("Alerts")
  createOrUpdate is AlertByBillingAccountOps.CreateOrUpdateAsync<
    Alert,
    Response =
      | ArmResourceUpdatedResponse<Alert>
      | ArmResourceCreatedResponse<
          Alert,
          ArmLroLocationHeader<FinalResult = Alert> &
            Azure.Core.Foundations.RetryAfterHeader
        >
  >;

  /**
   * Deletes an alert for the specified Billing Account.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("Alerts")
  delete is AlertByBillingAccountOps.DeleteSync<Alert>;

  /**
   * Gets the alert definition by an Id.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("Alerts")
  getById is AlertByBillingAccountOps.Read<Alert>;

  /**
   * Lists the alerts for a billing account. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement and Microsoft Partner Agreement.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("Alerts")
  listByBillingAccount is AlertByBillingAccountOps.List<
    Alert,
    Parameters = DefaultODataParameters,
    Response = ArmResponse<AlertListResult>
  >;

  /**
   * Lists the alerts for a billing profile. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement and Microsoft Partner Agreement.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("Alerts")
  listByBillingProfile is AlertByBillingProfileOps.List<
    Alert,
    Parameters = DefaultODataParameters,
    Response = ArmResponse<AlertListResult>
  >;
}

@@doc(
  Alert.name,
  "The resource ID that uniquely identifies a billing alert resource."
);
@@doc(Alert.properties, "A billing alert.");
@@doc(Alerts.createOrUpdate::parameters.resource, "A billing alert.");
