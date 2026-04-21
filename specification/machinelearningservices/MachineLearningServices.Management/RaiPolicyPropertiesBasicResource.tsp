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
 * Azure OpenAI Content Filters resource.
 */
@removed(Versions.v2025_12_01)
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_03_01)
@removed(Versions.v2026_05_01)
@parentResource(WorkspaceConnectionPropertiesV2BasicResource)
model RaiPolicyPropertiesBasicResource
  is Azure.ResourceManager.ProxyResource<RaiPolicyProperties, false> {
  ...ResourceNameParameter<
    Resource = RaiPolicyPropertiesBasicResource,
    KeyName = "raiPolicyName",
    SegmentName = "raiPolicies",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;
}

/**
 * RaiPolicyPropertiesBasicResourceOps is preview-only.
 */
@removed(Versions.v2025_12_01)
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_03_01)
@removed(Versions.v2026_05_01)
@armResourceOperations
interface RaiPolicyPropertiesBasicResourceOps
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
        /** Name of the Rai Policy. */
        @path
        @segment("raiPolicies")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        raiPolicyName: string,
      }
    > {}

/**
 * RaiPolicyPropertiesBasicResources is preview-only.
 */
@removed(Versions.v2025_12_01)
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_03_01)
@removed(Versions.v2026_05_01)
@armResourceOperations
interface RaiPolicyPropertiesBasicResources {
  /**
   * Gets the specified Content Filters associated with the Azure OpenAI connection.
   */
  @summary("Gets the specified Content Filters associated with the Azure OpenAI connection.")
  get is RaiPolicyPropertiesBasicResourceOps.Read<RaiPolicyPropertiesBasicResource>;

  /**
   * Update the state of specified Content Filters associated with the Azure OpenAI connection.
   */
  @summary("Update the state of specified Content Filters associated with the Azure OpenAI connection.")
  create is RaiPolicyPropertiesBasicResourceOps.CreateOrUpdateAsync<
    RaiPolicyPropertiesBasicResource,
    Parameters = {
      ...ProxyApiVersion;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = RaiPolicyPropertiesBasicResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the specified Content Filters associated with the Azure OpenAI connection.
   */
  @summary("Deletes the specified Content Filters associated with the Azure OpenAI connection.")
  delete is RaiPolicyPropertiesBasicResourceOps.DeleteWithoutOkAsync<
    RaiPolicyPropertiesBasicResource,
    Parameters = {
      ...ProxyApiVersion;
    }
  >;

  /**
   * List the specified Content Filters associated with the Azure OpenAI connection.
   */
  @summary("List the specified Content Filters associated with the Azure OpenAI connection.")
  list is RaiPolicyPropertiesBasicResourceOps.List<
    RaiPolicyPropertiesBasicResource,
    Parameters = {
      ...ProxyApiVersion;
    },
    Response = ArmResponse<RaiPolicyPropertiesBasicResourceArmPaginatedResult>
  >;
}

/**
 * RaiPolicyOps is preview-only.
 */
@removed(Versions.v2025_12_01)
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_03_01)
@removed(Versions.v2026_05_01)
@armResourceOperations
interface RaiPolicyOps
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
        /** Name of the Rai Policy. */
        @path
        @segment("raiPolicies")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        raiPolicyName: string,
      }
    > {}

/**
 * RaiPolicy is preview-only.
 */
@removed(Versions.v2025_12_01)
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_03_01)
@removed(Versions.v2026_05_01)
@armResourceOperations
interface RaiPolicy {
  /**
   * Gets the specified Content Filters associated with the Azure OpenAI account.
   */
  @summary("Gets the specified Content Filters associated with the Azure OpenAI account.")
  get is RaiPolicyOps.Read<RaiPolicyPropertiesBasicResource>;

  /**
   * Update the state of specified Content Filters associated with the Azure OpenAI account.
   */
  @summary("Update the state of specified Content Filters associated with the Azure OpenAI account.")
  create is RaiPolicyOps.CreateOrUpdateAsync<
    RaiPolicyPropertiesBasicResource,
    Parameters = {
      ...ProxyApiVersion;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = RaiPolicyPropertiesBasicResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the specified Content Filters associated with the Azure OpenAI account.
   */
  @summary("Deletes the specified Content Filters associated with the Azure OpenAI account.")
  delete is RaiPolicyOps.DeleteWithoutOkAsync<
    RaiPolicyPropertiesBasicResource,
    Parameters = {
      ...ProxyApiVersion;
    }
  >;

  /**
   * List the specified Content Filters associated with the Azure OpenAI account.
   */
  @summary("List the specified Content Filters associated with the Azure OpenAI account.")
  list is RaiPolicyOps.List<
    RaiPolicyPropertiesBasicResource,
    Parameters = {
      ...ProxyApiVersion;
    },
    Response = ArmResponse<RaiPolicyPropertiesBasicResourceArmPaginatedResult>
  >;
}

@@doc(RaiPolicyPropertiesBasicResource.name, "Name of the Rai Policy.");
@@doc(RaiPolicyPropertiesBasicResource.properties,
  "Azure OpenAI Content Filters properties."
);
@@doc(RaiPolicyPropertiesBasicResources.create::parameters.resource,
  "Content filter policy resource to create or update."
);
@@doc(RaiPolicy.create::parameters.resource,
  "Content filter policy resource to create or update."
);
