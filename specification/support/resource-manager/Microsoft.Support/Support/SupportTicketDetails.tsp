import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Support;
/**
 * Object that represents SupportTicketDetails resource.
 */
@subscriptionResource
model SupportTicketDetails
  is Azure.ResourceManager.ProxyResource<
    SupportTicketDetailsProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = SupportTicketDetails,
    KeyName = "supportTicketName",
    SegmentName = "supportTickets",
    NamePattern = ""
  >;
}

/**
 * [Placeholder] Description for page model
 */
model SupportTicketsListResult {
  /**
   * [Placeholder] Description for nextLink property
   */
  @nextLink
  nextLink?: string;

  /**
   * [Placeholder] Description for value property
   */
  @pageItems
  value?: SupportTicketDetails[];
}

@armResourceOperations
interface SupportTicketOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = SupportTicketDetails,
        KeyName = "supportTicketName",
        SegmentName = "supportTickets",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface SupportTickets {
  /**
   * Get ticket details for an Azure subscription. Support ticket data is available for 18 months after ticket creation. If a ticket was created more than 18 months ago, a request for data might cause an error.
   */
  get is SupportTicketOps.Read<SupportTicketDetails>;

  /**
   * Creates a new support ticket for Subscription and Service limits (Quota), Technical, Billing, and Subscription Management issues for the specified subscription. Learn the [prerequisites](https://aka.ms/supportAPI) required to create a support ticket.<br/><br/>Always call the Services and ProblemClassifications API to get the most recent set of services and problem categories required for support ticket creation.<br/><br/>Adding attachments is not currently supported via the API. To add a file to an existing support ticket, visit the [Manage support ticket](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/managesupportrequest) page in the Azure portal, select the support ticket, and use the file upload control to add a new file.<br/><br/>Providing consent to share diagnostic information with Azure support is currently not supported via the API. The Azure support engineer working on your ticket will reach out to you for consent if your issue requires gathering diagnostic information from your Azure resources.<br/><br/>**Creating a support ticket for on-behalf-of**: Include _x-ms-authorization-auxiliary_ header to provide an auxiliary token as per [documentation](https://docs.microsoft.com/azure/azure-resource-manager/management/authenticate-multi-tenant). The primary token will be from the tenant for whom a support ticket is being raised against the subscription, i.e. Cloud solution provider (CSP) customer tenant. The auxiliary token will be from the Cloud solution provider (CSP) partner tenant.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is SupportTicketOps.CreateOrUpdateAsync<
    SupportTicketDetails,
    Response = ArmResourceUpdatedResponse<SupportTicketDetails> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = SupportTicketDetails> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * This API allows you to update the severity level, ticket status, advanced diagnostic consent and your contact information in the support ticket.<br/><br/>Note: The severity levels cannot be changed if a support ticket is actively being worked upon by an Azure support engineer. In such a case, contact your support engineer to request severity update by adding a new communication using the Communications API.
   */
  @patch(#{ implicitOptionality: false })
  update is SupportTicketOps.CustomPatchSync<
    SupportTicketDetails,
    PatchModel = UpdateSupportTicket
  >;

  /**
   * Lists all the support tickets for an Azure subscription. You can also filter the support tickets by _Status_, _CreatedDate_, _ServiceId_, and _ProblemClassificationId_ using the $filter parameter. Output will be a paged result with _nextLink_, using which you can retrieve the next set of support tickets. <br/><br/>Support ticket data is available for 18 months after ticket creation. If a ticket was created more than 18 months ago, a request for data might cause an error.
   */
  list is SupportTicketOps.List<
    SupportTicketDetails,
    Parameters = {
      /**
       * The number of values to return in the collection. Default is 25 and max is 100.
       */
      @query("$top")
      $top?: int32;

      /**
       * The filter to apply on the operation. We support 'odata v4.0' filter semantics. [Learn more](https://docs.microsoft.com/odata/concepts/queryoptions-overview). _Status_, _ServiceId_, and _ProblemClassificationId_ filters can only be used with Equals ('eq') operator. For _CreatedDate_ filter, the supported operators are Greater Than ('gt') and Greater Than or Equals ('ge'). When using both filters, combine them using the logical 'AND'.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = SupportTicketsListResult
  >;

  /**
   * Check the availability of a resource name. This API should be used to check the uniqueness of the name for adding a new communication to the support ticket.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  checkNameAvailability is SupportTicketOps.ActionSync<
    SupportTicketDetails,
    CheckNameAvailabilityInput,
    ArmResponse<CheckNameAvailabilityOutput>
  >;
}
@armResourceOperations
interface SupportTicketsNoSubscriptionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = SupportTicketDetails,
        KeyName = "supportTicketName",
        SegmentName = "supportTickets",
        NamePattern = ""
      >>
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "For backward compatibility"
@armResourceOperations
interface SupportTicketsNoSubscription {
  /**
   * Gets details for a specific support ticket. Support ticket data is available for 18 months after ticket creation. If a ticket was created more than 18 months ago, a request for data might cause an error.
   */
  get is SupportTicketsNoSubscriptionOps.Read<SupportTicketDetails>;

  /**
   * Creates a new support ticket for Billing, and Subscription Management issues. Learn the [prerequisites](https://aka.ms/supportAPI) required to create a support ticket.<br/><br/>Always call the Services and ProblemClassifications API to get the most recent set of services and problem categories required for support ticket creation.<br/><br/>Adding attachments is not currently supported via the API. To add a file to an existing support ticket, visit the [Manage support ticket](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/managesupportrequest) page in the Azure portal, select the support ticket, and use the file upload control to add a new file.<br/><br/>Providing consent to share diagnostic information with Azure support is currently not supported via the API. The Azure support engineer working on your ticket will reach out to you for consent if your issue requires gathering diagnostic information from your Azure resources.<br/><br/>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is SupportTicketsNoSubscriptionOps.CreateOrUpdateAsync<
    SupportTicketDetails,
    Response = ArmResourceUpdatedResponse<SupportTicketDetails> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = SupportTicketDetails> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * This API allows you to update the severity level, ticket status, and your contact information in the support ticket.<br/><br/>Note: The severity levels cannot be changed if a support ticket is actively being worked upon by an Azure support engineer. In such a case, contact your support engineer to request severity update by adding a new communication using the Communications API.
   */
  @patch(#{ implicitOptionality: false })
  update is SupportTicketsNoSubscriptionOps.CustomPatchSync<
    SupportTicketDetails,
    PatchModel = UpdateSupportTicket
  >;

  /**
   * Lists all the support tickets. <br/><br/>You can also filter the support tickets by <i>Status</i>, <i>CreatedDate</i>, , <i>ServiceId</i>, and <i>ProblemClassificationId</i> using the $filter parameter. Output will be a paged result with <i>nextLink</i>, using which you can retrieve the next set of support tickets. <br/><br/>Support ticket data is available for 18 months after ticket creation. If a ticket was created more than 18 months ago, a request for data might cause an error.
   */
  list is SupportTicketsNoSubscriptionOps.List<
    SupportTicketDetails,
    Parameters = {
      /**
       * The number of values to return in the collection. Default is 25 and max is 100.
       */
      @query("$top")
      $top?: int32;

      /**
       * The filter to apply on the operation. We support 'odata v4.0' filter semantics. <a target='_blank' href='https://docs.microsoft.com/odata/concepts/queryoptions-overview'>Learn more</a> <br/><i>Status</i> , <i>ServiceId</i>, and <i>ProblemClassificationId</i> filters can only be used with 'eq' operator. For <i>CreatedDate</i> filter, the supported operators are 'gt' and 'ge'. When using both filters, combine them using the logical 'AND'.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = SupportTicketsListResult
  >;

  /**
   * Check the availability of a resource name. This API should be used to check the uniqueness of the name for adding a new communication to the support ticket.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  checkNameAvailability is SupportTicketsNoSubscriptionOps.ActionSync<
    SupportTicketDetails,
    CheckNameAvailabilityInput,
    ArmResponse<CheckNameAvailabilityOutput>
  >;
}

@@doc(SupportTicketDetails.name, "Support ticket name.");
@@doc(SupportTicketDetails.properties, "Properties of the resource.");
@@doc(SupportTickets.create::parameters.resource,
  "Support ticket request payload."
);
@@doc(SupportTickets.update::parameters.properties,
  "UpdateSupportTicket object."
);
@@doc(SupportTickets.checkNameAvailability::parameters.body, "Input to check.");
@@doc(SupportTicketsNoSubscription.create::parameters.resource,
  "Support ticket request payload."
);
@@doc(SupportTicketsNoSubscription.update::parameters.properties,
  "UpdateSupportTicket object."
);
@@doc(SupportTicketsNoSubscription.checkNameAvailability::parameters.body,
  "Input to check."
);
