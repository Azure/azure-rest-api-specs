import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./helpers.tsp";

using Azure.ResourceManager;

namespace Microsoft.ContainerService;

@armResourceOperations
interface NodeCustomizations {
  @doc("Get a node customization at the latest version.")
  get is ArmResourceRead<NodeCustomization>;
  @doc("Create or update a node customization resource. This will create a new version.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    NodeCustomization,
    Azure.ResourceManager.Foundations.BaseParameters<NodeCustomization> &
      IfMatchParameters<NodeCustomization> &
      IfNoneMatchParameters<NodeCustomization>
  >;

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
  delete is ArmResourceDeleteWithoutOkAsync<
    NodeCustomization,
    Azure.ResourceManager.Foundations.BaseParameters<NodeCustomization> &
      IfMatchParameters<NodeCustomization>
  >;

  @doc("Delete a node customization version. This operation will be blocked if the node customization version is in use.")
  deleteVersion is ArmResourceDeleteWithoutOkAsync<
    NodeCustomizationVersion,
    Azure.ResourceManager.Foundations.BaseParameters<NodeCustomizationVersion> &
      IfMatchParameters<NodeCustomizationVersion>
  >;

  @doc("List the node customizations in a resource group at the latest version.")
  listByResourceGroup is ArmResourceListByParent<NodeCustomization>;

  @doc("List the node customizations in a subscription at the latest version.")
  listBySubscription is ArmListBySubscription<NodeCustomization>;

  @doc("Get a node customization at a particular version.")
  getVersion is ArmResourceRead<NodeCustomizationVersion>;

  @doc("List all versions of a node customization.")
  listVersions is ArmResourceListByParent<NodeCustomizationVersion>;
}
