import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./helpers.tsp";

using Azure.ResourceManager;

namespace Microsoft.ContainerService;

@armResourceOperations
interface NodeCustomizations {
  get is ArmResourceRead<NodeCustomization>;
  create is ArmResourceCreateOrUpdateAsync<
    NodeCustomization,
    Azure.ResourceManager.Foundations.BaseParameters<NodeCustomization> &
      IfMatchParameters<NodeCustomization> &
      IfNoneMatchParameters<NodeCustomization>
  >;
  updateAsync is ArmCustomPatchAsync<
    NodeCustomization,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      NodeCustomization,
      NodeCustomizationProperties
    >,
    Azure.ResourceManager.Foundations.BaseParameters<NodeCustomization> &
      IfMatchParameters<NodeCustomization>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    NodeCustomization,
    Azure.ResourceManager.Foundations.BaseParameters<NodeCustomization> &
      IfMatchParameters<NodeCustomization>
  >;
  listByResourceGroup is ArmResourceListByParent<NodeCustomization>;
  listBySubscription is ArmListBySubscription<NodeCustomization>;
  getVersion is ArmResourceRead<NodeCustomizationVersion>;
  listVersions is ArmResourceListByParent<NodeCustomizationVersion>;
}
