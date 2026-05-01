import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

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

@armResourceOperations(#{ omitTags: true })
interface ManagedNetworkSettingsPropertiesBasicResources {
  /**
   * Get API for managed network settings of a cognitive services account.
   */
  @tag("ManagedNetwork")
  get is ArmResourceRead<ManagedNetworkSettingsPropertiesBasicResource>;

  /**
   * PUT API for managed network settings of a cognitive services account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "PUT returns 202 Accepted instead of 201 Created to match backend LRO behavior"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "PUT returns 202 Accepted instead of 201 Created to match backend LRO behavior"
  @tag("ManagedNetwork")
  put is ArmResourceCreateOrReplaceAsync<
    ManagedNetworkSettingsPropertiesBasicResource,
    LroHeaders = ArmLroLocationHeader<FinalResult = ManagedNetworkSettingsPropertiesBasicResource> &
      Azure.Core.Foundations.RetryAfterHeader,
    Response = ArmResourceUpdatedResponse<ManagedNetworkSettingsPropertiesBasicResource> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ManagedNetworkSettingsPropertiesBasicResource> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Patch API for managed network settings of a cognitive services account.
   */
  @tag("ManagedNetwork")
  @patch(#{ implicitOptionality: false })
  patch is Azure.ResourceManager.Legacy.CustomPatchAsync<
    ManagedNetworkSettingsPropertiesBasicResource,
    PatchModel = ManagedNetworkSettingsPropertiesBasicResource,
    OptionalRequestBody = true
  >;

  /**
   * Delete API for managed network settings of a cognitive services account.
   */
  @added(Versions.v2026_01_15_preview)
  @tag("ManagedNetwork")
  delete is ArmResourceDeleteWithoutOkAsync<ManagedNetworkSettingsPropertiesBasicResource>;

  /**
   * List API for managed network settings of a cognitive services account.
   */
  @tag("ManagedNetwork")
  list is ArmResourceListByParent<
    ManagedNetworkSettingsPropertiesBasicResource,
    Response = ArmResponse<ManagedNetworkListResult>
  >;

  /**
   * The POST API for updating the outbound rules of the managed network associated with the cognitive services account.
   */
  @tag("ManagedNetwork")
  @action("batchOutboundRules")
  @list
  post is ArmResourceActionAsync<
    ManagedNetworkSettingsPropertiesBasicResource,
    Request = ManagedNetworkSettingsBasicResource,
    Response = OutboundRuleListResult
  >;

  /**
   * Provisions the managed network of a cognitive services account.
   */
  @tag("ManagedNetwork")
  @action("provision")
  provisionManagedNetwork is ArmResourceActionAsync<
    ManagedNetworkSettingsPropertiesBasicResource,
    Request = ManagedNetworkProvisionOptions,
    Response = ArmResponse<ManagedNetworkProvisionStatus>,
    LroHeaders = ArmLroLocationHeader<FinalResult = ManagedNetworkProvisionStatus> &
      Azure.Core.Foundations.RetryAfterHeader,
    OptionalRequestBody = true
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
@@summary(ManagedNetworkSettingsPropertiesBasicResources.delete,
  "Delete API for managed network settings of a cognitive services account."
);
@@summary(ManagedNetworkSettingsPropertiesBasicResources.post,
  "The POST API for updating the outbound rules of the managed network associated with the cognitive services account."
);
@@doc(ManagedNetworkSettingsPropertiesBasicResources.provisionManagedNetwork::parameters.body,
  "Managed Network Provisioning Options for a cognitive services account."
);
@@summary(ManagedNetworkSettingsPropertiesBasicResources.provisionManagedNetwork,
  "Provisions the managed network of a cognitive services account."
);
