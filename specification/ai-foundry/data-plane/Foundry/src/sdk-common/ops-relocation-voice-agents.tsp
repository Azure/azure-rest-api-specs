using Azure.ClientGenerator.Core;
using Azure.AI.Projects;

namespace Azure.AI.Projects.Beta {
  interface Agents {}
  @@clientLocation(Azure.AI.Projects.Agents.generateAgent, Agents);
  @@clientName(Azure.AI.Projects.Agents.generateAgent, "createFromPrompt");
}

namespace Azure.AI.Projects.Beta.VoiceAgents {
  interface Realtime {}
  @@clientLocation(VoiceAgentWebSocket.connectVoiceAgent, Realtime);
  @@access(VoiceAgentWebSocket.connectVoiceAgent, Access.internal);

  interface Conversations {}
  @@clientLocation(
    AgentEndpointConversations.listAgentConversations,
    Conversations
  );
  @@clientName(AgentEndpointConversations.listAgentConversations, "list");
  @@clientLocation(
    AgentEndpointConversations.getAgentConversation,
    Conversations
  );
  @@clientName(AgentEndpointConversations.getAgentConversation, "get");
  @@clientLocation(
    AgentEndpointConversations.deleteAgentConversation,
    Conversations
  );
  @@clientName(AgentEndpointConversations.deleteAgentConversation, "delete");
  @@clientLocation(
    AgentEndpointConversations.listAgentConversationResponses,
    Conversations
  );
  @@clientName(
    AgentEndpointConversations.listAgentConversationResponses,
    "listResponses"
  );
  @@clientLocation(
    AgentEndpointConversations.getAgentConversationResponse,
    Conversations
  );
  @@clientName(
    AgentEndpointConversations.getAgentConversationResponse,
    "getResponse"
  );
  @@clientLocation(
    AgentEndpointConversations.listAgentConversationResponseItems,
    Conversations
  );
  @@clientName(
    AgentEndpointConversations.listAgentConversationResponseItems,
    "listResponseItems"
  );
  @@clientLocation(
    AgentEndpointConversations.listAgentConversationItems,
    Conversations
  );
  @@clientName(
    AgentEndpointConversations.listAgentConversationItems,
    "listItems"
  );
  @@clientLocation(
    AgentEndpointConversations.getAgentConversationItem,
    Conversations
  );
  @@clientName(AgentEndpointConversations.getAgentConversationItem, "getItem");
  @@clientLocation(
    AgentEndpointConversations.getAgentConversationItemAudio,
    Conversations
  );
  @@clientName(
    AgentEndpointConversations.getAgentConversationItemAudio,
    "getAudioItem"
  );
  @@clientLocation(
    AgentEndpointConversations.getAgentConversationItemAudioContent,
    Conversations
  );
  @@clientName(
    AgentEndpointConversations.getAgentConversationItemAudioContent,
    "downloadAudioItem"
  );
  @@clientLocation(
    AgentEndpointConversations.getAgentConversationItemGeneratedAudio,
    Conversations
  );
  @@clientName(
    AgentEndpointConversations.getAgentConversationItemGeneratedAudio,
    "getGeneratedAudioItem"
  );
  @@clientLocation(
    AgentEndpointConversations.getAgentConversationItemGeneratedAudioContent,
    Conversations
  );
  @@clientName(
    AgentEndpointConversations.getAgentConversationItemGeneratedAudioContent,
    "downloadGeneratedAudioItem"
  );
  @@clientLocation(
    AgentEndpointConversations.getAgentConversationAudio,
    Conversations
  );
  @@clientName(
    AgentEndpointConversations.getAgentConversationAudio,
    "getAudio"
  );
  @@clientLocation(
    AgentEndpointConversations.getAgentConversationAudioContent,
    Conversations
  );
  @@clientName(
    AgentEndpointConversations.getAgentConversationAudioContent,
    "downloadAudio"
  );

  interface Telephony {}
  @@clientLocation(AgentTelephony.createTelephonyBinding, Telephony);
  @@clientName(AgentTelephony.createTelephonyBinding, "createBinding");
  @@clientLocation(AgentTelephony.listTelephonyBindings, Telephony);
  @@clientName(AgentTelephony.listTelephonyBindings, "listBindings");
  @@clientLocation(AgentTelephony.getTelephonyBinding, Telephony);
  @@clientName(AgentTelephony.getTelephonyBinding, "getBinding");
  @@clientLocation(AgentTelephony.updateTelephonyBinding, Telephony);
  @@clientName(AgentTelephony.updateTelephonyBinding, "updateBinding");
  @@clientLocation(AgentTelephony.deleteTelephonyBinding, Telephony);
  @@clientName(AgentTelephony.deleteTelephonyBinding, "deleteBinding");
  @@clientLocation(AgentTelephony.listTelephonyCalls, Telephony);
  @@clientName(AgentTelephony.listTelephonyCalls, "listCalls");
  @@clientLocation(AgentTelephony.getTelephonyCall, Telephony);
  @@clientName(AgentTelephony.getTelephonyCall, "getCall");
  @@clientLocation(AgentTelephony.transferTelephonyCall, Telephony);
  @@clientName(AgentTelephony.transferTelephonyCall, "transferCall");
  @@clientLocation(AgentTelephony.endTelephonyCall, Telephony);
  @@clientName(AgentTelephony.endTelephonyCall, "endCall");
  @@clientLocation(AgentTelephony.getTelephonyTransferTargets, Telephony);
  @@clientName(
    AgentTelephony.getTelephonyTransferTargets,
    "getTransferTargets"
  );
  @@clientLocation(AgentTelephony.replaceTelephonyTransferTargets, Telephony);
  @@clientName(
    AgentTelephony.replaceTelephonyTransferTargets,
    "replaceTransferTargets"
  );
  @@clientLocation(AgentTelephony.createTelephonyCallJob, Telephony);
  @@clientName(AgentTelephony.createTelephonyCallJob, "createCallJob");
  @@clientLocation(AgentTelephony.getTelephonyCallJob, Telephony);
  @@clientName(AgentTelephony.getTelephonyCallJob, "getCallJob");
  @@clientLocation(AgentTelephony.cancelTelephonyCallJob, Telephony);
  @@clientName(AgentTelephony.cancelTelephonyCallJob, "cancelCallJob");
  @@clientLocation(AgentTelephony.createTelephonyCampaign, Telephony);
  @@clientName(AgentTelephony.createTelephonyCampaign, "createCampaign");
  @@clientLocation(AgentTelephony.getTelephonyCampaign, Telephony);
  @@clientName(AgentTelephony.getTelephonyCampaign, "getCampaign");
  @@clientLocation(AgentTelephony.importTelephonyCampaignRecipients, Telephony);
  @@clientName(
    AgentTelephony.importTelephonyCampaignRecipients,
    "importCampaignRecipients"
  );
  @@clientLocation(
    AgentTelephony.getTelephonyCampaignRecipientImport,
    Telephony
  );
  @@clientName(
    AgentTelephony.getTelephonyCampaignRecipientImport,
    "getCampaignRecipientImport"
  );
  @@clientLocation(AgentTelephony.validateTelephonyCampaign, Telephony);
  @@clientName(AgentTelephony.validateTelephonyCampaign, "validateCampaign");
  @@clientLocation(AgentTelephony.publishTelephonyCampaign, Telephony);
  @@clientName(AgentTelephony.publishTelephonyCampaign, "publishCampaign");
  @@clientLocation(AgentTelephony.pauseTelephonyCampaign, Telephony);
  @@clientName(AgentTelephony.pauseTelephonyCampaign, "pauseCampaign");
  @@clientLocation(AgentTelephony.resumeTelephonyCampaign, Telephony);
  @@clientName(AgentTelephony.resumeTelephonyCampaign, "resumeCampaign");
  @@clientLocation(AgentTelephony.cancelTelephonyCampaign, Telephony);
  @@clientName(AgentTelephony.cancelTelephonyCampaign, "cancelCampaign");
  @@clientLocation(AgentTelephony.getTelephonyOperation, Telephony);
  @@clientName(AgentTelephony.getTelephonyOperation, "getOperation");
}
