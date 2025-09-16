import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
@doc("The integration account.")
model IntegrationAccount
  is Azure.ResourceManager.TrackedResource<IntegrationAccountProperties> {
  ...ResourceNameParameter<
    Resource = IntegrationAccount,
    KeyName = "integrationAccountName",
    SegmentName = "integrationAccounts",
    NamePattern = ""
  >;

  @doc("The sku.")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: IntegrationAccountSku;
}

@armResourceOperations
interface IntegrationAccounts {
  @doc("Gets an integration account.")
  get is ArmResourceRead<IntegrationAccount>;

  @doc("Creates or updates an integration account.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<IntegrationAccount>;

  @doc("Updates an integration account.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    IntegrationAccount,
    PatchModel = IntegrationAccount
  >;

  @doc("Deletes an integration account.")
  delete is ArmResourceDeleteSync<IntegrationAccount>;

  @doc("Gets a list of integration accounts by resource group.")
  listByResourceGroup is ArmResourceListByParent<
    IntegrationAccount,
    Parameters = {
      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;
    }
  >;

  @doc("Gets a list of integration accounts by subscription.")
  listBySubscription is ArmListBySubscription<
    IntegrationAccount,
    Parameters = {
      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;
    }
  >;

  @doc("Gets the integration account callback URL.")
  listCallbackUrl is ArmResourceActionSync<
    IntegrationAccount,
    GetCallbackUrlParameters,
    ArmResponse<CallbackUrl>
  >;

  @doc("Gets the integration account's Key Vault keys.")
  listKeyVaultKeys is ArmResourceActionSync<
    IntegrationAccount,
    ListKeyVaultKeysDefinition,
    ArmResponse<KeyVaultKeyCollection>
  >;

  @doc("Logs the integration account's tracking events.")
  logTrackingEvents is ArmResourceActionSync<
    IntegrationAccount,
    TrackingEventsDefinition,
    OkResponse
  >;

  @doc("Regenerates the integration account access key.")
  regenerateAccessKey is ArmResourceActionSync<
    IntegrationAccount,
    RegenerateActionParameter,
    ArmResponse<IntegrationAccount>
  >;
}

@@doc(IntegrationAccount.name, "The integration account name.");
@@doc(IntegrationAccount.properties, "The integration account properties.");
@@doc(IntegrationAccounts.createOrUpdate::parameters.resource,
  "The integration account."
);
@@doc(IntegrationAccounts.update::parameters.properties,
  "The integration account."
);
@@doc(IntegrationAccounts.listCallbackUrl::parameters.body,
  "The callback URL parameters."
);
@@doc(IntegrationAccounts.listKeyVaultKeys::parameters.body,
  "The key vault parameters."
);
@@doc(IntegrationAccounts.logTrackingEvents::parameters.body,
  "The callback URL parameters."
);
@@doc(IntegrationAccounts.regenerateAccessKey::parameters.body,
  "The access key type."
);
