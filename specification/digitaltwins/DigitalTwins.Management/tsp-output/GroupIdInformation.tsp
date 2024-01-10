import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DigitalTwinsDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DigitalTwins;
@doc("The group information for creating a private endpoint on Digital Twin.")
@parentResource(DigitalTwinsDescription)
model GroupIdInformation is ProxyResource<GroupIdInformationProperties> {
  @doc("The name of the private link resource.")
  @key("resourceId")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
@projectedName("client", "PrivateLinkResources")
interface GroupIdInformations_PrivateLinkResources {
  @doc("Get the specified private link resource for the given Digital Twin.")
  get is ArmResourceRead<GroupIdInformation>;

  @doc("List private link resources for given Digital Twin.")
  list is ArmResourceListByParent<GroupIdInformation>;
}
