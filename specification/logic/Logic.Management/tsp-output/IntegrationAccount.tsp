import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Logic;
@doc("The integration account.")
model IntegrationAccount is TrackedResource<IntegrationAccountProperties> {
  @doc("The integration account name.")
  @path
  @key("integrationAccountName")
  @segment("integrationAccounts")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface IntegrationAccounts {
  @doc("Gets an integration account.")
  get is ArmResourceRead<IntegrationAccount>;
  @doc("Creates or updates an integration account.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<IntegrationAccount>;
  @doc("Updates an integration account.")
  update is ArmResourcePatchSync<
    IntegrationAccount,
    IntegrationAccountProperties
  >;
  @doc("Deletes an integration account.")
  delete is ArmResourceDeleteSync<IntegrationAccount>;
  @doc("Gets a list of integration accounts by resource group.")
  listByResourceGroup is ArmResourceListByParent<
    IntegrationAccount,
    {
      ...BaseParameters<IntegrationAccount>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;
    }
  >;
  @doc("Gets a list of integration accounts by subscription.")
  listBySubscription is ArmListBySubscription<IntegrationAccount>;
  @doc("Gets the integration account callback URL.")
  listCallbackUrl is ArmResourceActionSync<
    IntegrationAccount,
    GetCallbackUrlParameters,
    CallbackUrl
  >;
  @doc("Gets the integration account's Key Vault keys.")
  listKeyVaultKeys is ArmResourceActionSync<
    IntegrationAccount,
    ListKeyVaultKeysDefinition,
    KeyVaultKeyCollection
  >;
  @doc("Logs the integration account's tracking events.")
  logTrackingEvents is ArmResourceActionSync<
    IntegrationAccount,
    TrackingEventsDefinition,
    {}
  >;
  @doc("Regenerates the integration account access key.")
  regenerateAccessKey is ArmResourceActionSync<
    IntegrationAccount,
    RegenerateActionParameter,
    IntegrationAccount
  >;
}
