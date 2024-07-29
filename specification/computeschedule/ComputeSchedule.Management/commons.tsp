import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ComputeSchedule;

@doc("Lists {name}", TResponse)
@get
@autoRoute
@listsResource(TResponse)
@armResourceList(TResponse)
op ArmResourceListActionSync<
TResource extends Azure.ResourceManager.Foundations.Resource, 
TResponse extends TypeSpec.Reflection.Model,
TBaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<TResource>>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>
): ArmResponse<ResourceListResult<TResponse>> | ErrorResponse;


@autoRoute
@armResourceAction(TResource)
@post
op ArmResourceActionNoContentNoResponseSync<
TResource extends Azure.ResourceManager.Foundations.Resource,
TBaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<TResource>>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,
) : ArmNoContentResponse | ErrorResponse;