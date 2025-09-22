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
        serviceName: string,
      },
      {
        /** Group identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("groups")
        @key
        groupId: string,
      }
    > {}

@armResourceOperations
interface GroupContracts {
  /**
   * Gets the details of the group specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Group_Get")
  get is GroupContractOps.Read<GroupContract>;

  /**
   * Gets the entity state (Etag) version of the group specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Group_GetEntityTag")
  getEntityTag is GroupContractOps.CheckExistence<GroupContract>;

  /**
   * Creates or Updates a group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Group_CreateOrUpdate")
  createOrUpdate is GroupContractOps.CreateOrUpdateSync<
    GroupContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Updates the details of the group specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Group_Update")
  @patch(#{ implicitOptionality: false })
  update is GroupContractOps.CustomPatchSync<
    GroupContract,
    PatchModel = GroupUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Deletes specific group of the API Management service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Group_Delete")
  delete is GroupContractOps.DeleteSync<
    GroupContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Lists a collection of groups defined within a service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Group_ListByService")
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
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<GroupCollection>
  >;

  /**
   * Lists a collection of user entities associated with the group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GroupUser_List")
  @get
  @action("users")
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
      @query("$skip")
      $skip?: int32;
    }
  >;

  /**
   * Checks that user entity specified by identifier is associated with the group entity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GroupUser_CheckEntityExists")
  @head
  @action("{userId}")
  checkEntityExists is GroupContractOps.ActionSync<
    GroupContract,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * User identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(80)
      @minLength(1)
      @path
      userId: string;
    }
  >;

  /**
   * Add existing user to existing group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GroupUser_Create")
  @put
  @action("{userId}")
  create is GroupContractOps.ActionSync<
    GroupContract,
    void,
    ArmResponse<UserContract> | ArmResourceCreatedSyncResponse<UserContract>,
    Parameters = {
      /**
       * User identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(80)
      @minLength(1)
      @path
      userId: string;
    }
  >;

  /**
   * Remove existing user from existing group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GroupUser_Delete")
  @delete
  @action("{userId}")
  groupUserDelete is GroupContractOps.ActionSync<
    GroupContract,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * User identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(80)
      @minLength(1)
      @path
      userId: string;
    }
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
        serviceName: string,

        /** Workspace identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[^*#&+:<>?]+$")
        workspaceId: string,
      },
      {
        /** Group identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("groups")
        @key
        groupId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceGroup {
  /**
   * Gets the details of the group specified by its identifier.
   */
  get is WorkspaceGroupOps.Read<GroupContract>;

  /**
   * Gets the entity state (Etag) version of the group specified by its identifier.
   */
  getEntityTag is WorkspaceGroupOps.CheckExistence<GroupContract>;

  /**
   * Creates or Updates a group.
   */
  createOrUpdate is WorkspaceGroupOps.CreateOrUpdateSync<
    GroupContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
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
      @header
      `If-Match`: string;
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
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Lists a collection of groups defined within a workspace in a service instance.
   */
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
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<GroupCollection>
  >;

  /**
   * Lists a collection of user entities associated with the group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceGroupUser_List")
  @get
  @action("users")
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
      @query("$skip")
      $skip?: int32;
    }
  >;

  /**
   * Checks that user entity specified by identifier is associated with the group entity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceGroupUser_CheckEntityExists")
  @head
  @action("{userId}")
  checkEntityExists is WorkspaceGroupOps.ActionSync<
    GroupContract,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * User identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(80)
      @minLength(1)
      @path
      userId: string;
    }
  >;

  /**
   * Add existing user to existing group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceGroupUser_Create")
  @put
  @action("{userId}")
  create is WorkspaceGroupOps.ActionSync<
    GroupContract,
    void,
    ArmResponse<UserContract> | ArmResourceCreatedSyncResponse<UserContract>,
    Parameters = {
      /**
       * User identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(80)
      @minLength(1)
      @path
      userId: string;
    }
  >;

  /**
   * Remove existing user from existing group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceGroupUser_Delete")
  @delete
  @action("{userId}")
  workspaceGroupUserDelete is WorkspaceGroupOps.ActionSync<
    GroupContract,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * User identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(80)
      @minLength(1)
      @path
      userId: string;
    }
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
