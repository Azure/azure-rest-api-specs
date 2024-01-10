import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DataReplication;

@summary("Performs the resource name availability check.")
@doc("Checks the resource name availability.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.DataReplication/locations/{location}/checkNameAvailability")
@post
op CheckNameAvailability is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription. The value must be an UUID.")
    @path
    subscriptionId: string;

    @doc("The name of the Azure region.")
    @minLength(1)
    @path
    location: string;

    @doc("Resource details.")
    @body
    body?: CheckNameAvailabilityModel;
  },
  CheckNameAvailabilityResponseModel
>;

@summary("Performs resource deployment validation.")
@doc("Performs resource deployment validation.")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/deployments/{deploymentId}/preflight")
@post
op DeploymentPreflight is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the target subscription. The value must be an UUID.")
    @path
    subscriptionId: string;

    @doc("The name of the resource group. The name is case insensitive.")
    @maxLength(90)
    @minLength(1)
    @path
    resourceGroupName: string;

    @doc("Deployment Id.")
    @path
    deploymentId: string;

    @doc("Deployment preflight model.")
    @body
    body?: DeploymentPreflightModel;
  },
  DeploymentPreflightModel
>;
