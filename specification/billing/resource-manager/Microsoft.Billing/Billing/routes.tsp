import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Billing;

@armResourceOperations(#{ omitTags: true })
interface AddressOperationGroup {
  /**
   * Validates an address. Use the operation to validate an address before using it as soldTo or a billTo address.
   */
  @tag("BillingAccount")
  @autoRoute
  @action("validateAddress")
  validate is ArmProviderActionSync<
    Request = AddressDetails,
    Response = AddressValidationResponse
  >;
}

@armResourceOperations(#{ omitTags: true })
interface InvoicesOperationGroup {
  /**
   * Gets a URL to download multiple invoice documents (invoice pdf, tax receipts, credit notes) as a zip file. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  @tag("Invoice")
  @autoRoute
  @action("downloadDocuments")
  @post
  @armResourceAction(DocumentDownloadResult)
  downloadDocumentsByBillingSubscription(
    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing",

    /** undefined */
    @path
    @segment("billingAccounts")
    @key
    default: "default",

    /** The ID that uniquely identifies a billing subscription. */
    @path
    @segment("billingSubscriptions")
    @key
    @pattern(GuidPattern)
    subscriptionId: string,

    ...ApiVersionParameter,

    /** A list of download details for individual documents. */
    #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing documentation uses array as the body. Back compat."
    @body
    @identifiers(#[])
    downloadUrls: DocumentDownloadRequest[],
  ):
    | ArmResponse<DocumentDownloadResult>
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        LroHeaders = ArmLroLocationHeader<FinalResult = DocumentDownloadResult>
      >
    | ErrorResponse;
}
