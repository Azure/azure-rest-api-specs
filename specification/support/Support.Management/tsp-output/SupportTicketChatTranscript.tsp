import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SubscriptionSupportTicket.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Support;
@doc("Object that represents a Chat Transcript resource.")
@parentResource(SubscriptionSupportTicket)
model SupportTicketChatTranscript
  is ProxyResource<ChatTranscriptDetailsProperties> {
  @doc("ChatTranscript name.")
  @path
  @key("chatTranscriptName")
  @segment("chatTranscripts")
  name: string;
}

@armResourceOperations
interface SupportTicketChatTranscripts {
  @doc("Returns chatTranscript details for a support ticket under a subscription.")
  get is ArmResourceRead<SupportTicketChatTranscript>;
  @doc("Lists all chat transcripts for a support ticket under subscription")
  list is ArmResourceListByParent<SupportTicketChatTranscript>;
}
