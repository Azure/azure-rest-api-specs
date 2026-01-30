import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RuntimeEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the Package type.
 */
@parentResource(RuntimeEnvironment)
model Package is Azure.ResourceManager.TrackedResource<PackageProperties> {
  ...ResourceNameParameter<
    Resource = Package,
    KeyName = "packageName",
    SegmentName = "packages",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Packages {
  /**
   * Retrieve the Package identified by Package name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/packageoperations")
  get is ArmResourceRead<Package>;

  /**
   * Create or update the package identified by package name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/packageoperations")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    Package,
    Request = PackageCreateOrUpdateParameters
  >;

  /**
   * Update the Package identified by Package name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/packageoperations")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Package, PatchModel = PackageUpdateParameters>;

  /**
   * Delete the package by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Package_Delete")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/packageoperations")
  delete is ArmResourceDeleteSync<Package>;

  /**
   * Retrieve the a list of Packages
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/packageoperations")
  listByRuntimeEnvironment is ArmResourceListByParent<Package>;
}

@@doc(Package.name, "The Package name.");
@@doc(Package.properties, "Gets or sets the Package properties.");
@@doc(Packages.createOrUpdate::parameters.resource,
  "The create or update parameters for Package."
);
@@doc(Packages.update::parameters.properties,
  "The update parameters for Package."
);
