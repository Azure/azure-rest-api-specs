import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./WorkspaceConnectionPropertiesV2BasicResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;

/**
 * EndpointDeploymentResourcePropertiesBasicResource is preview-only.
 */
@removed(Versions.v2025_12_01)
@added(Versions.v2026_01_15_preview)
@parentResource(WorkspaceConnectionPropertiesV2BasicResource)
model EndpointDeploymentResourcePropertiesBasicResource
  is Azure.ResourceManager.ProxyResource<
    EndpointDeploymentResourceProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = EndpointDeploymentResourcePropertiesBasicResource,
    KeyName = "deploymentName",
    SegmentName = "deployments",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$"
  >;
}

/**
 * EndpointDeploymentResourcePropertiesBasicResourceOps is preview-only.
 */
@removed(Versions.v2025_12_01)
@added(Versions.v2026_01_15_preview)
@armResourceOperations
interface EndpointDeploymentResourcePropertiesBasicResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Azure Machine Learning Workspace Name */
        @path
        @segment("workspaces")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
        workspaceName: string,

        /** Friendly name of the workspace connection */
        @path
        @segment("connections")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
        connectionName: string,
      },
      {
        /** Name of the deployment resource */
        @path
        @segment("deployments")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
        deploymentName: string,
      }
    > {}

/**
 * EndpointDeploymentResourcePropertiesBasicResources is preview-only.
 */
@removed(Versions.v2025_12_01)
@added(Versions.v2026_01_15_preview)
@armResourceOperations
interface EndpointDeploymentResourcePropertiesBasicResources {
  /**
   * Get deployments under the Azure OpenAI connection by name.
   */
  @summary("Get deployments under the Azure OpenAI connection by name.")
  getDeployment is EndpointDeploymentResourcePropertiesBasicResourceOps.Read<EndpointDeploymentResourcePropertiesBasicResource>;

  /**
   * Create or update Azure OpenAI connection deployment resource with the specified parameters
   */
  @summary("Create or update Azure OpenAI connection deployment resource with the specified parameters")
  createOrUpdateDeployment is EndpointDeploymentResourcePropertiesBasicResourceOps.CreateOrUpdateAsync<
    EndpointDeploymentResourcePropertiesBasicResource,
    Parameters = {
      /**
       * Api version used by proxy call
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
      @query("proxy-api-version")
      `proxy-api-version`?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = EndpointDeploymentResourcePropertiesBasicResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete Azure OpenAI connection deployment resource by name
   */
  @summary("Delete Azure OpenAI connection deployment resource by name")
  deleteDeployment is EndpointDeploymentResourcePropertiesBasicResourceOps.DeleteWithoutOkAsync<
    EndpointDeploymentResourcePropertiesBasicResource,
    Parameters = {
      /**
       * Api version used by proxy call
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
      @query("proxy-api-version")
      `proxy-api-version`?: string;
    }
  >;

  /**
   * Get all the deployments under the Azure OpenAI connection.
   */
  @summary("Get all the deployments under the Azure OpenAI connection.")
  listDeployments is EndpointDeploymentResourcePropertiesBasicResourceOps.List<
    EndpointDeploymentResourcePropertiesBasicResource,
    Parameters = {
      /**
       * Api version used by proxy call
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
      @query("proxy-api-version")
      `proxy-api-version`?: string;
    },
    Response = ArmResponse<EndpointDeploymentResourcePropertiesBasicResourceArmPaginatedResult>
  >;
}

/**
 * EndpointDeploymentOps is preview-only.
 */
@removed(Versions.v2025_12_01)
@added(Versions.v2026_01_15_preview)
@armResourceOperations
interface EndpointDeploymentOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Azure Machine Learning Workspace Name */
        @path
        @segment("workspaces")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
        workspaceName: string,

        /** Name of the endpoint resource. */
        @path
        @segment("endpoints")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]{2,32}$")
        endpointName: string,
      },
      {
        /** Name of the deployment resource */
        @path
        @segment("deployments")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
        deploymentName: string,
      }
    > {}

/**
 * EndpointDeployment is preview-only.
 */
@removed(Versions.v2025_12_01)
@added(Versions.v2026_01_15_preview)
@armResourceOperations
interface EndpointDeployment {
  /**
   * Get deployments under endpoint resource by name
   */
  @summary("Get deployments under endpoint resource by name")
  get is EndpointDeploymentOps.Read<EndpointDeploymentResourcePropertiesBasicResource>;

  /**
   * Create or update endpoint deployment resource with the specified parameters
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Existing API returns additional response codes"
  @summary("Create or update endpoint deployment resource with the specified parameters")
  createOrUpdate is EndpointDeploymentOps.CreateOrUpdateAsync<
    EndpointDeploymentResourcePropertiesBasicResource,
    Response = ArmResourceUpdatedResponse<EndpointDeploymentResourcePropertiesBasicResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = EndpointDeploymentResourcePropertiesBasicResource>> &
      Azure.Core.Foundations.RetryAfterHeader)
  >;

  /**
   * Delete  endpoint deployment resource by name
   */
  @summary("Delete  endpoint deployment resource by name")
  delete is EndpointDeploymentOps.DeleteWithoutOkAsync<
    EndpointDeploymentResourcePropertiesBasicResource,
    Parameters = {
      /**
       * Api version used by proxy call
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
      @query("proxy-api-version")
      `proxy-api-version`?: string;
    }
  >;

  /**
   * Get all the deployments under the endpoint resource scope
   */
  @summary("Get all the deployments under the endpoint resource scope")
  list is EndpointDeploymentOps.List<
    EndpointDeploymentResourcePropertiesBasicResource,
    Response = ArmResponse<EndpointDeploymentResourcePropertiesBasicResourceArmPaginatedResult>
  >;
}

@@doc(EndpointDeploymentResourcePropertiesBasicResource.name,
  "Name of the deployment resource"
);
@@doc(EndpointDeploymentResourcePropertiesBasicResource.properties, "");
@@doc(EndpointDeploymentResourcePropertiesBasicResources.createOrUpdateDeployment::parameters.resource,
  "deployment object"
);
@@doc(EndpointDeployment.createOrUpdate::parameters.resource,
  "deployment object"
);
