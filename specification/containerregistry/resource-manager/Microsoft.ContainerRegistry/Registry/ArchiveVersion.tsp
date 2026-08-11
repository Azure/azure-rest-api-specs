import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./ArchiveVersion.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ContainerRegistry;

// we must have this legacy operations right now because there is a virtual resource `Package` between `Achieve` and `Registry`
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ArchiveVersionOperationOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ResourceInstanceParameters<Registry>,

        /**
         * The package type.
         */
        @path
        @segment("packages")
        @minLength(3)
        @maxLength(50)
        @pattern("^[a-zA-Z]*$")
        @doc("The package type.")
        packageType: string,

        /**
         * The name of the archive resource.
         */
        @path
        @segment("archives")
        @pattern("^[a-zA-Z0-9-]*$")
        @minLength(5)
        @maxLength(200)
        @doc("The name of the archive resource.")
        archiveName: string,
      },
      {
        /**
         * The name of the archive version resource.
         */
        @path
        @segment("versions")
        @pattern("^[a-zA-Z0-9-]*$")
        @minLength(5)
        @maxLength(200)
        @doc("The name of the archive version resource.")
        archiveVersionName: string,
      }
    > {}

/**
 * An object that represents an export pipeline for a container registry.
 */
@added(Versions.vLatestPreview)
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

@added(Versions.vLatestPreview)
@armResourceOperations
interface ArchiveVersions {
  /**
   * Gets the properties of the archive version.
   */
  get is ArchiveVersionOperationOps.Read<ArchiveVersion>;

  /**
   * Creates a archive version for a container registry with the specified parameters.
   */
  create is ArchiveVersionOperationOps.CreateOrUpdateAsync<
    ArchiveVersion,
    Request = void
  >;

  /**
   * Deletes a archive version from a container registry.
   */
  delete is ArchiveVersionOperationOps.DeleteWithoutOkAsync<ArchiveVersion>;

  /**
   * Lists all archive versions for the specified container registry, repository type and archive name.
   */
  list is ArchiveVersionOperationOps.List<
    ArchiveVersion,
    Response = ArmResponse<ArchiveVersionListResult>
  >;
}

@@maxLength(ArchiveVersion.name, 200);
@@minLength(ArchiveVersion.name, 5);
@@doc(ArchiveVersion.name, "The name of the archive version resource.");
@@doc(ArchiveVersion.properties, "The properties of the archive.");
