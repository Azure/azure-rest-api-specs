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

@doc("A Instance resource belonging to an Instance resource.")
model Instance is TrackedResource<InstanceProperties> {
  @doc("Name of Instance.")
  @key("instanceName")
  @segment("instances")
  @pattern("^[a-z0-9][a-z0-9-]{1,62}[a-z0-9]$") 
  @path
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation?: ExtendedLocation;
}

@doc("The properties of a Instance resource.")
model InstanceProperties {
  @doc("User-friendly name for the Instance.")
  displayName?: string;
  
  @doc("scope description")
  scope?: string;
  
  @doc("solution description")
  solution?: string;

  @doc("target description")
  target?: TargetSelectorProperties;

  @doc("version description")
  version?: string;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The selected target description.")
model TargetSelectorProperties {
  @doc("Name of the target")
  name?:	string;
  
  @doc("selector description")
  selector?: {};
}

@armResourceOperations
interface Instances {
  get is ArmResourceRead<Instance>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Instance>;
  update is ArmCustomPatchSync<Instance>;
  delete is ArmResourceDeleteAsync<Instance>;
  listByResourceGroup is ArmResourceListByParent<Instance>;
  listBySubscription is ArmListBySubscription<Instance>;
}
