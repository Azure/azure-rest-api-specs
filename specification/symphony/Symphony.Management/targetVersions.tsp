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

@doc("Defining the TargetVersion.")
model TargetVersionProperties {
  @doc("Provisioning state of the service.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The metadata of the TargetVersion.")
  metadata?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
  @doc("The properties of the TargetVersion.")
  properties?: Record<string>;

  @doc("The displayName of the TargetVersion.")
  displayName?: string;

  @doc("The constraints of the TargetVersion.")
  constraints?: string;

  @doc("The scope of the TargetVersion.")
  scope?: string;

  @doc("A list of topologies")
  @OpenAPI.extension("x-ms-identifiers", [])
  topologies?: TopologyProperties[];

  @doc("A list of components")
  @OpenAPI.extension("x-ms-identifiers", [])
  components?: ComponentProperties[];

  @doc("The reconciliationPolicy of the TargetVersion.")
  reconciliationPolicy?: ReconciliationPolicyProperties;
}

@doc("The service entity.")
@resource("versions")
@parentResource(Target)
model TargetVersion is ProxyResource<TargetVersionProperties> {
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
interface TargetVersions {
  @doc("Returns details of the service.")
  get is Azure.ResourceManager.ArmResourceRead<TargetVersion>;
  @doc("Creates new or updates existing API.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceAsync<TargetVersion>;
  @doc("Updates existing service.")
  update is ArmResourcePatchAsync<TargetVersion, TargetVersionProperties>;
  @doc("Deletes specified service.")
  delete is ArmResourceDeleteSync<TargetVersion>;

  listByParent is ArmResourceListByParent<TargetVersion>;
}