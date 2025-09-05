import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

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
  get is ArmResourceRead<AppAttachPackage>;

  /**
   * Create or update an App Attach package.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<AppAttachPackage>;

  /**
   * Update an App Attach Package
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AppAttachPackage,
    AppAttachPackagePatch,
    Request = {
      /**
       * The resource properties to be updated
       */
      @bodyRoot appAttachPackagePatch?: AppAttachPackagePatch;
    }
  >;

  /**
   * Remove an App Attach Package.
   */
  delete is ArmResourceDeleteSync<
    AppAttachPackage,
    Parameters = {
      /**
       * Allows force delete
       */
      @query("force")
      force?: boolean;
    }
  >;

  /**
   * List App Attach packages in resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    AppAttachPackage,
    Parameters = {
      /**
       * OData filter expression. Valid properties for filtering are package name and host pool.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = AppAttachPackageList
  >;

  /**
   * List App Attach packages in subscription.
   */
  listBySubscription is ArmListBySubscription<
    AppAttachPackage,
    Parameters = {
      /**
       * OData filter expression. Valid properties for filtering are package name, host pool, and resource group.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = AppAttachPackageList
  >;
}

@@maxLength(AppAttachPackage.name, 100);
@@minLength(AppAttachPackage.name, 3);
@@doc(AppAttachPackage.name, "The name of the App Attach package");
@@doc(AppAttachPackage.properties,
  "Detailed properties for App Attach Package"
);
@@doc(AppAttachPackages.createOrUpdate::parameters.resource,
  "Object containing App Attach Package definitions."
);
