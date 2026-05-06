import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * A ImportSite
 */
model ImportSite
  is Azure.ResourceManager.TrackedResource<ImportSiteProperties> {
  ...ResourceNameParameter<
    Resource = ImportSite,
    KeyName = "siteName",
    SegmentName = "importSites"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ImportSites {
  /**
   * Get a ImportSite
   */
  @tag("ImportSitesController")
  get is ArmResourceRead<ImportSite>;

  /**
   * Create a ImportSite
   */
  @tag("ImportSitesController")
  create is ArmResourceCreateOrReplaceSync<ImportSite>;

  /**
   * Update a ImportSite
   */
  @tag("ImportSitesController")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<ImportSite, PatchModel = ImportSiteUpdate>;

  /**
   * Delete a ImportSite
   */
  @tag("ImportSitesController")
  delete is ArmResourceDeleteSync<ImportSite>;

  /**
   * Get all import sites.
   */
  @tag("ImportSitesController")
  listByResourceGroup is ArmResourceListByParent<ImportSite>;

  /**
   * List ImportSite resources by subscription ID
   */
  @tag("ImportSitesController")
  listBySubscription is ArmListBySubscription<ImportSite>;

  /**
   * Deletes the imported machines for site.
   */
  @tag("ImportSitesController")
  deleteImportedMachines is ArmResourceActionSync<
    ImportSite,
    unknown,
    ArmResponse<SasUriResponse>
  >;

  /**
   * Method to export  a site.
   */
  @tag("ImportSitesController")
  exportUri is ArmResourceActionSync<
    ImportSite,
    SasUriResponse,
    ArmResponse<SasUriResponse>
  >;

  /**
   * Method to import a site.
   */
  @tag("ImportSitesController")
  importUri is ArmResourceActionSync<
    ImportSite,
    SasUriResponse,
    ArmResponse<SasUriResponse>
  >;
}

@@doc(ImportSite.name, "Site name");
@@doc(ImportSite.properties,
  "The resource-specific properties for this resource."
);
