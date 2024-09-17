import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.PortalServices;
/**
 * The portal extension resource definition.
 */
model PortalExtension
  is Azure.ResourceManager.TrackedResource<PortalExtensionProperties> {
  /**
   * The name of the portal extension.
   */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9]+$")
  @path
  @key("portalExtensionName")
  @segment("extensions")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface PortalExtensions {
  /**
   * Gets the portal extension.
   */
  get is ArmResourceRead<PortalExtension>;

  /**
   * Creates or updates a portal extension.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PortalExtension>;

  /**
   * Updates an existing portal extension.
   */
  update is ArmCustomPatchSync<PortalExtension, PatchablePortalExtension>;

  /**
   * Deletes the portal extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Azure specs should not be using decorator " $extension " from @typespec/openapi or @azure-tools/typespec-autorest. They will not apply to other emitter."
  @OpenAPI.extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  delete is ArmResourceDeleteWithoutOkAsync<PortalExtension>;

  /**
   * Gets all the portal extensions within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<PortalExtension>;

  /**
   * Gets all the portal extensions within a subscription.
   */
  listBySubscription is ArmListBySubscription<PortalExtension>;

  /**
   * Alters portal extension source files.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Azure specs should not be using decorator " $extension " from @typespec/openapi or @azure-tools/typespec-autorest. They will not apply to other emitter."
  @OpenAPI.extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  alter is ArmResourceActionAsync<PortalExtension, PortalExtensionAlter, never>;

  /**
   * compiles a file in the context of the extension.
   */
  compileFile is ArmResourceActionSync<
    PortalExtension,
    PortalExtensionCompileFile,
    PortalExtensionCompileFileResult
  >;

  /**
   * Exports the extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Azure specs should not be using decorator " $extension " from @typespec/openapi or @azure-tools/typespec-autorest. They will not apply to other emitter."
  @OpenAPI.extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  export is ArmResourceActionAsync<
    PortalExtension,
    PortalExtensionExport,
    PortalExtensionExportResult
  >;

  /**
   * Lists sources of the extension.
   */
  listSources is ArmResourceActionSync<
    PortalExtension,
    void,
    PortalExtensionListSourcesResult
  >;
}

@@doc(PortalExtensions.createOrUpdate::parameters.resource,
  "The parameters required to create or update a portal extension."
);
@@doc(PortalExtensions.update::parameters.properties,
  "The updatable fields of a portal extension."
);
@@doc(PortalExtensions.alter::parameters.body,
  "The parameters required to alter portal extension sources."
);
@@doc(PortalExtensions.compileFile::parameters.body,
  "The parameters required to compile a source file."
);
@@doc(PortalExtensions.export::parameters.body,
  "The parameters required to export the extension."
);

@@clientName(PortalExtensions.export::parameters.body, "portalExtensionExport");

@@clientName(PortalExtensions.compileFile::parameters.body,
  "portalExtensionCompileFile"
);

@@clientName(PortalExtensions.alter::parameters.body, "portalExtensionAlter");

@@clientName(PortalExtensions.createOrUpdate::parameters.resource,
  "portalExtension"
);

@@clientName(PortalExtensions.update::parameters.properties, "portalExtension");
