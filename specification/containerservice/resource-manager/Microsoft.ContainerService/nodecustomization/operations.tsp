import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./helpers.tsp";

using Azure.ResourceManager;

namespace Microsoft.ContainerService;

@armResourceOperations
interface NodeCustomizations {
  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  @doc("Deprecated: Get a node customization at the latest version. Use Prepared Image Specification APIs instead.")
  get is ArmResourceRead<NodeCustomization>;
  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  @doc("Deprecated: Create or update a node customization resource. This will create a new version. Use Prepared Image Specification APIs instead.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    NodeCustomization,
    Azure.ResourceManager.Foundations.BaseParameters<NodeCustomization> &
      IfMatchParameters<NodeCustomization> &
      IfNoneMatchParameters<NodeCustomization>
  >;

  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  @doc("Deprecated: Update a node customization. Use Prepared Image Specification APIs instead.")
  update is ArmCustomPatchAsync<
    NodeCustomization,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      NodeCustomization,
      NodeCustomizationProperties
    >,
    Azure.ResourceManager.Foundations.BaseParameters<NodeCustomization> &
      IfMatchParameters<NodeCustomization>
  >;

  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  @doc("Deprecated: Delete a node customization. This operation will be blocked if the resource is in use. Use Prepared Image Specification APIs instead.")
  delete is ArmResourceDeleteWithoutOkAsync<
    NodeCustomization,
    Azure.ResourceManager.Foundations.BaseParameters<NodeCustomization> &
      IfMatchParameters<NodeCustomization>
  >;

  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  @doc("Deprecated: Delete a node customization version. This operation will be blocked if the node customization version is in use. Use Prepared Image Specification APIs instead.")
  deleteVersion is ArmResourceDeleteWithoutOkAsync<
    NodeCustomizationVersion,
    Azure.ResourceManager.Foundations.BaseParameters<NodeCustomizationVersion> &
      IfMatchParameters<NodeCustomizationVersion>
  >;

  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  @doc("Deprecated: List the node customizations in a resource group at the latest version. Use Prepared Image Specification APIs instead.")
  listByResourceGroup is ArmResourceListByParent<NodeCustomization>;

  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  @doc("Deprecated: List the node customizations in a subscription at the latest version. Use Prepared Image Specification APIs instead.")
  listBySubscription is ArmListBySubscription<NodeCustomization>;

  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  @doc("Deprecated: Get a node customization at a particular version. Use Prepared Image Specification APIs instead.")
  getVersion is ArmResourceRead<NodeCustomizationVersion>;

  #deprecated "Node Customization APIs are deprecated. Use Prepared Image Specification APIs instead."
  @doc("Deprecated: List all versions of a node customization. Use Prepared Image Specification APIs instead.")
  listVersions is ArmResourceListByParent<NodeCustomizationVersion>;
}
