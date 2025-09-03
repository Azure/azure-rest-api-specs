import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;
/**
 * The StorageDatabase resource definition.
 */
@parentResource(StorageSite)
model FileShare
  is Azure.ResourceManager.ProxyResource<FileShareProperties, false> {
  ...ResourceNameParameter<
    Resource = FileShare,
    KeyName = "shareName",
    SegmentName = "FileShares",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface FileShares {
  /**
   * Gets the FileShares resource.
   */
  get is ArmResourceRead<FileShare>;

  /**
   * Puts the FileShares resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<FileShare>;

  /**
   * Patch the FileShares resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<FileShare, FileShareResourcePatchProperties>;
  // @parameterVisibility
  // update is ArmCustomPatchAsync<
  //   FileShare,
  //   PatchModel = FileShareResourcePatch
  // >;

  /**
   * Deletes the FileShares resource.
   */
  delete is ArmResourceDeleteSync<FileShare>;

  /**
   * Lists the FileShares resource in StorageSites.
   */
  listBySite is ArmResourceListByParent<
    FileShare,
    Response = ArmResponse<FileShareList>
  >;
}

@@maxLength(FileShare.name, 100);
@@minLength(FileShare.name, 3);
@@doc(FileShare.name, "The name of FileShare");
@@doc(FileShare.properties, "Resource properties.");
@@doc(FileShares.createOrUpdate::parameters.resource,
  "The machines to add to the assessment"
);
@@doc(FileShares.update::parameters.properties, "FileShare patch payload.");
