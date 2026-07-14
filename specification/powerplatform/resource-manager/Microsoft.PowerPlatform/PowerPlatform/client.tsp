import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.PowerPlatform;
using Azure.ResourceManager;
using TypeSpec.Http;

@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(PatchTrackedResource.location, azureLocation, "csharp");
@@clientName(Account, "PowerPlatformAccount", "csharp");
@@clientName(PatchAccount, "PowerPlatformAccountPatch", "csharp");
@@clientName(
  PatchTrackedResource,
  "PowerPlatformTrackedResourcePatch",
  "csharp"
);
@@clientName(
  Microsoft.PowerPlatform.PrivateEndpointConnection,
  "PowerPlatformPrivateEndpointConnection",
  "csharp"
);
@@clientName(
  Microsoft.PowerPlatform.PrivateLinkResource,
  "PowerPlatformPrivateLinkResource",
  "csharp"
);
@@clientName(State, "EnterprisePolicyOnboardingState", "csharp");
@@clientName(HealthStatus, "EnterprisePolicyHealthStatus", "csharp");
@@clientName(ResourceIdentityType, "EnterprisePolicyIdentityType", "csharp");
@@clientName(
  PropertiesEncryption,
  "EnterprisePolicyEncryptionProperties",
  "csharp"
);
@@clientName(KeyVaultProperties, "PowerPlatformKeyVaultProperties", "csharp");
@@clientName(KeyVaultProperties.id, "VaultUri", "csharp");
@@clientName(keyProperties, "PowerPlatformKeyProperties", "csharp");
@@alternateType(
  EnterprisePolicyIdentity.systemAssignedIdentityPrincipalId,
  uuid,
  "csharp"
);
@@alternateType(EnterprisePolicyIdentity.tenantId, uuid, "csharp");
@@alternateType(PrivateEndpoint.id, armResourceIdentifier, "csharp");
@@alternateType(KeyVaultProperties.id, url, "csharp");

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op accountsCreateOrUpdate(
  /**
   * Name of the account.
   */
  @path
  accountName: string,

  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...ApiVersionParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /**
   * Parameters supplied to create or update an account.
   */
  @body
  parameters: Account,
):
  | ArmResourceUpdatedResponse<Account>
  | ArmResourceCreatedSyncResponse<Account>;

@@override(Accounts.createOrUpdate, accountsCreateOrUpdate);

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op accountsDelete(
  /**
   * Name of the account.
   */
  @path
  accountName: string,

  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...ApiVersionParameter,
  ...Azure.ResourceManager.Legacy.Provider,
): ArmDeletedResponse | ArmDeletedNoContentResponse;

@@override(Accounts.delete, accountsDelete);

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op accountsGet(
  /**
   * Name of the account.
   */
  @path
  accountName: string,

  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...ApiVersionParameter,
  ...Azure.ResourceManager.Legacy.Provider,
): ArmResponse<Account>;

@@override(Accounts.get, accountsGet);

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op accountsUpdate(
  /**
   * Name of the account.
   */
  @path
  accountName: string,

  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...ApiVersionParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /**
   * Parameters supplied to update an account.
   */
  @body
  parameters: PatchAccount,
): ArmResponse<Account>;

@@override(Accounts.update, accountsUpdate);

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op enterpriseCreateOrUpdate(
  /**
   * Name of the EnterprisePolicy.
   */
  @path
  enterprisePolicyName: string,

  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...ApiVersionParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /**
   * Parameters supplied to create or update EnterprisePolicy.
   */
  @body
  parameters: EnterprisePolicy,
):
  | ArmResourceUpdatedResponse<EnterprisePolicy>
  | ArmResourceCreatedSyncResponse<EnterprisePolicy>;

@@override(EnterprisePolicies.createOrUpdate, enterpriseCreateOrUpdate);

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op enterpriseGet(
  /**
   * Name of the EnterprisePolicy.
   */
  @path
  enterprisePolicyName: string,

  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...ApiVersionParameter,
  ...Azure.ResourceManager.Legacy.Provider,
): ArmResponse<EnterprisePolicy>;

@@override(EnterprisePolicies.get, enterpriseGet);

#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op enterpriseUpdate(
  /**
   * Name of the EnterprisePolicy.
   */
  @path
  enterprisePolicyName: string,

  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...ApiVersionParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /**
   * Parameters supplied to update EnterprisePolicy.
   */
  @body
  parameters: PatchEnterprisePolicy,
): ArmResponse<EnterprisePolicy>;

@@override(EnterprisePolicies.update, enterpriseUpdate);

@@clientName(Microsoft.PowerPlatform, "PowerPlatformMgmtClient", "python");
