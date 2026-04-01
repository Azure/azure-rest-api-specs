import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;

@parentResource(Workspace)
model OutboundRuleBasicResource
  is Azure.ResourceManager.ProxyResource<OutboundRule, false> {
  ...ResourceNameParameter<
    Resource = OutboundRuleBasicResource,
    KeyName = "ruleName",
    SegmentName = "outboundRules",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$"
  >;
}

@armResourceOperations
interface OutboundRuleBasicResourceOps
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
      },
      {
        /** Name of the workspace managed network outbound rule */
        @path
        @segment("outboundRules")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
        ruleName: string,
      }
    > {}

@armResourceOperations
interface OutboundRuleBasicResources {
  /**
   * Gets an outbound rule from the managed network of a machine learning workspace.
   */
  @summary("Gets an outbound rule from the managed network of a machine learning workspace.")
  get is OutboundRuleBasicResourceOps.Read<OutboundRuleBasicResource>;

  /**
   * Creates or updates an outbound rule in the managed network of a machine learning workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Existing API returns additional response codes"
  @summary("Creates or updates an outbound rule in the managed network of a machine learning workspace.")
  createOrUpdate is OutboundRuleBasicResourceOps.CreateOrUpdateAsync<
    OutboundRuleBasicResource,
    Response = ArmResourceUpdatedResponse<OutboundRuleBasicResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OutboundRuleBasicResource>> &
      Azure.Core.Foundations.RetryAfterHeader)
  >;

  /**
   * Deletes an outbound rule from the managed network of a machine learning workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API returns additional response codes for LRO delete"
  @summary("Deletes an outbound rule from the managed network of a machine learning workspace.")
  delete is OutboundRuleBasicResourceOps.DeleteWithoutOkAsync<
    OutboundRuleBasicResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists the managed network outbound rules for a machine learning workspace.
   */
  @summary("Lists the managed network outbound rules for a machine learning workspace.")
  list is OutboundRuleBasicResourceOps.List<
    OutboundRuleBasicResource,
    Response = OutboundRuleListResult
  >;
}
@armResourceOperations
interface OutboundRuleBasicResourceOperationGroupOps
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

        /** Name of the managedNetwork associated with the workspace. Only 'default' is supported. */
        @path
        @segment("managedNetworks")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
        managedNetworkName: string,
      },
      {
        /** Name of the workspace managed network outbound rule */
        @path
        @segment("outboundRules")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
        ruleName: string,
      }
    > {}

@removed(Versions.v2025_12_01)
@added(Versions.v2026_01_15_preview)
@armResourceOperations
interface OutboundRuleBasicResourceOperationGroup {
  /**
   * The GET API for retrieveing a single outbound rule of the managed network associated with the machine learning workspace.
   */
  @summary("The GET API for retrieveing a single outbound rule of the managed network associated with the machine learning workspace.")
  get is OutboundRuleBasicResourceOperationGroupOps.Read<OutboundRuleBasicResource>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Existing API returns additional response codes"
  createOrUpdate is OutboundRuleBasicResourceOperationGroupOps.CreateOrUpdateAsync<
    OutboundRuleBasicResource,
    Response = ArmResourceUpdatedResponse<OutboundRuleBasicResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OutboundRuleBasicResource>> &
      Azure.Core.Foundations.RetryAfterHeader)
  >;

  /**
   * The DELETE API for deleting a single outbound rule of the managed network associated with the machine learning workspace.
   */
  @summary("The DELETE API for deleting a single outbound rule of the managed network associated with the machine learning workspace.")
  delete is OutboundRuleBasicResourceOperationGroupOps.DeleteWithoutOkAsync<OutboundRuleBasicResource>;

  /**
   * The GET API for retrieveing the list of outbound rules of the managed network associated with the machine learning workspace.
   */
  @summary("The GET API for retrieveing the list of outbound rules of the managed network associated with the machine learning workspace.")
  list is OutboundRuleBasicResourceOperationGroupOps.List<
    OutboundRuleBasicResource,
    Response = OutboundRuleListResult
  >;
}

@@doc(OutboundRuleBasicResource.name,
  "Name of the workspace managed network outbound rule"
);
@@doc(OutboundRuleBasicResource.properties,
  "Outbound Rule for the managed network of a machine learning workspace."
);
@@doc(OutboundRuleBasicResources.createOrUpdate::parameters.resource,
  "Outbound Rule to be created or updated in the managed network of a machine learning workspace."
);
@@doc(OutboundRuleBasicResourceOperationGroup.createOrUpdate::parameters.resource,
  ""
);
