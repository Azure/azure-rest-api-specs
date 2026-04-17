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
 * Intermediate model for lowercase iotHubs path segment used by private link resources.
 */
model IotHubDescriptionLowerCase
  is Azure.ResourceManager.TrackedResource<IotHubProperties> {
  ...ResourceNameParameter<
    Resource = IotHubDescriptionLowerCase,
    KeyName = "resourceName",
    SegmentName = "iotHubs",
    NamePattern = ""
  >;
}

/**
 * The group information for creating a private endpoint on an IotHub
 */
@parentResource(IotHubDescriptionLowerCase)
model GroupIdInformation
  is Azure.ResourceManager.ProxyResource<GroupIdInformationProperties, false> {
  ...ResourceNameParameter<
    Resource = GroupIdInformation,
    KeyName = "groupId",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface GroupIdInformations {
  /**
   * Get the specified private link resource for the given IotHub
   */
  @summary("Get the specified private link resource")
  @tag("GET")
  get is ArmResourceRead<GroupIdInformation, Error = ErrorDetails>;

  /**
   * List private link resources for the given IotHub
   */
  @summary("List private link resources")
  @tag("GET")
  list is ArmResourceListByParent<
    GroupIdInformation,
    Response = ArmResponse<PrivateLinkResources>,
    Error = ErrorDetails
  >;
}

@@doc(GroupIdInformation.name, "The name of the private link resource");
@@doc(GroupIdInformation.properties,
  "The properties for a group information object"
);
