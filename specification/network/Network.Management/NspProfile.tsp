import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkSecurityPerimeter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * The network security perimeter profile resource
 */
@parentResource(NetworkSecurityPerimeter)
model NspProfile is Azure.ResourceManager.ProxyResource<NspProfileProperties> {
  ...ResourceNameParameter<
    Resource = NspProfile,
    KeyName = "profileName",
    SegmentName = "profiles",
    NamePattern = "(^[a-zA-Z0-9]+[a-zA-Z0-9_.-]*[a-zA-Z0-9_]+$)|(^[a-zA-Z0-9]$)"
  >;
}

@armResourceOperations
interface NspProfiles {
  /**
   * Gets the specified NSP profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterProfiles_Get")
  get is ArmResourceRead<NspProfile, Error = CloudError>;

  /**
   * Creates or updates a network profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterProfiles_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<NspProfile, Error = CloudError>;

  /**
   * Deletes an NSP profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterProfiles_Delete")
  delete is ArmResourceDeleteSync<NspProfile, Error = CloudError>;

  /**
   * Lists the NSP profiles in the specified network security perimeter.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterProfiles_List")
  list is ArmResourceListByParent<NspProfile,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    }, Error = CloudError>;
}

@@maxLength(NspProfile.name, 80);
@@doc(NspProfile.name, "The name of the NSP profile.");
@@doc(NspProfile.properties,
  "Properties of the network security perimeter profile"
);
@@doc(NspProfiles.createOrUpdate::parameters.resource,
  "Parameters that hold the NspProfile resource to be created/updated."
);
