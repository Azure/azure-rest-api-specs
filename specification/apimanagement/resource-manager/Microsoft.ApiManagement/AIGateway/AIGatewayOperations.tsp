import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Microsoft.ApiManagement;

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface AiGatewayResources {
  get is ArmResourceRead<AiGatewayResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AiGatewayResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AiGatewayResource,
    PatchModel = AiGatewayUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayResource,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  listByResourceGroup is ArmResourceListByParent<AiGatewayResource>;
  listBySubscription is ArmListBySubscription<AiGatewayResource>;
}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface AiGatewayWorkspaceResources {
  get is ArmResourceRead<AiGatewayWorkspaceResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AiGatewayWorkspaceResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AiGatewayWorkspaceResource,
    PatchModel = AiGatewayWorkspaceUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayWorkspaceResource,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  listByAiGateway is ArmResourceListByParent<AiGatewayWorkspaceResource>;
}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface AiGatewayModelProviderResources {
  get is ArmResourceRead<AiGatewayModelProviderResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AiGatewayModelProviderResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AiGatewayModelProviderResource,
    PatchModel = AiGatewayModelProviderUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayModelProviderResource,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  listByWorkspace is ArmResourceListByParent<AiGatewayModelProviderResource>;

  /** Gets credential metadata for a model provider. Secret values are not returned. */
  @post
  @action("listCredentials")
  listCredentials is ArmResourceActionSync<
    AiGatewayModelProviderResource,
    void,
    ArmResponse<AiGatewayCredentialValue>
  >;
}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface AiGatewayModelResources {
  get is ArmResourceRead<AiGatewayModelResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AiGatewayModelResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AiGatewayModelResource,
    PatchModel = AiGatewayModelUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayModelResource,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  listByModelProvider is ArmResourceListByParent<AiGatewayModelResource>;
}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface AiGatewayToolServerResources {
  get is ArmResourceRead<AiGatewayToolServerResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AiGatewayToolServerResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AiGatewayToolServerResource,
    PatchModel = AiGatewayToolServerUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayToolServerResource,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  listByWorkspace is ArmResourceListByParent<AiGatewayToolServerResource>;

  /** Lists secret values configured on tool server endpoints. */
  @post
  @action("listSecrets")
  listSecrets is ArmResourceActionSync<
    AiGatewayToolServerResource,
    void,
    ArmResponse<AiGatewayToolServerSecrets>
  >;
}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface AiGatewayApiKeyResources {
  get is ArmResourceRead<AiGatewayApiKeyResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AiGatewayApiKeyResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AiGatewayApiKeyResource,
    PatchModel = AiGatewayApiKeyUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayApiKeyResource,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  listByAiGateway is ArmResourceListByParent<AiGatewayApiKeyResource>;

  /** Returns primary and secondary key values. */
  @post
  @action("listSecrets")
  listSecrets is ArmResourceActionSync<
    AiGatewayApiKeyResource,
    void,
    ArmResponse<AiGatewayApiKeyValues>
  >;

  /** Regenerates the primary API key value. */
  @post
  @action("regeneratePrimaryKey")
  regeneratePrimaryKey is ArmResourceActionSync<
    AiGatewayApiKeyResource,
    void,
    ArmNoContentResponse
  >;

  /** Regenerates the secondary API key value. */
  @post
  @action("regenerateSecondaryKey")
  regenerateSecondaryKey is ArmResourceActionSync<
    AiGatewayApiKeyResource,
    void,
    ArmNoContentResponse
  >;
}

/** Cross-provider model listing operations. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This operation returns models across all providers in one workspace."
@added(Versions.v2026_09_01_preview)
interface AiGatewayWorkspaceModelOperations {
  /** Lists models from every model provider in an AI Gateway workspace. */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}/models")
  @get
  @list
  listByWorkspace(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** AI Gateway resource name. */
    @pattern("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$")
    @path
    aiGatewayName: string,

    /** Workspace resource name. */
    @pattern("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$")
    @path
    workspaceName: string,
  ): ArmResponse<ResourceListResult<AiGatewayModelResource>> | ErrorResponse;
}
