using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.App;

@doc("Subscription resource.")
@resource("subscriptions")
model Subscription {
  @doc("The ID of the target subscription. The value must be an UUID.")
  @key("subscriptionId")
  @segment("subscriptions")
  @visibility
  subscriptionId: uuid;
}

@doc("Resource group resource.")
@parentResource(Subscription)
@resource("resourceGroups")
model ResourceGroup {
  @doc("The name of the resource group. The name is case insensitive.")
  @key("resourceGroupName")
  @segment("resourceGroups")
  @visibility
  @maxLength(90)
  @minLength(1)
  resourceGroupName: string;
}

@doc("Session pool resource.")
@parentResource(ResourceGroup)
@resource("sessionPools")
model SessionPool {
  @doc("The name of the session pool.")
  @key("sessionPoolName")
  @segment("sessionPools")
  @visibility
  sessionPoolName: string;
}

@doc("Session identifier query parameter.")
model SessionIdentifier {
  @doc("The identifier of the session.")
  @query
  identifier: string;
}
