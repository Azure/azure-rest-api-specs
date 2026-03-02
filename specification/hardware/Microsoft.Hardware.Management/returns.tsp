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

namespace Microsoft.Hardware;

// ===== Return Order Models =====

@added(Versions.v2026_02_26_preview)
@doc("A Hardware Resource Provider Return Order resource")
model ReturnOrder is TrackedResource<ReturnOrderProperties> {
  ...ResourceNameParameter<
    Resource = ReturnOrder,
    KeyName = "name",
    SegmentName = "returns",
    NamePattern = ""
  >;
}

@added(Versions.v2026_02_26_preview)
@doc("Warranty deprovision status values")
union WarrantyDeprovisionStatus {
  string,

  @doc("Warranty deprovision request has not been fulfilled")
  Unfulfilled: "unfulfilled",
}

@added(Versions.v2026_02_26_preview)
@doc("Return Reason Codes")
union ReturnReasonCode {
  @doc("Product satisfaction")
  ProductSatisfaction: "productsatisfaction",

  @doc("Customer satisfaction")
  CustomerSatisfaction: "customersatisfaction",

  @doc("Incorrect Product Attribute")
  IncorrectProductAttribute: "incorrectproductattribute",

  @doc("Defective Item")
  DefectiveItem: "defectiveitem",

  @doc("Cancel Attempted But Shipped")
  CancelAttemptedButShipped: "cancelattemptedbutshipped",

  @doc("Better Price Available")
  BetterPriceAvailable: "betterpriceavailable",

  @doc("Damaged In Transit")
  DamagedInTransit: "damagedintransit",

  @doc("Duplicate Order")
  DuplicateOrder: "duplicateorder",

  @doc("Incorrect Product")
  IncorrectProduct: "incorrectproduct",

  @doc("Customer Error")
  CustomerError: "customererror",

  @doc("Vendor Approved Return")
  VendorApprovedReturn: "vendorapprovedreturn",

  @doc("Refused Order")
  RefusedOrder: "refusedorder",

  @doc("Missing Items")
  MissingItems: "missingitems",

  @doc("Fraud Reason Code")
  Fraud: "fraud",

  @doc("On Behalf Of Error")
  OnBehalfOfError: "onbehalfoferror",

  @doc("Damaged Product")
  DamagedProduct: "damagedproduct",

  @doc("Trial Product")
  TrialProduct: "trialproduct",

  @doc("Ordered Without Approval")
  OrderedWithoutApproval: "orderedwithoutapproval",

  string,
}

@added(Versions.v2026_02_26_preview)
@doc("Return Exception Codes")
union ReturnExceptionCode {
  @doc("The exception resolved")
  ExceptionResolved: "ExceptionResolved",

  @doc("Wrong Product")
  WrongProduct: "WrongProduct",

  @doc("No Product")
  NoProduct: "NoProduct",

  @doc("The non Microsoft product")
  NonMSFTProduct: "NonMSFTProduct",

  @doc("The damaged product")
  DamagedProduct: "DamagedProduct",

  @doc("Other Exception Code")
  Other: "Other",

  string,
}

@added(Versions.v2026_02_26_preview)
@doc("Hardware Return Order Properties")
model ReturnOrderProperties {
  @doc("Customer PurchaseOrder")
  customerOrder?: CustomerOrder;

  @doc("Return order status")
  @visibility(Lifecycle.Read)
  status?: OrderStatus;

  @doc("Return order lines")
  @identifiers(#["id"])
  returnLines: ReturnLine[];

  @doc("RMA (Return Merchandise Authorization) ID - this is an alphanumeric string id which is assigned by the system when the return order is created")
  @visibility(Lifecycle.Read)
  rmaId?: string;

  @doc("Return label")
  @visibility(Lifecycle.Read)
  returnLabel?: string;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_02_26_preview)
@doc("Hardware Return Order Line")
model ReturnLine {
  @doc("This is a unique identifier for return line, that can be assigned during return order creation. This is not the same as referenceOrderLineId which refers to the original order line that is being returned.")
  id: int64;

  @doc("Id of the forward order where the device was purchased which is being returned as part of this return in this return line")
  referenceOrderId: string;

  @doc("Billing State")
  @visibility(Lifecycle.Read)
  billingState?: BillingState;

  @doc("LineId of the forward order line where the device was purchased which is being returned as part of this return in this return line")
  referenceOrderLineId: int64;

  @doc("Sender address for return shipment")
  senderAddress: ShipTo;

  @doc("Return line quantity")
  quantity: OrderLineQuantity;

  @doc("Product being returned")
  product: Product;

  @doc("Refunded amount for this return line")
  @visibility(Lifecycle.Read)
  refundedAmount?: Price;

  @doc("Estimated refund amount")
  @visibility(Lifecycle.Read)
  estimatedRefundAmount?: Price;

  @doc("Reasons for return")
  @identifiers(#[])
  returnReasons: ReturnReason[];

  @doc("Return line status")
  @visibility(Lifecycle.Read)
  status?: OrderLineStatus;

  @doc("Warranty deprovision request ID")
  warrantyDeprovisionRequestId?: string;

  @doc("Warranty deprovision status")
  warrantyDeprovisionStatus?: WarrantyDeprovisionStatus;

  @doc("Warranty deprovisioned serial numbers")
  warrantyDeprovisionedSerialNumbers?: string[];
}

@added(Versions.v2026_02_26_preview)
@doc("Return reason")
model ReturnReason {
  @doc("Serial numbers associated with this return reason")
  serialNumbers?: string[];

  @doc("Return reason code")
  reasonCode: ReturnReasonCode;

  @doc("Additional comments for the return reason")
  additionalComments?: string;

  @doc("Exception code for the return")
  exceptionCode?: ReturnExceptionCode;
}

@added(Versions.v2026_02_26_preview)
@doc("Shipment detail")
model ShipmentDetail {
  @doc("Shipping carrier name")
  carrierName?: string;

  @doc("Shipment tracking number")
  trackingNumber?: string;

  @doc("Tracking link URL")
  trackingLink?: string;

  @doc("Date when item was shipped")
  shippedDate?: utcDateTime;

  @doc("Date when item was delivered")
  deliveredDate?: utcDateTime;

  @doc("Estimated delivery date")
  estimatedDeliverByDate?: utcDateTime;
}

@added(Versions.v2026_02_26_preview)
@armResourceOperations
interface ReturnOrders {
  get is ArmResourceRead<ReturnOrder>;

  create is ArmResourceCreateOrUpdateAsync<ReturnOrder>;

  update is ArmResourcePatchSync<ReturnOrder, ReturnOrderProperties>;

  delete is ArmResourceDeleteSync<ReturnOrder>;

  listByResourceGroup is ArmResourceListByParent<ReturnOrder>;

  listBySubscription is ArmListBySubscription<ReturnOrder>;
}

@added(Versions.v2026_02_26_preview)
@armResourceOperations
interface ReturnPreviewInterface {
  @armResourceCollectionAction
  @armProviderNameValue
  @doc("Preview a return order before placing it")
  @TypeSpec.Rest.action("returnPreview")
  @post
  returnPreview(
    ...SubscriptionIdParameter,
    ...DefaultProviderNamespace,
    ...ApiVersionParameter,

    @doc("Return order details to preview")
    @bodyRoot
    bodyRoot: ReturnOrder,
  ): ReturnOrder | ErrorResponse;
}
