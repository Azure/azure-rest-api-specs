import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.Scom.Builders;

/**
 * CUSTOM OPERATION forked from ArmResourceListByParent where we specify an explict List model
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Template op"
@autoRoute
@doc("List {name} resources by subscription ID", TResource)
@listsResource(TResource)
@segmentOf(TResource)
@armResourceList(TResource)
@get
op ScomArmListBySubscription<TResource extends ArmResource, List>(
  ...SubscriptionScope<TResource>,
): ArmResponse<List> | ErrorResponse;

/**
 * CUSTOM OPERATION forked from ArmResourceListByParent where we specify an explict List model
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Template op"
@get
@autoRoute
@listsResource(TResource)
@segmentOf(TResource)
@armResourceList(TResource)
op ScomArmResourceListByParent<TResource extends ArmResource, List>(
  ...ResourceParentParameters<TResource, BaseParameters<TResource>>,
): ArmResponse<List> | ErrorResponse;
