// FIXTURE (TRUE NEGATIVE -- class 3: linter-owned violations).
// Every defect in this file is already caught mechanically by a shipped
// @azure-tools/typespec-azure-core rule at 🔒 Linted status in
// references/data-plane-linter-rule-coverage.md. The reviewer must stay
// silent on all of them: CI already reports them, and a second report is
// noise. Any finding naming one of these rules is a test failure.
//
// Seeded, with the owning rule:
//   enum instead of union          -> no-enum
//   string | null property         -> no-nullable
//   @format decorator              -> no-format
//   unknown-typed property         -> no-unknown
//   generic `numeric` type         -> no-generic-numeric
//   missing @doc on model/property -> documentation-required
//   snake_case declaration name    -> casing-style
//   raw array request body         -> request-body-problem
//   explicit @route on a standard
//     resource operation           -> no-explicit-routes-resource-ops
//
// Not a real service. Not under specification/; not compiled by CI.

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "Inventory" })
@versioned(Versions)
@server("https://{endpoint}", "Inventory service", { endpoint: string })
namespace Inventory;

@doc("Service API versions.")
enum Versions {
  @doc("The 2026-01-01 stable version.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2026_01_01: "2026-01-01",
}

// LINTER-OWNED: no-enum. Should be an extensible `union`.
@doc("Condition of a stocked item.")
enum ItemCondition {
  @doc("Unopened and undamaged.")
  New,

  @doc("Opened but functional.")
  Refurbished,

  @doc("Damaged; not saleable.")
  Damaged,
}

@doc("An item held in inventory.")
@resource("items")
model Item {
  @doc("Stock-keeping unit identifying the item. Immutable after creation.")
  @key
  @visibility(Lifecycle.Read)
  sku: string;

  @doc("Condition the item is currently in.")
  condition: ItemCondition;

  // LINTER-OWNED: no-nullable. Should be `description?: string`.
  @doc("Free-text description supplied by the supplier.")
  description: string | null;

  // LINTER-OWNED: no-format. Constraints belong in @pattern / scalar types.
  @doc("Contact address of the supplier.")
  @format("email")
  supplierEmail: string;

  // LINTER-OWNED: no-unknown.
  @doc("Supplier-specific attributes, passed through unchanged.")
  supplierAttributes: unknown;

  // LINTER-OWNED: no-generic-numeric. Should be int32 or float64.
  @doc("Quantity currently on hand at the default warehouse.")
  quantityOnHand: numeric;

  // LINTER-OWNED: documentation-required. No @doc at all.
  unitPriceUsd: float64;

  // LINTER-OWNED: casing-style. Should be camelCase.
  @doc("Warehouse the item is stored in.")
  warehouse_id: string;
}

// LINTER-OWNED: documentation-required. No @doc on the model.
model BulkAdjustment {
  @doc("Stock-keeping unit of the item to adjust.")
  sku: string;

  @doc("Signed change to apply to the quantity on hand.")
  delta: int32;
}

@doc("Operations on inventory items.")
interface Items {
  // LINTER-OWNED: no-explicit-routes-resource-ops.
  @doc("Gets an item by SKU.")
  @route("/items/{sku}")
  get is StandardResourceOperations.ResourceRead<Item>;

  @doc("Creates or replaces an item.")
  createOrReplace is StandardResourceOperations.ResourceCreateOrReplace<Item>;

  @doc("Lists items in inventory.")
  list is StandardResourceOperations.ResourceList<Item>;

  // LINTER-OWNED: request-body-problem. Raw array request body.
  @doc("Applies a batch of quantity adjustments.")
  @route("/items:bulkAdjust")
  @post
  bulkAdjust(@body body: BulkAdjustment[]): OkResponse;
}
