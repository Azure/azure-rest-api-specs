import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SupportTicketDetails.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Support;
@doc("Object that represents a Chat Transcript resource.")
@parentResource(SupportTicketDetails)
model ChatTranscriptDetails is ProxyResource<ChatTranscriptDetailsProperties> {
  @doc("ChatTranscript name.")
  @key("chatTranscriptName")
  @segment("chatTranscripts")
  name: string;
}

@armResourceOperations
@projectedName("client", "ChatTranscripts")
interface ChatTranscriptDetails_ChatTranscripts {
  @doc("Returns chatTranscript details for a support ticket under a subscription.")
  get is ArmResourceRead<ChatTranscriptDetails>;

  @doc("Lists all chat transcripts for a support ticket under subscription")
  list is ArmResourceListByParent<ChatTranscriptDetails>;
}
