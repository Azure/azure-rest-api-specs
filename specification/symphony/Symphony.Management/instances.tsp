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

@doc("The properties of an Instance resource.")
model InstanceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The metadata information of the InstanceVersion resource.")
  @added(Versions.v2024_08_01_preview)
  metadata?: Record<string>;

  @doc("The display name of the InstanceVersion resource.")
  @added(Versions.v2024_08_01_preview)
  displayName?: string;

  @doc("The scope of the InstanceVersion resource.")
  @added(Versions.v2024_08_01_preview)
  scope?: string;

  @doc("The SolutionVersion resource of the InstanceVersion resource.")
  @added(Versions.v2024_08_01_preview)
  solution: string;

  @doc("Defines the Target the InstanceVersion resource will deploy to.")
  @added(Versions.v2024_08_01_preview)
  target?: TargetSelectorProperties;

  @doc("The reconciliationPolicy of the InstanceVersion resource.")
  @added(Versions.v2024_08_01_preview)
  reconciliationPolicy?: ReconciliationPolicyProperties;

  @doc("The running state for the InstanceVersion resource.")
  @added(Versions.v2024_08_01_preview)
  isDryRun?: boolean;

  @doc("The status of the InstanceVersion.")
  @visibility("read")
  @added(Versions.v2024_08_01_preview)
  status?: InstanceTargetStatusProperties;
}

@doc("An Instance resource.")
model Instance is TrackedResource<InstanceProperties> {
  @doc("Name of Instance.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  @path
  @key("instanceName")
  @segment("instances")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Instances {
  @doc("Returns details of specified Instance resource.")
  get is ArmResourceRead<Instance>;
  @doc("Creates new or updates existing Instance resource.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Instance>;
  @doc("Updates existing Instance resource.")
  update is ArmCustomPatchAsync<Instance>;
  @doc("Deletes specified Instance resource.")
  delete is ArmResourceDeleteWithoutOkAsync<Instance>;
  @doc("Returns a collection of Instances resources within the resource group.")
  listByResourceGroup is Azure.ResourceManager.ArmResourceListByParent<Instance>;
  @doc("Lists Instances resources within an Azure subscription.")
  listBySubscription is ArmListBySubscription<Instance>;
}
