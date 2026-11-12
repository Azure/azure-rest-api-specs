import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Account.tsp";
import "./ConnectionName.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Microsoft.CognitiveServicesConstraints;

namespace Microsoft.CognitiveServices;

alias ConnectionsListParameters = {
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
};

/**
 * Connection base resource schema.
 */
@parentResource(Account)
model ConnectionPropertiesV2BasicResource is Azure.ResourceManager.ProxyResource<
  ConnectionPropertiesV2,
  false
> {
  /** Friendly name of the connection */
  @key("connectionName")
  @segment("connections")
  @path
  @typeChangedFrom(Versions.v2026_09_15_preview, LegacyConnectionName)
  @typeChangedFrom(Versions.v2026_11_01, ConnectionName)
  name: LegacyConnectionName;
}

/** Connection properties returned by ordinary resource operations. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "The read projection preserves the existing synchronous connection contract, which does not expose provisioningState."
@added(Versions.v2026_11_01)
@discriminator("authType")
model ConnectionPropertiesV2Read {
  ...OmitProperties<ConnectionPropertiesV2, "authType">;

  /** Authentication type of the connection target */
  authType: ConnectionPropertiesV2.authType::type;
}

/** Personal access token connection properties returned by ordinary resource operations. */
@added(Versions.v2026_11_01)
model PatAuthTypeConnectionPropertiesRead extends ConnectionPropertiesV2Read {
  ...PickProperties<PATAuthTypeConnectionProperties, "authType">;
}

/** Managed identity connection properties returned by ordinary resource operations. */
@added(Versions.v2026_11_01)
model ManagedIdentityAuthTypeConnectionPropertiesRead
  extends ConnectionPropertiesV2Read {
  ...PickProperties<
    ManagedIdentityAuthTypeConnectionProperties,
    "credentials" | "authType"
  >;
}

/** Username and password connection properties returned by ordinary resource operations. */
@added(Versions.v2026_11_01)
model UsernamePasswordAuthTypeConnectionPropertiesRead
  extends ConnectionPropertiesV2Read {
  ...PickProperties<UsernamePasswordAuthTypeConnectionProperties, "authType">;

  /** Nonsensitive authentication metadata. */
  credentials?: ConnectionUsernamePasswordRead;
}

/** Username metadata returned without the password or security token. */
@added(Versions.v2026_11_01)
model ConnectionUsernamePasswordRead is PickProperties<
  ConnectionUsernamePassword,
  "username"
>;

/** Unauthenticated connection properties returned by ordinary resource operations. */
@added(Versions.v2026_11_01)
model NoneAuthTypeConnectionPropertiesRead extends ConnectionPropertiesV2Read {
  ...PickProperties<NoneAuthTypeConnectionProperties, "authType">;
}

/** Shared access signature connection properties returned by ordinary resource operations. */
@added(Versions.v2026_11_01)
model SasAuthTypeConnectionPropertiesRead extends ConnectionPropertiesV2Read {
  ...PickProperties<SASAuthTypeConnectionProperties, "authType">;
}

/** Account key connection properties returned by ordinary resource operations. */
@added(Versions.v2026_11_01)
model AccountKeyAuthTypeConnectionPropertiesRead
  extends ConnectionPropertiesV2Read {
  ...PickProperties<AccountKeyAuthTypeConnectionProperties, "authType">;
}

/** Service principal connection properties returned by ordinary resource operations. */
@added(Versions.v2026_11_01)
model ServicePrincipalAuthTypeConnectionPropertiesRead
  extends ConnectionPropertiesV2Read {
  ...PickProperties<ServicePrincipalAuthTypeConnectionProperties, "authType">;

  /** Nonsensitive authentication metadata. */
  credentials?: ConnectionServicePrincipalRead;
}

/** Service principal identifiers returned without the client secret. */
@added(Versions.v2026_11_01)
model ConnectionServicePrincipalRead is PickProperties<
  ConnectionServicePrincipal,
  "clientId" | "tenantId"
>;

/** Access key connection properties returned by ordinary resource operations. */
@added(Versions.v2026_11_01)
model AccessKeyAuthTypeConnectionPropertiesRead
  extends ConnectionPropertiesV2Read {
  ...PickProperties<AccessKeyAuthTypeConnectionProperties, "authType">;

  /** Nonsensitive authentication metadata. */
  credentials?: ConnectionAccessKeyRead;
}

/** Access key identifier returned without the secret access key. */
@added(Versions.v2026_11_01)
model ConnectionAccessKeyRead is PickProperties<
  ConnectionAccessKey,
  "accessKeyId"
>;

/** API key connection properties returned by ordinary resource operations. */
@added(Versions.v2026_11_01)
model ApiKeyAuthConnectionPropertiesRead extends ConnectionPropertiesV2Read {
  ...PickProperties<ApiKeyAuthConnectionProperties, "authType">;
}

/** Custom-key connection properties returned without stored credentials. */
@added(Versions.v2026_11_01)
model CustomKeysConnectionPropertiesRead extends ConnectionPropertiesV2Read {
  /** Authentication type of the connection target. */
  authType: "CustomKeys";
}

/** OAuth connection properties returned by ordinary resource operations. */
@added(Versions.v2026_11_01)
model Oauth2AuthTypeConnectionPropertiesRead
  extends ConnectionPropertiesV2Read {
  ...PickProperties<OAuth2AuthTypeConnectionProperties, "authType">;

  /** Nonsensitive authentication metadata. */
  credentials?: ConnectionOauth2Read;
}

/** OAuth identifiers and endpoint metadata returned without credential values. */
@added(Versions.v2026_11_01)
model ConnectionOauth2Read is PickProperties<
  ConnectionOAuth2,
  "authUrl" | "clientId" | "tenantId" | "username"
>;

/** Microsoft Entra connection properties returned by ordinary resource operations. */
@added(Versions.v2026_11_01)
model AadAuthTypeConnectionPropertiesRead extends ConnectionPropertiesV2Read {
  ...PickProperties<AADAuthTypeConnectionProperties, "authType">;
}

/** A connection returned by ordinary resource operations. */
@added(Versions.v2026_11_01)
@parentResource(Account)
model ConnectionPropertiesV2BasicResourceRead is Azure.ResourceManager.ProxyResource<
  ConnectionPropertiesV2Read,
  false
> {
  /** Friendly name of the connection. */
  @key("connectionName")
  @segment("connections")
  @path
  @visibility(Lifecycle.Read)
  name: LegacyConnectionName;
}

@doc("Azure operation completed successfully.")
model ConnectionReadResult<Resource extends Azure.ResourceManager.Foundations.SimpleResource> {
  ...OkResponse;

  @doc("The body type of the operation request or response.")
  @bodyRoot
  @typeChangedFrom(Versions.v2026_11_01, Resource)
  body: ConnectionPropertiesV2BasicResourceRead;
}

@doc("Resource '{name}' update operation succeeded", Resource)
model ConnectionUpdatedResult<Resource extends Azure.ResourceManager.Foundations.SimpleResource>
  is ConnectionReadResult<Resource>;

alias ConnectionListResult = ArmResponse<ConnectionPropertiesV2BasicResourceArmPaginatedResult>;
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
        @typeChangedFrom(Versions.v2026_09_15_preview, LegacyConnectionName)
        @typeChangedFrom(Versions.v2026_11_01, ConnectionName)
        connectionName: LegacyConnectionName,
      },
      ResourceName = "CognitiveServicesConnection"
    > {}

@armResourceOperations(#{ omitTags: true })
interface ConnectionPropertiesV2BasicResources {
  /**
   * Lists Cognitive Services account connection by name.
   */
  @tag("AccountConnectionResource")
  get is ConnectionPropertiesV2BasicResourceOps.Read<
    ConnectionPropertiesV2BasicResource,
    Response = ConnectionReadResult<ConnectionPropertiesV2BasicResource>
  >;

  /**
   * Create or update Cognitive Services account connection under the specified account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "PUT response codes for 'get' match existing service endpoint behavior"
  @tag("AccountConnectionResource")
  create is ConnectionPropertiesV2BasicResourceOps.CreateOrUpdateSync<
    ConnectionPropertiesV2BasicResource,
    Response = ConnectionUpdatedResult<ConnectionPropertiesV2BasicResource>,
    OptionalRequestBody = true
  >;

  /**
   * Update Cognitive Services account connection under the specified account.
   */
  @tag("AccountConnectionResource")
  @patch(#{ implicitOptionality: false })
  update is ConnectionPropertiesV2BasicResourceOps.CustomPatchSync<
    ConnectionPropertiesV2BasicResource,
    PatchModel = ConnectionUpdateContent,
    Response = ConnectionReadResult<ConnectionPropertiesV2BasicResource>,
    OptionalRequestBody = true
  >;

  /**
   * Delete Cognitive Services account connection by name.
   */
  @tag("AccountConnectionResource")
  delete is ConnectionPropertiesV2BasicResourceOps.DeleteSync<ConnectionPropertiesV2BasicResource>;

  /**
   * Lists all the available  Cognitive Services account connections under the specified account.
   */
  @tag("AccountConnectionResource")
  list is ConnectionPropertiesV2BasicResourceOps.List<
    ConnectionPropertiesV2BasicResource,
    Parameters = ConnectionsListParameters,
    Response = ConnectionListResult
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
        @typeChangedFrom(Versions.v2026_09_15_preview, LegacyConnectionName)
        @typeChangedFrom(Versions.v2026_11_01, ConnectionName)
        connectionName: LegacyConnectionName,
      },
      ResourceName = "CognitiveServicesProjectConnection"
    > {}

@armResourceOperations(#{ omitTags: true })
interface ProjectConnections {
  /**
   * Lists Cognitive Services project connection by name.
   */
  @tag("ProjectConnectionResource")
  get is ProjectConnectionOps.Read<
    ConnectionPropertiesV2BasicResource,
    Response = ConnectionReadResult<ConnectionPropertiesV2BasicResource>
  >;

  /**
   * Create or update Cognitive Services project connection under the specified project.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "PUT response codes for 'get' match existing service endpoint behavior"
  @tag("ProjectConnectionResource")
  create is ProjectConnectionOps.CreateOrUpdateSync<
    ConnectionPropertiesV2BasicResource,
    Response = ConnectionUpdatedResult<ConnectionPropertiesV2BasicResource>,
    OptionalRequestBody = true
  >;

  /**
   * Update Cognitive Services project connection under the specified project.
   */
  @tag("ProjectConnectionResource")
  @patch(#{ implicitOptionality: false })
  update is ProjectConnectionOps.CustomPatchSync<
    ConnectionPropertiesV2BasicResource,
    PatchModel = ConnectionUpdateContent,
    Response = ConnectionReadResult<ConnectionPropertiesV2BasicResource>,
    OptionalRequestBody = true
  >;

  /**
   * Delete Cognitive Services project connection by name.
   */
  @tag("ProjectConnectionResource")
  delete is ProjectConnectionOps.DeleteSync<ConnectionPropertiesV2BasicResource>;

  /**
   * Lists all the available Cognitive Services project connections under the specified project.
   */
  @tag("ProjectConnectionResource")
  list is ProjectConnectionOps.List<
    ConnectionPropertiesV2BasicResource,
    Parameters = ConnectionsListParameters,
    Response = ConnectionListResult
  >;
}

@@doc(
  ConnectionPropertiesV2BasicResource.name,
  "Friendly name of the connection"
);
@@doc(
  ConnectionPropertiesV2BasicResource.properties,
  "Connection property base schema."
);
@@doc(
  ConnectionPropertiesV2BasicResources.create::parameters.resource,
  "The object for creating or updating a new account connection"
);
@@doc(
  ConnectionPropertiesV2BasicResources.update::parameters.properties,
  "Parameters for account connection update."
);
@@doc(
  ProjectConnections.create::parameters.resource,
  "The object for creating or updating a new account connection"
);
@@doc(
  ProjectConnections.update::parameters.properties,
  "Parameters for account connection update."
);
@@summary(
  ConnectionPropertiesV2BasicResources.list,
  "Lists all the available  Cognitive Services account connections under the specified account."
);
@@summary(
  ConnectionPropertiesV2BasicResources.get,
  "Lists Cognitive Services account connection by name."
);
@@summary(
  ConnectionPropertiesV2BasicResources.create,
  "Create or update Cognitive Services account connection under the specified account."
);
@@summary(
  ConnectionPropertiesV2BasicResources.update,
  "Update Cognitive Services account connection under the specified account."
);
@@summary(
  ConnectionPropertiesV2BasicResources.delete,
  "Delete Cognitive Services account connection by name."
);
@@summary(
  ProjectConnections.list,
  "Lists all the available Cognitive Services project connections under the specified project."
);
@@summary(
  ProjectConnections.get,
  "Lists Cognitive Services project connection by name."
);
@@summary(
  ProjectConnections.create,
  "Create or update Cognitive Services project connection under the specified project."
);
@@summary(
  ProjectConnections.update,
  "Update Cognitive Services project connection under the specified project."
);
@@summary(
  ProjectConnections.delete,
  "Delete Cognitive Services project connection by name."
);
