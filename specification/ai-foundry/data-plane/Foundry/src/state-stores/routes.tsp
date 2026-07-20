// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

/**
 * DRAFT — routes for the Foundry State Storage contract. See `./models.tsp`
 * for the checklist and open items to verify before opening the specs PR.
 * Not yet compiled.
 */

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Azure.AI.Projects;

@tag("State Stores")
interface StateStores {
  /** Creates a durable state store. `201` on success, `409` if `name` already exists. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Create a state store")
  @operationId("createStateStore")
  @post
  @route("/storage/state_stores")
  @extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
  createStateStore is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.state_stores_v1_preview,
    CreateStateStoreRequest,
    StateStore
  >;

  /** Lists the state stores available to the caller. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("List state stores")
  @operationId("listStateStores")
  @get
  @list
  @route("/storage/state_stores")
  @extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
  listStateStores is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.state_stores_v1_preview,
    ListStateStoresRequest,
    AgentsPagedResult<StateStore>
  >;

  /** Retrieves the specified state store. `404` if no such store exists. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Get a state store")
  @operationId("getStateStore")
  @get
  @route("/storage/state_stores/{state_store}")
  @extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
  getStateStore is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.state_stores_v1_preview,
    GetStateStoreRequest,
    StateStore
  >;

  /** Updates the mutable metadata (`description` / `tags`) of a state store. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Update a state store")
  @operationId("updateStateStore")
  @patch
  @route("/storage/state_stores/{state_store}")
  @extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
  updateStateStore is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.state_stores_v1_preview,
    UpdateStateStoreRequest,
    StateStore
  >;

  /** Deletes a state store and, cascading, every item under it. Idempotent. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Delete a state store")
  @operationId("deleteStateStore")
  @delete
  @route("/storage/state_stores/{state_store}")
  @extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
  deleteStateStore is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.state_stores_v1_preview,
    DeleteStateStoreRequest,
    DeletedStateStore
  >;
}

@tag("State Store Items")
interface StateStoreItems {
  /** Creates an item. `409` on a duplicate `key`; `404` if the store does not exist. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Create a state-store item")
  @operationId("createStateStoreItem")
  @post
  @route("/storage/state_stores/{state_store}/items")
  @extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
  createStateStoreItem is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.state_stores_v1_preview,
    CreateItemRequest,
    StateStoreItemRef
  >;

  /** Lists item keys (keys-only projection); never returns `value`. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("List state-store item keys")
  @operationId("listStateStoreItemKeys")
  @get
  @list
  @route("/storage/state_stores/{state_store}/items:keys")
  @extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
  listStateStoreItemKeys is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.state_stores_v1_preview,
    ListItemKeysRequest,
    AgentsPagedResult<StateStoreItemKey>
  >;

  /** Idempotent create-or-replace by key. `If-Match` gives optimistic concurrency (`412` on mismatch). */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Put a state-store item")
  @operationId("putStateStoreItem")
  @put
  @route("/storage/state_stores/{state_store}/items/{key}")
  @extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
  putStateStoreItem is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.state_stores_v1_preview,
    PutItemRequest,
    StateStoreItemRef
  >;

  /** Retrieves the item at `key`. `404` if the key has never been written. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Get a state-store item")
  @operationId("getStateStoreItem")
  @get
  @route("/storage/state_stores/{state_store}/items/{key}")
  @extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
  getStateStoreItem is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.state_stores_v1_preview,
    GetItemRequest,
    StateStoreItem
  >;

  /** Deletes the item at `key`. `If-Match` gives a conditional delete (`412`). Idempotent. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Delete a state-store item")
  @operationId("deleteStateStoreItem")
  @delete
  @route("/storage/state_stores/{state_store}/items/{key}")
  @extension("x-ms-foundry-meta", StateStoreRequiredPreviews)
  deleteStateStoreItem is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.state_stores_v1_preview,
    DeleteItemRequest,
    DeletedStateStoreItem
  >;
}
