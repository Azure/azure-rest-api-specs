import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
/**
 * Schema for App Attach Package properties.
 */
model AppAttachPackage
  is Azure.ResourceManager.TrackedResource<AppAttachPackageProperties, false> {
  ...ResourceNameParameter<
    Resource = AppAttachPackage,
    KeyName = "appAttachPackageName",
    SegmentName = "appAttachPackages",
    NamePattern = "^[a-z0-9]([a-z0-9]|(-(?!-))){1,61}[a-z0-9]$"
  >;
}

@armResourceOperations
interface AppAttachPackages {
  /**
   * Get an app attach package.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppAttachPackage_Get")
  get is ArmResourceRead<AppAttachPackage>;

  /**
   * Create or update an App Attach package.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppAttachPackage_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AppAttachPackage>;

  /**
   * Update an App Attach Package
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("AppAttachPackage_Update")
  update is ArmCustomPatchSync<
    AppAttachPackage,
    PatchModel = AppAttachPackagePatch
  >;

  /**
   * Remove an App Attach Package.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppAttachPackage_Delete")
  delete is ArmResourceDeleteSync<
    AppAttachPackage,
    Parameters = {
      /**
       * Force flag to delete App Attach package.
       */
      @query("force")
      force?: boolean;
    }
  >;

  /**
   * List App Attach packages in resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppAttachPackage_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    AppAttachPackage,
    Parameters = {
      /**
       * OData filter expression. Valid properties for filtering are package name, host pool, package owner name, and custom data.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<AppAttachPackageList>
  >;

  /**
   * List App Attach packages in subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppAttachPackage_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    AppAttachPackage,
    Parameters = {
      /**
       * OData filter expression. Valid properties for filtering are package name, resource group, host pool, package owner name, and custom data.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<AppAttachPackageList>
  >;
}

@@maxLength(AppAttachPackage.name, 100);
@@minLength(AppAttachPackage.name, 3);
@@doc(AppAttachPackage.name, "The name of the App Attach package arm object");
@@doc(AppAttachPackage.properties,
  "Detailed properties for App Attach Package"
);
@@doc(AppAttachPackages.createOrUpdate::parameters.resource,
  "Object containing App Attach Package definitions."
);
@@doc(AppAttachPackages.update::parameters.properties,
  "Object containing App Attach Package definition."
);
