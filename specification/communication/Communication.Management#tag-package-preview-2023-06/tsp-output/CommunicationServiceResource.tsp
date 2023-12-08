import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Communication;
@doc("A class representing a CommunicationService resource.")
model CommunicationServiceResource
  is TrackedResource<CommunicationServiceProperties> {
  @doc("The name of the CommunicationService resource.")
  @maxLength(63)
  @minLength(1)
  @pattern("^[-\\w]+$")
  @path
  @key("communicationServiceName")
  @segment("communicationServices")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface CommunicationServiceResources {
  @doc("Get the CommunicationService and its properties.")
  get is ArmResourceRead<CommunicationServiceResource>;
  @doc("Create a new CommunicationService or update an existing CommunicationService.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CommunicationServiceResource>;
  @doc("Operation to update an existing CommunicationService.")
  update is ArmResourcePatchSync<
    CommunicationServiceResource,
    CommunicationServiceProperties
  >;
  @doc("Operation to delete a CommunicationService.")
  delete is ArmResourceDeleteAsync<CommunicationServiceResource>;
  @doc("Handles requests to list all resources in a resource group.")
  listByResourceGroup is ArmResourceListByParent<CommunicationServiceResource>;
  @doc("Handles requests to list all resources in a subscription.")
  listBySubscription is ArmListBySubscription<CommunicationServiceResource>;
  @doc("Links an Azure Notification Hub to this communication service.")
  linkNotificationHub is ArmResourceActionSync<
    CommunicationServiceResource,
    LinkNotificationHubParameters,
    LinkedNotificationHub
  >;
  @doc("Get the access keys of the CommunicationService resource.")
  listKeys is ArmResourceActionSync<
    CommunicationServiceResource,
    {},
    CommunicationServiceKeys
  >;
  @doc("Regenerate CommunicationService access key. PrimaryKey and SecondaryKey cannot be regenerated at the same time.")
  regenerateKey is ArmResourceActionSync<
    CommunicationServiceResource,
    RegenerateKeyParameters,
    CommunicationServiceKeys
  >;
}
