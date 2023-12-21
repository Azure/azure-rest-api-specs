import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Maps;
@doc("An Azure resource which represents access to a suite of Maps REST APIs.")
model MapsAccount is TrackedResource<MapsAccountProperties> {
  @doc("The name of the Maps Account.")
  @path
  @key("accountName")
  @segment("accounts")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Accounts {
  @doc("Get a Maps Account.")
  get is ArmResourceRead<MapsAccount>;
  @doc("Create or update a Maps Account. A Maps Account holds the keys which allow access to the Maps REST APIs.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MapsAccount>;
  @doc("Updates a Maps Account. Only a subset of the parameters may be updated after creation, such as Sku, Tags, Properties.")
  update is ArmResourcePatchSync<MapsAccount, MapsAccountProperties>;
  @doc("Delete a Maps Account.")
  delete is ArmResourceDeleteSync<MapsAccount>;
  @doc("Get all Maps Accounts in a Resource Group")
  listByResourceGroup is ArmResourceListByParent<MapsAccount>;
  @doc("Get all Maps Accounts in a Subscription")
  listBySubscription is ArmListBySubscription<MapsAccount>;
  @doc("""
Create and list an account shared access signature token. Use this SAS token for authentication to Azure Maps REST APIs through various Azure Maps SDKs. As prerequisite to create a SAS Token. 

Prerequisites:
1. Create or have an existing User Assigned Managed Identity in the same Azure region as the account. 
2. Create or update an Azure Map account with the same Azure region as the User Assigned Managed Identity is placed.
""")
  listSas is ArmResourceActionSync<
    MapsAccount,
    AccountSasParameters,
    MapsAccountSasToken
  >;
  @doc("Get the keys to use with the Maps APIs. A key is used to authenticate and authorize access to the Maps REST APIs. Only one key is needed at a time; two are given to provide seamless key regeneration.")
  listKeys is ArmResourceActionSync<MapsAccount, void, MapsAccountKeys>;
  @doc("Regenerate either the primary or secondary key for use with the Maps APIs. The old key will stop working immediately.")
  regenerateKeys is ArmResourceActionSync<
    MapsAccount,
    MapsKeySpecification,
    MapsAccountKeys
  >;
}
