import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Security Application over a given scope")
@subscriptionResource
model SubscriptionSecurityApplication is ProxyResource<ApplicationProperties> {
  @doc("The security Application key - unique key for the standard application")
  @path
  @key("applicationId")
  @segment("applications")
  name: string;
}

@armResourceOperations
interface SubscriptionSecurityApplications {
  @doc("Get a specific application for the requested scope by applicationId")
  get is ArmResourceRead<SubscriptionSecurityApplication>;
  @doc("Creates or update a security application on the given subscription.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SubscriptionSecurityApplication>;
  @doc("Delete an Application over a given scope")
  delete is ArmResourceDeleteSync<SubscriptionSecurityApplication>;
  @doc("Get a list of all relevant applications over a subscription level scope")
  list is ArmResourceListByParent<SubscriptionSecurityApplication>;
}
