import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./Server.tsp";
import "./Database.tsp";
import "./ReaderEndpointFeatureRegistration.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Sql;

/** A reader endpoint. */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The SQL project splits generated specifications by feature."
@added(Versions.v2026_11_01_preview)
@parentResource(Server)
@Azure.ResourceManager.Legacy.feature(
  Microsoft.SqlFeatureRegistration.ReaderEndpointFeatures.ReaderEndpoints
)
model ReaderEndpoint is ProxyResource<ReaderEndpointProperties> {
  ...ResourceNameParameter<
    Resource = ReaderEndpoint,
    KeyName = "readerEndpointName",
    SegmentName = "readerEndpoints",
    NamePattern = "^[a-z0-9]+(-*[a-z0-9]+)*$"
  >;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Preserves the generated SQL proxy resource contract. ARM exception approval is required."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The source Swagger defines writable string dictionary tags on this proxy resource. ARM exception approval is required."
  tags?: Record<string>;

  /** Resource location inherited from the parent server. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The source Swagger exposes the parent location as read-only proxy metadata. ARM exception approval is required."
  @visibility(Lifecycle.Read)
  location?: string;
}

/** Provisioning state of the reader endpoint. */
@added(Versions.v2026_11_01_preview)
union ReaderEndpointProvisioningState<T extends string> {
  T,

  /** The reader endpoint has been created. */
  Created: "Created",

  /** An operation is in progress. */
  InProgress: "InProgress",

  /** The last operation succeeded. */
  Succeeded: "Succeeded",

  /** The last operation failed. */
  Failed: "Failed",

  /** The last operation was canceled. */
  Canceled: "Canceled",
}

/** Properties of a reader endpoint. */
@added(Versions.v2026_11_01_preview)
model ReaderEndpointProperties {
  /** Provisioning state of the reader endpoint. */
  @visibility(Lifecycle.Read)
  provisioningState?: ReaderEndpointProvisioningState<string>;

  /** Primary database and server of the reader endpoint. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  readerEndpointPrimaryInfo: ReaderEndpointPrimaryInfo;

  /** List of databases in the reader endpoint. */
  databases?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers/databases";
    }
  ]>[];
}

/** Primary server and database of the reader endpoint. */
@added(Versions.v2026_11_01_preview)
model ReaderEndpointPrimaryInfo {
  /** Resource ID of the reader endpoint's primary database. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  primaryDatabaseId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers/databases";
    }
  ]>;

  /** Resource ID of the reader endpoint's primary server. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  primaryServerId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers";
    }
  ]>;
}

/** A reader endpoint update request. */
@added(Versions.v2026_11_01_preview)
model ReaderEndpointUpdate {
  /** Resource properties. */
  properties?: ReaderEndpointUpdateProperties;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}

/** Properties of a reader endpoint patch. */
@added(Versions.v2026_11_01_preview)
model ReaderEndpointUpdateProperties {
  /** List of databases in the reader endpoint. */
  databases?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers/databases";
    }
  ]>[];
}

/** A list of reader endpoints. */
@added(Versions.v2026_11_01_preview)
model ReaderEndpointListResult {
  /** Array of results. */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: ReaderEndpoint[];

  /** Link to retrieve the next page of results. */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: url;
}

/** Path parameters without adding constraints absent from the source Swagger. */
@added(Versions.v2026_11_01_preview)
model ReaderEndpointPathParameters<Resource extends {}> {
  ...OmitProperties<
    ResourceInstanceParameters<Resource>,
    "serverName" | "readerEndpointName" | "databaseName"
  >;

  /** The name of the server containing the reader endpoint. */
  @path
  @segment("servers")
  serverName: string;

  ...PickProperties<
    ResourceInstanceParameters<Resource>,
    "readerEndpointName" | "databaseName"
  >;
}

/** Manage reader endpoints under a server. */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The SQL project splits generated specifications by feature."
@added(Versions.v2026_11_01_preview)
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(
  Microsoft.SqlFeatureRegistration.ReaderEndpointFeatures.ReaderEndpoints
)
interface ReaderEndpoints {
  /** Gets a reader endpoint. */
  @get
  @autoRoute
  @armResourceRead(ReaderEndpoint)
  get is Azure.ResourceManager.Foundations.ArmReadOperation<
    ReaderEndpointPathParameters<ReaderEndpoint>,
    ArmResponse<ReaderEndpoint>,
    ErrorResponse
  >;

  /** Creates or updates a reader endpoint. */
  @put
  @autoRoute
  @armResourceCreateOrUpdate(ReaderEndpoint)
  @Azure.Core.useFinalStateVia("location")
  createOrUpdate is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ReaderEndpointPathParameters<ReaderEndpoint>,
    ReaderEndpoint,
    Response =
      | (ArmResourceUpdatedResponse<ReaderEndpoint> &
          ArmCombinedLroHeaders<
            FinalResult = ReaderEndpoint,
            FinalUrlValue = url
          > &
          Azure.Core.Foundations.RetryAfterHeader)
      | ArmResourceCreatedResponse<
          ReaderEndpoint,
          ArmCombinedLroHeaders<
            FinalResult = ReaderEndpoint,
            FinalUrlValue = url
          > &
            Azure.Core.Foundations.RetryAfterHeader
        >,
    ErrorResponse = Azure.ResourceManager.ErrorResponse
  >;

  /** Updates a reader endpoint. */
  @autoRoute
  @armResourceUpdate(ReaderEndpoint)
  @Azure.Core.useFinalStateVia("location")
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Foundations.ArmUpdateOperation<
    ReaderEndpointPathParameters<ReaderEndpoint>,
    ReaderEndpointUpdate,
    Response =
      | ArmResponse<ReaderEndpoint>
      | ArmAcceptedLroResponse<
          "The reader endpoint update is in progress.",
          ArmCombinedLroHeaders<
            FinalResult = ReaderEndpoint,
            FinalUrlValue = url
          > &
            Azure.Core.Foundations.RetryAfterHeader
        >,
    ErrorResponse = Azure.ResourceManager.ErrorResponse
  >;

  /** Deletes a reader endpoint. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Preserves the SQL RP contract: completed deletion returns 200, pending deletion returns 202, and an absent resource returns 204. ARM exception approval is required."
  @delete
  @autoRoute
  @armResourceDelete(ReaderEndpoint)
  @Azure.Core.useFinalStateVia("location")
  delete(...ReaderEndpointPathParameters<ReaderEndpoint>):
    | ArmDeletedResponse
    | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders<
        FinalResult = void,
        FinalUrlValue = url
      > &
        Azure.Core.Foundations.RetryAfterHeader>
    | ArmDeletedNoContentResponse
    | ErrorResponse;

  /** Lists the reader endpoints for a server. */
  @get
  @autoRoute
  @list
  @listsResource(ReaderEndpoint)
  @segmentOf(ReaderEndpoint)
  @armResourceList(ReaderEndpoint)
  listByServer is Azure.ResourceManager.Foundations.ArmReadOperation<
    ReaderEndpointPathParameters<Server>,
    ArmResponse<ReaderEndpointListResult>,
    ErrorResponse
  >;
}

/** List reader endpoints for a primary database. */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The SQL project splits generated specifications by feature."
@added(Versions.v2026_11_01_preview)
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(
  Microsoft.SqlFeatureRegistration.ReaderEndpointFeatures.ReaderEndpointsList
)
interface ReaderEndpointsList {
  /** Lists the reader endpoints for a primary server and database. */
  @get
  @autoRoute
  @list
  @listsResource(ReaderEndpoint)
  @segment("readerEndpoints")
  listByDatabase is Azure.ResourceManager.Foundations.ArmReadOperation<
    {
      ...OmitProperties<ReaderEndpointPathParameters<Database>, "databaseName">;

      /** Primary database whose reader endpoints need to be listed. */
      @path
      @segment("databases")
      databaseName: string;
    },
    ArmResponse<ReaderEndpointListResult>,
    ErrorResponse
  >;
}

@@minLength(ReaderEndpoint.name, 1);
@@maxLength(ReaderEndpoint.name, 63);
@@doc(ReaderEndpoint.name, "The name of the reader endpoint.");
@@doc(ReaderEndpoint.properties, "Resource properties.");
@@doc(
  ReaderEndpoints.createOrUpdate::parameters.resource,
  "The reader endpoint parameters."
);
@@doc(
  ReaderEndpoints.update::parameters.properties,
  "The reader endpoint patch parameters."
);
