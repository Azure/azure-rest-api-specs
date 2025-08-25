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

@doc("EventGridTopicTypePublisherAuthentications properties")
model EventGridTopicTypePublisherAuthenticationsResourceProperties {
  @doc("Name of the Topic Type. Required.")
  topicTypeName: string;

  @doc("Gets the Authentication type, e.g. \"Certificate\". Required.")
  authenticationType: string;

  @doc("List of certificate subject names that's used while publishing events to EventGrid. e.g., [\"CN=test.domain.com\", \"CN=test2.domain.net\"]. Required.")
  certificateSubjectNames: Array<string>;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: EventGridProvisioningState;
}

@doc("EventGridTopicTypePublisherAuthentications Resource")
model EventGridTopicTypePublisherAuthenticationsResource
  is ProxyResource<EventGridTopicTypePublisherAuthenticationsResourceProperties> {
  @doc("The name of the resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("eventGridTopicTypePublisherAuthentications") // Start with lower case. Should be plural
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface EventGridTopicTypePublisherAuthentications {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EventGridTopicTypePublisherAuthenticationsResource>;
  get is ArmResourceRead<EventGridTopicTypePublisherAuthenticationsResource>;
  listByResourceGroup is ArmResourceListByParent<EventGridTopicTypePublisherAuthenticationsResource>;
  listBySubscription is ArmListBySubscription<EventGridTopicTypePublisherAuthenticationsResource>;
}
