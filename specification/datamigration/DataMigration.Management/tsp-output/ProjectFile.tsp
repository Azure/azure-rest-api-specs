import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataMigration;
/**
 * A file resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Project)
@Azure.ResourceManager.Private.armResourceInternal(ProjectFileProperties)
@includeInapplicableMetadataInPayload(false)
model ProjectFile extends Resource {
  /**
   * Name of the File
   */
  @path
  @key("fileName")
  @segment("files")
  name: string;

  /**
   * HTTP strong entity tag value. This is ignored if submitted.
   */
  etag?: string;

  /**
   * Custom file properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ProjectFileProperties;
}

@armResourceOperations
interface ProjectFiles {
  /**
   * The files resource is a nested, proxy-only resource representing a file stored under the project resource. This method retrieves information about a file.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Files_Get")
  get is ArmResourceRead<ProjectFile>;

  /**
   * The PUT method creates a new file or updates an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Files_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ProjectFile>;

  /**
   * This method updates an existing file.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Files_Update")
  update is ArmCustomPatchSync<ProjectFile, ProjectFile>;

  /**
   * This method deletes a file.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Files_Delete")
  delete is ArmResourceDeleteSync<ProjectFile>;

  /**
   * The project resource is a nested resource representing a stored migration project. This method returns a list of files owned by a project resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Files_List")
  list is ArmResourceListByParent<ProjectFile>;

  /**
   * This method is used for requesting storage information using which contents of the file can be downloaded.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Files_Read")
  read is ArmResourceActionSync<ProjectFile, void, FileStorageInfo>;

  /**
   * This method is used for requesting information for reading and writing the file content.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Files_ReadWrite")
  readWrite is ArmResourceActionSync<ProjectFile, void, FileStorageInfo>;
}

@@projectedName(ProjectFiles.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ProjectFiles.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ProjectFiles.createOrUpdate::parameters.resource,
  "Information about the file"
);
@@projectedName(ProjectFiles.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ProjectFiles.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ProjectFiles.update::parameters.properties, "Information about the file");
