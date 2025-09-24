import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Devices;
/**
 * The group information for creating a private endpoint on a provisioning service
 */
@parentResource(ProvisioningServiceDescription)
model GroupIdInformation
  is Azure.ResourceManager.ProxyResource<GroupIdInformationProperties, false> {
  ...ResourceNameParameter<
    Resource = GroupIdInformation,
    KeyName = "groupId",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GroupIdInformationsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * Name of the provisioning service to retrieve.
         */
        @path
        @segment("provisioningServices")
        resourceName: string,
      },
      {},
      ErrorDetails
    > {}

@armResourceOperations
interface GroupIdInformations {
  /**
   * Get the specified private link resource for the given provisioning service
   */
  getPrivateLinkResources is GroupIdInformationsOps.Read<
    GroupIdInformation,
    Parameters = {
      /**
       * The name of the private link resource
       */
      @path
      @segment("privateLinkResources")
      groupId: string;
    },
    Response = ArmResponse<GroupIdInformation>
  >;

  /**
   * List private link resources for the given provisioning service
   */
  listPrivateLinkResources is GroupIdInformationsOps.List<
    GroupIdInformation,
    Response = ArmResponse<PrivateLinkResources>
  >;
}

@@doc(GroupIdInformation.name, "The name of the private link resource");
@@doc(GroupIdInformation.properties,
  "The properties for a group information object"
);
