import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiManagementServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Gateway details.
 */
@parentResource(ApiManagementServiceResource)
model GatewayContract
  is Azure.ResourceManager.ProxyResource<GatewayContractProperties> {
  ...ResourceNameParameter<
    Resource = GatewayContract,
    KeyName = "gatewayId",
    SegmentName = "gateways",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

alias GatewayApiParentParameter = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /**
   * The name of the API Management service.
   */
  @path
  @segment("service")
  @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
  @minLength(1)
  @maxLength(50)
  serviceName: string;

  /**
   * Gateway entity identifier. Must be unique in the current API Management service instance. Must not have value 'managed'
   */
  @path
  @segment("gateways")
  @minLength(1)
  @maxLength(80)
  gatewayId: string;
};

alias GatewayApiParameter = {
  /**
   * API identifier. Must be unique in the current API Management service instance.
   */
  @maxLength(80)
  @minLength(1)
  @path
  @segment("apis")
  apiId: string;
};

alias GatewayApiOps = Azure.ResourceManager.Legacy.RoutedOperations<
  GatewayApiParentParameter,
  GatewayApiParameter,
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/gateways/{gatewayId}/apis/{apiId}",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface GatewayContracts {
  /**
   * Gets the details of the Gateway specified by its identifier.
   */
  get is ArmResourceRead<
    GatewayContract,
    Response = ArmResponse<GatewayContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the Gateway specified by its identifier.
   */
  getEntityTag is ArmResourceCheckExistence<
    GatewayContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates a Gateway to be used in Api Management instance.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    GatewayContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<GatewayContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<GatewayContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the details of the gateway specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    GatewayContract,
    PatchModel = GatewayContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<GatewayContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes specific Gateway.
   */
  delete is ArmResourceDeleteSync<
    GatewayContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Lists a collection of gateways registered with service instance.
   */
  listByService is ArmResourceListByParent<
    GatewayContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| region | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<GatewayCollection>
  >;

  /**
   * Retrieves gateway keys.
   */
  listKeys is ArmResourceActionSync<
    GatewayContract,
    void,
    Response = ArmResponse<GatewayKeysContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Regenerates specified gateway key invalidating any tokens created with it.
   */
  regenerateKey is ArmResourceActionSync<
    GatewayContract,
    GatewayKeyRegenerationRequestContract,
    NoContentResponse
  >;

  /**
   * Gets the Shared Access Authorization Token for the gateway.
   */
  generateToken is ArmResourceActionSync<
    GatewayContract,
    GatewayTokenRequestContract,
    ArmResponse<GatewayTokenContract>
  >;

  /**
   * Action is invalidating all debug credentials issued for gateway.
   */
  invalidateDebugCredentials is ArmResourceActionSync<
    GatewayContract,
    void,
    NoContentResponse
  >;

  /**
   * Create new debug credentials for gateway.
   */
  listDebugCredentials is ArmResourceActionSync<
    GatewayContract,
    GatewayListDebugCredentialsContract,
    ArmResponse<GatewayDebugCredentialsContract>
  >;

  /**
   * Fetches trace collected by gateway.
   */
  listTrace is ArmResourceActionSync<
    GatewayContract,
    GatewayListTraceContract,
    ArmResponse<Record<unknown>>
  >;

  /**
   * Lists a collection of the APIs associated with a gateway.
   */
  @get
  @action("apis")
  @list
  gatewayApiListByService is ArmResourceActionSync<
    GatewayContract,
    void,
    ArmResponse<ApiCollection>,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    }
  >;

  /**
   * Checks that API entity specified by identifier is associated with the Gateway entity.
   */
  @head
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/gateways/{gatewayId}/apis/{apiId}")
  gatewayApiGetEntityTag is GatewayApiOps.ActionSync<
    GatewayContract,
    void,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Adds an API to the specified Gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/gateways/{gatewayId}/apis/{apiId}")
  gatewayApiCreateOrUpdate is GatewayApiOps.ActionSync<
    GatewayContract,
    AssociationContract,
    Response = ArmResponse<ApiContract> | ArmResourceCreatedSyncResponse<ApiContract>,
    OptionalRequestBody = true
  >;

  /**
   * Deletes the specified API from the specified Gateway.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/gateways/{gatewayId}/apis/{apiId}")
  gatewayApiDelete is GatewayApiOps.ActionSync<
    GatewayContract,
    void,
    Response = OkResponse | NoContentResponse
  >;
}

@@maxLength(GatewayContract.name, 80);
@@minLength(GatewayContract.name, 1);
@@doc(GatewayContract.name,
  "Gateway entity identifier. Must be unique in the current API Management service instance. Must not have value 'managed'"
);
@@doc(GatewayContract.properties, "Gateway details.");
@@doc(GatewayContracts.createOrUpdate::parameters.resource, "");
@@doc(GatewayContracts.update::parameters.properties, "");
@@doc(GatewayContracts.regenerateKey::parameters.body, "");
@@doc(GatewayContracts.generateToken::parameters.body, "");
@@doc(GatewayContracts.listDebugCredentials::parameters.body,
  "List debug credentials properties."
);
@@doc(GatewayContracts.listTrace::parameters.body, "List trace properties.");
@@doc(GatewayContracts.gatewayApiCreateOrUpdate::parameters.body, "");
