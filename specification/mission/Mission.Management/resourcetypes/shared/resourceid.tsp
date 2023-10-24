import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

scalar VirtualEnclaveResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.Mission/virtualEnclaves",
    }
  ]>;

scalar NsgResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.Network/networkSecurityGroups",
    }
  ]>;

scalar CommunityResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.Mission/communities",
    }
  ]>;

scalar KeyVaultResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults",
    }
  ]>;

scalar LogAnalyticsResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces",
    }
  ]>;

scalar StorageAccountResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts",
    }
  ]>;

scalar EndpointResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.Mission/virtualEnclaves/endpoints",
    }
  ]>;

scalar EnclaveConnectionSourceResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.Mission/virtualEnclaves",
    },
    {
      type: "Microsoft.Mission/communities/transitHubs",
    }
  ]>;

scalar DestinationEndpointResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.Mission/virtualEnclaves/enclaveEndpoints",
    },
    {
      type: "Microsoft.Mission/communities/communityEndpoints",
    }
  ]>;

scalar TransitHubResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.Mission/communities/transitHubs",
    }
  ]>;

scalar IPGroupResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.Network/IpGroups",
    }
  ]>;
