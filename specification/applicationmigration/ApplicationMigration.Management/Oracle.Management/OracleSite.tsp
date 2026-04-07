import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;
/**
 * The OracleSite resource definition.
 */
model OracleSite
  is Azure.ResourceManager.TrackedResource<OracleSiteProperties, false> {
  ...ResourceNameParameter<
    Resource = OracleSite,
    KeyName = "siteName",
    SegmentName = "oracleSites",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface OracleSites {
  /**
   * Gets the OracleSites resource.
   */
  get is ArmResourceRead<OracleSite>;
  /**
   * Puts the OracleSites resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<OracleSite>;

  /**
   * Patch the OracleSites resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<OracleSite, SiteTagsPatch>;

  /**
   * Deletes the OracleSites resource.
   */
  delete is ArmResourceDeleteSync<OracleSite>;

  /**
   * Lists the OracleSites resource in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    OracleSite,
    Response = ArmResponse<OracleSiteList>
  >;

  /**
   * Lists the OracleSites resource in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    OracleSite,
    Response = ArmResponse<OracleSiteList>
  >;
}

@@maxLength(OracleSite.name, 63);
@@minLength(OracleSite.name, 3);
@@doc(OracleSite.name, "The name of Site");
@@doc(OracleSite.properties, "Resource properties.");
@@doc(OracleSites.createOrUpdate::parameters.resource,
  "The request body for creating or updating a OracleSite resource."
);
