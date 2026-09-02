using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects.Beta {
  interface VoiceAgentWebSocket {}
  @@clientLocation(
    Azure.AI.Projects.VoiceAgentWebSocket.connectVoiceAgent,
    VoiceAgentWebSocket
  );

  interface AgentEndpointConversations {}
  @@clientLocation(
    Azure.AI.Projects.AgentEndpointConversations.listAgentConversations,
    AgentEndpointConversations
  );
  @@clientLocation(
    Azure.AI.Projects.AgentEndpointConversations.getAgentConversation,
    AgentEndpointConversations
  );
  @@clientLocation(
    Azure.AI.Projects.AgentEndpointConversations.deleteAgentConversation,
    AgentEndpointConversations
  );
  @@clientLocation(
    Azure.AI.Projects.AgentEndpointConversations.listAgentConversationResponses,
    AgentEndpointConversations
  );
  @@clientLocation(
    Azure.AI.Projects.AgentEndpointConversations.getAgentConversationResponse,
    AgentEndpointConversations
  );
  @@clientLocation(
    Azure.AI.Projects.AgentEndpointConversations.listAgentConversationResponseItems,
    AgentEndpointConversations
  );
  @@clientLocation(
    Azure.AI.Projects.AgentEndpointConversations.listAgentConversationItems,
    AgentEndpointConversations
  );
  @@clientLocation(
    Azure.AI.Projects.AgentEndpointConversations.getAgentConversationItem,
    AgentEndpointConversations
  );
  @@clientLocation(
    Azure.AI.Projects.AgentEndpointConversations.getAgentConversationItemAudio,
    AgentEndpointConversations
  );
  @@clientLocation(
    Azure.AI.Projects.AgentEndpointConversations.getAgentConversationItemAudioContent,
    AgentEndpointConversations
  );
  @@clientLocation(
    Azure.AI.Projects.AgentEndpointConversations.getAgentConversationAudio,
    AgentEndpointConversations
  );
  @@clientLocation(
    Azure.AI.Projects.AgentEndpointConversations.getAgentConversationAudioContent,
    AgentEndpointConversations
  );
}
