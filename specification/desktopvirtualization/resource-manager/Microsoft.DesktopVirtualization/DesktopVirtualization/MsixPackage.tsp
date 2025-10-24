import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HostPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DesktopVirtualization;
/**
 * Schema for MSIX Package properties.
 */
// Manually switched@subscriptionResource
#suppress "@azure-tools/typespec-azure-core/casing-style" "Following old implementation"
@parentResource(HostPool)
model MSIXPackage
  is Azure.ResourceManager.ProxyResource<MSIXPackageProperties, false> {
  ...ResourceNameParameter<
    Resource = MSIXPackage,
    KeyName = "msixPackageFullName",
    SegmentName = "msixPackages",
    NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Following old implementation"
@armResourceOperations
interface MSIXPackages {
  /**
   * Get a msixpackage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "casing issue"
  @OpenAPI.operationId("MSIXPackages_Get")
  get is ArmResourceRead<
    MSIXPackage,
    Azure.ResourceManager.Foundations.ResourceGroupBaseParameters
  >;

  /**
   * Create or update a MSIX package.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "casing issue"
  @OpenAPI.operationId("MSIXPackages_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    MSIXPackage,
    Azure.ResourceManager.Foundations.ResourceGroupBaseParameters
  >;

  /**
   * Update an  MSIX Package.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "casing issue"
  @OpenAPI.operationId("MSIXPackages_Update")
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.ArmCustomPatchSync<
    MSIXPackage,
    MSIXPackagePatch,
    Azure.ResourceManager.Foundations.ResourceGroupBaseParameters
  >;

  /**
   * Remove an MSIX Package.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "casing issue"
  @OpenAPI.operationId("MSIXPackages_Delete")
  delete is ArmResourceDeleteSync<
    MSIXPackage,
    Azure.ResourceManager.Foundations.ResourceGroupBaseParameters
  >;

  /**
   * List MSIX packages in hostpool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "casing issue"
  @OpenAPI.operationId("MSIXPackages_List")
  list is ArmResourceListByParent<
    MSIXPackage,
    Azure.ResourceManager.Foundations.ResourceGroupBaseParameters,
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
    Response = MSIXPackageList
  >;
}

@@maxLength(MSIXPackage.name, 100);
@@minLength(MSIXPackage.name, 3);
@@doc(MSIXPackage.name,
  "The version specific package full name of the MSIX package within specified hostpool"
);
@@doc(MSIXPackage.properties, "Detailed properties for MSIX Package");
@@doc(MSIXPackages.createOrUpdate::parameters.resource,
  "Object containing  MSIX Package definitions."
);
