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
 * Object that represents a Chat Transcript resource.
 */
@parentResource(SupportTicketDetails)
model ChatTranscriptDetails
  is Azure.ResourceManager.ProxyResource<ChatTranscriptDetailsProperties> {
  ...ResourceNameParameter<
    Resource = ChatTranscriptDetails,
    KeyName = "chatTranscriptName",
    SegmentName = "chatTranscripts",
    NamePattern = ""
  >;
}

/**
 * [Placeholder] Description for page model
 */
model ChatTranscriptsListResult {
  /**
   * [Placeholder] Description for nextLink property
   */
  @nextLink
  nextLink?: string;

  /**
   * [Placeholder] Description for value property
   */
  @pageItems
  value?: ChatTranscriptDetails[];
}

@armResourceOperations
interface ChatTranscriptOps
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
        Resource = ChatTranscriptDetails,
        KeyName = "chatTranscriptName",
        SegmentName = "chatTranscripts",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ChatTranscripts {
  /**
   * Returns chatTranscript details for a support ticket under a subscription.
   */
  get is ChatTranscriptOps.Read<ChatTranscriptDetails>;

  /**
   * Lists all chat transcripts for a support ticket under subscription
   */
  list is ChatTranscriptOps.List<
    ChatTranscriptDetails,
    Response = ChatTranscriptsListResult
  >;
}
@armResourceOperations
interface ChatTranscriptsNoSubscriptionOps
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
        Resource = ChatTranscriptDetails,
        KeyName = "chatTranscriptName",
        SegmentName = "chatTranscripts",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ChatTranscriptsNoSubscription {
  /**
   * Returns chatTranscript details for a no subscription support ticket.
   */
  get is ChatTranscriptsNoSubscriptionOps.Read<ChatTranscriptDetails>;

  /**
   * Lists all chat transcripts for a support ticket
   */
  list is ChatTranscriptsNoSubscriptionOps.List<
    ChatTranscriptDetails,
    Response = ChatTranscriptsListResult
  >;
}

@@doc(ChatTranscriptDetails.name, "ChatTranscript name.");
@@doc(ChatTranscriptDetails.properties, "Properties of the resource.");
