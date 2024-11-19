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
 * Schema for MSIX Package properties.
 */
@subscriptionResource
model MsixPackage
  is Azure.ResourceManager.ProxyResource<MsixPackageProperties, false> {
  ...ResourceNameParameter<
    Resource = MsixPackage,
    KeyName = "msixPackageFullName",
    SegmentName = "msixPackages",
    NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
  >;
}

@armResourceOperations
interface MsixPackages {
  /**
   * Get a msixpackage.
   */
  get is ArmResourceRead<
    MsixPackage,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Create or update a MSIX package.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    MsixPackage,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Update an  MSIX Package.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<
    MsixPackage,
    MsixPackagePatch,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Remove an MSIX Package.
   */
  delete is ArmResourceDeleteSync<
    MsixPackage,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * List MSIX packages in hostpool.
   */
  list is ArmResourceListByParent<
    MsixPackage,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    },
    Response = MsixPackageList
  >;
}

@@maxLength(MsixPackage.name, 100);
@@minLength(MsixPackage.name, 3);
@@doc(MsixPackage.name,
  "The version specific package full name of the MSIX package within specified hostpool"
);
@@doc(MsixPackage.properties, "Detailed properties for MSIX Package");
@@doc(MsixPackages.createOrUpdate::parameters.resource,
  "Object containing  MSIX Package definitions."
);
@@doc(MsixPackages.update::parameters.properties,
  "Object containing MSIX Package definitions."
);
