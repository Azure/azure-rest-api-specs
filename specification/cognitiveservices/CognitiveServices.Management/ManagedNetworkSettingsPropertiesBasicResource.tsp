import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;

@parentResource(Account)
model ManagedNetworkSettingsPropertiesBasicResource
  is Azure.ResourceManager.ProxyResource<ManagedNetworkSettingsProperties> {
  ...ResourceNameParameter<
    Resource = ManagedNetworkSettingsPropertiesBasicResource,
    KeyName = "managedNetworkName",
    SegmentName = "managedNetworks",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ManagedNetworkSettingsPropertiesBasicResources {
  /**
   * Get API for managed network settings of a cognitive services account.
   */
  get is ArmResourceRead<ManagedNetworkSettingsPropertiesBasicResource>;

  /**
   * PUT API for managed network settings of a cognitive services account.
   */
  put is ArmResourceCreateOrReplaceAsync<
    ManagedNetworkSettingsPropertiesBasicResource,
    LroHeaders = ArmLroLocationHeader<FinalResult = ManagedNetworkSettingsPropertiesBasicResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Patch API for managed network settings of a cognitive services account.
   */
  @patch(#{ implicitOptionality: false })
  patch is Azure.ResourceManager.Legacy.CustomPatchAsync<
    ManagedNetworkSettingsPropertiesBasicResource,
    PatchModel = ManagedNetworkSettingsPropertiesBasicResource,
    OptionalRequestBody = true
  >;

  /**
   * List API for managed network settings of a cognitive services account.
   */
  list is ArmResourceListByParent<
    ManagedNetworkSettingsPropertiesBasicResource,
    Response = ArmResponse<ManagedNetworkListResult>
  >;

  /**
   * The POST API for updating the outbound rules of the managed network associated with the cognitive services account.
   */
  @action("batchOutboundRules")
  post is ArmResourceActionAsync<
    ManagedNetworkSettingsPropertiesBasicResource,
    Request = ManagedNetworkSettingsBasicResource,
    Response = OutboundRuleListResult
  >;
}

@@doc(ManagedNetworkSettingsPropertiesBasicResource.name,
  "Name of the managedNetwork associated with the cognitive services account. Only 'default' is supported."
);
@@doc(ManagedNetworkSettingsPropertiesBasicResource.properties,
  "The properties of the managed network settings of a cognitive services account."
);
@@doc(ManagedNetworkSettingsPropertiesBasicResources.put::parameters.resource,
  "The Managed Network Settings object of the account."
);
@@doc(ManagedNetworkSettingsPropertiesBasicResources.patch::parameters.properties,
  "The Managed Network Settings object of the account."
);
@@doc(ManagedNetworkSettingsPropertiesBasicResources.post::parameters.body,
  "The Managed Network Settings object of the account."
);
@@summary(ManagedNetworkSettingsPropertiesBasicResources.list,
  "List API for managed network settings of a cognitive services account."
);
@@summary(ManagedNetworkSettingsPropertiesBasicResources.get,
  "Get API for managed network settings of a cognitive services account."
);
@@summary(ManagedNetworkSettingsPropertiesBasicResources.put,
  "PUT API for managed network settings of a cognitive services account."
);
@@summary(ManagedNetworkSettingsPropertiesBasicResources.patch,
  "Patch API for managed network settings of a cognitive services account."
);
@@summary(ManagedNetworkSettingsPropertiesBasicResources.post,
  "The POST API for updating the outbound rules of the managed network associated with the cognitive services account."
);
