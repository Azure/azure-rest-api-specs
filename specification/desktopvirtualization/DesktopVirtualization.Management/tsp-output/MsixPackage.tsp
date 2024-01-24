import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HostPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
/**
 * Schema for MSIX Package properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(HostPool)
@Azure.ResourceManager.Private.armResourceInternal(MsixPackageProperties)
@includeInapplicableMetadataInPayload(false)
model MsixPackage extends ProxyResourceBase {
  /**
   * The version specific package full name of the MSIX package within specified hostpool
   */
  @maxLength(100)
  @minLength(3)
  @path
  @key("msixPackageFullName")
  @segment("msixPackages")
  name: string;

  /**
   * Detailed properties for MSIX Package
   */
  @extension("x-ms-client-flatten", true)
  properties: MsixPackageProperties;
}

@armResourceOperations
interface MsixPackages {
  /**
   * Get a msixpackage.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MSIXPackages_Get")
  get is ArmResourceRead<MsixPackage>;

  /**
   * Create or update a MSIX package.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MSIXPackages_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MsixPackage>;

  /**
   * Update an  MSIX Package.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("MSIXPackages_Update")
  update is ArmCustomPatchSync<MsixPackage, MsixPackagePatch>;

  /**
   * Remove an MSIX Package.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MSIXPackages_Delete")
  delete is ArmResourceDeleteSync<MsixPackage>;

  /**
   * List MSIX packages in hostpool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MSIXPackages_List")
  list is ArmResourceListByParent<
    MsixPackage,
    {
      ...BaseParameters<MsixPackage>;

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
    }
  >;
}

@@projectedName(MsixPackages.createOrUpdate::parameters.resource,
  "json",
  "msixPackage"
);
@@extension(MsixPackages.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "msixPackage"
);
@@doc(MsixPackages.createOrUpdate::parameters.resource,
  "Object containing  MSIX Package definitions."
);
@@projectedName(MsixPackages.update::parameters.properties,
  "json",
  "msixPackage"
);
@@extension(MsixPackages.update::parameters.properties,
  "x-ms-client-name",
  "msixPackage"
);
@@doc(MsixPackages.update::parameters.properties,
  "Object containing MSIX Package definitions."
);
