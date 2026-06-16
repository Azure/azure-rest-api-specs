import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ContainerService;
using Azure.Core;
using TypeSpec.Http;

@@clientName(Microsoft.ContainerService,
  "ContainerServiceFleetManagementClient",
  "java"
);

@@clientName(Microsoft.ContainerService,
  "ContainerServiceFleetMgmtClient",
  "python"
);

@@clientName(Microsoft.ContainerService.APIServerAccessProfile,
  "ApiServerAccessProfile",
  "java"
);
@@clientName(Azure.ResourceManager.EntityTagProperty.eTag, "etag", "java");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Existing usage of legacy type"
@@clientName(Azure.ResourceManager.Legacy.ManagedServiceIdentityV4,
  "ManagedServiceIdentity"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Existing usage of legacy type"
@@clientName(Azure.ResourceManager.Legacy.ManagedServiceIdentityType.SystemAndUserAssigned,
  "SYSTEM_ASSIGNED_USER_ASSIGNED",
  "python"
);
@@clientName(Microsoft.ContainerService.FleetMembers.updateAsync,
  "begin_update",
  "python"
);
@@clientName(Microsoft.ContainerService.Fleets.create,
  "begin_create_or_update",
  "python"
);
@@clientName(Microsoft.ContainerService.Fleets.updateAsync,
  "begin_update",
  "python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.TrackedResource.properties
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.ProxyResource.properties
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ResourceUpdateModel.properties
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.Foundations.ProxyResourceUpdateModel.properties
);
@@clientName(Microsoft.ContainerService,
  "ContainerServiceFleetClient",
  "javascript"
);

// csharp
@@clientName(Fleet, "ContainerServiceFleet", "csharp");
@@clientName(Gate, "ContainerServiceFleetGate", "csharp");
@@clientName(UpdateRun, "ContainerServiceFleetUpdateRun", "csharp");
@@clientName(FleetMember, "ContainerServiceFleetMember", "csharp");
@@clientName(FleetManagedNamespace,
  "ContainerServiceFleetManagedNamespace",
  "csharp"
);
@@clientName(SkipProperties, "ContainerServiceFleetSkipProperties", "csharp");
@@clientName(SkipTarget, "ContainerServiceFleetSkipTarget", "csharp");
@@clientName(SkipTarget.type, "TargetType", "csharp");
@@clientName(TargetType, "ContainerServiceFleetTargetType", "csharp");
@@clientName(UpgradeChannel, "ContainerServiceFleetUpgradeChannel", "csharp");
@@clientName(GenerateResponse, "AutoUpgradeProfileGenerateResult", "csharp");
@@clientName(FleetMemberStatus, "ContainerServiceFleetMemberStatus", "csharp");
@@clientName(FleetStatus, "ContainerServiceFleetStatus", "csharp");
@@clientName(Timing, "ContainerServiceFleetGateTiming", "csharp");
@@clientName(AgentProfile, "ContainerServiceFleetAgentProfile", "csharp");
@@clientName(APIServerAccessProfile,
  "ContainerServiceFleetAPIServerAccessProfile",
  "csharp"
);
@@clientName(GateType, "ContainerServiceFleetGateType", "csharp");
@@clientName(GateProvisioningState,
  "ContainerServiceFleetGateProvisioningState",
  "csharp"
);
@@clientName(GateState, "ContainerServiceFleetGateState", "csharp");
@@clientName(GateTarget, "ContainerServiceFleetGateTarget", "csharp");
@@clientName(GateConfiguration,
  "ContainerServiceFleetGateConfiguration",
  "csharp"
);
@@clientName(UpdateStatus, "ContainerServiceFleetUpdateStatus", "csharp");
@@clientName(WaitStatus, "ContainerServiceFleetWaitStatus", "csharp");
@@clientName(UpdateStageStatus,
  "ContainerServiceFleetUpdateStageStatus",
  "csharp"
);
@@clientName(UpdateStage, "ContainerServiceFleetUpdateStage", "csharp");
@@clientName(UpdateRunStrategy,
  "ContainerServiceFleetUpdateRunStrategy",
  "csharp"
);
@@clientName(UpdateRunStatus, "ContainerServiceFleetUpdateRunStatus", "csharp");
@@clientName(UpdateRunProvisioningState,
  "ContainerServiceFleetUpdateRunProvisioningState",
  "csharp"
);
@@clientName(UpdateGroupStatus,
  "ContainerServiceFleetUpdateGroupStatus",
  "csharp"
);
@@clientName(UpdateGroup, "ContainerServiceFleetUpdateGroup", "csharp");
@@clientName(UpdateState, "ContainerServiceFleetUpdateState", "csharp");
@@clientName(ManagedClusterUpdate,
  "ContainerServiceFleetManagedClusterUpdate",
  "csharp"
);
@@clientName(ManagedClusterUpgradeSpec,
  "ContainerServiceFleetManagedClusterUpgradeSpec",
  "csharp"
);
@@clientName(ManagedClusterUpgradeSpec.type, "UpgradeType", "csharp");
@@clientName(ManagedClusterUpgradeType,
  "ContainerServiceFleetManagedClusterUpgradeType",
  "csharp"
);
@@clientName(NodeImageSelection.type, "SelectionType", "csharp");
@@clientName(AutoUpgradeNodeImageSelection.type, "SelectionType", "csharp");
@@clientName(AdoptionPolicy, "ContainerServiceFleetAdoptionPolicy", "csharp");
@@clientName(DeletePolicy, "ContainerServiceFleetDeletePolicy", "csharp");
@@clientName(NetworkPolicy, "ContainerServiceFleetNetworkPolicy", "csharp");
@@clientName(PlacementProfile,
  "ContainerServiceFleetPlacementProfile",
  "csharp"
);
@@clientName(PolicyRule, "ContainerServiceFleetPolicyRule", "csharp");
@@clientName(PropagationPolicy,
  "ContainerServiceFleetPropagationPolicy",
  "csharp"
);
@@clientName(PropagationType, "ContainerServiceFleetPropagationType", "csharp");
@@clientName(ResourceQuota, "ContainerServiceFleetResourceQuota", "csharp");
@@clientName(Placement.V1.PlacementPolicy,
  "ContainerServiceFleetPlacementPolicy",
  "csharp"
);
@@clientName(Placement.V1.PlacementType,
  "ContainerServiceFleetPlacementType",
  "csharp"
);
@@clientName(Placement.V1.ClusterAffinity,
  "ContainerServiceFleetClusterAffinity",
  "csharp"
);
@@clientName(Placement.V1.ClusterSelectorTerm,
  "ContainerServiceFleetClusterSelectorTerm",
  "csharp"
);
@@clientName(Placement.V1.PropertySelectorOperator,
  "ContainerServiceFleetPropertySelectorOperator",
  "csharp"
);
@@clientName(Placement.V1.PropertySelectorRequirement,
  "ContainerServiceFleetPropertySelectorRequirement",
  "csharp"
);
@@clientName(Placement.V1.Toleration,
  "ContainerServiceFleetToleration",
  "csharp"
);
@@clientName(Core.V1.TaintEffect, "ContainerServiceFleetTaintEffect", "csharp");
@@clientName(Core.V1.TolerationOperator,
  "ContainerServiceFleetTolerationOperator",
  "csharp"
);
@@clientName(Meta.V1.LabelSelector,
  "ContainerServiceFleetLabelSelector",
  "csharp"
);
@@clientName(Meta.V1.LabelSelectorOperator,
  "ContainerServiceFleetLabelSelectorOperator",
  "csharp"
);
@@clientName(Meta.V1.LabelSelectorRequirement,
  "ContainerServiceFleetLabelSelectorRequirement",
  "csharp"
);

@@alternateType(Azure.ResourceManager.EntityTagProperty.eTag,
  EtagProperty.etag,
  "csharp"
);
@@alternateType(MemberUpdateStatus.clusterResourceId,
  armResourceIdentifier,
  "csharp"
);
@@usage(Gate, Usage.input, "csharp");
@@usage(UpdateRunGateTargetProperties, Usage.input, "csharp");
@@usage(GateTarget, Usage.input, "csharp");
