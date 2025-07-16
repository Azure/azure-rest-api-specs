import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./../helpers.tsp";
import "./run.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;

@resource("autoUpgradeProfiles")
@parentResource(Fleet)
@added(Versions.v2024_05_02_preview)
@doc("The AutoUpgradeProfile resource.")
model AutoUpgradeProfile
  is Azure.ResourceManager.ProxyResource<AutoUpgradeProfileProperties> {
  @doc("The name of the AutoUpgradeProfile resource.")
  @key("autoUpgradeProfileName")
  @segment("autoUpgradeProfiles")
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @minLength(1)
  @maxLength(50)
  @path
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;

  ...EntityTagProperty;
}

@doc("The provisioning state of the AutoUpgradeProfile resource.")
union AutoUpgradeProfileProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("The properties of the AutoUpgradeProfile.")
@added(Versions.v2024_05_02_preview)
model AutoUpgradeProfileProperties {
  @visibility(Lifecycle.Read)
  @doc("The provisioning state of the AutoUpgradeProfile resource.")
  provisioningState?: AutoUpgradeProfileProvisioningState;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The resource id of the UpdateStrategy resource to reference. If not specified, the auto upgrade will run on all clusters which are members of the fleet.")
  updateStrategyId?: FleetUpdateStrategyResourceId;

  @doc("Configures how auto-upgrade will be run.")
  channel: UpgradeChannel;

  @doc("The node image upgrade to be applied to the target clusters in auto upgrade.")
  nodeImageSelection?: AutoUpgradeNodeImageSelection;

  @doc("""
    If set to False: the auto upgrade has effect - target managed clusters will be upgraded on schedule.
    If set to True: the auto upgrade has no effect - no upgrade will be run on the target managed clusters.
    This is a boolean and not an enum because enabled/disabled are all available states of the auto upgrade profile.
    By default, this is set to False.
    """)
  disabled?: boolean;

  @doc("The status of the auto upgrade profile.")
  @added(Versions.v2025_03_01)
  autoUpgradeProfileStatus?: AutoUpgradeProfileStatus;

  @doc("""
      This is the target Kubernetes version for auto-upgrade. The format must be `{major version}.{minor version}`. For example, "1.30".
      By default, this is empty.
      If upgrade channel is set to TargetKubernetesVersion, this field must not be empty.
      If upgrade channel is Rapid, Stable or NodeImage, this field must be empty.
    """)
  @added(Versions.v2025_04_01_preview)
  targetKubernetesVersion?: string;

  @doc("""
      If upgrade channel is not TargetKubernetesVersion, this field must be False.
      If set to True: Fleet auto upgrade will continue generate update runs for patches of minor versions earlier than N-2 
      (where N is the latest supported minor version) if those minor versions support Long-Term Support (LTS).
      By default, this is set to False.
      For more information on AKS LTS, please see https://learn.microsoft.com/en-us/azure/aks/long-term-support
    """)
  @added(Versions.v2025_04_01_preview)
  longTermSupport?: boolean;
}

@doc("Configuration of how auto upgrade will be run.")
union UpgradeChannel {
  string,

  @doc("""
     Upgrades the clusters kubernetes version to the latest supported patch release on minor version N-1, where N is the latest supported minor version.
     For example, if a cluster runs version 1.17.7 and versions 1.17.9, 1.18.4, 1.18.6, and 1.19.1 are available, the cluster upgrades to 1.18.6.
    """)
  Stable: "Stable",

  @doc("Upgrades the clusters kubernetes version to the latest supported patch release on the latest supported minor version.")
  Rapid: "Rapid",

  @doc("Upgrade node image version of the clusters.")
  NodeImage: "NodeImage",

  @doc("""
      Upgrades the clusters Kubernetes version to the latest supported patch version of the specified target Kubernetes version.
      For information on the behavior of update run for Kubernetes version upgrade, 
      see https://learn.microsoft.com/en-us/azure/kubernetes-fleet/update-orchestration?tabs=azure-portal
    """)
  @added(Versions.v2025_04_01_preview)
  TargetKubernetesVersion: "TargetKubernetesVersion",
}

@doc("The node image upgrade to be applied to the target clusters in auto upgrade.")
@added(Versions.v2024_05_02_preview)
model AutoUpgradeNodeImageSelection {
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The node image upgrade type.")
  type: AutoUpgradeNodeImageSelectionType;
}

@doc("The node image upgrade type.")
@added(Versions.v2024_05_02_preview)
union AutoUpgradeNodeImageSelectionType {
  string,

  @doc("Use the latest image version when upgrading nodes. Clusters may use different image versions (e.g., 'AKSUbuntu-1804gen2containerd-2021.10.12' and 'AKSUbuntu-1804gen2containerd-2021.10.19') because, for example, the latest available version is different in different regions.")
  Latest: "Latest",

  @doc("The image versions to upgrade nodes to are selected as described below: for each node pool in managed clusters affected by the update run, the system selects the latest image version such that it is available across all other node pools (in all other clusters) of the same image type. As a result, all node pools of the same image type will be upgraded to the same image version. For example, if the latest image version for image type 'AKSUbuntu-1804gen2containerd' is 'AKSUbuntu-1804gen2containerd-2021.10.12' for a node pool in cluster A in region X, and is 'AKSUbuntu-1804gen2containerd-2021.10.17' for a node pool in cluster B in region Y, the system will upgrade both node pools to image version 'AKSUbuntu-1804gen2containerd-2021.10.12'.")
  Consistent: "Consistent",
}

@added(Versions.v2024_05_02_preview)
@armResourceOperations
interface AutoUpgradeProfiles {
  get is ArmResourceRead<AutoUpgradeProfile>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    AutoUpgradeProfile,
    BaseParameters<AutoUpgradeProfile> &
      IfMatchParameters<AutoUpgradeProfile> &
      IfNoneMatchParameters<AutoUpgradeProfile>
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    AutoUpgradeProfile,
    BaseParameters<AutoUpgradeProfile> & IfMatchParameters<AutoUpgradeProfile>
  >;

  listByFleet is ArmResourceListByParent<AutoUpgradeProfile>;
}

@doc("AutoUpgradeProfileStatus is the status of an auto upgrade profile.")
@added(Versions.v2025_03_01)
model AutoUpgradeProfileStatus {
  @doc("The UTC time of the last attempt to automatically create and start an UpdateRun as triggered by the release of new versions.")
  @visibility(Lifecycle.Read)
  lastTriggeredAt?: utcDateTime;

  @doc("The status of the last AutoUpgrade trigger.")
  @visibility(Lifecycle.Read)
  lastTriggerStatus?: AutoUpgradeLastTriggerStatus;

  @doc("The error details of the last trigger.")
  @visibility(Lifecycle.Read)
  lastTriggerError?: Azure.ResourceManager.Foundations.ErrorDetail; // https://github.com/Azure/azure-rest-api-specs/blob/1de0b5315d62e1b40052bad2c9a2f2c89d84ff0f/specification/common-types/resource-management/v5/types.json#L260

  @doc("The target Kubernetes version or node image versions of the last trigger.")
  @visibility(Lifecycle.Read)
  lastTriggerUpgradeVersions?: string[];
}

@doc("AutoUpgradeLastTriggerStatus is the status of the last AutoUpgrade trigger (attempt to automatically create and start UpdateRun when there are new released versions) of an auto upgrade profile.")
@added(Versions.v2025_03_01)
union AutoUpgradeLastTriggerStatus {
  string,

  @doc("The last AutoUpgrade trigger was succeeded.")
  Succeeded: "Succeeded",

  @doc("The last AutoUpgrade trigger failed.")
  Failed: "Failed",
}

@added(Versions.v2025_03_01)
@armResourceOperations
interface AutoUpgradeProfileOperations {
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "use azure-async instead"
  @useFinalStateVia("azure-async-operation")
  @doc("Generates an update run for a given auto upgrade profile.")
  generateUpdateRun is Azure.ResourceManager.ArmResourceActionAsync<
    AutoUpgradeProfile,
    void,
    GenerateResponse,
    BaseParameters<AutoUpgradeProfile>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = GenerateResponse> &
      ArmLroLocationHeader<FinalResult = GenerateResponse> &
      IfMatchParameters<AutoUpgradeProfile>
  >;
}

@added(Versions.v2025_03_01)
@doc("GenerateResponse is the response of a generate request.")
model GenerateResponse {
  @visibility(Lifecycle.Read)
  @doc("The ARM resource id of the generated UpdateRun. e.g.: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerService/fleets/{fleetName}/updateRuns/{updateRunName}'.")
  id: string;
}
