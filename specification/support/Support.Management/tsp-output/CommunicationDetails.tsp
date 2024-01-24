import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SupportTicketDetails.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Support;
/**
 * Object that represents a Communication resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(SupportTicketDetails)
@Azure.ResourceManager.Private.armResourceInternal(
  CommunicationDetailsProperties
)
@includeInapplicableMetadataInPayload(false)
model CommunicationDetails extends ProxyResourceBase {
  /**
   * Communication name.
   */
  @path
  @key("communicationName")
  @segment("communications")
  name: string;

  /**
   * Properties of the resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CommunicationDetailsProperties;
}

@armResourceOperations
@projectedName("client", "CommunicationDetails")
interface CommunicationDetailsOperationGroup {
  /**
   * Returns communication details for a support ticket.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Communications_Get")
  get is ArmResourceRead<CommunicationDetails>;

  /**
   * Adds a new customer communication to an Azure support ticket.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Communications_Create")
  create is ArmResourceCreateOrReplaceAsync<
    CommunicationDetails,
    BaseParameters<CommunicationDetails>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists all communications (attachments not included) for a support ticket. &lt;br/&gt;&lt;/br&gt; You can also filter support ticket communications by _CreatedDate_ or _CommunicationType_ using the $filter parameter. The only type of communication supported today is _Web_. Output will be a paged result with _nextLink_, using which you can retrieve the next set of Communication results. &lt;br/&gt;&lt;br/&gt;Support ticket data is available for 18 months after ticket creation. If a ticket was created more than 18 months ago, a request for data might cause an error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Communications_List")
  list is ArmResourceListByParent<
    CommunicationDetails,
    {
      ...BaseParameters<CommunicationDetails>;

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
    }
  >;
}

@@projectedName(CommunicationDetailsOperationGroup.create::parameters.resource,
  "json",
  "createCommunicationParameters"
);
@@extension(CommunicationDetailsOperationGroup.create::parameters.resource,
  "x-ms-client-name",
  "createCommunicationParameters"
);
@@doc(CommunicationDetailsOperationGroup.create::parameters.resource,
  "Communication object."
);
