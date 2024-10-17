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

@doc("The properties of a Target resource.")
model TargetProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The metadata information of the TargetVersion.")
  @added(Versions.v2024_08_01_preview)
  metadata?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
  @doc("The properties of the TargetVersion.")
  @added(Versions.v2024_08_01_preview)
  properties?: Record<string>;

  @doc("The display name of the TargetVersion.")
  @added(Versions.v2024_08_01_preview)
  displayName?: string;

  @doc("The constraints of the TargetVersion.")
  @added(Versions.v2024_08_01_preview)
  constraints?: string;

  @doc("The scope of the TargetVersion.")
  @added(Versions.v2024_08_01_preview)
  scope?: string;

  @doc("Defines the device topology for a target or instance.")
  @OpenAPI.extension("x-ms-identifiers", [])
  @added(Versions.v2024_08_01_preview)
  topologies?: TopologyProperties[];

  @doc("A list of components.")
  @OpenAPI.extension("x-ms-identifiers", [])
  @added(Versions.v2024_08_01_preview)
  components?: ComponentProperties[];

  @doc("The reconciliationPolicy of the TargetVersion.")
  @added(Versions.v2024_08_01_preview)
  reconciliationPolicy?: ReconciliationPolicyProperties;

  @doc("The running state for the TargetVersion resource.")
  @added(Versions.v2024_08_01_preview)
  isDryRun?: boolean;

  @doc("The status of the TargetVersion.")
  @visibility("read")
  @added(Versions.v2024_08_01_preview)
  status?: InstanceTargetStatusProperties;
}

@doc("A Target resource.")
model Target is TrackedResource<TargetProperties> {
  @doc("Name of target.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  @path
  @key("targetName")
  @segment("targets")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Targets {
  @doc("Returns details of specified Target resource.")
  get is Azure.ResourceManager.ArmResourceRead<Target>;
  @doc("Creates new or updates existing Target resource.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceAsync<Target>;
  @doc("Updates existing Target resource.")
  update is ArmCustomPatchAsync<Target>;
  @doc("Deletes specified Target resource.")
  delete is ArmResourceDeleteWithoutOkAsync<Target>;
  @doc("Returns a collection of Target resources within the resource group.")
  listByResourceGroup is Azure.ResourceManager.ArmResourceListByParent<Target>;
  @doc("Lists Targets resources within an Azure subscription.")
  listBySubscription is ArmListBySubscription<Target>;
}
