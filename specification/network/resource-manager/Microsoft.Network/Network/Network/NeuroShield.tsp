import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Common;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Microsoft.Network/Network currently uses Azure.ResourceManager.Legacy templates to keep a single generated swagger surface across tags; NeuroShield 2026-01-01 follows this project-wide convention."
@added(Versions.v2026_01_01)
@Azure.ResourceManager.Legacy.feature(Features.neuroShield)
@armResourceOperations
interface NeuroShields {
  /**
   * Gets a NeuroShield resource.
   */
  @summary("Gets a NeuroShield resource.")
  get is ArmResourceRead<
    NeuroShieldResource,
    Response = ArmResponse<NeuroShieldResource> &
      Azure.Core.EtagResponseEnvelope,
    Error = CloudError
  >;

  /**
   * Creates or updates a NeuroShield resource.
   */
  @summary("Creates or updates a NeuroShield resource.")
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
    Error = CloudError
  >;

  /**
   * Updates the tags or properties of a NeuroShield resource.
   */
  @summary("Updates the tags or properties of a NeuroShield resource.")
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
    Error = CloudError
  >;

  /**
   * Deletes a NeuroShield resource.
   */
  @summary("Deletes a NeuroShield resource.")
  delete is ArmResourceDeleteSync<NeuroShieldResource, Error = CloudError>;

  /**
   * Gets all NeuroShield resources in a resource group.
   */
  @summary("Gets all NeuroShield resources in a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    NeuroShieldResource,
    Error = CloudError
  >;

  /**
   * Gets all NeuroShield resources in a subscription.
   */
  @summary("Gets all NeuroShield resources in a subscription.")
  listBySubscription is ArmListBySubscription<
    NeuroShieldResource,
    Error = CloudError
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
