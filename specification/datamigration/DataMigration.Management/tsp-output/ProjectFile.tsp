import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataMigration;
@doc("A file resource")
@parentResource(Project)
model ProjectFile is ProxyResource<ProjectFileProperties> {
  @doc("Name of the File")
  @key("fileName")
  @segment("files")
  name: string;

  @doc("HTTP strong entity tag value. This is ignored if submitted.")
  etag?: string;
}

@armResourceOperations
interface Files {
  @doc("The files resource is a nested, proxy-only resource representing a file stored under the project resource. This method retrieves information about a file.")
  get is ArmResourceRead<ProjectFile>;
  @doc("The PUT method creates a new file or updates an existing one.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ProjectFile>;
  @doc("This method updates an existing file.")
  update is ArmCustomPatchSync<ProjectFile, ProjectFile>;
  @doc("This method deletes a file.")
  delete is ArmResourceDeleteSync<ProjectFile>;
  @doc("The project resource is a nested resource representing a stored migration project. This method returns a list of files owned by a project resource.")
  list is ArmResourceListByParent<ProjectFile>;
  @doc("This method is used for requesting storage information using which contents of the file can be downloaded.")
  read is ArmResourceActionSync<ProjectFile, void, FileStorageInfo>;
  @doc("This method is used for requesting information for reading and writing the file content.")
  readWrite is ArmResourceActionSync<ProjectFile, void, FileStorageInfo>;
}
