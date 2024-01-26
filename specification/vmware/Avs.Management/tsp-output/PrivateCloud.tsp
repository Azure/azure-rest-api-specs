import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * A private cloud resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(PrivateCloudProperties)
model PrivateCloud extends TrackedResourceBase {
  /**
   * Name of the private cloud
   */
  @pattern("^[-\\w\\._]+$")
  @path
  @key("privateCloudName")
  @segment("privateClouds")
  @visibility("read")
  name: string;

  /**
   * The properties of a private cloud resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: PrivateCloudProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface PrivateClouds {
  /**
   * Get a private cloud
   */
  get is ArmResourceRead<PrivateCloud>;

  /**
   * Create or update a private cloud
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PrivateCloud>;

  /**
   * Update a private cloud
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<PrivateCloud, PrivateCloudUpdate>;

  /**
   * Delete a private cloud
   */
  delete is ArmResourceDeleteAsync<PrivateCloud>;

  /**
   * List private clouds in a resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateClouds_List")
  list is ArmResourceListByParent<PrivateCloud>;

  /**
   * List private clouds in a subscription
   */
  listInSubscription is ArmListBySubscription<PrivateCloud>;

  /**
   * Rotate the vCenter password
   */
  rotateVcenterPassword is ArmResourceActionNoResponseContentAsync<
    PrivateCloud,
    void
  >;

  /**
   * Rotate the NSX-T Manager password
   */
  rotateNsxtPassword is ArmResourceActionNoResponseContentAsync<
    PrivateCloud,
    void
  >;

  /**
   * List the admin credentials for the private cloud
   */
  listAdminCredentials is ArmResourceActionSync<
    PrivateCloud,
    void,
    AdminCredentials
  >;
}

@@projectedName(PrivateClouds.createOrUpdate::parameters.resource,
  "json",
  "privateCloud"
);
@@extension(PrivateClouds.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "privateCloud"
);
@@doc(PrivateClouds.createOrUpdate::parameters.resource, "The private cloud");
@@projectedName(PrivateClouds.update::parameters.properties,
  "json",
  "privateCloudUpdate"
);
@@extension(PrivateClouds.update::parameters.properties,
  "x-ms-client-name",
  "privateCloudUpdate"
);
@@doc(PrivateClouds.update::parameters.properties,
  "The private cloud properties to be updated"
);
