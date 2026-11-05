import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace NeuroShield.Management;

@added(Versions.v2026_10_01_preview)
@armResourceOperations
interface NeuroShields {
  /**
   * Gets a NeuroShield resource.
   */
  @summary("Get a NeuroShield resource")
  get is ArmResourceRead<
    NeuroShieldResource,
    Response = ArmResponse<NeuroShieldResource> &
      Azure.Core.EtagResponseEnvelope,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Creates or updates a NeuroShield resource.
   */
  @summary("Create or update a NeuroShield resource")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    NeuroShieldResource,
    Parameters = {
      /** The entity tag that makes the request conditional. */
      @header("If-Match")
      ifMatch?: string;
    },
    Response =
      | (ArmResponse<NeuroShieldResource> & Azure.Core.EtagResponseEnvelope)
      | (ArmCreatedResponse<NeuroShieldResource, {}> &
          Azure.Core.EtagResponseEnvelope),
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Updates the tags or properties of a NeuroShield resource.
   */
  @summary("Update a NeuroShield resource")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    NeuroShieldResource,
    PatchModel = NeuroShieldPatch,
    Parameters = {
      /** The entity tag that makes the request conditional. */
      @header("If-Match")
      ifMatch?: string;
    },
    Response = ArmResponse<NeuroShieldResource> &
      Azure.Core.EtagResponseEnvelope,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Deletes a NeuroShield resource.
   */
  @summary("Delete a NeuroShield resource")
  delete is ArmResourceDeleteSync<
    NeuroShieldResource,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Gets all NeuroShield resources in a resource group.
   */
  @summary("List NeuroShield resources by resource group")
  listByResourceGroup is ArmResourceListByParent<
    NeuroShieldResource,
    Parameters = NeuroShieldPaginationParameters,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Gets all NeuroShield resources in a subscription.
   */
  @summary("List NeuroShield resources by subscription")
  listBySubscription is ArmListBySubscription<
    NeuroShieldResource,
    Parameters = NeuroShieldPaginationParameters,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;
}

@added(Versions.v2026_10_01_preview)
@armResourceOperations
interface NeuroShieldSummaries {
  /**
   * Lists the aggregate fleet overview singleton for a NeuroShield resource.
   */
  @sharedRoute
  @summary("List NeuroShield fleet summaries")
  list is ArmResourceListByParent<
    NeuroShieldSummary,
    Parameters = NeuroShieldSummaryListParameters,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;

  /**
   * Gets the aggregate fleet overview singleton for a NeuroShield resource.
   */
  @summary("Get a NeuroShield fleet summary")
  get is ArmResourceRead<
    NeuroShieldSummary,
    Error = Azure.ResourceManager.CommonTypes.ErrorResponse
  >;
}

@@doc(NeuroShieldResource.name, "The name of the NeuroShield resource.");
@@doc(
  NeuroShieldResource.properties,
  "Properties of the NeuroShield resource."
);
@@doc(
  NeuroShields.createOrUpdate::parameters.resource,
  "The create or update request body."
);
@@doc(NeuroShields.update::parameters.properties, "The patch request body.");
