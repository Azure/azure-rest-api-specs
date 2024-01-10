import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Security;
@doc("Security Application over a given scope")
@subscriptionResource
model Application is ProxyResource<ApplicationProperties> {
  @doc("The security Application key - unique key for the standard application")
  @key("applicationId")
  @segment("applications")
  name: string;
}

@armResourceOperations
@projectedName("client", "Application")
interface Applications_Application {
  @doc("Get a specific application for the requested scope by applicationId")
  get is ArmResourceRead<Application>;

  @doc("Creates or update a security application on the given subscription.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Application>;

  @doc("Delete an Application over a given scope")
  delete is ArmResourceDeleteSync<Application>;
}

@armResourceOperations
interface Applications {
  @doc("Get a list of all relevant applications over a subscription level scope")
  list is ArmResourceListByParent<Application>;
}
