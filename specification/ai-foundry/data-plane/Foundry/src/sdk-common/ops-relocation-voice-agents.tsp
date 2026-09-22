using Azure.ClientGenerator.Core;
using Azure.AI.Projects;

namespace Azure.AI.Projects.Beta {
  interface Agents {}
  @@clientLocation(Azure.AI.Projects.Agents.generateAgent, Agents);
}

namespace Azure.AI.Projects.Beta.VoiceAgents {
  interface Campaigns {}
  @@clientLocation(TelephonyCampaigns.start, Campaigns);
  @@clientLocation(TelephonyCampaigns.getOperation, Campaigns);
  @@clientLocation(TelephonyCampaigns.create, Campaigns);
  @@clientLocation(TelephonyCampaigns.get, Campaigns);
  @@clientLocation(TelephonyCampaigns.list, Campaigns);
  @@clientLocation(TelephonyCampaigns.cancel, Campaigns);
  @@clientLocation(TelephonyCampaigns.delete, Campaigns);
  @@clientLocation(TelephonyCampaigns.pause, Campaigns);
  @@clientLocation(TelephonyCampaigns.listRecipientResults, Campaigns);

  interface Conversations {}
  @@clientLocation(
    AgentEndpointConversations.listAgentConversations,
    Conversations
  );
  @@clientLocation(
    AgentEndpointConversations.getAgentConversation,
    Conversations
  );
  @@clientLocation(
    AgentEndpointConversations.deleteAgentConversation,
    Conversations
  );
  @@clientLocation(
    AgentEndpointConversations.listAgentConversationResponses,
    Conversations
  );
  @@clientLocation(
    AgentEndpointConversations.getAgentConversationResponse,
    Conversations
  );
  @@clientLocation(
    AgentEndpointConversations.listAgentConversationResponseItems,
    Conversations
  );
  @@clientLocation(
    AgentEndpointConversations.listAgentConversationItems,
    Conversations
  );
  @@clientLocation(
    AgentEndpointConversations.getAgentConversationItem,
    Conversations
  );
  @@clientLocation(
    AgentEndpointConversations.getAgentConversationAudioItem,
    Conversations
  );
  @@clientLocation(
    AgentEndpointConversations.getAgentConversationAudioItemContent,
    Conversations
  );
  @@clientLocation(
    AgentEndpointConversations.getAgentConversationGeneratedAudioItem,
    Conversations
  );
  @@clientLocation(
    AgentEndpointConversations.getAgentConversationGeneratedAudioItemContent,
    Conversations
  );
  @@clientLocation(
    AgentEndpointConversations.getAgentConversationAudio,
    Conversations
  );
  @@clientLocation(
    AgentEndpointConversations.getAgentConversationAudioContent,
    Conversations
  );

  interface Telephony {}
  @@clientLocation(AgentTelephony.createTelephonyBinding, Telephony);
  @@clientLocation(AgentTelephony.listTelephonyBindings, Telephony);
  @@clientLocation(AgentTelephony.getTelephonyBinding, Telephony);
  @@clientLocation(AgentTelephony.updateTelephonyBinding, Telephony);
  @@clientLocation(AgentTelephony.deleteTelephonyBinding, Telephony);
  @@clientLocation(AgentTelephony.listTelephonyCalls, Telephony);
  @@clientLocation(AgentTelephony.getTelephonyCall, Telephony);
  @@clientLocation(AgentTelephony.transferTelephonyCall, Telephony);
  @@clientLocation(AgentTelephony.endTelephonyCall, Telephony);
  @@clientLocation(AgentTelephony.getTelephonyTransferTargets, Telephony);
  @@clientLocation(AgentTelephony.replaceTelephonyTransferTargets, Telephony);
  @@clientLocation(AgentTelephony.createTelephonyCallJob, Telephony);
  @@clientLocation(AgentTelephony.getTelephonyCallJob, Telephony);
  @@clientLocation(AgentTelephony.listTelephonyCallJobs, Telephony);
  @@clientLocation(AgentTelephony.deleteTelephonyCallJob, Telephony);
  @@clientLocation(AgentTelephony.cancelTelephonyCallJob, Telephony);
}
