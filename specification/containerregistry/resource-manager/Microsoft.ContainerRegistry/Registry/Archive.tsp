import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Registry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;

/**
 * Package type resource for organizing archives
 */
@parentResource(Registry)
model ArchivePackageType is Azure.ResourceManager.ProxyResource<{}> {
  @key("packageType")
  @path
  @minLength(3)
  @maxLength(50)
  @pattern("^[a-zA-Z]*$")
  @segment("packages")
  @doc("The package type.")
  name: string;
}

/**
 * An object that represents a archive for a container registry.
 */
@parentResource(ArchivePackageType)
model Archive is Azure.ResourceManager.ProxyResource<ArchiveProperties> {
  ...ResourceNameParameter<
    Resource = Archive,
    KeyName = "archiveName",
    SegmentName = "archives",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface Archives {
  /**
   * Gets the properties of the archive.
   */
  get is ArmResourceRead<Archive>;

  /**
   * Creates a archive for a container registry with the specified parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<Archive>;

  /**
   * Updates a archive for a container registry with the specified parameters.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Archive, PatchModel = ArchiveUpdateParameters>;

  /**
   * Deletes a archive from a container registry.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Archive>;

  /**
   * Lists all archives for the specified container registry and package type.
   */
  @list
  list is ArmResourceListByParent<
    Archive,
    Response = ArmResponse<ArchiveListResult>
  >;
}

@@maxLength(Archive.name, 200);
@@minLength(Archive.name, 5);
@@doc(Archive.name, "The name of the archive resource.");
@@doc(Archive.properties, "The properties of the archive.");
@@doc(Archives.create::parameters.resource,
  "The parameters for creating a archive."
);
@@doc(Archives.update::parameters.properties,
  "The parameters for updating a archive."
);
