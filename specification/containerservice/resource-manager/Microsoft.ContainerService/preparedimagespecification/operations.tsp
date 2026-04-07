import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./helpers.tsp";

using Azure.ResourceManager;

namespace Microsoft.ContainerService;

@armResourceOperations
interface PreparedImageSpecifications {
  @doc("Get a prepared image specification at the latest version.")
  get is ArmResourceRead<PreparedImageSpecification>;
  @doc("Create or update a prepared image specification resource. A new version is created only when the resource content changes.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    PreparedImageSpecification,
    Azure.ResourceManager.Foundations.BaseParameters<PreparedImageSpecification> &
      IfMatchParameters<PreparedImageSpecification> &
      IfNoneMatchParameters<PreparedImageSpecification>
  >;

  update is ArmCustomPatchSync<
    PreparedImageSpecification,
    PatchModel = PreparedImageSpecificationPatch,
    Parameters = IfMatchParameters<PreparedImageSpecification>
  >;

  @doc("Delete a prepared image specification. This operation will be blocked if the resource is in use.")
  delete is ArmResourceDeleteWithoutOkAsync<
    PreparedImageSpecification,
    Azure.ResourceManager.Foundations.BaseParameters<PreparedImageSpecification> &
      IfMatchParameters<PreparedImageSpecification>
  >;

  @doc("Delete a prepared image specification version. This operation will be blocked if the prepared image specification version is in use.")
  deleteVersion is ArmResourceDeleteWithoutOkAsync<
    PreparedImageSpecificationVersion,
    Azure.ResourceManager.Foundations.BaseParameters<PreparedImageSpecificationVersion> &
      IfMatchParameters<PreparedImageSpecificationVersion>
  >;

  @doc("List the prepared image specifications in a resource group at the latest version.")
  listByResourceGroup is ArmResourceListByParent<PreparedImageSpecification>;

  @doc("List the prepared image specifications in a subscription at the latest version.")
  listBySubscription is ArmListBySubscription<PreparedImageSpecification>;

  @doc("Get a prepared image specification at a particular version.")
  getVersion is ArmResourceRead<PreparedImageSpecificationVersion>;

  @doc("List all versions of a prepared image specification.")
  listVersions is ArmResourceListByParent<PreparedImageSpecificationVersion>;
}
