import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./helpers.tsp";

using Azure.ResourceManager;

namespace Microsoft.ContainerService;

@armResourceOperations
interface NodeCustomizations {
  @doc("Get a node customization at the latest version.")
  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  get is ArmResourceRead<NodeCustomization>;
  @doc("Create or update a node customization resource. This will create a new version.")
  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    NodeCustomization,
    Azure.ResourceManager.Foundations.BaseParameters<NodeCustomization> &
      IfMatchParameters<NodeCustomization> &
      IfNoneMatchParameters<NodeCustomization>
  >;

  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  update is ArmCustomPatchAsync<
    NodeCustomization,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      NodeCustomization,
      NodeCustomizationProperties
    >,
    Azure.ResourceManager.Foundations.BaseParameters<NodeCustomization> &
      IfMatchParameters<NodeCustomization>
  >;

  @doc("Delete a node customization. This operation will be blocked if the resource is in use.")
  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  delete is ArmResourceDeleteWithoutOkAsync<
    NodeCustomization,
    Azure.ResourceManager.Foundations.BaseParameters<NodeCustomization> &
      IfMatchParameters<NodeCustomization>
  >;

  @doc("Delete a node customization version. This operation will be blocked if the node customization version is in use.")
  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  deleteVersion is ArmResourceDeleteWithoutOkAsync<
    NodeCustomizationVersion,
    Azure.ResourceManager.Foundations.BaseParameters<NodeCustomizationVersion> &
      IfMatchParameters<NodeCustomizationVersion>
  >;

  @doc("List the node customizations in a resource group at the latest version.")
  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  listByResourceGroup is ArmResourceListByParent<NodeCustomization>;

  @doc("List the node customizations in a subscription at the latest version.")
  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  listBySubscription is ArmListBySubscription<NodeCustomization>;

  @doc("Get a node customization at a particular version.")
  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  getVersion is ArmResourceRead<NodeCustomizationVersion>;

  @doc("List all versions of a node customization.")
  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  listVersions is ArmResourceListByParent<NodeCustomizationVersion>;
}
