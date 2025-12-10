import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./Archive.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AchieveOperationOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * The name of the container registry.
         */
        @path
        @segment("registries")
        @pattern("^[a-zA-Z0-9]*$")
        @minLength(5)
        @maxLength(50)
        @doc("The name of the container registry.")
        registryName: string,

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
      },
      {
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
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AchieveOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * The name of the container registry.
         */
        @path
        @segment("registries")
        @pattern("^[a-zA-Z0-9]*$")
        @minLength(5)
        @maxLength(50)
        @doc("The name of the container registry.")
        registryName: string,

        /**
         * The package type.
         */
        @path
        @minLength(3)
        @maxLength(50)
        @pattern("^[a-zA-Z]*$")
        @segment("packages")
        @doc("The package type.")
        packageType: string,
      },
      {}
    > {}

/**
 * An object that represents a archive for a container registry.
 */
@added(Versions.vLatestPreview)
@parentResource(Registry)
model Archive is Azure.ResourceManager.ProxyResource<ArchiveProperties> {
  ...ResourceNameParameter<
    Resource = Archive,
    KeyName = "archiveName",
    SegmentName = "archives",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@added(Versions.vLatestPreview)
@armResourceOperations
interface Archives {
  /**
   * Gets the properties of the archive.
   */
  get is AchieveOperationOps.Read<Archive>;

  /**
   * Creates a archive for a container registry with the specified parameters.
   */
  create is AchieveOperationOps.CreateOrUpdateAsync<Archive>;

  /**
   * Updates a archive for a container registry with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is AchieveOperationOps.CustomPatchSync<
    Archive,
    PatchModel = ArchiveUpdateParameters
  >;

  /**
   * Deletes a archive from a container registry.
   */
  delete is AchieveOperationOps.DeleteWithoutOkAsync<Archive>;

  /**
   * Lists all archives for the specified container registry and package type.
   */
  @action("archives")
  @list
  list is AchieveOps.Read<Archive, Response = ArmResponse<ArchiveListResult>>;
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
