import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.AzureCis;

@doc("EventGridTopicTypeEventTypes properties")
model EventGridTopicTypeEventTypesResourceProperties {
  @doc("Name of the Topic Type. Required.")
  topicTypeName: string;

  @doc("Name of the Event Type. Required.")
  eventTypeName: string;

  @doc("Display Name of the EventType. Required.")
  displayName: string;

  @doc("Description of the EventType. Required.")
  description: string;

  @doc("SchemaUrl of the EventType. Required.")
  schemaUrl: string;

  @doc("If True, the eventType is pre-selected as part of Event Subscription creation process. Optional.")
  isInDefaultSet?: boolean;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: EventGridProvisioningState;
}

@doc("EventGridTopicTypeEventTypes Resource")
model EventGridTopicTypeEventTypesResource
  is ProxyResource<EventGridTopicTypeEventTypesResourceProperties> {
  @doc("The name of the resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("eventGridTopicTypeEventTypes") // Start with lower case. Should be plural
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface EventGridTopicTypeEventTypes {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EventGridTopicTypeEventTypesResource>;
  get is ArmResourceRead<EventGridTopicTypeEventTypesResource>;
  listByResourceGroup is ArmResourceListByParent<EventGridTopicTypeEventTypesResource>;
  listBySubscription is ArmListBySubscription<EventGridTopicTypeEventTypesResource>;
}
