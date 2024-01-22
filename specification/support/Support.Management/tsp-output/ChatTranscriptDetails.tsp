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
 * Object that represents a Chat Transcript resource.
 */
@parentResource(SupportTicketDetails)
model ChatTranscriptDetails is ProxyResource<ChatTranscriptDetailsProperties> {
  /**
   * ChatTranscript name.
   */
  @path
  @key("chatTranscriptName")
  @segment("chatTranscripts")
  name: string;
}

@armResourceOperations
@projectedName("client", "ChatTranscriptDetails")
interface ChatTranscriptDetailsOperationGroup {
  /**
   * Returns chatTranscript details for a support ticket under a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ChatTranscripts_Get")
  get is ArmResourceRead<ChatTranscriptDetails>;

  /**
   * Lists all chat transcripts for a support ticket under subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ChatTranscripts_List")
  list is ArmResourceListByParent<ChatTranscriptDetails>;
}
