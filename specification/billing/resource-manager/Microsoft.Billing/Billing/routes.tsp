// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Billing;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AddressOperationGroup {
  /**
   * Validates an address. Use the operation to validate an address before using it as soldTo or a billTo address.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("BillingAccount")
  @autoRoute
  @action("validateAddress")
  validate is ArmProviderActionSync<
    Request = AddressDetails,
    Response = AddressValidationResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface InvoicesOperationGroup {
  /**
   * Gets a URL to download multiple invoice documents (invoice pdf, tax receipts, credit notes) as a zip file. The operation is supported for billing accounts with agreement type Microsoft Partner Agreement or Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Invoice")
  @autoRoute
  @action("downloadDocuments")
  @post
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
    @pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
    subscriptionId: string,

    ...ApiVersionParameter,

    /** A list of download details for individual documents. */
    #suppress "@azure-tools/typespec-azure-core/request-body-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @body
    @identifiers(#[])
    downloadUrls: DocumentDownloadRequest[],
  ): ArmResponse<DocumentDownloadResult> | ArmAcceptedLroResponse<
    "Resource operation accepted.",
    LroHeaders = ArmLroLocationHeader<FinalResult = DocumentDownloadResult>
  > | ErrorResponse;
}
