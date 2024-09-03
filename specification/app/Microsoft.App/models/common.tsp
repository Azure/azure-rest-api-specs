import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.App;
using OpenAPI;

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
  @pattern("^[a-z][a-z0-9]*$")
  @maxLength(63)
  @minLength(3)
  sessionPoolName: string;
}

@doc("The subscription identifier path parameter.")
model SubscriptionIdParameter {
  @doc("The ID of the target subscription. The value must be an UUID.")
  @path
  @segment("subscriptions")
  @extension("x-ms-parameter-location", "client")
  subscriptionId: uuid;
}

@doc("The resource group name path parameter.")
model ResourceGroupNameParameter {
  @doc("The name of the resource group. The name is case insensitive.")
  @path
  @maxLength(90)
  @minLength(1)
  @extension("x-ms-parameter-location", "client")
  resourceGroupName: string;
}

@doc("The session pool name path parameter.")
model SessionPoolNameParameter {
  @doc("The name of the session pool.")
  @path
  @extension("x-ms-parameter-location", "client")
  sessionPoolName: string;
}

@doc("The code execution name path parameter.")
model SessionResourceFileNameParameter {
  @doc("The name of the file.")
  @path
  filename: string;
}

@doc("Session identifier query parameter.")
model SessionIdentifier {
  @doc("The identifier of the session.")
  @query
  @extension("x-ms-parameter-location", "client")
  identifier: string;
}

@doc("Session code execution identifier query parameter.")
model CodeExecutionIdentifier {
  @doc("The identifier of code execution.")
  @query
  @extension("x-ms-parameter-location", "client")
  executionId: string;
}
