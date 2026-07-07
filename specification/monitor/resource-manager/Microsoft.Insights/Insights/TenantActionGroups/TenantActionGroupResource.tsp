import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * A tenant action group resource.
 */
model TenantActionGroupResource
  is Azure.ResourceManager.TrackedResource<TenantActionGroup> {
  ...ResourceNameParameter<
    Resource = TenantActionGroupResource,
    KeyName = "tenantActionGroupName",
    SegmentName = "tenantActionGroups",
    NamePattern = "^[A-Za-z][A-Za-z0-9]*$"
  >;
}

alias QuotaCounterKeyParentParameters = {
  ...ApiVersionParameter;

  /**
   * aaaaaaaaaaaaaaaaaaaaa
   */
  @path
  @segment("managementGroups")
  @key
  managementGroupId: string;

  /**
   *  aaaaaaaaaaaaaaaaaaaaa
   */
  @path
  @segment("tenantActionGroups")
  @key
  @pattern("^[A-Za-z][A-Za-z0-9]*$")
  @minLength(1)
  @maxLength(260)
  tenantActionGroupName: string;
};

alias QuotaCounterKeyParameters = {
  /**
   * aaaaaaaaaaaaaaaaaaaaaa
   */
  @path
  @key
  @segment("notificationStatus")
  notificationId: string;
};

alias TenantActionGroupResourcesOps = Azure.ResourceManager.Legacy.RoutedOperations<
  QuotaCounterKeyParentParameters,
  QuotaCounterKeyParameters,
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/quotas/{quotaCounterKey}",
  }
>;

@armResourceOperations(#{ omitTags: true, allowStaticRoutes: true })
interface TenantActionGroupResources {
  /**
   * Get a tenant action group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TenantActionGroups_Get")
  get is Extension.Read<
    Extension.ManagementGroup<"managementGroupId">,
    TenantActionGroupResource,
    Parameters = {
      /**
       * The tenant ID of the client making the request.
       */
      @header
      `x-ms-client-tenant-id`: string;
    },
    Error = ErrorResponse
  >;

  /**
   * Create a new tenant action group or update an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TenantActionGroups_CreateOrUpdate")
  createOrUpdate is Extension.CreateOrReplaceSync<
    Extension.ManagementGroup<"managementGroupId">,
    TenantActionGroupResource,
    Parameters = {
      /**
       * The tenant ID of the client making the request.
       */
      @header
      `x-ms-client-tenant-id`: string;
    },
    Error = ErrorResponse
  >;

  /**
   * Updates an existing tenant action group's tags. To update other fields use the CreateOrUpdate method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TenantActionGroups_Update")
  @patch(#{ implicitOptionality: false })
  update is Extension.CustomPatchSync<
    Extension.ManagementGroup<"managementGroupId">,
    TenantActionGroupResource,
    PatchModel = ActionGroupPatchBody,
    Parameters = {
      /**
       * The tenant ID of the client making the request.
       */
      @header
      `x-ms-client-tenant-id`: string;
    },
    Error = ErrorResponse
  >;

  /**
   * Delete a tenant action group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TenantActionGroups_Delete")
  delete is Extension.DeleteSync<
    Extension.ManagementGroup<"managementGroupId">,
    TenantActionGroupResource,
    Parameters = {
      /**
       * The tenant ID of the client making the request.
       */
      @header
      `x-ms-client-tenant-id`: string;
    },
    Error = ErrorResponse
  >;

  /**
   * Get a list of all tenant action groups in a management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TenantActionGroups_ListByManagementGroupId")
  listByManagementGroupId is Extension.ListByTarget<
    Extension.ManagementGroup<"managementGroupId">,
    TenantActionGroupResource,
    Parameters = {
      /**
       * The tenant ID of the client making the request.
       */
      @header
      `x-ms-client-tenant-id`: string;
    },
    Response = ArmResponse<TenantActionGroupList>,
    Error = ErrorResponse
  >;

  /**
   * Send test notifications to a set of provided receivers
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CreateNotificationsAtTenantActionGroupResourceLevel")
  @action("createNotifications")
  createNotificationsAtTenantActionGroupResourceLevel is Extension.ActionAsync<
    Extension.ManagementGroup<"managementGroupId">,
    TenantActionGroupResource,
    TenantNotificationRequestBody,
    Response = TestNotificationDetailsResponse,
    Parameters = {
      /**
       * The tenant ID of the client making the request.
       */
      @header
      `x-ms-client-tenant-id`: string;
    }
  >;

  /**
   * Get the test notifications by the notification id
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GetTestNotificationsAtTenantActionGroupResourceLevel")
  @get
  @action("{notificationId}")
  @route("/providers/microsoft.Management/managementGroups/{managementGroupId}/providers/microsoft.Insights/tenantActionGroups/{tenantActionGroupName}/notificationStatus/{notificationId}")
  getTestNotificationsAtTenantActionGroupResourceLevel is TenantActionGroupResourcesOps.ActionSync<
    TenantActionGroupResource,
    void,
    ArmResponse<TestNotificationDetailsResponse>,
    Parameters = {
      /**
       * The tenant ID of the client making the request.
       */
      @header
      `x-ms-client-tenant-id`: string;
    },
    OverrideErrorType = ErrorResponse
  >;
}

@@maxLength(TenantActionGroupResource.name, 260);
@@minLength(TenantActionGroupResource.name, 1);
@@doc(TenantActionGroupResource.name, "The name of the action group.");
@@doc(
  TenantActionGroupResource.properties,
  "The tenant action groups properties of the resource."
);
@@doc(
  TenantActionGroupResources.createOrUpdate::parameters.resource,
  "The tenant action group to create or use for the update."
);
@@doc(
  TenantActionGroupResources.update::parameters.properties,
  "Parameters supplied to the operation."
);
@@doc(
  TenantActionGroupResources.createNotificationsAtTenantActionGroupResourceLevel::parameters.body,
  "The notification request body which includes the contact details"
);
