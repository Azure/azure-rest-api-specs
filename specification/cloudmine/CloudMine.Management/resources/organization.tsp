import "../models/organization.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.CloudMine;

@tenantResource
model Organization is ProxyResource<OrganizationProperties> {
  ...ResourceNameParameter<Organization>;
}

@armResourceOperations
interface Organizations {
  get is ArmResourceRead<Organization>;
  list is ArmResourceListByParent<Organization>;
}
