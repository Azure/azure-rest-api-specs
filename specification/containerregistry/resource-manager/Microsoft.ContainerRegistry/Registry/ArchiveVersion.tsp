import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Archive.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
/**
 * An object that represents an export pipeline for a container registry.
 */
@parentResource(Archive)
model ArchiveVersion
  is Azure.ResourceManager.ProxyResource<ArchiveVersionProperties> {
  ...ResourceNameParameter<
    Resource = ArchiveVersion,
    KeyName = "archiveVersionName",
    SegmentName = "versions",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface ArchiveVersions {
  /**
   * Gets the properties of the archive version.
   */
  get is ArmResourceRead<ArchiveVersion>;

  /**
   * Creates a archive for a container registry with the specified parameters.
   */
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    ArchiveVersion,
    Request = void
  >;

  /**
   * Deletes a archive version from a container registry.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ArchiveVersion>;

  /**
   * Lists all archive versions for the specified container registry, repository type and archive name.
   */
  @list
  list is ArmResourceListByParent<
    ArchiveVersion,
    Response = ArmResponse<ArchiveVersionListResult>
  >;
}

@@maxLength(ArchiveVersion.name, 200);
@@minLength(ArchiveVersion.name, 5);
@@doc(ArchiveVersion.name, "The name of the archive version resource.");
@@doc(ArchiveVersion.properties, "The properties of the archive.");
