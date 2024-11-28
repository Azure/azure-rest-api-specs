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

@doc("The properties of an InstanceVersion resource.")
@removed(Versions.v2024_08_01_preview)
model InstanceVersionProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The metadata information of the InstanceVersion resource.")
  metadata?: Record<string>;

  @doc("The display name of the InstanceVersion resource.")
  displayName?: string;

  @doc("The scope of the InstanceVersion resource.")
  scope?: string;

  @doc("The SolutionVersion resource of the InstanceVersion resource.")
  solution: string;

  @doc("Defines the Target the InstanceVersion resource will deploy to.")
  target?: TargetSelectorProperties;

  @doc("The reconciliationPolicy of the InstanceVersion resource.")
  reconciliationPolicy?: ReconciliationPolicyProperties;

  @doc("The status of the InstanceVersion.")
  @visibility("read")
  status?: InstanceTargetStatusProperties;
}

@doc("An InstanceVersion resource belonging to an Instance resource.")
@resource("versions")
@parentResource(Instance)
@removed(Versions.v2024_08_01_preview)
model InstanceVersion is TrackedResource<InstanceVersionProperties> {
  @doc("Name of InstanceVersion resource.")
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
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
@removed(Versions.v2024_08_01_preview)
interface InstanceVersions {
  @doc("Returns details of specified InstanceVersion resource.")
  get is Azure.ResourceManager.ArmResourceRead<InstanceVersion>;
  @doc("Creates new or updates existing InstanceVersion resource.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceAsync<InstanceVersion>;
  @doc("Updates existing InstanceVersion resource.")
  update is ArmCustomPatchAsync<InstanceVersion>;
  @doc("Deletes specified InstanceVersion resource.")
  delete is ArmResourceDeleteWithoutOkAsync<InstanceVersion>;
  @doc("Returns a collection of InstanceVersion resources belonging to an Instance resource.")
  listByInstance is ArmResourceListByParent<InstanceVersion>;
}
