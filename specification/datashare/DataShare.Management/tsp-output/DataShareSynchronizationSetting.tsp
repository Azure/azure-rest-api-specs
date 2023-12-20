import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataShare.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataShare;
// FIXME: DataShareSynchronizationSetting has no properties property
@doc("A Synchronization Setting data transfer object.")
@parentResource(DataShare)
model DataShareSynchronizationSetting is ProxyResource<{}> {
  @doc("The name of the synchronizationSetting.")
  @path
  @key("synchronizationSettingName")
  @segment("synchronizationSettings")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataShareSynchronizationSettings {
  @doc("Get a synchronizationSetting in a share")
  get is ArmResourceRead<DataShareSynchronizationSetting>;
  @doc("Create a synchronizationSetting")
  create is ArmResourceCreateOrReplaceSync<DataShareSynchronizationSetting>;
  @doc("Delete a synchronizationSetting in a share")
  delete is ArmResourceDeleteAsync<DataShareSynchronizationSetting>;
  @doc("List synchronizationSettings in a share")
  listByShare is ArmResourceListByParent<
    DataShareSynchronizationSetting,
    {
      ...BaseParameters<DataShareSynchronizationSetting>;

      @doc("continuation token")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
