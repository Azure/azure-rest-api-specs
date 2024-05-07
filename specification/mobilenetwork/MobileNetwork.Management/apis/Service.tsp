import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/ServiceModels.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Service resource. Must be created in the same location as its parent mobile network.")
@resource("services")
@parentResource(MobileNetwork)
model Service is TrackedResource<ServicePropertiesFormat> {
  @doc("The name of the service. You must not use any of the following reserved strings - `default`, `requested` or `service`")
  @maxLength(64)
  @pattern("^(?!(default|requested|service)$)[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("serviceName")
  @segment("services")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface Services {
  @doc("Gets information about the specified service.")
  get is ArmResourceRead<Service>;

  @doc("Creates or updates a service. Must be created in the same location as its parent mobile network.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Service>;

  @doc("Updates service tags.")
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<Service, TagsObject>;

  @doc("Deletes the specified service.")
  delete is ArmResourceDeleteWithoutOkAsync<Service>;

  @doc("Gets all the services in a mobile network.")
  listByMobileNetwork is ArmResourceListByParent<Service>;
}

@@doc(Services.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update service operation."
);
@@doc(Services.updateTags::parameters.properties,
  "Parameters supplied to update service tags."
);
