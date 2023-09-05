import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.IoTOperationsOrchestrator;

@doc("A Target resource belonging to an Instance resource.")
model Target is TrackedResource<TargetProperties> {
  @doc("Name of target.")
  @key("targetName")
  @segment("targets")
  @pattern("^[a-z0-9][a-z0-9-]{1,62}[a-z0-9]$") 
  @path
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation?: ExtendedLocation;
}

@doc("The properties of a Target resource.")
model TargetProperties {
  @doc("components description")
  @OpenAPI.extension("x-ms-identifiers", [])  
  components?: ComponentProperties[];
  
  @doc("User-friendly name for the Target.")
  displayName?: string;
  
  @doc("scope description")
  scope?: string;

  @doc("Defines the device topology for a target or instance")
  @OpenAPI.extension("x-ms-identifiers", [])  
  topologies?: TopologiesProperties[];

  @doc("version description")
  version?: string;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Defines a desired runtime component.")
model TopologiesProperties {
  @doc("bindings description")
  @OpenAPI.extension("x-ms-identifiers", [])
  bindings?: BindingProperties[];

  @doc("Name of the component")
  device?:	string;
  
  @doc("selector description")
  selector?: {};
}

@doc("Defines a desired runtime component.")
model BindingProperties {
  @doc("config description")
  config?: {};

  @doc("Name of the component")
  provider:	string;
  
  @doc("role description")
  role: {};
}

@armResourceOperations
interface Targets {
  get is ArmResourceRead<Target>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Target>;
  update is ArmCustomPatchSync<Target>;
  delete is ArmResourceDeleteAsync<Target>;
  listByResourceGroup is ArmResourceListByParent<Target>;
  listBySubscription is ArmListBySubscription<Target>;
}
