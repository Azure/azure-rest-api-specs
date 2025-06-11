import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * Profile of a Bastion Host
 */
model BastionHost
  is Azure.ResourceManager.TrackedResource<BastionHostProperties, false> {
  ...ResourceNameParameter<
    Resource = BastionHost,
    KeyName = "name",
    SegmentName = "bastionhosts",
    NamePattern = ""
  >;
}

@armResourceOperations
interface BastionHosts {
  /**
   * Get bastionhost.
   */
  get is ArmResourceRead<BastionHost>;

  /**
   * Create or replace an existing bastionHost. This operation can take a while to complete.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BastionHost,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of bastionhosts. All other properties will be ignored.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmTagsPatchAsync<BastionHost>;

  /**
   * Delete bastionhost. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    BastionHost,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List bastionhosts in a given virtual network.
   */
  list is ArmResourceListByParent<
    BastionHost,
    Parameters = {
      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')'
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<BastionHostList>
  >;
}

@@doc(BastionHost.name, "The name of the bastionhost.");
@@doc(BastionHost.properties, "The properties of the resource.");
@@doc(BastionHosts.createOrUpdate::parameters.resource,
  "Profile of a Bastion Host"
);
@@doc(BastionHosts.update::parameters.properties,
  "Allows modifying tags of bastionhosts. All other properties will be ignored."
);
