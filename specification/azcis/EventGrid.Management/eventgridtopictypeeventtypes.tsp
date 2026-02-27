import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";

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

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Maintaining compatibility with current SDKs."
  @doc("If True, the eventType is pre-selected as part of Event Subscription creation process. Optional.")
  isInDefaultSet?: string | "False" | "True";

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: EventGridProvisioningState;

  @doc("Resource event argument result; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  eventTypeOutput?: string;
}

@doc("EventGridTopicTypeEventTypes Resource")
model EventGridTopicTypeEventTypesResource
  is ProxyResource<EventGridTopicTypeEventTypesResourceProperties> {
  @doc("The name of the resource.")
  @pattern("^[a-zA-Z0-9-]*$")
  @minLength(3)
  @maxLength(80)
  @key("resourceName")
  @segment("eventGridTopicTypeEventTypes") // Start with lower case. Should be plural
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Delete operation is currently not supported by FRP."
@armResourceOperations
interface EventGridTopicTypeEventTypes {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EventGridTopicTypeEventTypesResource>;
  get is ArmResourceRead<EventGridTopicTypeEventTypesResource>;
  listByResourceGroup is ArmResourceListByParent<EventGridTopicTypeEventTypesResource>;
  listBySubscription is ArmListBySubscription<EventGridTopicTypeEventTypesResource>;
}
