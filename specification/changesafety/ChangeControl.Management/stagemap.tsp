import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./commonmodels.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
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
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Array of stages objects.")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  @visibility("read", "create", "update")
  stages: Stage[];

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppressing the warning of operation parameters should not be of type Record as per ARM."
  @doc("StageMap parameters schema for each stage.")
  @visibility("read", "create", "update")
  parameters?: Record<Parameter>;
}

@doc("Defines details about each stage in the stage map resource.")
model Stage {
  @doc("Name of the individual stage.")
  @minLength(3)
  @maxLength(100)
  @pattern("^[a-zA-Z0-9-]{3,100}$")
  @visibility("read", "create", "update")
  name: string;

  @doc("Positive integer defining the orchestration order of the stages.")
  @visibility("read", "create", "update")
  @minValue(1)
  sequence: int32;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppressing the warning: We need list of parameters in key:value format."
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "Suppressing warning: We need the Parameters to be strong type. So need to provide all the supported types which are string & int for now."
  @doc("Parameters to apply on the change of that stage. Key value pairs of parameter and values.")
  @visibility("read", "create", "update")
  parameterValues?: Record<string | int32>;

  @doc("Stage Map resource Id.")
  @visibility("read", "create", "update")
  nestedStageMapResourceId?: StageMapResourceId;
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

  createOrUpdate is ArmResourceCreateOrReplaceSync<StageMap>;
  createOrUpdateAtSubscriptionLevel is ArmResourceCreateOrReplaceSync<
    StageMap,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
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

  delete is ArmResourceDeleteSync<StageMap>;
  deleteAtSubscriptionLevel is ArmResourceDeleteSync<
    StageMap,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;

  list is ArmResourceListAtScope<StageMap>;
  listBySubscription is ArmListBySubscription<StageMap>;
}
