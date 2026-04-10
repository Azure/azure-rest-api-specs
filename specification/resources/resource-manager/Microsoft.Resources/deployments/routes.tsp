// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Resources;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface DeploymentsOperationGroup {
  /**
   * Calculate the hash of the given template.
   */
  @tag("Deployments")
  @autoRoute
  calculateTemplateHash is ArmProviderActionSync<
    Request = unknown,
    Response = TemplateHashResult,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface DeploymentOperationsOperationGroup {
  /**
   * Gets a deployments operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "For backward compatibility"
  @tag("DeploymentOperations")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/deployments/{deploymentName}/operations/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the deployment.
     */
    @maxLength(64)
    @minLength(1)
    @pattern("^[-\\w\\._\\(\\)]+$")
    @path
    deploymentName: string,

    /**
     * The ID of the operation to get.
     */
    @path
    operationId: string,

    ...SubscriptionIdParameter,
  ): ArmResponse<DeploymentOperation> | CloudError;

  /**
   * Gets all deployments operations for a deployment.
   */
  @tag("DeploymentOperations")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/deployments/{deploymentName}/operations")
  @get
  @list
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the deployment.
     */
    @maxLength(64)
    @minLength(1)
    @pattern("^[-\\w\\._\\(\\)]+$")
    @path
    @segment("deployments")
    deploymentName: string,

    /**
     * The number of results to return.
     */
    @query("$top")
    $top?: int32,
  ): ArmResponse<DeploymentOperationsListResult> | CloudError;
}
