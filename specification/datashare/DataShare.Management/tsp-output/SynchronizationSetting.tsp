import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Share.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataShare;
// FIXME: SynchronizationSetting has no properties property
@doc("A Synchronization Setting data transfer object.")
@parentResource(Share)
model SynchronizationSetting is ProxyResource<{}> {
  @doc("The name of the synchronizationSetting.")
  @path
  @key("synchronizationSettingName")
  @segment("synchronizationSettings")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface SynchronizationSettings {
  @doc("Get a synchronizationSetting in a share")
  get is ArmResourceRead<SynchronizationSetting>;
  @doc("Create a synchronizationSetting")
  create is ArmResourceCreateOrReplaceSync<SynchronizationSetting>;
  @doc("Delete a synchronizationSetting in a share")
  delete is ArmResourceDeleteAsync<SynchronizationSetting>;
  @doc("List synchronizationSettings in a share")
  listByShare is ArmResourceListByParent<
    SynchronizationSetting,
    {
      ...BaseParameters<SynchronizationSetting>;

      @doc("continuation token")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
