import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;

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

@armResourceOperations
interface ManagedNetworkSettingsPropertiesBasicResources {
  /**
   * Get API for managed network settings of a machine learning workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedNetworkSettings_Get")
  get is ArmResourceRead<ManagedNetworkSettingsPropertiesBasicResource>;

  /**
   * PUT API for managed network settings of a machine learning workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ManagedNetworkSettings_Put")
  put is ArmResourceCreateOrReplaceAsync<
    ManagedNetworkSettingsPropertiesBasicResource,
    Response = ArmResourceUpdatedResponse<ManagedNetworkSettingsPropertiesBasicResource> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ManagedNetworkSettingsPropertiesBasicResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Patch API for managed network settings of a machine learning workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedNetworkSettings_Patch")
  @patch(#{ implicitOptionality: false })
  patch is Azure.ResourceManager.Legacy.CustomPatchAsync<
    ManagedNetworkSettingsPropertiesBasicResource,
    PatchModel = ManagedNetworkSettingsPropertiesBasicResource,
    OptionalRequestBody = true
  >;

  /**
   * List API for managed network settings of a machine learning workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedNetworkSettings_List")
  list is ArmResourceListByParent<ManagedNetworkSettingsPropertiesBasicResource>;

  /**
   * The POST API for updating the outbound rules of the managed network associated with the machine learning workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("OutboundRules_Post")
  @list
  @action("batchOutboundRules")
  post is ArmResourceActionAsync<
    ManagedNetworkSettingsPropertiesBasicResource,
    ManagedNetworkSettingsBasicResource,
    ArmResponse<ResourceListResult<OutboundRuleBasicResource>>
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
