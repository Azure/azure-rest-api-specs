import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./Agent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Agents;

namespace Microsoft.Contoso;

/** Note, we would need to alter this rule to allow the status property or add a provisioning state */
/** rp-specific properties for contoso agent */
model ContosoAgentProperties is AgentProperties {
  ...AgentToolProperty;
  ...DefaultProvisioningStateProperty;
}

model ContosoConversationProperties is ConversationProperties {
  ...DefaultProvisioningStateProperty;
  ...AgentInstructionsProperty;
}

model ContosoResponseProperties is ResponseProperties {
  ...PreviousResponseProperty;
  ...DefaultProvisioningStateProperty;
}

@@visibility(ContosoResponseProperties.previous_response_id, Lifecycle.Read);

model ContosoAgent is Agent<ContosoAgentProperties> {
  ...ResourceNameParameter<ContosoAgent>;
}

@parentResource(ContosoAgent)
model ContosoResponse is ProxyResource<ContosoResponseProperties> {
  ...ResourceNameParameter<ContosoResponse>;
}

@parentResource(ContosoAgent)
model ContosoConversation is ProxyResource<ContosoConversationProperties> {
  ...ResourceNameParameter<ContosoConversation>;
}

@armResourceOperations(ContosoAgent)
interface ContosoAgents {
  get is ArmResourceRead<ContosoAgent>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ContosoAgent>;
  update is ArmTagsPatchSync<ContosoAgent>;
  delete is ArmResourceDeleteWithoutOkAsync<ContosoAgent>;
  listBySubscription is ArmListBySubscription<ContosoAgent>;
  listByResourceGroup is ArmResourceListByParent<ContosoAgent>;
}

@armResourceOperations(ContosoAgent)
interface Conversations {
  get is ArmResourceRead<ContosoConversation>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ContosoConversation>;
  update is ArmCustomPatchSync<
    ContosoConversation,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ContosoConversation,
      ContosoConversationProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ContosoConversation>;
  listByAgent is ArmResourceListByParent<ContosoConversation>;
}

@armResourceOperations(ContosoAgent)
interface Responses {
  get is ArmResourceRead<ContosoResponse>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ContosoResponse>;
  update is ArmCustomPatchSync<
    ContosoResponse,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ContosoResponse,
      ContosoResponseProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ContosoResponse>;
  listByAgent is ArmResourceListByParent<ContosoResponse>;
}
