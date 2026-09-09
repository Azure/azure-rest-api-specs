import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.HorizonDb;

@added(Versions.v2026_09_01)
@doc("A customer-chosen DNS base name for a HorizonDB endpoint. The service validates that the name is globally available across HorizonDB endpoint DNS names.")
@pattern("^[a-z0-9](?:[-a-z0-9]*[a-z0-9])?$")
@minLength(1)
@maxLength(63)
scalar EndpointBaseName extends string;

@added(Versions.v2026_09_01)
@doc("A customer-selected lowercase DNS segment used as a HorizonDB endpoint alias.")
@pattern("^[a-z0-9](?:[-a-z0-9]*[a-z0-9])?$")
@minLength(1)
@maxLength(63)
scalar EndpointAlias extends string;

@added(Versions.v2026_09_01)
@doc("Represents a service-generated, service-managed HorizonDB endpoint. The Cluster-scoped Endpoint is created and deleted with its parent Cluster. A Pool-scoped Endpoint is created and deleted with the Pool identified by associatedResourceId. Endpoints cannot be created or deleted independently from their lifecycle owner.")
@parentResource(Cluster)
model Endpoint is Azure.ResourceManager.ProxyResource<EndpointProperties> {
  @doc("The service-generated name of the HorizonDB endpoint. The Cluster-scoped Endpoint is named cluster. Pool-scoped Endpoint names use the form pool-NN, where NN is a two-digit sequence number.")
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9]*[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("endpointName")
  @path
  @segment("endpoints")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Endpoint is a service-managed resource with no asynchronous PUT or PATCH operation whose status would require provisioningState."
@added(Versions.v2026_09_01)
@doc("Properties of a service-generated HorizonDB endpoint.")
model EndpointProperties {
  @doc("The scope of the endpoint. Cluster-scoped Endpoints provide the cluster connection, and Pool-scoped Endpoints provide read-only connections to eligible nodes in one pool.")
  @visibility(Lifecycle.Read)
  scope: EndpointScope;

  @doc("The Azure resource ID of the Endpoint's lifecycle owner. For Cluster scope, this identifies the parent Cluster with which the Endpoint is created and deleted. For Pool scope, this identifies the Pool with which the Endpoint and its FirewallRule children are created and deleted; the Pool must be a child of the Endpoint's parent Cluster.")
  @visibility(Lifecycle.Read)
  associatedResourceId: EndpointAssociatedResourceId;

  @doc("The service-generated fully qualified domain name of the endpoint. A Cluster-scoped Endpoint uses <cluster>.<clusterid>.<region>.horizondb.azure.com. A Pool-scoped Endpoint uses <poolid>.<cluster>.<clusterid>.<region>.horizondb.azure.com.")
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainName: string;

  @doc("The routing role of the endpoint. A Cluster-scoped Endpoint normally has the ReadWrite role. Pool-scoped Endpoints have the ReadOnly role and route only to allocated nodes in the associated Pool that are not currently playing the read-write role. A Pool-scoped ReadOnly Endpoint has no routing destination unless at least one such node exists, including when the Pool is Stopped or Shutdown, has zero allocated nodes, or has only one allocated node and that node is playing the read-write role.")
  @visibility(Lifecycle.Read)
  role: EndpointRole;

  @doc("The customer-selected DNS aliases for the endpoint. An empty list means that the endpoint has no aliased CNAME. Only one alias is currently supported.")
  @maxItems(1)
  @visibility(Lifecycle.Update, Lifecycle.Read)
  aliases: EndpointAlias[];

  @doc("The fully qualified domain names formed from aliases by appending the .horizondb.azure.com suffix. The list is empty when aliases is empty.")
  @visibility(Lifecycle.Read)
  aliasFullyQualifiedDomainNames: string[];
}

@added(Versions.v2026_09_01)
@doc("Properties of a service-generated HorizonDB endpoint for an update operation.")
model EndpointPropertiesForPatchUpdate {
  @doc("The replacement DNS alias list. An empty list removes the aliased CNAME. Only one alias is currently supported.")
  @maxItems(1)
  @visibility(Lifecycle.Update)
  aliases?: EndpointAlias[];
}

@added(Versions.v2026_09_01)
@doc("A service-generated HorizonDB endpoint update request.")
model EndpointForPatchUpdate {
  @doc("The endpoint properties to update.")
  properties?: EndpointPropertiesForPatchUpdate;
}

@added(Versions.v2026_09_01)
@doc("The scope of a HorizonDB endpoint.")
union EndpointScope {
  string,

  /** The Endpoint is associated with its parent Cluster. */
  Cluster: "Cluster",

  /** The Endpoint is associated with a Pool under its parent Cluster and has the ReadOnly role. */
  Pool: "Pool",
}

@added(Versions.v2026_09_01)
@doc("Role of the endpoint.")
union EndpointRole {
  string,

  /** The Endpoint accepts read-only traffic. This applies to Pool-scoped Endpoints and may apply to other endpoint scenarios introduced by later API versions. */
  ReadOnly: "ReadOnly",

  /** The Cluster-scoped Endpoint accepts read and write traffic. */
  ReadWrite: "ReadWrite",
}

@added(Versions.v2026_09_01)
@doc("The Azure resource ID of the HorizonDB cluster or pool associated with an endpoint.")
scalar EndpointAssociatedResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters",
    },
    {
      type: "Microsoft.HorizonDb/clusters/pools",
    }
  ]>;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Endpoint instances are service-created with their lifecycle owner and cannot be deleted independently."
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-put-operation" "Endpoint instances are service-created with their lifecycle owner; customers can only replace the alias list through PATCH."
@added(Versions.v2026_09_01)
@armResourceOperations
interface Endpoints {
  @doc("Gets information about a service-generated HorizonDB Cluster- or Pool-scoped Endpoint.")
  get is ArmResourceRead<Endpoint>;

  @doc("Lists the service-generated Endpoints in a cluster. The collection contains the Cluster-scoped Endpoint named cluster and one Pool-scoped Endpoint for each pool.")
  list is ArmResourceListByParent<Endpoint>;

  @doc("Replaces the DNS alias list of a service-generated HorizonDB endpoint. An empty list removes the endpoint's aliased CNAME. Only one alias is currently supported.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Endpoint, PatchModel = EndpointForPatchUpdate>;
}
