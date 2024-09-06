import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.OpenAPI;

@doc("Microsoft.MessagingConnectors Resource Provider management API.")
@armProviderNamespace
@service({
  title: "Microsoft.MessagingConnectors management service",
})
@versioned(Versions)
namespace Microsoft.MessagingConnectors;

@doc("A Connector resource Azure")
model MessagingConnector is TrackedResource<ResourceProperties> {
  @doc("Name of the Connector resource.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{0,78}[a-zA-Z0-9_]")
  @path
  @key("name")
  @segment("connectors")
  name: string;
}

@armResourceOperations
interface ConnectorOperations {
  @doc("Gets an Connector instance for the specified subscription, resource group, and instance name.")
  get is ArmResourceRead<MessagingConnector>;

  @doc("Create an Connector instance for the specified subscription, resource group, and instance name.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MessagingConnector>;

  @doc("Delete an Connector instance for the specified subscription, resource group, and instance name.")
  delete is ArmResourceDeleteSync<MessagingConnector>;

  @doc("Pause one Connector to paused status")
  pause is ArmResourceActionNoContentSync<MessagingConnector, {}>;

  @doc("Resume one Connector to running status")
  resume is ArmResourceActionNoContentSync<MessagingConnector, {}>;

  @doc("List Connector By ResourceGroup and Subscription")
  listByResourceGroup is ArmResourceListByParent<MessagingConnector>;

  @doc("List Connector By Subscription")
  listBySubscription is ArmListBySubscription<MessagingConnector>;

  @doc("Update Tags of Connector")
  updateTags is ArmTagsPatchSync<MessagingConnector>;
}
