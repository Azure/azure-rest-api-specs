import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

using Microsoft.Discovery.Common;

@versioned(Microsoft.Discovery.Workspace.Versions)
namespace Microsoft.Discovery.Workspace;

@doc("Status")
union InvestigationStatus {
  /** Investigation Created */
  Created: "Created",

  /** Investigation Validated */
  Validated: "Validated",

  /** Investigation Failed */
  Failed: "Failed",

  string,
}

@doc("A investigation list item.")
@resource("investigations")
@parentResource(Project)
model Investigation {
  @doc("The investigation name.")
  @visibility(Lifecycle.Read)
  @key("investigationName")
  @maxLength(24)
  @pattern(resourceNamePattern)
  name: string;

  @doc("The parent project name.")
  @visibility(Lifecycle.Read)
  @maxLength(24)
  @pattern(resourceNamePattern)
  projectName: string;

  ...DataPlaneResource;
  ...WithStatus<InvestigationStatus>;
  ...WithOptionalDescription;
  ...WithTags;
  ...WithOptionalTitle;
}

@doc("Collection of data assets linked to an investigation.")
@removed(Versions.`2026-02-01-preview`)
model InvestigationDataAssets {
  @doc("List of linked data asset IDs.")
  dataAssetIds: DataAssetId[];
}

@doc("Request body for linking a data asset to an investigation.")
@removed(Versions.`2026-02-01-preview`)
model LinkDataAssetRequest {
  @doc("The data asset resource ID to link.")
  dataAssetId: DataAssetId;
}

@doc("Request body for unlinking a data asset from an investigation.")
@removed(Versions.`2026-02-01-preview`)
model UnlinkDataAssetRequest {
  @doc("The data asset resource ID to unlink.")
  dataAssetId: DataAssetId;
}

@doc("Discovery Engine Status")
union DiscoveryEngineStatus {
  /** Discovery Engine Inactive */
  Inactive: "Inactive",

  /** Discovery Engine Active */
  Active: "Active",

  string,
}

@doc("Working memory entry type.")
@added(Versions.`2026-02-01-preview`)
union WorkingMemoryEntryType {
  /** Thought */
  @removed(Versions.`2026-06-01`)
  thought: "thought",

  /** Thought */
  @added(Versions.`2026-06-01`)
  Thought: "Thought",

  string,
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type"
@doc("Discovery engine instance.")
model DiscoveryEngine {
  @doc("The Discovery Engine status.")
  discoveryEngineStatus: DiscoveryEngineStatus;

  @doc("The system prompt.")
  systemPrompt?: string;

  @doc("The Discovery Engine configuration.")
  configuration?: Record<unknown>;

  // DiscoveryEngine is response-only, so we inline these properties without
  // @visibility(Lifecycle.Read) to avoid them being marked "readOnly" in OpenAPI.
  @doc("The timestamp when the resource was created.")
  createdAt?: utcDateTime;

  @doc("The ID of the user who created this resource.")
  createdBy?: string;

  @doc("The type of user who created this resource.")
  createdByType?: ByType;

  @doc("The timestamp when the resource was last updated")
  lastModifiedAt?: utcDateTime;

  @doc("The ID of the user who updated this resource.")
  lastModifiedBy?: string;

  @doc("The type of user who updated this resource.")
  lastModifiedByType?: ByType;
}

@doc("Working memory entry.")
@added(Versions.`2026-02-01-preview`)
model WorkingMemoryEntry {
  @doc("The content of the working memory entry.")
  content: string;

  @doc("The type of the working memory entry.")
  type: WorkingMemoryEntryType;

  // WorkingMemoryEntry is also response-only, so we inline this property
  @doc("The timestamp when the resource was created.")
  createdAt?: utcDateTime;
}

/** Get discovery engine working memory parameters (preview). */
alias GetDiscoveryEngineMemoryParameters = {
  @doc("Skip results.")
  @added(Versions.`2026-02-01-preview`)
  @query
  skip?: int32;

  @doc("Query the top results.")
  @added(Versions.`2026-02-01-preview`)
  @query
  top?: int32;

  @doc("Bound the number of results that come back in one response.")
  @added(Versions.`2026-02-01-preview`)
  @query
  maxPageSize?: int32;
};

#suppress "@azure-tools/typespec-azure-core/bad-record-type"
@doc("Discovery Engine Update Request. This will create the discovery engine if it does not already exist.")
model DiscoveryEngineUpdate {
  @removed(Versions.`2026-06-01`)
  @doc("The Discovery Engine status.")
  discoveryEngineStatus?: DiscoveryEngineStatus;

  @doc("The system prompt.")
  systemPrompt?: string;

  @doc("The Discovery Engine configuration.")
  configuration?: Record<unknown>;
}

// Named alias so the GA (2026-06-01) SDK model is `InvestigationOperationStatus`
// instead of the auto-synthesized `ResourceOperationStatusInvestigationInvestigationError`.
// Scoped to GA only: the model is @added at 2026-06-01 and is referenced solely by
// the GA operation below. The 2026-02-01-preview swagger is frozen via a
// version-split (see the Conversations update/stableUpdate precedent).
@doc("The status of a long-running Investigation operation.")
@added(Versions.`2026-06-01`)
model InvestigationOperationStatus is ResourceOperationStatus<Investigation>;

interface Investigations {
  @doc("Fetch a Investigation by name.")
  get is ResourceRead<Investigation>;

  // Preview (2026-02-01-preview) operation, frozen and removed at GA. Renamed to
  // `...Legacy` so the GA operation can take the clean `getOperationStatus` name;
  // @operationId preserves the preview swagger's operationId byte-for-byte.
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Versioned operation needs explicit operationId"
  @doc("Get the status of a long-running operation.")
  @sharedRoute
  @added(Versions.`2026-02-01-preview`)
  @removed(Versions.`2026-06-01`)
  @operationId("Investigations_GetOperationStatus")
  getOperationStatusLegacy is Operations.GetResourceOperationStatus<Investigation>;

  // GA (2026-06-01) operation returning the cleanly-named model; keeps the clean
  // `getOperationStatus` name (and operationId) as the public surface.
  @doc("Get the status of a long-running operation.")
  @sharedRoute
  @added(Versions.`2026-06-01`)
  getOperationStatus is ResourceRead<InvestigationOperationStatus>;

  @doc("Creates an Investigation.")
  createOrReplace is StandardResourceOperations.ResourceCreateOrReplace<Investigation>;

  @doc("Updates an Investigation.")
  @sharedRoute
  @removed(Versions.`2026-06-01`)
  createOrUpdate is StandardResourceOperations.ResourceCreateOrUpdate<Investigation>;

  @doc("Updates an Investigation.")
  @sharedRoute
  @added(Versions.`2026-06-01`)
  update is StandardResourceOperations.ResourceUpdate<Investigation>;

  @doc("Delete a Investigation.")
  @sharedRoute
  @removed(Versions.`2026-02-01-preview`)
  deleteInvestigationLegacy is ResourceDelete<Investigation>;

  @doc("Delete a Investigation.")
  @sharedRoute
  @pollingOperation(Investigations.getOperationStatus)
  @added(Versions.`2026-02-01-preview`)
  delete is LongRunningResourceDelete<Investigation>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation returns a bare array per service behavior, not a paged result"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Preserving operationId for backward compatibility with existing preview SDKs"
  @doc("List Investigation resources")
  @route("/projects/{projectName}/investigations")
  @get
  @sharedRoute
  @removed(Versions.`2026-06-01`)
  @operationId("Investigations_List")
  listLegacy is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      projectName: string;
    } & WithQueryCreatedSince,
    Investigation[]
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Paginated list operation"
  @doc("List Investigation resources")
  @route("/projects/{projectName}/investigations")
  @get
  @sharedRoute
  @added(Versions.`2026-06-01`)
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      projectName: string;
    } & WithQueryCreatedSince &
      Azure.Core.StandardListQueryParameters,
    Azure.Core.Foundations.CustomPage<Investigation>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get data assets linked to an investigation.")
  @route("/projects/{projectName}/investigations/{investigationName}/data")
  @get
  @removed(Versions.`2026-02-01-preview`)
  getInvestigationData is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      investigationName: string;
    },
    InvestigationDataAssets
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Link a data asset to an investigation.")
  @route("/projects/{projectName}/investigations/{investigationName}/data:linkDataAsset")
  @post
  @removed(Versions.`2026-02-01-preview`)
  linkDataAsset is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      investigationName: string;

      @doc("The data asset link request.")
      @body
      body: LinkDataAssetRequest;
    },
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Unlink a data asset from an investigation.")
  @route("/projects/{projectName}/investigations/{investigationName}/data:unlinkDataAsset")
  @post
  @removed(Versions.`2026-02-01-preview`)
  unlinkDataAsset is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      investigationName: string;

      @doc("The data asset unlink request.")
      @body
      body: UnlinkDataAssetRequest;
    },
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get the discovery engine for an investigation.")
  @route("/projects/{projectName}/investigations/{investigationName}/discoveryEngine")
  @get
  getDiscoveryEngine is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      investigationName: string;
    },
    DiscoveryEngine
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Preserving operationId for backward compatibility with existing preview SDKs"
  @doc("List discovery engine working memory entries for an investigation.")
  @route("/projects/{projectName}/investigations/{investigationName}/discoveryEngine/workingMemory")
  @get
  @sharedRoute
  @added(Versions.`2026-02-01-preview`)
  @removed(Versions.`2026-06-01`)
  @operationId("Investigations_GetDiscoveryEngineMemory")
  getDiscoveryEngineMemoryLegacy is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      investigationName: string;
    } & GetDiscoveryEngineMemoryParameters,
    Azure.Core.Foundations.CustomPage<WorkingMemoryEntry>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List discovery engine working memory entries for an investigation.")
  @route("/projects/{projectName}/investigations/{investigationName}/discoveryEngine/workingMemory")
  @get
  @sharedRoute
  @added(Versions.`2026-06-01`)
  getDiscoveryEngineMemory is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      investigationName: string;
    } & Azure.Core.StandardListQueryParameters,
    Azure.Core.Foundations.CustomPage<WorkingMemoryEntry>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Start the discovery engine for an investigation.")
  @route("/projects/{projectName}/investigations/{investigationName}/discoveryEngine:start")
  @post
  startDiscoveryEngine is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      investigationName: string;
    },
    DiscoveryEngine
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Stop the discovery engine for an investigation.")
  @route("/projects/{projectName}/investigations/{investigationName}/discoveryEngine:stop")
  @post
  stopDiscoveryEngine is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      investigationName: string;
    },
    DiscoveryEngine
  >;

  #suppress "@typespec/http/patch-implicit-optional" ""
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Update the discovery engine for an investigation. This will create the discovery engine if it does not already exist.")
  @route("/projects/{projectName}/investigations/{investigationName}/discoveryEngine")
  @patch
  updateDiscoveryEngine is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @maxLength(24)
      @pattern(resourceNamePattern)
      investigationName: string;

      @doc("The discovery engine update request. This will create the discovery engine if it does not already exist.")
      @body
      body: DiscoveryEngineUpdate;
    },
    DiscoveryEngine
  >;
}
