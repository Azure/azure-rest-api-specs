import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./commonmodels.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ChangeSafety;

@doc("Resource provides details about stages a deployment goes through.")
model StageMap is ProxyResource<StageMapProperties> {
  @pattern("^[a-zA-Z0-9-]{3,100}$")
  @key("stageMapName")
  @segment("stageMaps")
  @path
  @minLength(3)
  @maxLength(100) // 260 is the max limit.
  @doc("The name of the StageMap")
  name: string;
}

@doc("Detailed properties of the StageMap resource.")
model StageMapProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Array of stages objects.")
  @identifiers(#["name"])
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  stages: Stage[];

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Parameter names are customer-defined; ChangeSafety cannot enumerate the keys. Values use the typed Parameter schema."
  @doc("StageMap parameters schema for each stage.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  parameters?: Record<Parameter>;
}

@doc("Defines details about each stage in the stage map resource.")
model Stage {
  @doc("Name of the individual stage.")
  @minLength(3)
  @maxLength(100)
  @pattern("^[a-zA-Z0-9-]{3,100}$")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: string;

  @doc("Positive integer defining the orchestration order of the stages.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minValue(1)
  sequence: int32;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Stage specific key value pairs of parameter names & their values, which can be any type"
  @doc("Variables to apply on the change of that stage. Key value pairs supporting any JSON values.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  stageVariables?: Record<unknown>;

  @doc("Nested stage map details.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  nestedStageMap?: NestedStageMap;
}

@doc("Azure resource Id of a stage map.")
scalar StageMapResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ChangeSafety/stageMaps",
    }
  ]>;

@doc("A StageMap reference and optional captured resource contents in a ChangeRecord snapshot.")
model StageMapSnapshot {
  @doc("ARM resource ID of the captured StageMap.")
  @visibility(Lifecycle.Read)
  resourceId: StageMapResourceId;

  @doc("Captured StageMap resource. Omitted when the snapshot entry contains only a reference.")
  @visibility(Lifecycle.Read)
  stageMap?: StageMap;
}

alias StageMapManagementGroupParameters = {
  ...ApiVersionParameter;
  ...Azure.ResourceManager.CommonTypes.ManagementGroupNameParameter;
};

@@segment(
  StageMapManagementGroupParameters.managementGroupName,
  "providers/Microsoft.Management/managementGroups"
);

@armResourceOperations
@doc("The operations of the StageMap resource.")
interface StageMaps {
  get is ArmResourceRead<StageMap>;
  getAtSubscriptionLevel is ArmResourceRead<
    StageMap,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  getAtManagementGroupLevel is ArmResourceRead<
    StageMap,
    StageMapManagementGroupParameters
  >;

  createOrUpdate is ArmResourceCreateOrReplaceSync<StageMap>;
  createOrUpdateAtSubscriptionLevel is ArmResourceCreateOrReplaceSync<
    StageMap,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  createOrUpdateAtManagementGroupLevel is ArmResourceCreateOrReplaceSync<
    StageMap,
    StageMapManagementGroupParameters
  >;

  update is ArmCustomPatchSync<
    StageMap,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      StageMap,
      ParameterPatchProperties<StageMapProperties>
    >
  >;
  updateAtSubscriptionLevel is ArmCustomPatchSync<
    StageMap,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      StageMap,
      ParameterPatchProperties<StageMapProperties>
    >,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  updateAtManagementGroupLevel is ArmCustomPatchSync<
    StageMap,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      StageMap,
      ParameterPatchProperties<StageMapProperties>
    >,
    StageMapManagementGroupParameters
  >;

  delete is ArmResourceDeleteSync<StageMap>;
  deleteAtSubscriptionLevel is ArmResourceDeleteSync<
    StageMap,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  deleteAtManagementGroupLevel is ArmResourceDeleteSync<
    StageMap,
    StageMapManagementGroupParameters
  >;

  list is ArmResourceListAtScope<StageMap>;
  listBySubscription is ArmListBySubscription<StageMap>;

  listByManagementGroup is ArmResourceListByParent<
    StageMap,
    StageMapManagementGroupParameters
  >;
}
