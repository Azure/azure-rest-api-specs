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

namespace Microsoft.MachineLearningServices;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BatchJobDeploymentOperationGroup {
  /**
   * Creates a batch inference job for a deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Creates a batch inference job for a deployment.")
  @operationId("BatchJobDeployment_Create")
  @autoRoute
  @action("jobs")
  create is ArmProviderActionSync<
    Request = BatchJobResource,
    Response = BatchJobResource,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * Name of endpoint
       */
      @path
      @segment("batchEndpoints")
      endpointName: string;

      /**
       * Name of deployment
       */
      @path
      @segment("deployments")
      deploymentName: string;

      /**
       * Name of Azure Machine Learning workspace.
       */
      @path
      @segment("workspaces")
      workspaceName: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BatchJobEndpointOperationGroup {
  /**
   * Creates a batch inference endpoint job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Creates a batch inference endpoint job.")
  @operationId("BatchJobEndpoint_Create")
  @autoRoute
  @action("jobs")
  create is ArmProviderActionSync<
    Request = BatchJobResource,
    Response = BatchJobResource,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * Name of endpoint
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,254}$")
      @path
      @segment("batchEndpoints")
      endpointName: string;

      /**
       * Name of Azure Machine Learning workspace.
       */
      @path
      @segment("workspaces")
      workspaceName: string;
    }
  >;
}
