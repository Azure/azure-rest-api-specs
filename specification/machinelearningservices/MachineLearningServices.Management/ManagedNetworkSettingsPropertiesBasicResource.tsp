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

/**
 * ManagedNetworkSettingsPropertiesBasicResource is a preview-only resource.
 */
@removed(Versions.v2025_12_01)
@parentResource(Workspace)
model ManagedNetworkSettingsPropertiesBasicResource
  is Azure.ResourceManager.ProxyResource<ManagedNetworkSettingsProperties> {
  ...ResourceNameParameter<
    Resource = ManagedNetworkSettingsPropertiesBasicResource,
    KeyName = "managedNetworkName",
    SegmentName = "managedNetworks",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$"
  >;
}

/**
 * ManagedNetworkSettingsPropertiesBasicResources interface is preview-only.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Resource does not support delete operation"
@removed(Versions.v2025_12_01)
@armResourceOperations
interface ManagedNetworkSettingsPropertiesBasicResources {
  /**
   * Get API for managed network settings of a machine learning workspace.
   */
  @summary("Get the managed network settings for a machine learning workspace.")
  get is ArmResourceRead<ManagedNetworkSettingsPropertiesBasicResource>;

  /**
   * PUT API for managed network settings of a machine learning workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Existing API returns additional response codes"
  @summary("PUT API for managed network settings of a machine learning workspace.")
  put is ArmResourceCreateOrReplaceAsync<
    ManagedNetworkSettingsPropertiesBasicResource,
    Response = ArmResourceUpdatedResponse<ManagedNetworkSettingsPropertiesBasicResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ManagedNetworkSettingsPropertiesBasicResource>> &
      Azure.Core.Foundations.RetryAfterHeader)
  >;

  /**
   * Patch API for managed network settings of a machine learning workspace.
   */
  @patch(#{ implicitOptionality: false })
  @summary("Patch API for managed network settings of a machine learning workspace.")
  patch is Azure.ResourceManager.Legacy.CustomPatchAsync<
    ManagedNetworkSettingsPropertiesBasicResource,
    PatchModel = ManagedNetworkSettingsPropertiesBasicResource,
    OptionalRequestBody = true
  >;

  /**
   * List API for managed network settings of a machine learning workspace.
   */
  @summary("List the managed network settings for a machine learning workspace.")
  list is ArmResourceListByParent<
    ManagedNetworkSettingsPropertiesBasicResource,
    Response = ManagedNetworkListResult
  >;

  /**
   * The POST API for updating the outbound rules of the managed network associated with the machine learning workspace.
   */
  @summary("The POST API for updating the outbound rules of the managed network associated with the machine learning workspace.")
  @action("batchOutboundRules")
  @list
  @post
  post is ArmResourceActionAsync<
    ManagedNetworkSettingsPropertiesBasicResource,
    ManagedNetworkSettingsBasicResource,
    OutboundRuleListResult
  >;
}

@@doc(ManagedNetworkSettingsPropertiesBasicResource.name,
  "Name of the managedNetwork associated with the workspace. Only 'default' is supported."
);
@@doc(ManagedNetworkSettingsPropertiesBasicResource.properties,
  "The properties of the managed network settings of a machine learning workspace."
);
@@doc(ManagedNetworkSettingsPropertiesBasicResources.put::parameters.resource,
  "The Managed Network Settings object of the workspace."
);
@@doc(ManagedNetworkSettingsPropertiesBasicResources.patch::parameters.properties,
  "The Managed Network Settings object of the workspace."
);
@@doc(ManagedNetworkSettingsPropertiesBasicResources.post::parameters.body,
  "The Managed Network Settings object of the workspace."
);
