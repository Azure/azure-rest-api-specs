import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Connection base resource schema.
 */
@parentResource(Account)
model ConnectionPropertiesV2BasicResource
  is Azure.ResourceManager.ProxyResource<ConnectionPropertiesV2, false> {
  ...ResourceNameParameter<
    Resource = ConnectionPropertiesV2BasicResource,
    KeyName = "connectionName",
    SegmentName = "connections",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$"
  >;
}

@armResourceOperations
interface ConnectionPropertiesV2BasicResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of Cognitive Services account. */
        @path
        @segment("accounts")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        @minLength(2)
        @maxLength(64)
        accountName: string,
      },
      {
        /** Friendly name of the connection */
        @path
        @segment("connections")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
        connectionName: string,
      }
    > {}

@armResourceOperations
interface ConnectionPropertiesV2BasicResources {
  /**
   * Lists Cognitive Services account connection by name.
   */
  get is ConnectionPropertiesV2BasicResourceOps.Read<ConnectionPropertiesV2BasicResource>;

  /**
   * Create or update Cognitive Services account connection under the specified account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ConnectionPropertiesV2BasicResourceOps.CreateOrUpdateSync<
    ConnectionPropertiesV2BasicResource,
    Response = ArmResourceUpdatedResponse<ConnectionPropertiesV2BasicResource>,
    OptionalRequestBody = true
  >;

  /**
   * Update Cognitive Services account connection under the specified account.
   */
  @patch(#{ implicitOptionality: false })
  update is ConnectionPropertiesV2BasicResourceOps.CustomPatchSync<
    ConnectionPropertiesV2BasicResource,
    PatchModel = ConnectionUpdateContent,
    OptionalRequestBody = true
  >;

  /**
   * Delete Cognitive Services account connection by name.
   */
  delete is ConnectionPropertiesV2BasicResourceOps.DeleteSync<ConnectionPropertiesV2BasicResource>;

  /**
   * Lists all the available  Cognitive Services account connections under the specified account.
   */
  list is ConnectionPropertiesV2BasicResourceOps.List<
    ConnectionPropertiesV2BasicResource,
    Parameters = {
      /**
       * Target of the connection.
       */
      @query("target")
      target?: string;

      /**
       * Category of the connection.
       */
      @query("category")
      category?: string;

      /**
       * query parameter that indicates if get connection call should return both connections and datastores
       */
      @query("includeAll")
      includeAll?: boolean = false;
    },
    Response = ArmResponse<ConnectionPropertiesV2BasicResourceArmPaginatedResult>
  >;
}
@armResourceOperations
interface ProjectConnectionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of Cognitive Services account. */
        @path
        @segment("accounts")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        @minLength(2)
        @maxLength(64)
        accountName: string,

        /** The name of Cognitive Services account's project. */
        @path
        @segment("projects")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        @minLength(2)
        @maxLength(64)
        projectName: string,
      },
      {
        /** Friendly name of the connection */
        @path
        @segment("connections")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
        connectionName: string,
      }
    > {}

@armResourceOperations
interface ProjectConnections {
  /**
   * Lists Cognitive Services project connection by name.
   */
  get is ProjectConnectionOps.Read<ConnectionPropertiesV2BasicResource>;

  /**
   * Create or update Cognitive Services project connection under the specified project.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is ProjectConnectionOps.CreateOrUpdateSync<
    ConnectionPropertiesV2BasicResource,
    Response = ArmResourceUpdatedResponse<ConnectionPropertiesV2BasicResource>,
    OptionalRequestBody = true
  >;

  /**
   * Update Cognitive Services project connection under the specified project.
   */
  @patch(#{ implicitOptionality: false })
  update is ProjectConnectionOps.CustomPatchSync<
    ConnectionPropertiesV2BasicResource,
    PatchModel = ConnectionUpdateContent,
    OptionalRequestBody = true
  >;

  /**
   * Delete Cognitive Services project connection by name.
   */
  delete is ProjectConnectionOps.DeleteSync<ConnectionPropertiesV2BasicResource>;

  /**
   * Lists all the available Cognitive Services project connections under the specified project.
   */
  list is ProjectConnectionOps.List<
    ConnectionPropertiesV2BasicResource,
    Parameters = {
      /**
       * Target of the connection.
       */
      @query("target")
      target?: string;

      /**
       * Category of the connection.
       */
      @query("category")
      category?: string;

      /**
       * query parameter that indicates if get connection call should return both connections and datastores
       */
      @query("includeAll")
      includeAll?: boolean = false;
    },
    Response = ArmResponse<ConnectionPropertiesV2BasicResourceArmPaginatedResult>
  >;
}

@@doc(ConnectionPropertiesV2BasicResource.name,
  "Friendly name of the connection"
);
@@doc(ConnectionPropertiesV2BasicResource.properties,
  "Connection property base schema."
);
@@doc(ConnectionPropertiesV2BasicResources.create::parameters.resource,
  "The object for creating or updating a new account connection"
);
@@doc(ConnectionPropertiesV2BasicResources.update::parameters.properties,
  "Parameters for account connection update."
);
@@doc(ProjectConnections.create::parameters.resource,
  "The object for creating or updating a new account connection"
);
@@doc(ProjectConnections.update::parameters.properties,
  "Parameters for account connection update."
);
@@summary(ConnectionPropertiesV2BasicResources.list,
  "Lists all the available  Cognitive Services account connections under the specified account."
);
@@summary(ConnectionPropertiesV2BasicResources.get,
  "Lists Cognitive Services account connection by name."
);
@@summary(ConnectionPropertiesV2BasicResources.create,
  "Create or update Cognitive Services account connection under the specified account."
);
@@summary(ConnectionPropertiesV2BasicResources.update,
  "Update Cognitive Services account connection under the specified account."
);
@@summary(ConnectionPropertiesV2BasicResources.delete,
  "Delete Cognitive Services account connection by name."
);
@@summary(ProjectConnections.list,
  "Lists all the available Cognitive Services project connections under the specified project."
);
@@summary(ProjectConnections.get,
  "Lists Cognitive Services project connection by name."
);
@@summary(ProjectConnections.create,
  "Create or update Cognitive Services project connection under the specified project."
);
@@summary(ProjectConnections.update,
  "Update Cognitive Services project connection under the specified project."
);
@@summary(ProjectConnections.delete,
  "Delete Cognitive Services project connection by name."
);
