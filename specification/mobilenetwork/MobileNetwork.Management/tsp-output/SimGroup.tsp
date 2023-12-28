import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.MobileNetwork;
@doc("SIM group resource.")
model SimGroup is TrackedResource<SimGroupPropertiesFormat> {
  @doc("The name of the SIM Group.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @key("simGroupName")
  @segment("simGroups")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface SimGroups {
  @doc("Gets information about the specified SIM group.")
  get is ArmResourceRead<SimGroup>;
  @doc("Creates or updates a SIM group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SimGroup>;
  @doc("Patch SIM group resource.")
  updateTags is ArmCustomPatchSync<SimGroup, IdentityAndTagsObject>;
  @doc("Deletes the specified SIM group.")
  delete is ArmResourceDeleteAsync<SimGroup>;
  @doc("Gets all the SIM groups in a resource group.")
  listByResourceGroup is ArmResourceListByParent<SimGroup>;
  @doc("Gets all the SIM groups in a subscription.")
  listBySubscription is ArmListBySubscription<SimGroup>;
}

@armResourceOperations
interface Sims {
  @doc("Bulk upload SIMs to a SIM group.")
  bulkUpload is ArmResourceActionAsync<
    SimGroup,
    SimUploadList,
    AsyncOperationStatus
  >;
  @doc("Bulk delete SIMs from a SIM group.")
  bulkDelete is ArmResourceActionAsync<
    SimGroup,
    SimDeleteList,
    AsyncOperationStatus
  >;
  @doc("Bulk upload SIMs in encrypted form to a SIM group. The SIM credentials must be encrypted.")
  bulkUploadEncrypted is ArmResourceActionAsync<
    SimGroup,
    EncryptedSimUploadList,
    AsyncOperationStatus
  >;
}
