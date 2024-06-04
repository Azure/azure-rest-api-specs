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

namespace Microsoft.MessagingConnectors;

@doc("A Connector resource Azure")
model ConnectorInstance is TrackedResource<ResourceProperties> {
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
  get is ArmResourceRead<ConnectorInstance>;

  @doc("Create an Connector instance for the specified subscription, resource group, and instance name.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectorInstance>;

  @doc("Delete an Connector instance for the specified subscription, resource group, and instance name.")
  delete is ArmResourceDeleteSync<ConnectorInstance>;

  @doc("Pause one Connector to paused status")
  pause is ArmResourceActionNoContentSync<ConnectorInstance, {}>;

  @doc("Resume one Connector to running status")
  resume is ArmResourceActionNoContentSync<ConnectorInstance, {}>;

  @doc("List Connector By ResourceGroup and Subscription")
  listByResourceGroup is ArmResourceListByParent<ConnectorInstance>;

  @doc("List Connector By Subscription")
  listBySubscription is ArmListBySubscription<ConnectorInstance>;

  @doc("Update Tags of Connector")
  updateTags is ArmTagsPatchSync<ConnectorInstance>;
}
