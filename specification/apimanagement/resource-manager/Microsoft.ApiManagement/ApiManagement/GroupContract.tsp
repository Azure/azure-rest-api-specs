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
 * Contract details.
 */
@parentResource(ApiManagementServiceResource)
model GroupContract
  is Azure.ResourceManager.ProxyResource<GroupContractProperties> {
  ...ResourceNameParameter<
    Resource = GroupContract,
    KeyName = "groupId",
    SegmentName = "groups",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GroupContractOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,
      },
      {
        /** Group identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("groups")
        @key
        @minLength(1)
        @maxLength(256)
        groupId: string,
      }
    > {}

alias GroupUserParentParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /** The name of the API Management service. */
  @path
  @segment("service")
  @key
  @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
  @minLength(1)
  @maxLength(50)
  serviceName: string;

  /** Group identifier. Must be unique in the current API Management service instance. */
  @path
  @segment("groups")
  @key
  @minLength(1)
  @maxLength(256)
  groupId: string;
};

alias GroupUserParameters = {
  /**
   * User identifier. Must be unique in the current API Management service instance.
   */
  @path
  @segment("users")
  @key
  @minLength(1)
  @maxLength(80)
  userId: string;
};

alias GroupUserOps = Azure.ResourceManager.Legacy.RoutedOperations<
  GroupUserParentParameters,
  GroupUserParameters,
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/groups/{groupId}/users",
  }
>;

alias WorkspaceGroupUserParentParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /** The name of the API Management service. */
  @path
  @segment("service")
  @key
  @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
  @minLength(1)
  @maxLength(50)
  serviceName: string;

  /**
   * Workspace identifier. Must be unique in the current API Management service instance.
   */
  @path
  @key
  @segment("workspaces")
  @minLength(1)
  @maxLength(80)
  @pattern("^[^*#&+:<>?]+$")
  workspaceId: string;

  /** Group identifier. Must be unique in the current API Management service instance. */
  @path
  @segment("groups")
  @key
  @minLength(1)
  @maxLength(256)
  groupId: string;
};

alias WorkspaceGroupUserParameters = {
  /**
   * User identifier. Must be unique in the current API Management service instance.
   */
  @path
  @key
  @segment("users")
  @minLength(1)
  @maxLength(80)
  userId: string;
};

alias WorkspaceGroupUserOps = Azure.ResourceManager.Legacy.RoutedOperations<
  WorkspaceGroupUserParentParameters,
  WorkspaceGroupUserParameters,
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.ApiManagement/service/{serviceName}/workspaces/{workspaceId}/groups/{groupId}/users",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface GroupContracts {
  /**
   * Gets the details of the group specified by its identifier.
   */
  get is GroupContractOps.Read<
    GroupContract,
    Response = ArmResponse<GroupContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the group specified by its identifier.
   */
  getEntityTag is GroupContractOps.CheckExistence<
    GroupContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or Updates a group.
   */
  createOrUpdate is GroupContractOps.CreateOrUpdateSync<
    GroupContract,
    Request = GroupCreateParameters,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<GroupContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmCreatedResponse<GroupContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the details of the group specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is GroupContractOps.CustomPatchSync<
    GroupContract,
    PatchModel = GroupUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<GroupContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes specific group of the API Management service instance.
   */
  delete is GroupContractOps.DeleteSync<
    GroupContract,
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
   * Lists a collection of groups defined within a service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-create-groups")
  listByService is GroupContractOps.List<
    GroupContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| externalId | filter | eq |     |</br>
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
    Response = ArmResponse<GroupCollection>
  >;

  /**
   * Lists a collection of user entities associated with the group.
   */
  @get
  @action("users")
  @list
  list is GroupContractOps.ActionSync<
    GroupContract,
    void,
    ArmResponse<UserCollection>,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| firstName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| lastName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| email | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| registrationDate | filter | ge, le, eq, ne, gt, lt |     |</br>| note | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
   * Checks that user entity specified by identifier is associated with the group entity.
   */
  @head
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/groups/{groupId}/users/{userId}")
  checkEntityExists is GroupUserOps.ActionSync<
    GroupContract,
    void,
    Response = NoContentResponse | NotFoundResponse
  >;

  /**
   * Add existing user to existing group
   */
  @put
  create is GroupContractOps.CreateOrUpdateSync<
    GroupContract,
    Request = void,
    Response = ArmResponse<UserContract> | ArmResourceCreatedSyncResponse<UserContract>,
    Parameters = {
      /**
       * User identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(80)
      @minLength(1)
      @path
      @segment("users")
      userId: string;
    }
  >;

  /**
   * Remove existing user from existing group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/groups/{groupId}/users/{userId}")
  groupUserDelete is GroupUserOps.ActionSync<
    GroupContract,
    void,
    Response = OkResponse | NoContentResponse
  >;
}
@armResourceOperations
interface WorkspaceGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,

        /** Workspace identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        workspaceId: string,
      },
      {
        /** Group identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("groups")
        @key
        @minLength(1)
        @maxLength(256)
        groupId: string,
      }
    > {}

@armResourceOperations(#{ allowStaticRoutes: true })
interface WorkspaceGroup {
  /**
   * Gets the details of the group specified by its identifier.
   */
  get is WorkspaceGroupOps.Read<
    GroupContract,
    Response = ArmResponse<GroupContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the group specified by its identifier.
   */
  getEntityTag is WorkspaceGroupOps.CheckExistence<
    GroupContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or Updates a group.
   */
  createOrUpdate is WorkspaceGroupOps.CreateOrUpdateSync<
    GroupContract,
    Request = GroupCreateParameters,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<GroupContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<GroupContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the details of the group specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is WorkspaceGroupOps.CustomPatchSync<
    GroupContract,
    PatchModel = GroupUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<GroupContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes specific group of the workspace in an API Management service instance.
   */
  delete is WorkspaceGroupOps.DeleteSync<
    GroupContract,
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
   * Lists a collection of groups defined within a workspace in a service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-create-groups")
  listByService is WorkspaceGroupOps.List<
    GroupContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| externalId | filter | eq |     |</br>
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
    Response = ArmResponse<GroupCollection>
  >;

  /**
   * Lists a collection of user entities associated with the group.
   */
  @get
  @action("users")
  @list
  list is WorkspaceGroupOps.ActionSync<
    GroupContract,
    void,
    ArmResponse<UserCollection>,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| firstName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| lastName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| email | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| registrationDate | filter | ge, le, eq, ne, gt, lt |     |</br>| note | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
   * Checks that user entity specified by identifier is associated with the group entity.
   */
  @head
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/workspaces/{workspaceId}/groups/{groupId}/users/{userId}")
  checkEntityExists is WorkspaceGroupUserOps.ActionSync<
    GroupContract,
    void,
    Response = NoContentResponse | NotFoundResponse
  >;

  /**
   * Add existing user to existing group
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @put
  create is WorkspaceGroupOps.CreateOrUpdateSync<
    GroupContract,
    Request = void,
    Response = ArmResponse<UserContract> | ArmResourceCreatedSyncResponse<UserContract>,
    Parameters = {
      /**
       * User identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(80)
      @minLength(1)
      @path
      @segment("users")
      userId: string;
    }
  >;

  /**
   * Remove existing user from existing group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}/workspaces/{workspaceId}/groups/{groupId}/users/{userId}")
  workspaceGroupUserDelete is WorkspaceGroupUserOps.ActionSync<
    GroupContract,
    void,
    Response = OkResponse | NoContentResponse
  >;
}

@@maxLength(GroupContract.name, 256);
@@minLength(GroupContract.name, 1);
@@doc(GroupContract.name,
  "Group identifier. Must be unique in the current API Management service instance."
);
@@doc(GroupContract.properties, "Group entity contract properties.");
@@doc(GroupContracts.createOrUpdate::parameters.resource, "Create parameters.");
@@doc(GroupContracts.update::parameters.properties, "Update parameters.");
@@doc(WorkspaceGroup.createOrUpdate::parameters.resource, "Create parameters.");
@@doc(WorkspaceGroup.update::parameters.properties, "Update parameters.");
