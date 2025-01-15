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
model AppAttachPackageModel
  is Azure.ResourceManager.TrackedResource<AppAttachPackageProperties, false> {
  ...ResourceNameParameter<
    Resource = AppAttachPackageModel,
    KeyName = "appAttachPackageName",
    SegmentName = "appAttachPackages",
    NamePattern = "^[a-z0-9]([a-z0-9]|(-(?!-))){1,61}[a-z0-9]$"
  >;
}

@armResourceOperations
interface AppAttachPackage {
  /**
   * Get an app attach package.
   */
  get is ArmResourceRead<AppAttachPackageModel>;

  /**
   * Create or update an App Attach package.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<AppAttachPackageModel>;

  /**
   * Update an App Attach Package
   */
  @parameterVisibility
  update is ArmCustomPatchSync<AppAttachPackageModel, AppAttachPackagePatch>;

  /**
   * Remove an App Attach Package.
   */
  delete is ArmResourceDeleteSync<AppAttachPackageModel>;

  /**
   * List App Attach packages in resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    AppAttachPackageModel,
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
    AppAttachPackageModel,
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

@@maxLength(AppAttachPackageModel.name, 100);
@@minLength(AppAttachPackageModel.name, 3);
@@doc(AppAttachPackageModel.name, "The name of the App Attach package");
@@doc(AppAttachPackageModel.properties,
  "Detailed properties for App Attach Package"
);
@@doc(AppAttachPackage.createOrUpdate::parameters.resource,
  "Object containing App Attach Package definitions."
);
@@doc(AppAttachPackage.update::parameters.properties,
  "Object containing App Attach Package definition."
);
