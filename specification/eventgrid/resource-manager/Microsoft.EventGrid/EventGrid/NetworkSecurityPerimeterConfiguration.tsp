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
interface NetworkSecurityPerimeterConfigurationOps
  extends Azure.ResourceManager.Legacy.RoutedOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /**
         * The type of the resource. This can be either \\'topics\\', or \\'domains\\'.
         */
        @path
        resourceType: NetworkSecurityPerimeterResourceType,

        /**
         * The name of the resource group within the user's subscription.
         */
        @path
        @pattern("^[a-zA-Z0-9-]*$")
        @minLength(3)
        @maxLength(50)
        resourceName: string,
      },
      {},
      ResourceRoute = #{
        route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventGrid/{resourceType}/{resourceName}",
      }
    > {}

@armResourceOperations(#{ allowStaticRoutes: true })
interface NetworkSecurityPerimeterConfigurations {
  /**
   * Get a specific network security perimeter configuration with a topic or domain.
   */
  @summary("Get a specific network security perimeter configuration.")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventGrid/{resourceType}/{resourceName}/networkSecurityPerimeterConfigurations/{perimeterGuid}.{associationName}")
  get is NetworkSecurityPerimeterConfigurationOps.ActionSync<
    NetworkSecurityPerimeterConfiguration,
    Request = void,
    Response = ArmResponse<NetworkSecurityPerimeterConfiguration>,
    Parameters = {
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
  @summary("Get all network security perimeter configurations for resource.")
  @get
  @list
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventGrid/{resourceType}/{resourceName}/networkSecurityPerimeterConfigurations")
  list is NetworkSecurityPerimeterConfigurationOps.ActionSync<
    NetworkSecurityPerimeterConfiguration,
    Request = void,
    Response = ArmResponse<NetworkSecurityPerimeterConfigurationList>
  >;

  /**
   * Reconcile a specific network security perimeter configuration for a given network security perimeter association with a topic or domain.
   */
  @summary("Reconcile a specific network security perimeter configuration for a given network security perimeter association.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventGrid/{resourceType}/{resourceName}/networkSecurityPerimeterConfigurations/{perimeterGuid}.{associationName}/reconcile")
  reconcile is NetworkSecurityPerimeterConfigurationOps.ActionAsync<
    NetworkSecurityPerimeterConfiguration,
    Request = void,
    Result = NetworkSecurityPerimeterConfiguration,
    Parameters = {
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
