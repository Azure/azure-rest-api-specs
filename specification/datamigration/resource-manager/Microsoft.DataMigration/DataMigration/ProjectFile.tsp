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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

alias ProjectFileOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** Name of the resource group */
    @path
    @segment("resourceGroups")
    @key
    groupName: string;

    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the service */
    @path
    @segment("services")
    @key
    serviceName: string;

    /** Name of the project */
    @path
    @segment("projects")
    @key
    projectName: string;
  },
  {
    /** Name of the File */
    @path
    @segment("files")
    @key
    fileName: string;
  },
  ApiError
>;

@armResourceOperations(#{ omitTags: true })
interface ProjectFiles {
  /**
   * The files resource is a nested, proxy-only resource representing a file stored under the project resource. This method retrieves information about a file.
   */
  @summary("Get file information")
  @tag("File resource")
  @tag("Standard operation")
  @tag("GET")
  get is ProjectFileOps.Read<ProjectFile>;

  /**
   * The PUT method creates a new file or updates an existing one.
   */
  @summary("Create a file resource")
  @tag("Fie resource")
  @tag("Standard operation")
  @tag("PUT")
  createOrUpdate is ProjectFileOps.CreateOrUpdateSync<ProjectFile>;

  /**
   * This method updates an existing file.
   */
  @summary("Update a file")
  @tag("File resource")
  @tag("Standard operation")
  @tag("PATCH")
  @patch(#{ implicitOptionality: false })
  update is ProjectFileOps.CustomPatchSync<
    ProjectFile,
    PatchModel = ProjectFile
  >;

  /**
   * This method deletes a file.
   */
  @summary("Delete file")
  @tag("File resource")
  @tag("Standard operation")
  @tag("DELETE")
  delete is ProjectFileOps.DeleteSync<ProjectFile>;

  /**
   * The project resource is a nested resource representing a stored migration project. This method returns a list of files owned by a project resource.
   */
  @summary("Get files in a project")
  @tag("File resource")
  @tag("Standard operation")
  @tag("GET")
  list is ProjectFileOps.List<ProjectFile, Response = ArmResponse<FileList>>;

  /**
   * This method is used for requesting storage information using which contents of the file can be downloaded.
   */
  @summary("Request storage information for downloading the file content")
  @tag("File resource")
  @tag("Standard operation")
  @tag("POST")
  read is ProjectFileOps.ActionSync<
    ProjectFile,
    void,
    ArmResponse<FileStorageInfo>
  >;

  /**
   * This method is used for requesting information for reading and writing the file content.
   */
  @summary("Request information for reading and writing file content.")
  @tag("File resource")
  @tag("Standard operation")
  @tag("POST")
  @action("readwrite")
  readWrite is ProjectFileOps.ActionSync<
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
