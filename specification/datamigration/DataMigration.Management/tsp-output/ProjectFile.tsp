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
@doc("A file resource")
@parentResource(Project)
model ProjectFile is ProxyResource<ProjectFileProperties> {
  @doc("Name of the File")
  @path
  @key("fileName")
  @segment("files")
  name: string;

  @doc("HTTP strong entity tag value. This is ignored if submitted.")
  etag?: string;
}

@armResourceOperations
interface ProjectFiles {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("The files resource is a nested, proxy-only resource representing a file stored under the project resource. This method retrieves information about a file.")
  @operationId("Files_Get")
  get is ArmResourceRead<ProjectFile>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("The PUT method creates a new file or updates an existing one.")
  @operationId("Files_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ProjectFile>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("This method updates an existing file.")
  @operationId("Files_Update")
  update is ArmCustomPatchSync<ProjectFile, ProjectFile>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("This method deletes a file.")
  @operationId("Files_Delete")
  delete is ArmResourceDeleteSync<ProjectFile>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("The project resource is a nested resource representing a stored migration project. This method returns a list of files owned by a project resource.")
  @operationId("Files_List")
  list is ArmResourceListByParent<ProjectFile>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("This method is used for requesting storage information using which contents of the file can be downloaded.")
  @operationId("Files_Read")
  read is ArmResourceActionSync<ProjectFile, void, FileStorageInfo>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("This method is used for requesting information for reading and writing the file content.")
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
