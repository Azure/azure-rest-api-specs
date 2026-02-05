import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SupportTicketDetails.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Support;
/**
 * Object that represents a Communication resource.
 */
@parentResource(SupportTicketDetails)
model CommunicationDetails
  is Azure.ResourceManager.ProxyResource<
    CommunicationDetailsProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = CommunicationDetails,
    KeyName = "communicationName",
    SegmentName = "communications",
    NamePattern = ""
  >;
}

/**
 * [Placeholder] Description for page model
 */
model CommunicationsListResult {
  /**
   * [Placeholder] Description for nextLink property
   */
  @nextLink
  nextLink?: string;

  /**
   * [Placeholder] Description for value property
   */
  @pageItems
  value?: CommunicationDetails[];
}

@armResourceOperations
interface CommunicationOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = SupportTicketDetails,
          KeyName = "supportTicketName",
          SegmentName = "supportTickets",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = CommunicationDetails,
        KeyName = "communicationName",
        SegmentName = "communications",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface Communications {
  /**
   * Returns communication details for a support ticket.
   */
  get is CommunicationOps.Read<CommunicationDetails>;

  /**
   * Adds a new customer communication to an Azure support ticket.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is CommunicationOps.CreateOrUpdateAsync<
    CommunicationDetails,
    Response = ArmResourceUpdatedResponse<CommunicationDetails> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = CommunicationDetails> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Lists all communications (attachments not included) for a support ticket. <br/></br> You can also filter support ticket communications by _CreatedDate_ or _CommunicationType_ using the $filter parameter. The only type of communication supported today is _Web_. Output will be a paged result with _nextLink_, using which you can retrieve the next set of Communication results. <br/><br/>Support ticket data is available for 18 months after ticket creation. If a ticket was created more than 18 months ago, a request for data might cause an error.
   */
  list is CommunicationOps.List<
    CommunicationDetails,
    Parameters = {
      /**
       * The number of values to return in the collection. Default is 10 and max is 10.
       */
      @query("$top")
      $top?: int32;

      /**
       * The filter to apply on the operation. You can filter by communicationType and createdDate properties. CommunicationType supports Equals ('eq') operator and createdDate supports Greater Than ('gt') and Greater Than or Equals ('ge') operators. You may combine the CommunicationType and CreatedDate filters by Logical And ('and') operator.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = CommunicationsListResult
  >;
}
@armResourceOperations
interface CommunicationsNoSubscriptionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = SupportTicketDetails,
          KeyName = "supportTicketName",
          SegmentName = "supportTickets",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = CommunicationDetails,
        KeyName = "communicationName",
        SegmentName = "communications",
        NamePattern = ""
      >>
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "For backward compatibility"
@armResourceOperations
interface CommunicationsNoSubscription {
  /**
   * Returns communication details for a support ticket.
   */
  get is CommunicationsNoSubscriptionOps.Read<CommunicationDetails>;

  /**
   * Adds a new customer communication to an Azure support ticket.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is CommunicationsNoSubscriptionOps.CreateOrUpdateAsync<
    CommunicationDetails,
    Response = ArmResourceUpdatedResponse<CommunicationDetails> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = CommunicationDetails> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Lists all communications (attachments not included) for a support ticket. <br/></br> You can also filter support ticket communications by _CreatedDate_ or _CommunicationType_ using the $filter parameter. The only type of communication supported today is _Web_. Output will be a paged result with _nextLink_, using which you can retrieve the next set of Communication results. <br/><br/>Support ticket data is available for 18 months after ticket creation. If a ticket was created more than 18 months ago, a request for data might cause an error.
   */
  list is CommunicationsNoSubscriptionOps.List<
    CommunicationDetails,
    Parameters = {
      /**
       * The number of values to return in the collection. Default is 10 and max is 10.
       */
      @query("$top")
      $top?: int32;

      /**
       * The filter to apply on the operation. You can filter by communicationType and createdDate properties. CommunicationType supports Equals ('eq') operator and createdDate supports Greater Than ('gt') and Greater Than or Equals ('ge') operators. You may combine the CommunicationType and CreatedDate filters by Logical And ('and') operator.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = CommunicationsListResult
  >;
}

@@doc(CommunicationDetails.name, "Communication name.");
@@doc(CommunicationDetails.properties, "Properties of the resource.");
@@doc(Communications.create::parameters.resource, "Communication object.");
@@doc(CommunicationsNoSubscription.create::parameters.resource,
  "Communication object."
);
