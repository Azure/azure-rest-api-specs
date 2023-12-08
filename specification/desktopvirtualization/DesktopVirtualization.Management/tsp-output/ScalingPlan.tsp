import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DesktopVirtualization;
@doc("Represents a scaling plan definition.")
model ScalingPlan is TrackedResource<ScalingPlanProperties> {
  @doc("The name of the scaling plan.")
  @maxLength(64)
  @minLength(3)
  @path
  @key("scalingPlanName")
  @segment("scalingPlans")
  name: string;
}

@armResourceOperations
interface ScalingPlans {
  @doc("Get a scaling plan.")
  get is ArmResourceRead<ScalingPlan>;
  @doc("Create or update a scaling plan.")
  create is ArmResourceCreateOrReplaceSync<ScalingPlan>;
  @doc("Update a scaling plan.")
  update is ArmResourcePatchSync<ScalingPlan, ScalingPlanProperties>;
  @doc("Remove a scaling plan.")
  delete is ArmResourceDeleteSync<ScalingPlan>;
  @doc("List scaling plans.")
  listByResourceGroup is ArmResourceListByParent<
    ScalingPlan,
    {
      ...BaseParameters<ScalingPlan>;

      @doc("Number of items per page.")
      @query("pageSize")
      pageSize?: int32;

      @doc("Indicates whether the collection is descending.")
      @query("isDescending")
      isDescending?: boolean;

      @doc("Initial number of items to skip.")
      @query("initialSkip")
      initialSkip?: int32;
    }
  >;
  @doc("List scaling plans in subscription.")
  listBySubscription is ArmListBySubscription<ScalingPlan>;
}
