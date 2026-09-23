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
@@clientName(
  VirtualNetworkProperties,
  "PowerPlatformVirtualNetworkProperties",
  "csharp"
);
@@alternateType(
  EnterprisePolicyIdentity.systemAssignedIdentityPrincipalId,
  uuid,
  "csharp"
);
@@alternateType(EnterprisePolicyIdentity.tenantId, uuid, "csharp");
@@alternateType(PrivateEndpoint.id, armResourceIdentifier, "csharp");
@@alternateType(KeyVaultProperties.id, url, "csharp");
@@alternateType(VirtualNetworkProperties.id, armResourceIdentifier, "csharp");

@@override(
  Accounts.createOrUpdate,
  reorderParameters(
    Accounts.createOrUpdate,
    #[
      "accountName",
      "subscriptionId",
      "resourceGroupName",
      "apiVersion",
      "provider",
      "resource"
    ]
  )
);

@@clientName(Accounts.createOrUpdate::parameters.resource, "parameters");

@@override(
  Accounts.delete,
  reorderParameters(
    Accounts.delete,
    #[
      "accountName",
      "subscriptionId",
      "resourceGroupName",
      "apiVersion",
      "provider"
    ]
  )
);

@@override(
  Accounts.get,
  reorderParameters(
    Accounts.get,
    #[
      "accountName",
      "subscriptionId",
      "resourceGroupName",
      "apiVersion",
      "provider"
    ]
  )
);

@@override(
  Accounts.update,
  reorderParameters(
    Accounts.update,
    #[
      "accountName",
      "subscriptionId",
      "resourceGroupName",
      "apiVersion",
      "provider",
      "properties"
    ]
  )
);

@@clientName(Accounts.update::parameters.properties, "parameters");

@@override(
  EnterprisePolicies.createOrUpdate,
  reorderParameters(
    EnterprisePolicies.createOrUpdate,
    #[
      "enterprisePolicyName",
      "subscriptionId",
      "resourceGroupName",
      "apiVersion",
      "provider",
      "resource"
    ]
  )
);

@@clientName(
  EnterprisePolicies.createOrUpdate::parameters.resource,
  "parameters"
);

@@override(
  EnterprisePolicies.get,
  reorderParameters(
    EnterprisePolicies.get,
    #[
      "enterprisePolicyName",
      "subscriptionId",
      "resourceGroupName",
      "apiVersion",
      "provider"
    ]
  )
);

@@override(
  EnterprisePolicies.update,
  reorderParameters(
    EnterprisePolicies.update,
    #[
      "enterprisePolicyName",
      "subscriptionId",
      "resourceGroupName",
      "apiVersion",
      "provider",
      "properties"
    ]
  )
);

@@clientName(EnterprisePolicies.update::parameters.properties, "parameters");

@@clientName(Microsoft.PowerPlatform, "PowerPlatformMgmtClient", "python");
