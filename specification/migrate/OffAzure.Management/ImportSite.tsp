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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ImportSitesController")
  @operationId("ImportSitesController_Get")
  get is ArmResourceRead<ImportSite>;

  /**
   * Create a ImportSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ImportSitesController")
  @operationId("ImportSitesController_Create")
  create is ArmResourceCreateOrReplaceSync<ImportSite>;

  /**
   * Update a ImportSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ImportSitesController")
  @operationId("ImportSitesController_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<ImportSite, PatchModel = ImportSiteUpdate>;

  /**
   * Delete a ImportSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ImportSitesController")
  @operationId("ImportSitesController_Delete")
  delete is ArmResourceDeleteSync<ImportSite>;

  /**
   * Get all import sites.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ImportSitesController")
  @operationId("ImportSitesController_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ImportSite>;

  /**
   * List ImportSite resources by subscription ID
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ImportSitesController")
  @operationId("ImportSitesController_ListBySubscription")
  listBySubscription is ArmListBySubscription<ImportSite>;

  /**
   * Deletes the imported machines for site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ImportSitesController")
  @operationId("ImportSitesController_DeleteImportedMachines")
  deleteImportedMachines is ArmResourceActionSync<
    ImportSite,
    unknown,
    ArmResponse<SasUriResponse>
  >;

  /**
   * Method to export  a site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ImportSitesController")
  @operationId("ImportSitesController_ExportUri")
  exportUri is ArmResourceActionSync<
    ImportSite,
    SasUriResponse,
    ArmResponse<SasUriResponse>
  >;

  /**
   * Method to import a site.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @tag("ImportSitesController")
  @operationId("ImportSitesController_ImportUri")
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
