import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Hardware Resource Provider" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v4)
namespace Microsoft.Hardware;

enum Versions {
  /**
   * The 2023-07-12-preview API version.
   */
  v2023_07_12_preview: "2023-07-12-preview",

  /**
   * The 2025-12-04-preview API version.
   */
  v2025_12_04_preview: "2025-12-04-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A Hardware Resource Provider Order resource")
model Order is TrackedResource<OrderProperties> {
  ...ResourceNameParameter<
    Resource = Order,
    KeyName = "name",
    SegmentName = "orders",
    NamePattern = ""
  >;
}

@doc("Forward Order")
model OrderProperties {
  @doc("Customer PurchaseOrder")
  customerOrder?: CustomerOrder;

  @doc("Type of action Pre-Fulfill/Fulfill")
  @visibility(Lifecycle.Read)
  action?: string;

  @doc("Order status")
  @visibility(Lifecycle.Read)
  status?: OrderStatus;

  @doc("Order line details")
  @identifiers(#["id"])
  orderLines: OrderLine[];

  @doc("Currency for the order")
  currency: string;

  @doc("Market - country code for Order")
  market?: string;

  @doc("Language - language code for Order")
  language?: string;

  @doc("Reservation for order if applicable")
  reservationId?: string;

  @doc("Order provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Customer PurchaseOrder")
model CustomerOrder {
  @doc("Customer PurchaseOrder Id")
  id: string;

  @doc("Customer PurchaseOrder Date Time")
  createdDateTime: utcDateTime;
}

@doc("Order Line")
model OrderLine {
  @doc("Order lineId")
  id: int64;

  @doc("Order line status")
  @visibility(Lifecycle.Read)
  status?: OrderLineStatus;

  @doc("Billing State")
  @visibility(Lifecycle.Read)
  billingState?: BillingState;

  @doc("Order line date")
  @visibility(Lifecycle.Read)
  createdDateTime?: utcDateTime;

  @doc("Order line quantity")
  quantity: OrderLineQuantity;

  @doc("order line Product")
  product: Product;

  @doc("Order line fulfillment instructions")
  lineFulfillmentInstruction?: LineFulfillmentInstruction;

  @doc("line level Price")
  price: Price;

  @doc("shipTo Address")
  shipTo: ShipTo;

  @doc("Shipping Method")
  shippingMethod?: ShippingMethod;

  @doc("Requested Delivery Date Time")
  requestedDeliveryDateTime?: utcDateTime;

  @doc("Cancellation Reason")
  cancellationReason?: string;

  @doc("Cancelled By User details")
  cancelledBy?: string;

  @doc("Estimated Deliver Date Time")
  @visibility(Lifecycle.Read)
  estimatedDeliveryDateTime?: utcDateTime;

  @doc("Estimated Shipped Date Time")
  @visibility(Lifecycle.Read)
  estimatedShippedDateTime?: utcDateTime;
}

@doc("Order line quantity")
model OrderLineQuantity {
  @doc("Order line pending quantity")
  pending: int64;

  @doc("Order lineId in-progress quantity")
  @visibility(Lifecycle.Read)
  inProgress?: int64;

  @doc("Order lineId fulfilled quantity")
  @visibility(Lifecycle.Read)
  fulfilled?: int64;

  @doc("Order lineId quantity pending cancellation")
  @visibility(Lifecycle.Read)
  pendingCancel?: int64;

  @doc("Order lineId cancelled quantity")
  @visibility(Lifecycle.Read)
  cancelled?: int64;

  @doc("Order lineId returned quantity")
  @visibility(Lifecycle.Read)
  returned?: int64;
}

@doc("Order line product")
model Product {
  @doc("ProductId")
  id: string;

  @doc("ProductId Type")
  type: ProductIdType;

  @doc("Bundle Product Id")
  bundleProductId?: string;

  @doc("Bundle Instance Id")
  bundleInstanceId?: string;

  @doc("Bundle Slot Id")
  bundleSlotId?: int64;
}

@doc("Order line fulfillment instructions")
model LineFulfillmentInstruction {
  @doc("Device line referred to by the warranty line.")
  referenceDeviceLine?: int64;

  @doc("Serial Numbers")
  serialNumbers?: string[];
}

@doc("Order line price")
model Price {
  @doc("Price per unit")
  unitAmount: float64;

  @doc("Shipping cost for the line")
  shippingCost?: float64;

  @doc("Tax for this line")
  taxes?: Tax[];

  @doc("Fees for this line")
  @identifiers(#["type"])
  fees?: Fee[];
}

@doc("Fee model")
model Fee {
  @doc("Fee charged")
  amount: float64;

  @doc("Fee type")
  type: FeeType;
}

@doc("Tax model")
model Tax {
  @doc("Tax charged")
  amount: float64;

  @doc("Tax type")
  type: TaxType;

  @doc("Categorization of the taxation system")
  class?: string;

  @doc("Specific title assigned to the tax entity")
  name?: string;

  @doc("Level of governing authority")
  jurisdictionEntity?: string;

  @doc("Name of the jurisdiction")
  jurisdictionName?: string;

  @doc("Tax Rate")
  rate?: float64;
}

@doc("Ship-To id")
model ShipTo {
  @doc("ShipTo Id")
  id: string;

  @doc("Ship-To type")
  type: ShipToIdType;
}

@armResourceOperations
interface Orders {
  get is ArmResourceRead<Order>;

  create is ArmResourceCreateOrUpdateAsync<Order>;

  update is ArmResourcePatchSync<Order, OrderProperties>;

  delete is ArmResourceDeleteSync<Order>;

  listByResourceGroup is ArmResourceListByParent<Order>;

  listBySubscription is ArmListBySubscription<Order>;
}

@doc("Product-Id type")
union ProductIdType {
  @doc("UPN in Big-Catalog")
  UPN: "UPN",

  @doc("Product, SKU, Availability in Big-Catalog")
  PSA: "PSA",

  @doc("MS product identifier (3x5 SKU)")
  FulfillmentProductId: "FulfillmentProductId",

  string,
}

@doc("Shipping method")
union ShippingMethod {
  @doc("Ground shipping")
  Ground: "Ground",

  @doc("Two day shipping")
  TwoDay: "TwoDay",

  @doc("Three day shipping")
  ThreeDay: "ThreeDay",

  @doc("Sustainable shipping")
  Sustainable: "Sustainable",

  @doc("Street date shipping")
  StreetDate: "StreetDate",

  @doc("APO FPO shipping")
  ApoFpo: "ApoFpo",

  string,
}

@doc("Ship-To-Id Type")
union ShipToIdType {
  @doc("Modern Commerce API business location")
  BusinessLocation: "BusinessLocation",

  @doc("Partner External-Id")
  ExternalId: "ExternalId",

  string,
}

@doc("Fee type")
union FeeType {
  @doc("Recycling fee")
  Recycling: "Recycling",

  string,
}

@doc("Tax Type")
union TaxType {
  @doc("Tax on unit amount for product cost")
  Unit: "Unit",

  @doc("Tax on shipping cost")
  Shipping: "Shipping",

  string,
}

@doc("Order Status")
union OrderStatus {
  @doc("Order is pending")
  Pending: "Pending",

  @doc("Order is created")
  Created: "Created",

  @doc("Order is confirmed")
  Confirmed: "Confirmed",

  @doc("Order is PartiallyConfirmed")
  PartiallyConfirmed: "PartiallyConfirmed",

  @doc("Order is partially shipped")
  PartiallyShipped: "PartiallyShipped",

  @doc("Order is shipped")
  Shipped: "Shipped",

  @doc("Order is returned")
  Returned: "Returned",

  @doc("Order is cancelled")
  Cancelled: "Cancelled",

  string,
}

@doc("Order Line Status")
union OrderLineStatus {
  @doc("Order is pending")
  Pending: "Pending",

  @doc("Order is in-progress")
  InProgress: "InProgress",

  @doc("Order is fulfilled")
  Fulfilled: "Fulfilled",

  @doc("Order is cancelled")
  Cancelled: "Cancelled",

  @doc("Order is returned")
  Returned: "Returned",

  string,
}

@doc("Billing State")
union BillingState {
  @doc("The default state, initialized or reset after a failed operation")
  Pending: "Pending",

  @doc("The payment is pending capture.")
  PendingCapture: "PendingCapture",

  @doc("The payment has been captured successfully.")
  Captured: "Captured",

  @doc("The payment capture failed.")
  CaptureFailed: "CaptureFailed",

  @doc("The payment is pending a refund.")
  PendingRefund: "PendingRefund",

  @doc("The payment has been refunded.")
  Refunded: "Refunded",

  string,
}

@doc("Provisioning State")
union ProvisioningState {
  Azure.ResourceManager.ResourceProvisioningState,
  string,
}

alias DefaultProviderNamespace = {
  @path
  @TypeSpec.Rest.segment("providers")
  @doc("The provider namespace for the resource.")
  provider: "Microsoft.Hardware";
};

@armResourceOperations
interface OrderPreviewInterface {
  @armResourceCollectionAction
  @armProviderNameValue
  @doc("Enables preview of hardware order for passed order lines by populating fees, taxes, shipping estimates.")
  @TypeSpec.Rest.action("orderPreview")
  @post
  orderPreview(
    ...SubscriptionIdParameter,
    ...DefaultProviderNamespace,
    ...ApiVersionParameter,

    @doc("The orderPreview request")
    @bodyRoot
    bodyRoot: Order,
  ): Order | ErrorResponse;
}
