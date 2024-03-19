import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PortalExtension.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.PortalServices;
/**
 * Extension Version
 */
@parentResource(PortalExtension)
model ExtensionVersion is TrackedResource<ExtensionVersionProperties> {
  /**
   * The name of the version
   */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-z][a-z0-9]*$")
  @path
  @key("versionName")
  @segment("versions")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface PortalExtensionVersions {
  /**
   * Gets the portal extension.
   */
  get is ArmResourceRead<ExtensionVersion>;

  /**
   * Creates an extension version
   */
  create is ArmResourceCreateOrReplaceAsync<ExtensionVersion>;

  /**
   * Updates an existing portal extension version.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<ExtensionVersion, PatchableExtensionVersion>;

  /**
   * Deletes the portal extension.
   */
  @OpenAPI.extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  delete is ArmResourceDeleteWithoutOkAsync<ExtensionVersion>;

  /**
   * Gets all the portal extension versions within a resource group.
   */
  listByExtensions is ArmResourceListByParent<ExtensionVersion>;
}

@@doc(PortalExtensionVersions.create::parameters.resource,
  "extension version definition."
);
@@doc(PortalExtensionVersions.update::parameters.properties,
  "The updatable fields of a portal extension version."
);
