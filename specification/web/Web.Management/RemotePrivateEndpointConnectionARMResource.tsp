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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(AppServiceEnvironmentResource)
model RemotePrivateEndpointConnectionARMResource
  is Azure.ResourceManager.ProxyResource<RemotePrivateEndpointConnectionARMResourceProperties> {
  ...ResourceNameParameter<
    Resource = RemotePrivateEndpointConnectionARMResource,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface RemotePrivateEndpointConnectionARMResources {
  /**
   * Description for Gets a private endpoint connection
   */
  @summary("Gets a private endpoint connection")
  getPrivateEndpointConnection is RemotePrivateEndpointConnectionARMResourceOps.Read<
    RemotePrivateEndpointConnectionARMResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Approves or rejects a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Approves or rejects a private endpoint connection")
  approveOrRejectPrivateEndpointConnection is RemotePrivateEndpointConnectionARMResourceOps.CreateOrUpdateAsync<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResourceUpdatedResponse<RemotePrivateEndpointConnectionARMResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = RemotePrivateEndpointConnectionARMResource>> & {
      @bodyRoot
      _: RemotePrivateEndpointConnectionARMResource;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes a private endpoint connection")
  deletePrivateEndpointConnection is RemotePrivateEndpointConnectionARMResourceOps.DeleteWithoutOkAsync<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResponse<unknown> | (ArmDeleteAcceptedLroResponse & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    }) | (ArmDeletedNoContentResponse & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the list of private endpoints associated with a hosting environment
   */
  @summary("Gets the list of private endpoints associated with a hosting environment")
  getPrivateEndpointConnectionList is RemotePrivateEndpointConnectionARMResourceOps.List<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResponse<PrivateEndpointConnectionCollection>,
    OverrideErrorType = DefaultErrorResponse
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
  @summary("Gets a private endpoint connection")
  getPrivateEndpointConnection is StaticSiteOps.Read<
    RemotePrivateEndpointConnectionARMResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Approves or rejects a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Approves or rejects a private endpoint connection")
  approveOrRejectPrivateEndpointConnection is StaticSiteOps.CreateOrUpdateAsync<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResourceUpdatedResponse<RemotePrivateEndpointConnectionARMResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = RemotePrivateEndpointConnectionARMResource>> & {
      @bodyRoot
      _: RemotePrivateEndpointConnectionARMResource;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes a private endpoint connection")
  deletePrivateEndpointConnection is StaticSiteOps.DeleteWithoutOkAsync<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResponse<unknown> | (ArmDeleteAcceptedLroResponse & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    }) | (ArmDeletedNoContentResponse & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the list of private endpoint connections associated with a static site
   */
  @summary("Gets the list of private endpoint connections associated with a static site")
  getPrivateEndpointConnectionList is StaticSiteOps.List<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResponse<PrivateEndpointConnectionCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface PrivateEndpointConnectionOperationGroupOps
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface RemotePrivateEndpointConnectionARMResourceOperationGroup {
  /**
   * Description for Gets a private endpoint connection
   */
  @summary("Gets a private endpoint connection")
  getPrivateEndpointConnection is PrivateEndpointConnectionOperationGroupOps.Read<
    RemotePrivateEndpointConnectionARMResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Approves or rejects a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Approves or rejects a private endpoint connection")
  approveOrRejectPrivateEndpointConnection is PrivateEndpointConnectionOperationGroupOps.CreateOrUpdateAsync<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResourceUpdatedResponse<RemotePrivateEndpointConnectionARMResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = RemotePrivateEndpointConnectionARMResource>> & {
      @bodyRoot
      _: RemotePrivateEndpointConnectionARMResource;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes a private endpoint connection")
  deletePrivateEndpointConnection is PrivateEndpointConnectionOperationGroupOps.DeleteWithoutOkAsync<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResponse<unknown> | (ArmDeleteAcceptedLroResponse & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    }) | (ArmDeletedNoContentResponse & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the list of private endpoint connections associated with a site
   */
  @summary("Gets the list of private endpoint connections associated with a site")
  getPrivateEndpointConnectionList is PrivateEndpointConnectionOperationGroupOps.List<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResponse<PrivateEndpointConnectionCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface PrivateEndpointConnectionSlotOperationGroupOps
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
interface PrivateEndpointConnectionSlotOperationGroup {
  /**
   * Description for Gets a private endpoint connection
   */
  @summary("Gets a private endpoint connection")
  getPrivateEndpointConnectionSlot is PrivateEndpointConnectionSlotOperationGroupOps.Read<
    RemotePrivateEndpointConnectionARMResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Approves or rejects a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Approves or rejects a private endpoint connection")
  approveOrRejectPrivateEndpointConnectionSlot is PrivateEndpointConnectionSlotOperationGroupOps.CreateOrUpdateAsync<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResourceUpdatedResponse<RemotePrivateEndpointConnectionARMResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = RemotePrivateEndpointConnectionARMResource>> & {
      @bodyRoot
      _: RemotePrivateEndpointConnectionARMResource;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a private endpoint connection
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes a private endpoint connection")
  deletePrivateEndpointConnectionSlot is PrivateEndpointConnectionSlotOperationGroupOps.DeleteWithoutOkAsync<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResponse<unknown> | (ArmDeleteAcceptedLroResponse & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    }) | (ArmDeletedNoContentResponse & {
      #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body
      _: unknown;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Gets the list of private endpoint connections associated with a site
   */
  @summary("Gets the list of private endpoint connections associated with a site")
  @segment("privateEndpointConnections")
  getPrivateEndpointConnectionListSlot is PrivateEndpointConnectionSlotOperationGroupOps.List<
    RemotePrivateEndpointConnectionARMResource,
    Response = ArmResponse<PrivateEndpointConnectionCollection>,
    OverrideErrorType = DefaultErrorResponse
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
@@doc(PrivateEndpointConnectionSlotOperationGroup.approveOrRejectPrivateEndpointConnectionSlot::parameters.resource,
  ""
);
