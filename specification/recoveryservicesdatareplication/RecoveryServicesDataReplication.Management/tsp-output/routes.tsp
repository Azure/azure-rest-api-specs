import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DataReplication;

/**
 * Checks the resource name availability.
 */
@summary("Performs the resource name availability check.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.DataReplication/locations/{location}/checkNameAvailability")
@post
op checkNameAvailability is Azure.Core.Foundations.Operation<
  {
    /**
     * The ID of the target subscription. The value must be an UUID.
     */
    @path
    subscriptionId: string;

    /**
     * The name of the Azure region.
     */
    @minLength(1)
    @path
    location: string;

    /**
     * Resource details.
     */
    @body
    body?: CheckNameAvailabilityModel;
  },
  CheckNameAvailabilityResponseModel
>;

/**
 * Performs resource deployment validation.
 */
@summary("Performs resource deployment validation.")
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataReplication/deployments/{deploymentId}/preflight")
@post
op deploymentPreflight is Azure.Core.Foundations.Operation<
  {
    /**
     * The ID of the target subscription. The value must be an UUID.
     */
    @path
    subscriptionId: string;

    /**
     * The name of the resource group. The name is case insensitive.
     */
    @maxLength(90)
    @minLength(1)
    @path
    resourceGroupName: string;

    /**
     * Deployment Id.
     */
    @path
    deploymentId: string;

    /**
     * Deployment preflight model.
     */
    @body
    body?: DeploymentPreflightModel;
  },
  DeploymentPreflightModel
>;
