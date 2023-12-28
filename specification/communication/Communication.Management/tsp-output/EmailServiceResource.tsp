import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Communication;
@doc("A class representing an EmailService resource.")
model EmailServiceResource is TrackedResource<EmailServiceProperties> {
  @doc("The name of the EmailService resource.")
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]+$")
  @key("emailServiceName")
  @segment("emailServices")
  name: string;
}

@armResourceOperations
interface EmailServices {
  @doc("Get the EmailService and its properties.")
  get is ArmResourceRead<EmailServiceResource>;
  @doc("Create a new EmailService or update an existing EmailService.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EmailServiceResource>;
  @doc("Operation to update an existing EmailService.")
  update is ArmCustomPatchAsync<
    EmailServiceResource,
    EmailServiceResourceUpdate
  >;
  @doc("Operation to delete a EmailService.")
  delete is ArmResourceDeleteAsync<EmailServiceResource>;
  @doc("Handles requests to list all resources in a resource group.")
  listByResourceGroup is ArmResourceListByParent<EmailServiceResource>;
  @doc("Handles requests to list all resources in a subscription.")
  listBySubscription is ArmListBySubscription<EmailServiceResource>;
  @doc("Get a list of domains that are fully verified in Exchange Online.")
  listVerifiedExchangeOnlineDomains is ArmListBySubscription<EmailServiceResource>;
}
