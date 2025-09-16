import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * Service resource. Must be created in the same location as its parent mobile network.
 */
@parentResource(MobileNetwork)
model Service
  is Azure.ResourceManager.TrackedResource<ServicePropertiesFormat, false> {
  ...ResourceNameParameter<
    Resource = Service,
    KeyName = "serviceName",
    SegmentName = "services",
    NamePattern = "^(?!(default|requested|service)$)[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;
}

@armResourceOperations
interface Services {
  /**
   * Gets information about the specified service.
   */
  get is ArmResourceRead<Service>;

  /**
   * Creates or updates a service. Must be created in the same location as its parent mobile network.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Service>;

  /**
   * Updates service tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<Service, PatchModel = TagsObject>;

  /**
   * Deletes the specified service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Service,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all the services in a mobile network.
   */
  listByMobileNetwork is ArmResourceListByParent<Service>;
}

@@maxLength(Service.name, 64);
@@doc(Service.name,
  "The name of the service. You must not use any of the following reserved strings - `default`, `requested` or `service`"
);
@@doc(Service.properties, "Service Properties.");
@@doc(Services.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update service operation."
);
@@doc(Services.updateTags::parameters.properties,
  "Parameters supplied to update service tags."
);
