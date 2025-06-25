import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./Context.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.Edge;

@doc("Configuration of the EventGrid filter")
model Filter {
  @doc("Filter configuration: Removes all events with a subject that does not start with this string")
  subjectBeginsWith?: string;

  @doc("Filter configuration: Removes all events with a subject that does not end with this string")
  subjectEndsWith?: string;

  @doc("Event types subscribed")
  includedEventTypes?: string[];
}

@doc("Subscriber Identity Info, for passing client details")
model SubscriberIdentityInfo {
  @doc("Principal ID of the Client")
  clientPrincipalId?: string;

  @doc("Object ID of the Client")
  clientObjectId?: string;

  @doc("Tenant ID of the Client")
  clientTenantId?: string;

  @doc("Application ID of the Client")
  clientApplicationId?: string;

  @doc("Authorization Source of the Client")
  clientAuthorizationSource?: string;
}

@doc("Event Grid Filter Properties")
model EventGridFilterProperties {
  @doc("Filter details")
  filter?: Filter;

  @doc("Subscriber Identity details")
  subscriberIdentityInfo?: SubscriberIdentityInfo;

  @doc("Provisioning State")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Event Grid Filter Resource")
@parentResource(Context)
@resource("eventGridFilters")
model EventGridFilter
  is Azure.ResourceManager.ProxyResource<EventGridFilterProperties> {
  ...ResourceNameParameter<
    Resource = EventGridFilter,
    NamePattern = "^[a-zA-Z0-9_-]{3,24}$"
  >;
}

@armResourceOperations
interface EventGridFilters {
  @doc("Get Event Grid Filter Resource")
  get is ArmResourceRead<EventGridFilter>;

  @doc("Create or Update Event Grid Filter Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EventGridFilter>;

  @doc("Update Event Grid Filter Resource")
  update is ArmResourcePatchAsync<EventGridFilter, EventGridFilterProperties>;

  @doc("Delete Event Grid Filter Resource")
  delete is ArmResourceDeleteWithoutOkAsync<EventGridFilter>;

  @doc("List Event Grid Filter Resources")
  listByContext is ArmResourceListByParent<EventGridFilter>;
}
