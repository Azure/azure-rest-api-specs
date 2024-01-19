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
@doc("Object that represents a Communication resource.")
@parentResource(SupportTicketDetails)
model CommunicationDetails is ProxyResource<CommunicationDetailsProperties> {
  @doc("Communication name.")
  @path
  @key("communicationName")
  @segment("communications")
  name: string;
}

@armResourceOperations
@projectedName("client", "CommunicationDetails")
interface CommunicationDetailsOperationGroup {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns communication details for a support ticket.")
  @operationId("Communications_Get")
  get is ArmResourceRead<CommunicationDetails>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Adds a new customer communication to an Azure support ticket.")
  @operationId("Communications_Create")
  create is ArmResourceCreateOrUpdateAsync<
    CommunicationDetails,
    BaseParameters<CommunicationDetails>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all communications (attachments not included) for a support ticket. &lt;br/&gt;&lt;/br&gt; You can also filter support ticket communications by _CreatedDate_ or _CommunicationType_ using the $filter parameter. The only type of communication supported today is _Web_. Output will be a paged result with _nextLink_, using which you can retrieve the next set of Communication results. &lt;br/&gt;&lt;br/&gt;Support ticket data is available for 18 months after ticket creation. If a ticket was created more than 18 months ago, a request for data might cause an error.")
  @operationId("Communications_List")
  list is ArmResourceListByParent<
    CommunicationDetails,
    {
      ...BaseParameters<CommunicationDetails>;

      @doc("The number of values to return in the collection. Default is 10 and max is 10.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation. You can filter by communicationType and createdDate properties. CommunicationType supports Equals ('eq') operator and createdDate supports Greater Than ('gt') and Greater Than or Equals ('ge') operators. You may combine the CommunicationType and CreatedDate filters by Logical And ('and') operator.")
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
