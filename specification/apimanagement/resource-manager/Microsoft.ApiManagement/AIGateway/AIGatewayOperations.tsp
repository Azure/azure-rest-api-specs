import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.ApiManagement;

@added(Versions.v2026_11_01)
@armResourceOperations
interface AiGatewayNameAvailabilityOperations {
  /** Checks whether an AI Gateway name is valid and available in a location. */
  checkNameAvailability is checkLocalNameAvailability<
    AiGatewayCheckNameAvailabilityRequest,
    AiGatewayCheckNameAvailabilityResponse
  >;
}

/** OAuth actions on a tool-server endpoint, which is not an independent resource. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "The nested OAuth endpoint action uses the implemented explicit route and is not a separate ARM resource."
@added(Versions.v2026_11_01)
interface AiGatewayToolServerEndpointOperations {
  /** Gets links to complete OAuth consent for a tool-server endpoint. */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}/toolServers/{toolServerName}/endpoints/{endpointId}/oauth2/getLoginLinks")
  @post
  getLoginLinks(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** AI Gateway resource name. */
    @pattern("^[a-z0-9][a-z0-9-]{1,22}[a-z0-9]$")
    @path
    aiGatewayName: string,

    /** Default workspace resource name. */
    @pattern("^default$")
    @path
    workspaceName: string,

    /** Tool server resource name. */
    @pattern("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$")
    @path
    toolServerName: string,

    /** Stable identifier of the tool-server endpoint. */
    @path
    endpointId: string,
  ): ArmResponse<AiGatewayToolServerOauth2LoginLinks> | ErrorResponse;
}

@added(Versions.v2026_11_01)
@armResourceOperations
interface AiGatewayTelemetryExporterResources {
  checkExistence is ArmResourceCheckExistence<
    AiGatewayTelemetryExporterResource,
    Response = AiGatewayResourceExistsResponse
  >;
  get is ArmResourceRead<AiGatewayTelemetryExporterResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AiGatewayTelemetryExporterResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AiGatewayTelemetryExporterResource,
    PatchModel = AiGatewayTelemetryExporterUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteSync<
    AiGatewayTelemetryExporterResource,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  listByWorkspace is ArmResourceListByParent<AiGatewayTelemetryExporterResource>;
}

@added(Versions.v2026_11_01)
@armResourceOperations
interface AiGatewayAliasResources {
  checkExistence is ArmResourceCheckExistence<
    AiGatewayAliasResource,
    Response = AiGatewayResourceExistsResponse
  >;
  get is ArmResourceRead<AiGatewayAliasResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AiGatewayAliasResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AiGatewayAliasResource,
    PatchModel = AiGatewayAliasUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteSync<
    AiGatewayAliasResource,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  listByWorkspace is ArmResourceListByParent<AiGatewayAliasResource>;
}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface AiGatewayResources {
  get is ArmResourceRead<AiGatewayResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AiGatewayResource>;
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

@added(Versions.v2026_11_01)
@armResourceOperations
interface AiGatewayWorkspaceResources {
  checkExistence is ArmResourceCheckExistence<
    AiGatewayWorkspaceResource,
    Response = AiGatewayResourceExistsResponse
  >;
  get is ArmResourceRead<AiGatewayWorkspaceResource>;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AiGatewayWorkspaceResource,
    PatchModel = AiGatewayWorkspaceUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
}

@added(Versions.v2026_11_01)
@armResourceOperations
interface AiGatewayModelProviderResources {
  checkExistence is ArmResourceCheckExistence<
    AiGatewayModelProviderResource,
    Response = AiGatewayResourceExistsResponse
  >;
  get is ArmResourceRead<AiGatewayModelProviderResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AiGatewayModelProviderResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AiGatewayModelProviderResource,
    PatchModel = AiGatewayModelProviderUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteSync<
    AiGatewayModelProviderResource,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  listByWorkspace is ArmResourceListByParent<AiGatewayModelProviderResource>;

  /** Returns the stored model-provider credential value, including the secret. */
  @post
  @action("listCredentials")
  listCredentials is ArmResourceActionSync<
    AiGatewayModelProviderResource,
    void,
    ArmResponse<AiGatewayCredentialValue>
  >;
}

@added(Versions.v2026_11_01)
@armResourceOperations
interface AiGatewayModelResources {
  checkExistence is ArmResourceCheckExistence<
    AiGatewayModelResource,
    Response = AiGatewayResourceExistsResponse
  >;
  get is ArmResourceRead<AiGatewayModelResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AiGatewayModelResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AiGatewayModelResource,
    PatchModel = AiGatewayModelUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteSync<
    AiGatewayModelResource,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  listByModelProvider is ArmResourceListByParent<AiGatewayModelResource>;
}

@added(Versions.v2026_11_01)
@armResourceOperations
interface AiGatewayToolServerResources {
  checkExistence is ArmResourceCheckExistence<
    AiGatewayToolServerResource,
    Response = AiGatewayResourceExistsResponse
  >;
  get is ArmResourceRead<AiGatewayToolServerResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AiGatewayToolServerResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AiGatewayToolServerResource,
    PatchModel = AiGatewayToolServerUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteSync<
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

@added(Versions.v2026_11_01)
@armResourceOperations
interface AiGatewayApiKeyResources {
  checkExistence is ArmResourceCheckExistence<
    AiGatewayApiKeyResource,
    Response = AiGatewayResourceExistsResponse
  >;
  get is ArmResourceRead<AiGatewayApiKeyResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AiGatewayApiKeyResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AiGatewayApiKeyResource,
    PatchModel = AiGatewayApiKeyUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteSync<
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
@added(Versions.v2026_11_01)
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
    @pattern("^[a-z0-9][a-z0-9-]{1,22}[a-z0-9]$")
    @path
    aiGatewayName: string,

    /** Workspace resource name. */
    @pattern("^default$")
    @path
    workspaceName: string,
  ): ArmResponse<ResourceListResult<AiGatewayModelResource>> | ErrorResponse;
}
