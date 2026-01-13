import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceEnvironmentResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Describes main public IP address and any extra virtual IPs.
 */
@singleton("virtualip")
@parentResource(AppServiceEnvironmentResource)
model AddressResponse
  is Azure.ResourceManager.ProxyResource<AddressResponseProperties> {
  ...ResourceNameParameter<
    Resource = AddressResponse,
    KeyName = "capacity",
    SegmentName = "capacities",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface AddressResponses {
  /**
   * Description for Get IP addresses assigned to an App Service Environment.
   */
  @summary("Get IP addresses assigned to an App Service Environment.")
  getVipInfo is ArmResourceRead<AddressResponse, Error = DefaultErrorResponse>;
}

@@doc(AddressResponse.name, "");
@@doc(AddressResponse.properties,
  "AddressResponse resource specific properties"
);
