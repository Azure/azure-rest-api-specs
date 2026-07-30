import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BillingAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Billing;
/**
 * An invoice.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/improper-subscription-list-operation" "The subscription routes mean Billing Subscription, not Azure Subscription."
@tenantResource
@parentResource(BillingAccount)
model Invoice is Azure.ResourceManager.ProxyResource<InvoiceProperties> {
  ...ResourceNameParameter<
    Resource = Invoice,
    KeyName = "invoiceName",
    SegmentName = "invoices",
    NamePattern = InvoicePattern
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

alias InvoiceOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
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
    /** The ID that uniquely identifies an invoice. */
    @path
    @segment("invoices")
    @key
    @pattern(InvoicePattern)
    invoiceName: string;
  },
  "BillingInvoice"
>;

@armResourceOperations(#{ omitTags: true })
interface Invoices {
  /**
   * Gets an invoice by billing account name and ID. The operation is supported for all billing account types.
   */
  @tag("Invoice")
  getByBillingAccount is InvoiceOps.Read<Invoice>;

  /**
   * Lists the invoices for a billing account for a given start date and end date. The operation is supported for all billing account types.
   */
  @tag("Invoice")
  listByBillingAccount is InvoiceOps.List<
    Invoice,
    Parameters = {
      /**
       * The start date of the billing period for which the invoice is generated. The date is in MM-DD-YYYY format.
       */
      @query("periodStartDate")
      periodStartDate?: plainDate;

      /**
       * The end date of the billing period for which the invoice is generated. The date is in MM-DD-YYYY format.
       */
      @query("periodEndDate")
      periodEndDate?: plainDate;

      ...DefaultODataParameters;
    },
    Response = ArmResponse<InvoiceListResult>
  >;

  /**
   * Regenerate an invoice by billing account name and invoice name. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  @tag("Invoice")
  amend is InvoiceOps.ActionAsync<
    Invoice,
    void,
    Invoice,
    Response = ArmAcceptedLroResponse
  >;

  /**
   * Gets a URL to download an invoice document. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement, Microsoft Customer Agreement or Enterprise Agreement.
   */
  @tag("Invoice")
  @action("download")
  downloadByBillingAccount is InvoiceOps.ActionAsync<
    Invoice,
    void,
    DocumentDownloadResult,
    Parameters = {
      /**
       * The ID that uniquely identifies an invoice document. This ID may be an identifier for an invoice PDF, a credit note, or a tax receipt.
       */
      @query("documentName")
      documentName?: string;
    }
  >;

  /**
   * Gets a URL to download the summary document for an invoice. The operation is supported for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("Invoice")
  @action("downloadSummary")
  downloadSummaryByBillingAccount is InvoiceOps.ActionAsync<
    Invoice,
    void,
    DocumentDownloadResult
  >;

  /**
   * Lists the transactions for an invoice. Transactions include purchases, refunds and Azure usage charges.
   */
  @tag("Transaction")
  @list
  @get
  @action("transactions")
  listByInvoice is InvoiceOps.ActionSync<
    Invoice,
    void,
    ArmResponse<TransactionListResult>,
    Parameters = {
      ...DefaultODataParameters;
    }
  >;

  /**
   * Gets a URL to download the transactions document for an invoice. The operation is supported for billing accounts with agreement type Enterprise Agreement.
   */
  @tag("Transaction")
  @action("transactionsDownload")
  transactionsDownloadByInvoice is InvoiceOps.ActionAsync<
    Invoice,
    void,
    DocumentDownloadResult
  >;

  /**
   * Gets the transaction summary for an invoice. Transactions include purchases, refunds and Azure usage charges.
   */
  @tag("Transaction")
  @get
  @action("transactionSummary")
  getTransactionSummaryByInvoice is InvoiceOps.ActionSync<
    Invoice,
    void,
    ArmResponse<TransactionSummary>,
    Parameters = {
      /**
       * The filter query option allows clients to filter the line items that are aggregated to create the line item summary.
       */
      @query("filter")
      filter?: string;

      /**
       * The search query option allows clients to filter the line items that are aggregated to create the line item summary.
       */
      @query("search")
      search?: string;
    }
  >;
}
alias InvoiceByBillingSubscriptionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing";

    /** undefined */
    @path
    @segment("billingAccounts")
    @key
    default: "default";

    /** The ID that uniquely identifies a billing subscription. */
    @path
    @segment("billingSubscriptions")
    @key
    @pattern(GuidPattern)
    subscriptionId: string;
  },
  {},
  {
    /** The ID that uniquely identifies an invoice. */
    @path
    @segment("invoices")
    @key
    @pattern(InvoicePattern)
    invoiceName: string;
  },
  "SubscriptionBillingInvoice"
>;

@armResourceOperations(#{ omitTags: true })
interface InvoiceByBillingSubscription {
  /**
   * Gets an invoice by subscription ID and invoice ID. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  @tag("Invoice")
  getByBillingSubscription is InvoiceByBillingSubscriptionOps.Read<Invoice>;

  /**
   * Lists the invoices for a subscription. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  @tag("Invoice")
  listByBillingSubscription is InvoiceByBillingSubscriptionOps.List<
    Invoice,
    Parameters = {
      /**
       * The start date of the billing period for which the invoice is generated. The date is in MM-DD-YYYY format.
       */
      @query("periodStartDate")
      periodStartDate?: plainDate;

      /**
       * The end date of the billing period for which the invoice is generated. The date is in MM-DD-YYYY format.
       */
      @query("periodEndDate")
      periodEndDate?: plainDate;

      ...DefaultODataParameters;
    },
    Response = ArmResponse<InvoiceListResult>
  >;

  /**
   * Gets a URL to download an invoice by billing subscription. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  @tag("Invoice")
  @action("download")
  downloadByBillingSubscription is InvoiceByBillingSubscriptionOps.ActionAsync<
    Invoice,
    void,
    DocumentDownloadResult,
    Parameters = {
      /**
       * The ID that uniquely identifies an invoice document. This ID may be an identifier for an invoice PDF, a credit note, or a tax receipt.
       */
      @query("documentName")
      documentName?: string;
    }
  >;
}
alias InvoiceByIdOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing";

    /** undefined */
    @path
    @segment("billingAccounts")
    @key
    default: "default";
  },
  {},
  {
    /** The ID that uniquely identifies an invoice. */
    @path
    @segment("invoices")
    @key
    @pattern(InvoicePattern)
    invoiceName: string;
  },
  "DefaultBillingInvoice"
>;

@armResourceOperations(#{ omitTags: true })
interface InvoiceById {
  /**
   * Gets an invoice by ID. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  @tag("Invoice")
  get is InvoiceByIdOps.Read<Invoice>;
}

@@doc(Invoice.name, "The ID that uniquely identifies an invoice.");
@@doc(Invoice.properties, "An invoice.");
