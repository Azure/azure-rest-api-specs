import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PortalExtension.tsp";

using Azure.Core;
using Azure.ClientGenerator.Core;
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
model ExtensionVersion
  is Azure.ResourceManager.TrackedResource<ExtensionVersionProperties> {
  /**
   * The name of the version
   */
  @maxLength(64)
  @minLength(3)
  @pattern("^([A-Za-z0-9-]+(.){0,1})+$")
  @path
  @key("versionName")
  @segment("versions")
  @visibility(Lifecycle.Read)
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
  update is ArmCustomPatchSync<ExtensionVersion, PatchableExtensionVersion>;

  /**
   * Deletes the portal extension.
   */
  @useFinalStateVia("azure-async-operation")
  delete is ArmResourceDeleteWithoutOkAsync<
    ExtensionVersion,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmAsyncOperationHeader &
      ArmLroLocationHeader
  >;

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

@@clientName(PortalExtensionVersions.update::parameters.properties,
  "parameters"
);
