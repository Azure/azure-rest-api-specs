using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Workloads;
/**
 * Define the SAP Instance resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is a product."
@parentResource(SAPDiscoverySite)
model SAPInstance is TrackedResource<SAPInstanceProperties> {
  /**
   * The name of SAP Instance resource for SAP Migration.
   */
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{0,78}[a-zA-Z0-9_]$")
  @path
  @key("sapInstanceName")
  @segment("sapInstances")
  @visibility(Lifecycle.Read)
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is a product."
@armResourceOperations
interface SAPInstances {
  /**
   * Gets the SAP Instance resource.
   */
  get is ArmResourceRead<SAPInstance>;

  /**
   * Creates the SAP Instance resource. This will be used by service only. PUT operation on this resource by end user will return a Bad Request error.
   */
  create is ArmResourceCreateOrReplaceAsync<SAPInstance>;

  /**
   * Updates the SAP Instance resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmTagsPatchSync<SAPInstance>;

  /**
   * Deletes the SAP Instance resource. This will be used by service only. Delete operation on this resource by end user will return a Bad Request error. You can delete the parent resource, which is the SAP Migration discovery site resource, using the delete operation on it.
   */
  #suppress "deprecated" ""
  @removed(Versions.v2024_06_01_preview)
  @sharedRoute
  @renamedFrom(Versions.v2024_06_01_preview, "delete")
  deleteOld is ArmResourceDeleteAsync<SAPInstance>;

  /**
   * Deletes the SAP Instance resource. This will be used by service only. Delete operation on this resource by end user will return a Bad Request error. You can delete the parent resource, which is the SAP Migration discovery site resource, using the delete operation on it.
   */
  @added(Versions.v2024_06_01_preview)
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<SAPInstance>;

  /**
   * Lists the SAP Instance resources for the given SAP Migration discovery site resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is a product."
  @list
  ListBySapDiscoverySite is ArmResourceListByParent<SAPInstance>;
}
