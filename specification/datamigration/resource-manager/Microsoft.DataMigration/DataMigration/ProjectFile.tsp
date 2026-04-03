import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataMigration;
/**
 * A file resource
 */
@parentResource(Project)
model ProjectFile
  is Azure.ResourceManager.ProxyResource<ProjectFileProperties> {
  ...ResourceNameParameter<
    Resource = ProjectFile,
    KeyName = "fileName",
    SegmentName = "files",
    NamePattern = ""
  >;

  /**
   * HTTP strong entity tag value. This is ignored if submitted.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations(#{ omitTags: true })
interface ProjectFiles {
  /**
   * The files resource is a nested, proxy-only resource representing a file stored under the project resource. This method retrieves information about a file.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Files_Get")
  @tag("File resource")
  @tag("Standard operation")
  @tag("GET")
  get is ArmResourceRead<ProjectFile>;

  /**
   * The PUT method creates a new file or updates an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Files_CreateOrUpdate")
  @tag("Fie resource")
  @tag("Standard operation")
  @tag("PUT")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ProjectFile>;

  /**
   * This method updates an existing file.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Files_Update")
  @tag("File resource")
  @tag("Standard operation")
  @tag("PATCH")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<ProjectFile, PatchModel = ProjectFile>;

  /**
   * This method deletes a file.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Files_Delete")
  @tag("File resource")
  @tag("Standard operation")
  @tag("DELETE")
  delete is ArmResourceDeleteSync<ProjectFile>;

  /**
   * The project resource is a nested resource representing a stored migration project. This method returns a list of files owned by a project resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Files_List")
  @tag("File resource")
  @tag("Standard operation")
  @tag("GET")
  list is ArmResourceListByParent<
    ProjectFile,
    Response = ArmResponse<FileList>
  >;

  /**
   * This method is used for requesting storage information using which contents of the file can be downloaded.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Files_Read")
  @tag("File resource")
  @tag("Standard operation")
  @tag("POST")
  read is ArmResourceActionSync<
    ProjectFile,
    void,
    ArmResponse<FileStorageInfo>
  >;

  /**
   * This method is used for requesting information for reading and writing the file content.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Files_ReadWrite")
  @tag("File resource")
  @tag("Standard operation")
  @tag("POST")
  @action("readwrite")
  readWrite is ArmResourceActionSync<
    ProjectFile,
    void,
    ArmResponse<FileStorageInfo>
  >;
}

@@doc(ProjectFile.name, "Name of the File");
@@doc(ProjectFile.properties, "Custom file properties");
@@doc(ProjectFiles.createOrUpdate::parameters.resource,
  "Information about the file"
);
@@doc(ProjectFiles.update::parameters.properties, "Information about the file");
