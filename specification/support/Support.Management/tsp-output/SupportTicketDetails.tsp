import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Support;
/**
 * Object that represents SupportTicketDetails resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@subscriptionResource
@Azure.ResourceManager.Private.armResourceInternal(
  SupportTicketDetailsProperties
)
@includeInapplicableMetadataInPayload(false)
model SupportTicketDetails extends ProxyResourceBase {
  /**
   * Support ticket name.
   */
  @path
  @key("supportTicketName")
  @segment("supportTickets")
  name: string;

  /**
   * Properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SupportTicketDetailsProperties;
}

@armResourceOperations
@projectedName("client", "SupportTicketDetails")
interface SupportTicketDetailsOperationGroup {
  /**
   * Get ticket details for an Azure subscription. Support ticket data is available for 18 months after ticket creation. If a ticket was created more than 18 months ago, a request for data might cause an error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SupportTickets_Get")
  get is ArmResourceRead<SupportTicketDetails>;

  /**
   * Creates a new support ticket for Subscription and Service limits (Quota), Technical, Billing, and Subscription Management issues for the specified subscription. Learn the [prerequisites](https://aka.ms/supportAPI) required to create a support ticket.&lt;br/&gt;&lt;br/&gt;Always call the Services and ProblemClassifications API to get the most recent set of services and problem categories required for support ticket creation.&lt;br/&gt;&lt;br/&gt;Adding attachments is not currently supported via the API. To add a file to an existing support ticket, visit the [Manage support ticket](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/managesupportrequest) page in the Azure portal, select the support ticket, and use the file upload control to add a new file.&lt;br/&gt;&lt;br/&gt;Providing consent to share diagnostic information with Azure support is currently not supported via the API. The Azure support engineer working on your ticket will reach out to you for consent if your issue requires gathering diagnostic information from your Azure resources.&lt;br/&gt;&lt;br/&gt;**Creating a support ticket for on-behalf-of**: Include _x-ms-authorization-auxiliary_ header to provide an auxiliary token as per [documentation](https://docs.microsoft.com/azure/azure-resource-manager/management/authenticate-multi-tenant). The primary token will be from the tenant for whom a support ticket is being raised against the subscription, i.e. Cloud solution provider (CSP) customer tenant. The auxiliary token will be from the Cloud solution provider (CSP) partner tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SupportTickets_Create")
  create is ArmResourceCreateOrReplaceAsync<
    SupportTicketDetails,
    BaseParameters<SupportTicketDetails>,
    ArmAsyncOperationHeader
  >;

  /**
   * This API allows you to update the severity level, ticket status, advanced diagnostic consent and your contact information in the support ticket.&lt;br/&gt;&lt;br/&gt;Note: The severity levels cannot be changed if a support ticket is actively being worked upon by an Azure support engineer. In such a case, contact your support engineer to request severity update by adding a new communication using the Communications API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("SupportTickets_Update")
  update is ArmCustomPatchSync<SupportTicketDetails, UpdateSupportTicket>;

  /**
   * Lists all the support tickets for an Azure subscription. You can also filter the support tickets by _Status_, _CreatedDate_, _ServiceId_, and _ProblemClassificationId_ using the $filter parameter. Output will be a paged result with _nextLink_, using which you can retrieve the next set of support tickets. &lt;br/&gt;&lt;br/&gt;Support ticket data is available for 18 months after ticket creation. If a ticket was created more than 18 months ago, a request for data might cause an error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SupportTickets_List")
  list is ArmResourceListByParent<
    SupportTicketDetails,
    {
      ...BaseParameters<SupportTicketDetails>;

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
    }
  >;

  /**
   * Check the availability of a resource name. This API should be used to check the uniqueness of the name for adding a new communication to the support ticket.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Communications_CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    SupportTicketDetails,
    CheckNameAvailabilityInput,
    CheckNameAvailabilityOutput
  >;

  /**
   * Check the availability of a resource name. This API should be used to check the uniqueness of the name for support ticket creation for the selected subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SupportTickets_CheckNameAvailability")
  checkNameAvailability is checkGlobalNameAvailability<
    CheckNameAvailabilityInput,
    CheckNameAvailabilityOutput
  >;
}

@@projectedName(SupportTicketDetailsOperationGroup.create::parameters.resource,
  "json",
  "createSupportTicketParameters"
);
@@extension(SupportTicketDetailsOperationGroup.create::parameters.resource,
  "x-ms-client-name",
  "createSupportTicketParameters"
);
@@doc(SupportTicketDetailsOperationGroup.create::parameters.resource,
  "Support ticket request payload."
);
@@projectedName(SupportTicketDetailsOperationGroup.update::parameters.properties,
  "json",
  "updateSupportTicket"
);
@@extension(SupportTicketDetailsOperationGroup.update::parameters.properties,
  "x-ms-client-name",
  "updateSupportTicket"
);
@@doc(SupportTicketDetailsOperationGroup.update::parameters.properties,
  "UpdateSupportTicket object."
);
@@projectedName(SupportTicketDetailsOperationGroup.checkNameAvailability::parameters.body,
  "json",
  "checkNameAvailabilityInput"
);
@@extension(SupportTicketDetailsOperationGroup.checkNameAvailability::parameters.body,
  "x-ms-client-name",
  "checkNameAvailabilityInput"
);
@@doc(SupportTicketDetailsOperationGroup.checkNameAvailability::parameters.body,
  "Input to check."
);
