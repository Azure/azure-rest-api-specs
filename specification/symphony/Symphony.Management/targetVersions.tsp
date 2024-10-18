import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ToolchainOrchestrator;

@doc("The properties of a TargetVersion resource.")
@removed(Versions.v2024_08_01_preview)
model TargetVersionProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The metadata information of the TargetVersion.")
  metadata?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
  @doc("The properties of the TargetVersion.")
  properties?: Record<string>;

  @doc("The display name of the TargetVersion.")
  displayName?: string;

  @doc("The constraints of the TargetVersion.")
  constraints?: string;

  @doc("The scope of the TargetVersion.")
  scope?: string;

  @doc("Defines the device topology for a target or instance.")
  @OpenAPI.extension("x-ms-identifiers", [])
  topologies?: TopologyProperties[];

  @doc("A list of components.")
  @OpenAPI.extension("x-ms-identifiers", [])
  components?: ComponentProperties[];

  @doc("The reconciliationPolicy of the TargetVersion.")
  reconciliationPolicy?: ReconciliationPolicyProperties;

  @doc("The status of the TargetVersion.")
  @visibility("read")
  status?: InstanceTargetStatusProperties;
}

@doc("A TargetVersion resource belonging to a Target resource.")
@resource("versions")
@parentResource(Target)
@removed(Versions.v2024_08_01_preview)
model TargetVersion is TrackedResource<TargetVersionProperties> {
  @doc("The name of Azure API Center service.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-z0-9]+(\\.[a-z0-9]+)*$")
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
@removed(Versions.v2024_08_01_preview)
interface TargetVersions {
  @doc("Returns details of specified TargetVersion resource.")
  get is Azure.ResourceManager.ArmResourceRead<TargetVersion>;
  @doc("Creates new or updates existing TargetVersion resource.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceAsync<TargetVersion>;
  @doc("Updates existing TargetVersion resource.")
  update is ArmCustomPatchAsync<TargetVersion>;
  @doc("Deletes specified TargetVersion resource.")
  delete is ArmResourceDeleteWithoutOkAsync<TargetVersion>;
  @doc("Returns a collection of TargetVersion resources belonging to a Target resource.")
  listByTarget is ArmResourceListByParent<TargetVersion>;
}
