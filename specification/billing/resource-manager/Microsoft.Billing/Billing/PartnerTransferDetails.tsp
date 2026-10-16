import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/versioning";
import "./models.tsp";
import "./Customer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Billing;
/**
 * Details of the transfer.
 */
@tenantResource
@parentResource(Customer)
model PartnerTransferDetails
  is Azure.ResourceManager.ProxyResource<PartnerTransferProperties> {
  ...ResourceNameParameter<
    Resource = PartnerTransferDetails,
    KeyName = "transferName",
    SegmentName = "transfers",
    NamePattern = LowerAlphaNumericPattern
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

alias PartnerTransferOperations = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    @removed(Versions.v2024_08_01_preview)
    @path
    @segment("billingProfiles")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    billingProfileName: string;

    /** The ID that uniquely identifies a customer. */
    @path
    @segment("customers")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    customerName: string;
  },
  {},
  {
    /** The ID that uniquely identifies a transfer request. */
    @path
    @segment("transfers")
    @key
    @pattern(LowerAlphaNumericPattern)
    transferName: string;
  },
  "BillingCustomerTransfer"
>;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "A transfer is not a living resource, so it does not support delete operation."
@armResourceOperations(#{ omitTags: true })
interface PartnerTransfers {
  /**
   * Gets a transfer request by ID. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("Transfers")
  get is PartnerTransferOperations.Read<PartnerTransferDetails>;

  /**
   * Sends a request to a user in a customer's billing account to transfer billing ownership of their subscriptions. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("Transfers")
  initiate is PartnerTransferOperations.CreateOrUpdateSync<
    PartnerTransferDetails,
    Request = PartnerTransferDetails
  >;

  /**
   * Lists the transfer requests sent to a customer. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("Transfers")
  list is PartnerTransferOperations.List<
    PartnerTransferDetails,
    Response = ArmResponse<PartnerTransferDetailsListResult>
  >;

  /**
   * Cancels a transfer request. The operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("Transfers")
  @action("cancel")
  cancel is PartnerTransferOperations.ActionSync<
    PartnerTransferDetails,
    void,
    ArmResponse<PartnerTransferDetails>
  >;
}

alias TransferSupportedAccountOperations = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The ID that uniquely identifies a customer. */
    @path
    @segment("customers")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    customerName: string;
  },
  "BillingCustomer"
>;

@added(Versions.v2024_08_01_preview)
@armResourceOperations(#{ omitTags: true })
interface TransferSupportedAccounts {
  /**
   * Gets the accounts that support transfers for a customer.
   */
  @tag("Transfers")
  @get
  @list
  @action("transferSupportedAccounts")
  get is TransferSupportedAccountOperations.ActionSync<
    Customer,
    void,
    ArmResponse<SupportedAccountsDetailsListResult>
  >;
}

@@doc(
  PartnerTransferDetails.name,
  "The ID that uniquely identifies a transfer request."
);
@@doc(PartnerTransferDetails.properties, "Details of the transfer.");
@@typeChangedFrom(
  PartnerTransfers.initiate::parameters.resource,
  Versions.v2024_08_01_preview,
  PartnerInitiateTransferRequest
);
@@doc(
  PartnerTransfers.initiate::parameters.resource,
  "Request parameters that are provided to the initiate transfer operation."
);
