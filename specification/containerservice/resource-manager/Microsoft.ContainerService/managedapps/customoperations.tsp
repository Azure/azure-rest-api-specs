import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./appdeployment.tsp";

using Azure.Core;
using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ContainerService;

/** Lists the deployments for a given App Revision or Managed App. */
@action("deployments")
@armResourceAction(TResource)
@get
@armResourceList(AppDeployment)
op ListDeployments<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TBaseParameters = BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,
): ArmResponse<ResourceListResult<AppDeployment>> | ErrorResponse;
