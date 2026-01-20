import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventGrid;
/**
 * Network security perimeter configuration.
 */
@singleton("{perimeterGuid}.{associationName}")
model NetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.ProxyResource<NetworkSecurityPerimeterConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = NetworkSecurityPerimeterConfiguration,
    KeyName = "networkSecurityPerimeterConfiguration",
    SegmentName = "networkSecurityPerimeterConfigurations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface NetworkSecurityPerimeterConfigurations {
  /**
   * Get a specific network security perimeter configuration with a topic or domain.
   */
  get is ArmResourceRead<
    NetworkSecurityPerimeterConfiguration,
    Parameters = {
      /**
       * The type of the resource. This can be either \'topics\', or \'domains\'.
       */
      @path
      resourceType: NetworkSecurityPerimeterResourceType;

      /**
       * Unique identifier for perimeter
       */
      @path
      perimeterGuid: string;

      /**
       * Association name to association network security perimeter resource to profile
       */
      @path
      associationName: string;
    }
  >;

  /**
   * Get all network security perimeter configurations associated with a topic or domain.
   */
  list is ArmResourceListByParent<
    NetworkSecurityPerimeterConfiguration,
    Parameters = {
      /**
       * The type of the resource. This can be either \'topics\' or \'domains\'.
       */
      @path
      resourceType: NetworkSecurityPerimeterResourceType;
    },
    Response = ArmResponse<NetworkSecurityPerimeterConfigurationList>
  >;

  /**
   * Reconcile a specific network security perimeter configuration for a given network security perimeter association with a topic or domain.
   */
  reconcile is ArmResourceActionAsync<
    NetworkSecurityPerimeterConfiguration,
    void,
    ArmResponse<NetworkSecurityPerimeterConfiguration>,
    Parameters = {
      /**
       * The type of the resource. This can be either \'topics\' or \'domains\'.
       */
      @path
      resourceType: NetworkSecurityPerimeterResourceType;

      /**
       * Unique identifier for perimeter
       */
      @path
      perimeterGuid: string;

      /**
       * Association name to association network security perimeter resource to profile
       */
      @path
      associationName: string;
    }
  >;
}

@@doc(NetworkSecurityPerimeterConfiguration.name, "");
@@doc(NetworkSecurityPerimeterConfiguration.properties,
  "Properties of the network security perimeter configuration."
);
