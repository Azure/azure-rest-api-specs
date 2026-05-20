import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./LabDetails.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Education;
/**
 * join requests.
 */
@parentResource(LabDetails)
model JoinRequestDetails
  is Azure.ResourceManager.ProxyResource<JoinRequestProperties> {
  ...ResourceNameParameter<
    Resource = JoinRequestDetails,
    KeyName = "joinRequestName",
    SegmentName = "joinRequests",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the existing invoice-section JoinRequest paths for backward compatibility."
alias InvoiceSectionJoinRequestOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The billing provider namespace. */
    @path
    @segment("providers")
    @key
    billingProviderNamespace: "Microsoft.Billing";

    /** The name of the billing account. */
    @path
    @segment("billingAccounts")
    @key
    billingAccountName: string;

    /** The name of the billing profile. */
    @path
    @segment("billingProfiles")
    @key
    billingProfileName: string;

    /** The name of the invoice section. */
    @path
    @segment("invoiceSections")
    @key
    invoiceSectionName: string;

    ...Legacy.Provider;

    /** The lab name. */
    @path
    @segment("labs")
    @key
    lab: "default";
  },
  {},
  {
    /** The ID that uniquely identifies a join request. */
    @path
    @segment("joinRequests")
    @key
    joinRequestName: string;
  }
>;

@armResourceOperations
@tag("JoinRequest")
interface JoinRequests {
  /**
   * get student join requests
   */
  get is InvoiceSectionJoinRequestOps.Read<
    JoinRequestDetails,
    ErrorType = DefaultErrorResponse
  >;

  /**
   * get student join requests
   */
  list is InvoiceSectionJoinRequestOps.List<
    JoinRequestDetails,
    Parameters = {
      /**
       * Include denied
       */
      @query("includeDenied")
      includeDenied?: boolean;
    },
    Response = ArmResponse<JoinRequestList>,
    ErrorType = DefaultErrorResponse
  >;

  /**
   * Approve student joining the redeemable lab
   */
  @action("approve")
  approve is InvoiceSectionJoinRequestOps.ActionSync<
    JoinRequestDetails,
    void,
    OkResponse,
    ErrorType = DefaultErrorResponse
  >;

  /**
   * Deny student joining the redeemable lab
   */
  @action("deny")
  deny is InvoiceSectionJoinRequestOps.ActionSync<
    JoinRequestDetails,
    void,
    OkResponse,
    ErrorType = DefaultErrorResponse
  >;
}

@@doc(JoinRequestDetails.name,
  "The ID that uniquely identifies a join request."
);
@@doc(JoinRequestDetails.properties, "join request properties.");
