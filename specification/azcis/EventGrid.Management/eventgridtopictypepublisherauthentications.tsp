import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.AzureCis;

@doc("EventGridTopicTypePublisherAuthentications properties")
model EventGridTopicTypePublisherAuthenticationsResourceProperties {
  @doc("Name of the Topic Type. Required.")
  topicTypeName: string;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Maintaining compatibility with current SDKs."
  @doc("Authentication Type. Required.")
  authenticationType: string | "Certificate";

  @doc("List of certificate subject names that's used while publishing events to EventGrid. e.g., [\"CN=test.domain.com\"]. Required.")
  certificateSubjectNames: Array<string>;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: EventGridProvisioningState;

  @doc("Resource event argument result; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  publisherAuthenticationsOutput?: string;
}

@doc("EventGridTopicTypePublisherAuthentications Resource")
model EventGridTopicTypePublisherAuthenticationsResource
  is ProxyResource<EventGridTopicTypePublisherAuthenticationsResourceProperties> {
  @doc("The name of the resource.")
  @pattern("^[a-zA-Z0-9-]*$")
  @minLength(3)
  @maxLength(80)
  @key("resourceName")
  @segment("eventGridTopicTypePublisherAuthentications") // Start with lower case. Should be plural
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Delete operation is currently not supported by FRP."
@armResourceOperations
interface EventGridTopicTypePublisherAuthentications {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EventGridTopicTypePublisherAuthenticationsResource>;
  get is ArmResourceRead<EventGridTopicTypePublisherAuthenticationsResource>;
  listByResourceGroup is ArmResourceListByParent<EventGridTopicTypePublisherAuthenticationsResource>;
  listBySubscription is ArmListBySubscription<EventGridTopicTypePublisherAuthenticationsResource>;
}
