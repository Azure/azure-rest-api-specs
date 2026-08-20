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
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://inventory.azure.com/.default"],
    }
  ]>
)
@server(
  "https://{endpoint}",
  "Inventory service",
  {
    endpoint: string,
  }
)
namespace Inventory;

@doc("Service API versions.")
enum Versions {
  @doc("The 2026-01-01 stable version.")
  v2026_01_01: "2026-01-01",
}

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

  @doc("Free-text description supplied by the supplier.")
  description: string | null;

  @doc("Contact address of the supplier.")
  @format("email")
  supplierEmail: string;

  @doc("Supplier-specific attributes, passed through unchanged.")
  supplierAttributes: unknown;

  @doc("Quantity currently on hand at the default warehouse.")
  quantityOnHand: numeric;

  unitPriceUsd: float64;

  @doc("Warehouse the item is stored in.")
  warehouse_id: string;
}

model BulkAdjustment {
  @doc("Stock-keeping unit of the item to adjust.")
  sku: string;

  @doc("Signed change to apply to the quantity on hand.")
  delta: int32;
}

@doc("Operations on inventory items.")
interface Items {
  @doc("Gets an item by SKU.")
  @route("/items/{sku}")
  get is StandardResourceOperations.ResourceRead<Item>;

  @doc("Creates or replaces an item.")
  createOrReplace is StandardResourceOperations.ResourceCreateOrReplace<Item>;

  @doc("Deletes an item.")
  delete is StandardResourceOperations.ResourceDelete<Item>;

  @doc("Lists items in inventory.")
  list is StandardResourceOperations.ResourceList<Item>;

  @doc("Applies a batch of quantity adjustments.")
  @route("/items:bulkAdjust")
  @post
  bulkAdjust(@body body: BulkAdjustment[]): OkResponse;
}
