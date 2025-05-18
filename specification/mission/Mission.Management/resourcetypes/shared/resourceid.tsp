import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

scalar VirtualEnclaveResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Mission/virtualEnclaves",
    }
  ]>;

scalar VirtualNetworkResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks",
    }
  ]>;

scalar SubnetResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets",
    }
  ]>;

scalar NsgResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Network/networkSecurityGroups",
    }
  ]>;

scalar CommunityResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Mission/communities",
    }
  ]>;

scalar KeyVaultResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults",
    }
  ]>;

scalar LogAnalyticsResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces",
    }
  ]>;

scalar StorageAccountResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts",
    }
  ]>;

scalar EndpointResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Mission/virtualEnclaves/endpoints",
    }
  ]>;

scalar EnclaveConnectionSourceResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Mission/virtualEnclaves",
    },
    {
      type: "Microsoft.Mission/communities/transitHubs",
    }
  ]>;

scalar DestinationEndpointResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Mission/virtualEnclaves/enclaveEndpoints",
    },
    {
      type: "Microsoft.Mission/communities/communityEndpoints",
    }
  ]>;

scalar TransitHubResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Mission/communities/transitHubs",
    }
  ]>;

scalar IPGroupResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Network/IpGroups",
    }
  ]>;
