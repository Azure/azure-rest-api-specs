import "@typespec/rest";
import "./helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;

@doc("A fleet namespace.")
@resource("namespaces")
@added(Versions.v2025_03_01)
@parentResource(Fleet)
model FleetNamespace is TrackedResource<FleetNamespaceProperties> {
    @doc("The name of the fleet namespace resource.")
    @key("fleetNamespaceName")
    @segment("fleetNamespaces")
    @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
    @minLength(1)
    @maxLength(50)
    @path
    @visibility("create", "read")
    name: string;
  
    ...EntityTagProperty;
}

@doc("The provisioning state of the fleet namespace resource")
union FleetNamespaceProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The provisioning state of a fleet namespace being created.")
  Creating: "Creating",

  @doc("The provisioning state of a fleet namespace being updated.")
  Updating: "Updating",

  @doc("The provisioning state of a fleet namespace being deleted.")
  Deleting: "Deleting",
}

@doc("A fleet namespace.")
model FleetNamespaceProperties {

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: FleetNamespaceProvisioningState;

}

@added(Versions.v2025_03_01)
@armResourceOperations
interface FleetNamespaces {
  get is ArmResourceRead<FleetNamespace>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<
  FleetNamespace,
      BaseParameters<FleetNamespace> &
      IfMatchParameters<FleetNamespace> &
      IfNoneMatchParameters<FleetNamespace>
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    FleetNamespace,
    BaseParameters<FleetNamespace> & IfMatchParameters<FleetNamespace>
  >;

  listByFleet is ArmResourceListByParent<FleetNamespace>;
}
