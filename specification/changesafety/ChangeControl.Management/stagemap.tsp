import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "./commonmodels.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

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
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  stages: Stage[];

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppressing the warning of operation parameters should not be of type Record as per ARM."
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

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppressing the warning: We need list of parameters in key:value format."
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "Suppressing warning: We need the Parameters to be strong type. So need to provide all the supported types which are string & int for now."
  @doc("Parameters to apply on the change of that stage. Key value pairs of parameter and values.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @removed(Versions.v2025_07_01_preview)
  parameterValues?: Record<string | int32>;

  @doc("Stage Map resource Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @removed(Versions.v2025_07_01_preview)
  nestedStageMapResourceId?: StageMapResourceId;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Stage specific key value pairs of parameter names & their values, which can be any type"
  @doc("Variables to apply on the change of that stage. Key value pairs supporting any JSON values.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Versions.v2025_07_01_preview)
  stageVariables?: Record<unknown>;

  @doc("Nested stage map details.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Versions.v2025_07_01_preview)
  nestedStageMap?: NestedStageMap;
}

@doc("Azure resource Id of a stage map.")
scalar StageMapResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ChangeSafety/stageMaps",
    }
  ]>;

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

  @added(Versions.v2025_03_01_preview)
  getAtManagementGroupLevel is ArmResourceRead<
    StageMap,
    {
      ...ApiVersionParameter;
      ...Azure.ResourceManager.CommonTypes.ManagementGroupNameParameter;
    }
  >;

  createOrUpdate is ArmResourceCreateOrReplaceSync<StageMap>;
  createOrUpdateAtSubscriptionLevel is ArmResourceCreateOrReplaceSync<
    StageMap,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @added(Versions.v2025_03_01_preview)
  createOrUpdateAtManagementGroupLevel is ArmResourceCreateOrReplaceSync<
    StageMap,
    {
      ...ApiVersionParameter;
      ...Azure.ResourceManager.CommonTypes.ManagementGroupNameParameter;
    }
  >;

  update is ArmResourcePatchSync<StageMap, StageMapProperties>;
  updateAtSubscriptionLevel is ArmResourcePatchSync<
    StageMap,
    StageMapProperties,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @added(Versions.v2025_03_01_preview)
  updateAtManagementGroupLevel is ArmResourcePatchSync<
    StageMap,
    StageMapProperties,
    {
      ...ApiVersionParameter;
      ...Azure.ResourceManager.CommonTypes.ManagementGroupNameParameter;
    }
  >;

  delete is ArmResourceDeleteSync<StageMap>;
  deleteAtSubscriptionLevel is ArmResourceDeleteSync<
    StageMap,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  @added(Versions.v2025_03_01_preview)
  deleteAtManagementGroupLevel is ArmResourceDeleteSync<
    StageMap,
    {
      ...ApiVersionParameter;
      ...Azure.ResourceManager.CommonTypes.ManagementGroupNameParameter;
    }
  >;

  list is ArmResourceListAtScope<StageMap>;
  listBySubscription is ArmListBySubscription<StageMap>;

  @added(Versions.v2025_03_01_preview)
  listByManagementGroup is ArmResourceListByParent<
    StageMap,
    {
      ...ApiVersionParameter;
      ...Azure.ResourceManager.CommonTypes.ManagementGroupNameParameter;
    }
  >;
}
