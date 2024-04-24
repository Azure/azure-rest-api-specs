import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Symphony;

@doc("The properties of the service.")
model InstanceVersionProperties {
  @doc("Provisioning state of the service.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  metadata?: Record<string>;

  displayName?: string;

  scope?: string;

  solution: string;

  version?: string;

  target?: InstanceTargetProperties;

  reconciliationPolicy?: ReconciliationPolicyProperties;
}

@doc("The service entity.")
@resource("versions")
@parentResource(Instance)
model InstanceVersion is ProxyResource<InstanceVersionProperties> {
  @doc("The name of Azure API Center service.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]{3,90}$")
  @path
  @key("versionName")
  @segment("versions")
  name: string;
  
  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface IntanceVersions {
  @doc("Returns details of the service.")
  get is Azure.ResourceManager.ArmResourceRead<InstanceVersion>;
  @doc("Creates new or updates existing API.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceAsync<InstanceVersion>;
  @doc("Updates existing service.")
  update is ArmResourcePatchAsync<InstanceVersion, InstanceVersionProperties>;
  @doc("Deletes specified service.")
  delete is ArmResourceDeleteSync<InstanceVersion>;

  listByParent is ArmResourceListByParent<InstanceVersion>;
}