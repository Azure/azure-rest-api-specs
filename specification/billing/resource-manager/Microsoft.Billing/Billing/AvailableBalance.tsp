import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BillingAccount.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Billing;

// `availableBalance` is NOT a deployable Azure resource — it is not listed in the
// Microsoft.Billing/billingAccounts Bicep ARM template (only a read-only data shape
// returned by GET on a singleton path). Modeling it as `is ProxyResource<...>` causes
// the .NET MPG emitter to generate spurious `AvailableBalanceResource` and
// `BillingAccountAvailableBalanceResource` classes, which is a breaking change vs the
// stable GA package (`Azure.ResourceManager.Billing` 1.2.2). GA shipped this as plain
// action methods returning the data type via the autorest directive
// `request-path-is-non-resource`. The TypeSpec-equivalent is to model the type as a
// plain `extends CommonTypes.ProxyResource` data model (proven pattern: APIManagement
// `AllPoliciesContract`). The .NET MPG emitter then assigns the underlying GETs to
// the closest matching parent Resource (`BillingAccount` / `BillingProfile`) as
// `Action` methods returning the data type — matching GA byte-for-byte.

/**
 * The Available Credit or Payment on Account Balance. The credit balance can be used to settle due or past due invoices.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "AvailableBalance is intentionally modeled as plain proxy-resource-shaped data, not a deployable resource."
model AvailableBalance extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The Available Credit or Payment on Account Balance. The credit balance can be used to settle due or past due invoices.
   */
  properties?: AvailableBalanceProperties;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "AvailableBalance is not a deployable Azure resource; @armResourceOperations does not apply."
interface AvailableBalances {
  /**
   * The Available Credit or Payment on Account Balance for a billing account. The credit balance can be used to settle due or past due invoices and is supported for billing accounts with agreement type Microsoft Customer Agreement. The payment on account balance is supported for billing accounts with agreement type Microsoft Customer Agreement or Microsoft Online Services Program.
   */
  @tag("AvailableBalance")
  @get
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/availableBalance/default")
  getByBillingAccount(
    ...ApiVersionParameter,

    /** The ID that uniquely identifies a billing account. */
    @path
    @pattern(BillingAccountNamePattern)
    billingAccountName: string,
  ):
    | ArmResponse<AvailableBalance>
    | Azure.ResourceManager.CommonTypes.ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "AvailableBalance is not a deployable Azure resource; @armResourceOperations does not apply."
interface AvailableBalanceOperationGroup {
  /**
   * The Available Credit or Payment on Account Balance for a billing profile. The credit balance can be used to settle due or past due invoices and is supported for billing accounts with agreement type Microsoft Customer Agreement. The payment on account balance is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("AvailableBalance")
  @get
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/billingProfiles/{billingProfileName}/availableBalance/default")
  getByBillingProfile(
    ...ApiVersionParameter,

    /** The ID that uniquely identifies a billing account. */
    @path
    @pattern(BillingAccountNamePattern)
    billingAccountName: string,

    /** The ID that uniquely identifies a billing profile. */
    @path
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    billingProfileName: string,
  ):
    | ArmResponse<AvailableBalance>
    | Azure.ResourceManager.CommonTypes.ErrorResponse;
}
