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
 * The group information for creating a private endpoint on an IotHub
 */
model GroupIdInformation {
  /** The resource identifier. */
  @visibility(Lifecycle.Read)
  id?: string;

  /** The resource name. */
  @visibility(Lifecycle.Read)
  name?: string;

  /** The resource type. */
  @visibility(Lifecycle.Read)
  type?: string;

  /** The properties for a group information object */
  properties: GroupIdInformationProperties;
}

alias GroupIdInformationOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the IoT Hub */
    @path
    @key
    @segment("iotHubs")
    resourceName: string;
  },
  {
    /** The name of the private link resource */
    @path
    @key
    @segment("privateLinkResources")
    groupId: string;
  },
  ErrorType = ErrorDetails
>;

@armResourceOperations(#{ omitTags: true })
interface GroupIdInformations {
  /**
   * Get the specified private link resource for the given IotHub
   */
  @summary("Get the specified private link resource")
  @tag("GET")
  get is GroupIdInformationOps.Read<GroupIdInformation>;

  /**
   * List private link resources for the given IotHub
   */
  @summary("List private link resources")
  @tag("GET")
  list is GroupIdInformationOps.ListSinglePage<
    GroupIdInformation,
    Response = ArmResponse<PrivateLinkResources>
  >;
}

@@doc(GroupIdInformation.properties,
  "The properties for a group information object"
);
