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

/** A reader endpoint. Its location must match the location of its parent server. */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The SQL project splits its specifications by legacy feature."
@added(Versions.v2026_11_01_preview)
@parentResource(Server)
@Azure.ResourceManager.Legacy.feature(
  Microsoft.SqlFeatureRegistration.ReaderEndpointFeatures.ReaderEndpoints
)
model ReaderEndpoint is TrackedResource<ReaderEndpointProperties> {
  ...ResourceNameParameter<
    Resource = ReaderEndpoint,
    KeyName = "readerEndpointName",
    SegmentName = "readerEndpoints",
    NamePattern = "^[a-z0-9]+(-*[a-z0-9]+)*$"
  >;
}

/** Primary server and database of a reader endpoint. */
@added(Versions.v2026_11_01_preview)
model ReaderEndpointPrimaryInfo {
  /** The ARM resource ID of the primary database. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  primaryDatabaseId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers/databases";
    }
  ]>;

  /** The ARM resource ID of the primary server. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  primaryServerId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Sql/servers";
    }
  ]>;
}

/** The provisioning state of a reader endpoint. */
@added(Versions.v2026_11_01_preview)
union ReaderEndpointProvisioningState<T extends string> {
  T,

  /** The reader endpoint has been created. */
  Created: "Created",

  /** An operation on the reader endpoint is in progress. */
  InProgress: "InProgress",

  /** The last operation on the reader endpoint succeeded. */
  Succeeded: "Succeeded",

  /** The last operation on the reader endpoint failed. */
  Failed: "Failed",

  /** The last operation on the reader endpoint was canceled. */
  Canceled: "Canceled",
}

/** Properties of a reader endpoint. */
@added(Versions.v2026_11_01_preview)
model ReaderEndpointProperties {
  /** The status of the last operation on the reader endpoint. */
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
  @Azure.Core.useFinalStateVia("location")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
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
        >
  >;

  /** Updates a reader endpoint. */
  @Azure.Core.useFinalStateVia("location")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ReaderEndpoint,
    PatchModel = ReaderEndpointUpdate,
    LroHeaders = ArmCombinedLroHeaders<
      FinalResult = ReaderEndpoint,
      FinalUrlValue = url
    > &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /** Deletes a reader endpoint. */
  @Azure.Core.useFinalStateVia("location")
  delete is ArmResourceDeleteWithoutOkAsync<
    ReaderEndpoint,
    LroHeaders = ArmCombinedLroHeaders<
      FinalResult = void,
      FinalUrlValue = url
    > &
      Azure.Core.Foundations.RetryAfterHeader
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
@@minLength(ReaderEndpoint.name, 1);
@@maxLength(ReaderEndpoint.name, 63);
@@doc(ReaderEndpoint.properties, "Resource properties.");
@@doc(
  ReaderEndpoints.createOrUpdate::parameters.resource,
  "The reader endpoint parameters."
);
@@doc(
  ReaderEndpoints.update::parameters.properties,
  "The reader endpoint patch parameters."
);
