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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The SQL project splits its specifications by legacy feature."
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
    NamePattern = ""
  >;

  /** Resource location. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The existing reader endpoint proxy resource returns its server location."
  @visibility(Lifecycle.Read)
  location?: string;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The existing reader endpoint proxy resource accepts tags."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Resource tags are an existing string dictionary."
  tags?: Record<string>;
}

/** Primary server and database of a reader endpoint. */
@added(Versions.v2026_11_01_preview)
model ReaderEndpointPrimaryInfo {
  /** Primary database of the reader endpoint. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  primaryDatabase: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers/databases";
    }
  ]>;

  /** Primary server of the reader endpoint. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  primaryServer: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers";
    }
  ]>;
}

/** Properties of a reader endpoint. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "The existing API exposes completion through Location polling, not a provisioningState property."
@added(Versions.v2026_11_01_preview)
model ReaderEndpointProperties {
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

/** A reader endpoint update request. */
@added(Versions.v2026_11_01_preview)
model ReaderEndpointUpdate {
  /** Resource properties. */
  properties?: ReaderEndpointUpdateProperties;

  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Resource tags are an existing string dictionary."
  tags?: Record<string>;
}

/** Properties of a reader endpoint patch. */
@added(Versions.v2026_11_01_preview)
model ReaderEndpointUpdateProperties {
  /** List of databases in the reader endpoint. */
  databases: Azure.Core.armResourceIdentifier<[
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
  nextLink?: string;
}

/** Manage reader endpoints under a server. */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The SQL project splits its specifications by legacy feature."
@added(Versions.v2026_11_01_preview)
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(
  Microsoft.SqlFeatureRegistration.ReaderEndpointFeatures.ReaderEndpoints
)
interface ReaderEndpoints {
  /** Gets a reader endpoint. */
  get is ArmResourceRead<ReaderEndpoint>;

  /** Creates or updates a reader endpoint. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The existing PUT returns 200 or 201 on completion and 202 with Location while pending."
  @Azure.Core.useFinalStateVia("location")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ReaderEndpoint,
    Response =
      | ArmResourceUpdatedResponse<ReaderEndpoint>
      | ArmResourceCreatedSyncResponse<ReaderEndpoint>
      | ArmAcceptedLroResponse<
          "Accepted the request",
          ArmLroLocationHeader<FinalResult = ReaderEndpoint>
        >
  >;

  /** Updates a reader endpoint. */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ReaderEndpoint,
    PatchModel = ReaderEndpointUpdate,
    LroHeaders = ArmLroLocationHeader<FinalResult = ReaderEndpoint>
  >;

  /** Deletes a reader endpoint. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "The existing DELETE returns 200, 202 with Location, or 204 when the endpoint does not exist."
  delete is ArmResourceDeleteWithoutOkAsync<
    ReaderEndpoint,
    Response =
      | ArmDeletedResponse
      | ArmAcceptedLroResponse<
          "Accepted the request",
          ArmLroLocationHeader<FinalResult = void>
        >
      | ArmDeletedNoContentResponse
  >;

  /** Lists the reader endpoints for a server. */
  listByServer is ArmResourceListByParent<
    ReaderEndpoint,
    Response = ArmResponse<ReaderEndpointListResult>
  >;
}

/** List reader endpoints associated with a primary database. */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The SQL project splits its specifications by legacy feature."
@added(Versions.v2026_11_01_preview)
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(
  Microsoft.SqlFeatureRegistration.ReaderEndpointFeatures.ReaderEndpointsList
)
interface ReaderEndpointsList {
  /** Lists the reader endpoints for a database. */
  @get
  @autoRoute
  @list
  @listsResource(ReaderEndpoint)
  @segmentOf(ReaderEndpoint)
  @armResourceList(ReaderEndpoint)
  listByDatabase is Azure.ResourceManager.Foundations.ArmReadOperation<
    ResourceInstanceParameters<Database>,
    ArmResponse<ReaderEndpointListResult>,
    ErrorResponse
  >;
}

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
