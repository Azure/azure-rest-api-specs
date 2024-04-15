import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

@armProviderNamespace
@service({
  title: "TrafficController",
})
@doc("Traffic Controller Provider management API.")
@versioned(Versions)
namespace Microsoft.ServiceNetworking;

/** Api versions */
enum Versions {
  /** 2023-11-01 preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2023-11-01`,
}

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

//----------------------- Frontends -----------------------
@doc("Frontend Subresource of Traffic Controller.")
@parentResource(TrafficController)
model Frontend is TrackedResource<FrontendProperties> {
  @key("frontendName")
  @doc("Frontends")
  @visibility("read")
  @path
  @segment("frontends")
  @pattern("^[A-Za-z0-9]([A-Za-z0-9-_.]{0,62}[A-Za-z0-9])?$")
  name: string;
}

@doc("Frontend Properties.")
model FrontendProperties {
  @visibility("read")
  @doc("The Fully Qualified Domain Name of the DNS record associated to a Traffic Controller frontend.")
  fqdn?: string;

  @visibility("read")
  @doc("Provisioning State of Traffic Controller Frontend Resource")
  provisioningState?: ProvisioningState;
}

//----------------------- Associations -----------------------
@doc("Association Subresource of Traffic Controller")
@parentResource(TrafficController)
model Association is TrackedResource<AssociationProperties> {
  @key("associationName")
  @visibility("read")
  @doc("Name of Association")
  @path
  @segment("associations")
  @pattern("^[A-Za-z0-9]([A-Za-z0-9-_.]{0,62}[A-Za-z0-9])?$")
  name: string;
}

@doc("Association Properties.")
model AssociationProperties {
  @doc("Association Type")
  associationType: AssociationType;

  @doc("Association Subnet")
  subnet?: AssociationSubnet;

  @visibility("read")
  @doc("Provisioning State of Traffic Controller Association Resource")
  provisioningState?: ProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
union AssociationType {
  string,
  "subnets",
}

@doc("Association Subnet.")
model AssociationSubnet {
  @doc("Association ID.")
  id: string;
}

//----------------------- Traffic Controller -----------------------
@resource("trafficControllers")
model TrafficController is TrackedResource<TrafficControllerProperties> {
  @key("trafficControllerName")
  @path
  @segment("trafficControllers")
  @doc("traffic controller name for path")
  @pattern("^[A-Za-z0-9]([A-Za-z0-9-_.]{0,62}[A-Za-z0-9])?$")
  name: string;
}

@doc("Traffic Controller Properties.")
model TrafficControllerProperties {
  @doc("Configuration Endpoints.")
  @visibility("read")
  configurationEndpoints?: string[];

  @visibility("read")
  @doc("Frontends References List")
  frontends?: ResourceId[];

  @visibility("read")
  @doc("Associations References List")
  associations?: ResourceId[];

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@lroStatus
union ProvisioningState {
  string,
  Provisioning: "Provisioning",
  Updating: "Updating",
  Deleting: "Deleting",
  Accepted: "Accepted",
  Succeeded: "Succeeded",
  Failed: "Failed",
  Canceled: "Canceled",
}

@doc("Resource ID definition used by parent to reference child resources.")
model ResourceId {
  @doc("Resource ID of child resource.")
  id: string;
}

//----------------------- Paths -----------------------
@armResourceOperations
interface AssociationsInterface
  extends ResourceInstanceOperations<Association, AssociationProperties>,
    ResourceListByParent<Association> {}

@armResourceOperations
interface FrontendsInterface
  extends ResourceInstanceOperations<Frontend, FrontendProperties>,
    ResourceListByParent<Frontend> {}

@armResourceOperations
interface TrafficControllerInterface
  extends TrackedResourceOperations<
      TrafficController,
      TrafficControllerProperties
    > {}

interface Operations extends Azure.ResourceManager.Operations {}
