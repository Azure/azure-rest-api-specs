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
 * Remote Private Endpoint Connection ARM resource.
 */
@parentResource(AppServiceEnvironmentResource)
model RemotePrivateEndpointConnectionARMResource
  is Azure.ResourceManager.ProxyResource<RemotePrivateEndpointConnectionARMResourceProperties> {
  ...ResourceNameParameter<
    Resource = RemotePrivateEndpointConnectionARMResource,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface RemotePrivateEndpointConnectionARMResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the App Service Environment. */
        @path
        @segment("hostingEnvironments")
        @key
        name: string,
      },
      {
        /** Name of the private endpoint connection. */
        @path
        @segment("privateEndpointConnections")
        @key
        privateEndpointConnectionName: string,
      }
    > {}

@armResourceOperations
interface RemotePrivateEndpointConnectionARMResources {
  /**
   * Description for Gets a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServiceEnvironments_GetPrivateEndpointConnection")
  getPrivateEndpointConnection is RemotePrivateEndpointConnectionARMResourceOps.Read<RemotePrivateEndpointConnectionARMResource>;

  /**
   * Description for Approves or rejects a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("AppServiceEnvironments_ApproveOrRejectPrivateEndpointConnection")
  approveOrRejectPrivateEndpointConnection is RemotePrivateEndpointConnectionARMResourceOps.CreateOrUpdateAsync<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResourceUpdatedResponse<RemotePrivateEndpointConnectionARMResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: RemotePrivateEndpointConnectionARMResource;
    }),
    LroHeaders = ArmLroLocationHeader<FinalResult = RemotePrivateEndpointConnectionARMResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Description for Deletes a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("AppServiceEnvironments_DeletePrivateEndpointConnection")
  deletePrivateEndpointConnection is RemotePrivateEndpointConnectionARMResourceOps.DeleteWithoutOkAsync<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResponse<unknown> | (ArmDeleteAcceptedLroResponse & {
      @bodyRoot
      _: unknown;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * Description for Gets the list of private endpoints associated with a hosting environment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServiceEnvironments_GetPrivateEndpointConnectionList")
  getPrivateEndpointConnectionList is RemotePrivateEndpointConnectionARMResourceOps.List<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResponse<PrivateEndpointConnectionCollection>
  >;
}
@armResourceOperations
interface StaticSiteOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the static site. */
        @path
        @segment("staticSites")
        @key
        name: string,
      },
      {
        /** Name of the private endpoint connection. */
        @path
        @segment("privateEndpointConnections")
        @key
        privateEndpointConnectionName: string,
      }
    > {}

@armResourceOperations
interface StaticSites {
  /**
   * Description for Gets a private endpoint connection
   */
  getPrivateEndpointConnection is StaticSiteOps.Read<RemotePrivateEndpointConnectionARMResource>;

  /**
   * Description for Approves or rejects a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  approveOrRejectPrivateEndpointConnection is StaticSiteOps.CreateOrUpdateAsync<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResourceUpdatedResponse<RemotePrivateEndpointConnectionARMResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: RemotePrivateEndpointConnectionARMResource;
    }),
    LroHeaders = ArmLroLocationHeader<FinalResult = RemotePrivateEndpointConnectionARMResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Description for Deletes a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  deletePrivateEndpointConnection is StaticSiteOps.DeleteWithoutOkAsync<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResponse<unknown> | (ArmDeleteAcceptedLroResponse & {
      @bodyRoot
      _: unknown;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * Description for Gets the list of private endpoint connections associated with a static site
   */
  getPrivateEndpointConnectionList is StaticSiteOps.List<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResponse<PrivateEndpointConnectionCollection>
  >;
}
@armResourceOperations
interface RemotePrivateEndpointConnectionARMResourceOperationGroupOps_2
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the site. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** Name of the private endpoint connection. */
        @path
        @segment("privateEndpointConnections")
        @key
        privateEndpointConnectionName: string,
      }
    > {}

@armResourceOperations
interface RemotePrivateEndpointConnectionARMResourceOperationGroup {
  /**
   * Description for Gets a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetPrivateEndpointConnection")
  getPrivateEndpointConnection is RemotePrivateEndpointConnectionARMResourceOperationGroupOps_2.Read<RemotePrivateEndpointConnectionARMResource>;

  /**
   * Description for Approves or rejects a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("WebApps_ApproveOrRejectPrivateEndpointConnection")
  approveOrRejectPrivateEndpointConnection is RemotePrivateEndpointConnectionARMResourceOperationGroupOps_2.CreateOrUpdateAsync<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResourceUpdatedResponse<RemotePrivateEndpointConnectionARMResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: RemotePrivateEndpointConnectionARMResource;
    }),
    LroHeaders = ArmLroLocationHeader<FinalResult = RemotePrivateEndpointConnectionARMResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Description for Deletes a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("WebApps_DeletePrivateEndpointConnection")
  deletePrivateEndpointConnection is RemotePrivateEndpointConnectionARMResourceOperationGroupOps_2.DeleteWithoutOkAsync<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResponse<unknown> | (ArmDeleteAcceptedLroResponse & {
      @bodyRoot
      _: unknown;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * Description for Gets the list of private endpoint connections associated with a site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetPrivateEndpointConnectionList")
  getPrivateEndpointConnectionList is RemotePrivateEndpointConnectionARMResourceOperationGroupOps_2.List<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResponse<PrivateEndpointConnectionCollection>
  >;
}
@armResourceOperations
interface RemotePrivateEndpointConnectionARMResourceOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the site. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the site deployment slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Name of the private endpoint connection. */
        @path
        @segment("privateEndpointConnections")
        @key
        privateEndpointConnectionName: string,
      }
    > {}

@armResourceOperations
interface RemotePrivateEndpointConnectionARMResourceOperationGroup_2 {
  /**
   * Description for Gets a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetPrivateEndpointConnectionSlot")
  getPrivateEndpointConnectionSlot is RemotePrivateEndpointConnectionARMResourceOperationGroupOps.Read<RemotePrivateEndpointConnectionARMResource>;

  /**
   * Description for Approves or rejects a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("WebApps_ApproveOrRejectPrivateEndpointConnectionSlot")
  approveOrRejectPrivateEndpointConnectionSlot is RemotePrivateEndpointConnectionARMResourceOperationGroupOps.CreateOrUpdateAsync<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResourceUpdatedResponse<RemotePrivateEndpointConnectionARMResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: RemotePrivateEndpointConnectionARMResource;
    }),
    LroHeaders = ArmLroLocationHeader<FinalResult = RemotePrivateEndpointConnectionARMResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Description for Deletes a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("WebApps_DeletePrivateEndpointConnectionSlot")
  deletePrivateEndpointConnectionSlot is RemotePrivateEndpointConnectionARMResourceOperationGroupOps.DeleteWithoutOkAsync<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResponse<unknown> | (ArmDeleteAcceptedLroResponse & {
      @bodyRoot
      _: unknown;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * Description for Gets the list of private endpoint connections associated with a site
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetPrivateEndpointConnectionListSlot")
  @segment("privateEndpointConnections")
  getPrivateEndpointConnectionListSlot is RemotePrivateEndpointConnectionARMResourceOperationGroupOps.List<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResponse<PrivateEndpointConnectionCollection>
  >;
}

@@doc(RemotePrivateEndpointConnectionARMResource.name,
  "Name of the private endpoint connection."
);
@@doc(RemotePrivateEndpointConnectionARMResource.properties,
  "RemotePrivateEndpointConnectionARMResource resource specific properties"
);
@@doc(RemotePrivateEndpointConnectionARMResources.approveOrRejectPrivateEndpointConnection::parameters.resource,
  ""
);
@@doc(StaticSites.approveOrRejectPrivateEndpointConnection::parameters.resource,
  "Request body."
);
@@doc(RemotePrivateEndpointConnectionARMResourceOperationGroup.approveOrRejectPrivateEndpointConnection::parameters.resource,
  ""
);
// @@doc(RemotePrivateEndpointConnectionARMResourceOperationGroup.approveOrRejectPrivateEndpointConnectionSlot::parameters.resource,
//   ""
// );
