import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("PushAgentV2Account properties")
model PushAgentV2AccountResourceProperties {
  @doc("Geneva environment. Test or Prod. Default is Prod.")
  environment?: string;

  @doc("PAv2 Resource Provider name.")
  resourceProvider: string;

  @doc("PAv2 location. It's the same as the CIS region name.")
  location: string;

  @doc("Storage Account to onboard.")
  storageAccount: string;

  @doc("The type of the account where the storage account secret is stored. It can be dSMS, KeyVault, or Gsm.")
  accountType: string;

  @doc("The endpoint suffix of the Storage Account")
  endpointSuffix?: string;

  @doc("Absolute URL to the secret where storage account SAS token is stored. The secret path of storage account key.")
  secretPath: string;

  @doc("Usage reporting queue name.")
  usageReportingQueue: string;

  @doc("Usage reporting table name.")
  usageReportingTable: string;

  @doc("Error Reporting Queue name.")
  errorReportingQueue: string;

  @doc("Error Reporting Table name.")
  errorReportingTable: string;

  @doc("The ARM location of the Storage Account. ARM location is different from PAv2/CIS location, e.g. eastus VS. useast.")
  armLocation: string;

  @doc("Tenant ID of the Subscription.")
  tenantId: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: PushAgentV2AccountProvisioningState;
}

@doc("PushAgentV2Account Resource")
model PushAgentV2AccountResource
  is ProxyResource<PushAgentV2AccountResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("pushAgentV2Accounts") // Start with lower case. Should be plural
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface PushAgentV2Account {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PushAgentV2AccountResource>;
  listBySubscription is ArmListBySubscription<PushAgentV2AccountResource>;
  listByResourceGroup is ArmResourceListByParent<PushAgentV2AccountResource>;
  get is ArmResourceRead<PushAgentV2AccountResource>;
}
