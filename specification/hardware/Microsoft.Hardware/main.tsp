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
@service({
  title: "Hardware Resource Provider",
  version: "2023-07-12-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.Hardware;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A Hardware Resource Provider Order resource")
model Order is TrackedResource<OrderProperties> {
  @doc("Order Id")
  @key("orderId")
  @path
  @segment("orders")
  name: string;
}

@doc("Forward Order")
model OrderProperties {
  @doc("Customer PurchaseOrder")
  customerOrder?: CustomerOrder;

  @doc("Type of action Pre-Fulfill/Fulfill")
  @visibility("read")
  action?: string;

  @doc("Order status")
  @visibility("read")
  status?: OrderStatus;

  @doc("Order line details")
  @OpenAPI.extension("x-ms-identifiers", ["id"])
  orderLines: OrderLine[];

  @doc("Currency for the order")
  currency: string;

  @doc("Market - country code for Order")
  market?: string;

  @doc("Language - language code for Order")
  language?: string;

  @doc("Reservation for order if applicable")
  reservationId?: string;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Customer PurchaseOrder")
model CustomerOrder {
  @doc("Customer PurchaseOrder Id")
  id: string;

  @doc("Customer PurchaseOrder Date")
  createdDate: plainDate;
}

@doc("Order Line")
model OrderLine {
  @doc("Order lineId")
  id: int64;

  @doc("Order line status")
  @visibility("read")
  status?: OrderLineStatus;

  @doc("Order line date")
  @visibility("read")
  createdDateTime?: utcDateTime;

  @doc("Order line quantity")
  quantity: OrderLineQuantity;

  @doc("order line Product")
  product: Product;

  @doc("line level Price")
  price: Price;

  @doc("shipTo Address")
  shipTo: ShipTo;

  @doc("Shipping Method")
  shippingMethod?: ShippingMethod;

  @doc("Requested Delivery Date")
  requestedDeliveryDate?: plainDate;

  @doc("Cancellation Reason")
  cancellationReason?: string;

  @doc("Cancelled By User details")
  cancelledBy?: string;

  @doc("Estimated Deliver Date")
  @visibility("read")
  estimatedDeliveryDate?: plainDate;

  @doc("Estimated Shipped Date")
  @visibility("read")
  estimatedShippedDate?: plainDate;
}

@doc("Order line quantity")
model OrderLineQuantity {
  @doc("Order lineId Ordered Quantity")
  ordered: int64;

  @doc("Order lineId Confirmed Quantity")
  @visibility("read")
  confirmed?: int64;

  @doc("Order lineId Shipped Quantity")
  @visibility("read")
  shipped?: int64;

  @doc("Order lineId Returned Quantity")
  @visibility("read")
  returned?: int64;
}

@doc("Order line product")
model Product {
  @doc("ProductId")
  id: string;

  @doc("ProductId Type")
  type: ProductIdType;
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
  @OpenAPI.extension("x-ms-identifiers", ["type"])
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
  @Autorest.example("./examples/Orders_Get.json", "OrderById")
  get is ArmResourceRead<Order>;

  @Autorest.example("./examples/Orders_Create.json", "CreateOrder")
  create is ArmResourceCreateOrUpdateAsync<Order>;

  @Autorest.example("./examples/Orders_Update.json", "UpdateOrder")
  update is ArmResourcePatchSync<Order, OrderProperties>;

  @Autorest.example("./examples/Orders_Delete.json", "DeleteOrder")
  delete is ArmResourceDeleteSync<Order>;

  @Autorest.example(
    "./examples/Orders_ListByResourceGroup.json",
    "GetByResourceGroup"
  )
  listByResourceGroup is ArmResourceListByParent<Order>;

  @Autorest.example(
    "./examples/Orders_ListBySubscription.json",
    "GetBySubscription"
  )
  listBySubscription is ArmListBySubscription<Order>;
}

@doc("Product-Id type")
enum ProductIdType {
  @doc("UPN in Big-Catalog")
  UPN,

  @doc("Product, SKU, Availability in Big-Catalog")
  PSA,

  @doc("MS product identifier (3x5 SKU)")
  FulfillmentProductId,
}

@doc("Shipping method")
enum ShippingMethod {
  @doc("Ground shipping")
  Ground,

  @doc("Two day shipping")
  TwoDay,

  @doc("Three day shipping")
  ThreeDay,

  @doc("Sustainable shipping")
  Sustainable,

  @doc("Street date shipping")
  StreetDate,

  @doc("APO FPO shipping")
  ApoFpo,
}

@doc("Ship-To-Id Type")
enum ShipToIdType {
  @doc("Modern Commerce API business location")
  BusinessLocation,

  @doc("Partner External-Id")
  ExternalId,
}

@doc("Fee type")
enum FeeType {
  @doc("Recycling fee")
  Recycling,
}

@doc("Tax Type")
enum TaxType {
  @doc("Tax on unit amount for product cost")
  Unit,

  @doc("Tax on shipping cost")
  Shipping,
}

@doc("Order Status")
enum OrderStatus {
  @doc("Order is pending")
  Pending,

  @doc("Order is created")
  Created,

  @doc("Order is confirmed")
  Confirmed,

  @doc("Order is PartiallyConfirmed")
  PartiallyConfirmed,

  @doc("Order is pending cancellation")
  PendingCancel,

  @doc("Order is ready to ship cannot be cancelled")
  PendingShipment,

  @doc("Order is partially shipped")
  PartiallyShipped,

  @doc("Order is shipped")
  Shipped,
}

@doc("Order Line Status")
enum OrderLineStatus {
  @doc("Order is pending")
  Pending,

  @doc("Order is created")
  Created,

  @doc("Order is confirmed")
  Confirmed,

  @doc("Order is partially confirmed")
  PartiallyConfirmed,

  @doc("Order is pending cancellation")
  PendingCancel,

  @doc("Order is ready to ship cannot be cancelled")
  PendingShipment,

  @doc("Order is partially shipped")
  PartiallyShipped,

  @doc("Order is shipped")
  Shipped,
}

@doc("Provisioning State")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Order is pending")
  Pending,
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
  @Autorest.example("./examples/Orders_Preview.json", "OrderPreview")
  @TypeSpec.Rest.action("orderPreview")
  @post
  orderPreview(
    ...SubscriptionIdParameter,
    ...DefaultProviderNamespace,
    ...ApiVersionParameter,

    @doc("The orderPreview request")
    @body
    body: Order,
  ): Order | ErrorResponse;
}
