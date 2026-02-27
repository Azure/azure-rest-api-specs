import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./shared.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Microsoft.Discovery.Common;

@versioned(Microsoft.Discovery.Bookshelf.Versions)
namespace Microsoft.Discovery.Bookshelf;

/** Enum for IndexingStatus */
@lroStatus
union IndexingStatus {
  /** Indexing Not started */
  NotStarted: "NotStarted",

  /** Running */
  Running: "Running",

  /** Succeeded */
  @lroSucceeded
  Succeeded: "Succeeded",

  /** Canceled */
  @lroCanceled
  Canceled: "Canceled",

  /** Failed */
  @lroFailed
  Failed: "Failed",

  string,
}

@doc("Reference to a storage asset with identity information.")
@added(Versions.`2026-02-01-preview`)
model StorageAssetReference {
  @doc("The ARM resource ID of the storage asset.")
  id: StorageAssetId;

  @doc("The ARM resource ID of the User Assigned Managed Identity to access the storage asset.")
  userAssignedIdentity?: UserAssignedIdentityId;
}

/** Base knowledgeBase properties. */
alias BaseKnowledgeBase = WithId & {
  @doc("Version.")
  @visibility(Lifecycle.Read)
  version: string;

  /** The name of the associated Bookshelf tracked resource. */
  @visibility(Lifecycle.Read)
  bookshelfName: string;

  @doc("Storage asset references to index.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Versions.`2026-02-01-preview`)
  storageAssetReferences?: StorageAssetReference[];

  @doc("Catalog data assets to index.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @removed(Versions.`2026-02-01-preview`)
  dataAssetIds: DataAssetId[];

  @doc("URL to access the knowledge base.")
  @visibility(Lifecycle.Read)
  knowledgeBaseUrl?: string;

  /** Provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
} & DataPlaneResource &
  WithTags &
  WithDescription &
  WithCopilotInstruction &
  WithStatus<IndexingStatus>;

@doc("A knowledgeBase.")
@resource("knowledgeBases")
model KnowledgeBase {
  @doc("The knowledgeBase name.")
  @visibility(Lifecycle.Read)
  @key("knowledgeBaseName")
  @maxLength(24)
  @pattern(resourceNamePattern)
  name: string;

  ...BaseKnowledgeBase;
}

interface KnowledgeBases {
  @doc("List KnowledgeBase resources")
  list is ResourceList<KnowledgeBase>;
}
