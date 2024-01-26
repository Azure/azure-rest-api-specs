import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Billing;

interface PaymentMethodsOperations {
  /**
   * Lists the payment methods available for a billing account. Along with the payment methods owned by the caller, these payment methods can be attached to a billing profile to make payments. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/paymentMethods")
  @get
  listByBillingAccount is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID that uniquely identifies a billing account.
       */
      @path
      billingAccountName: string;
    },
    ResourceListResult<PaymentMethod>
  >;

  /**
   * Gets a payment method available for a billing account. The operation is supported only for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @route("/providers/Microsoft.Billing/billingAccounts/{billingAccountName}/paymentMethods/{paymentMethodName}")
  @get
  getByBillingAccount is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID that uniquely identifies a billing account.
       */
      @path
      billingAccountName: string;

      /**
       * The ID that uniquely identifies a payment method.
       */
      @path
      paymentMethodName: string;
    },
    PaymentMethod
  >;
}
