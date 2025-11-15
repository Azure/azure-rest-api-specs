import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EdgeOrder;

// csharp
@@clientName(AddressUpdateParameter, "EdgeOrderAddressPatch", "csharp");
@@clientName(OrderItemDetailsUpdateParameter,
  "EdgeOrderItemDetailsPatch",
  "csharp"
);
@@clientName(OrderItemUpdateParameter, "EdgeOrderItemPatch", "csharp");
@@clientName(WeightMeasurementUnit, "ProductWeightMeasurementUnit", "csharp");
@@clientName(Specification, "ProductSpecification", "csharp");
@@clientName(LinkType, "ProductLinkType", "csharp");
@@clientName(Link, "ProductLink", "csharp");
@@clientName(LengthHeightUnit, "ProductLengthHeightWidthUnit", "csharp");
@@clientName(ProductFamiliesMetadata,
  "ProductFamiliesMetadataListResult",
  "csharp"
);
@@clientName(ProductFamiliesMetadataDetails,
  "ProductFamiliesMetadata",
  "csharp"
);
@@clientName(DisplayInfo, "ProductDisplayInfo", "csharp");
@@clientName(DisabledReason, "ProductDisabledReason", "csharp");
@@clientName(Dimensions, "ProductDimensions", "csharp");
@@clientName(DescriptionType, "ProductDescriptionType", "csharp");
@@clientName(Description, "ProductDescription", "csharp");
@@clientName(Configuration, "ProductConfiguration", "csharp");
@@clientName(AvailabilityStage, "ProductAvailabilityStage", "csharp");
@@clientName(AvailabilityInformation,
  "ProductAvailabilityInformation",
  "csharp"
);
@@clientName(OrderItemReturnEnum, "OrderItemReturnStatus", "csharp");
@@clientName(Preferences, "OrderItemPreferences", "csharp");
@@clientName(OrderItemCancellationEnum,
  "OrderItemCancellationStatus",
  "csharp"
);
@@clientName(StageStatus, "EdgeOrderStageStatus", "csharp");
@@clientName(StageName, "EdgeOrderStageName", "csharp");
@@clientName(StageDetails, "EdgeOrderStageDetails", "csharp");
@@clientName(ShippingAddress, "EdgeOrderShippingAddress", "csharp");
@@clientName(MeteringType, "EdgeOrderProductMeteringType", "csharp");
@@clientName(MeterDetails, "EdgeOrderProductMeterDetails", "csharp");
@@clientName(ImageType, "EdgeOrderProductImageType", "csharp");
@@clientName(ImageInformation, "EdgeOrderProductImageInformation", "csharp");
@@clientName(DeviceDetails, "EdgeOrderProductDeviceDetails", "csharp");
@@clientName(CostInformation, "EdgeOrderProductCostInformation", "csharp");
@@clientName(ChargingType, "EdgeOrderProductChargingType", "csharp");
@@clientName(BillingMeterDetails,
  "EdgeOrderProductBillingMeterDetails",
  "csharp"
);
@@clientName(Product, "EdgeOrderProduct", "csharp");
@@clientName(ReturnOrderItemDetails, "EdgeOrderItemReturnContent", "csharp");
@@clientName(OrderItemDetails, "EdgeOrderItemDetails", "csharp");
@@clientName(OrderItemDetails.managementRpDetailsList,
  "ManagementRPDetailsList",
  "csharp"
);
@@clientName(CancellationReason, "EdgeOrderItemCancellationReason", "csharp");
@@clientName(AddressProperties, "EdgeOrderItemAddressProperties", "csharp");
@@clientName(AddressDetails, "EdgeOrderItemAddressDetails", "csharp");
@@clientName(AddressValidationStatus,
  "EdgeOrderAddressValidationStatus",
  "csharp"
);
@@clientName(AddressType, "EdgeOrderAddressType", "csharp");
@@clientName(ContactDetails, "EdgeOrderAddressContactDetails", "csharp");
@@clientName(ActionStatusEnum, "EdgeOrderActionStatus", "csharp");
@@clientName(ConfigurationFilter, "ConfigurationFilters", "csharp");
@@clientName(OrderResource, "EdgeOrder", "csharp");
@@clientName(AddressResource, "EdgeOrderAddress", "csharp");
@@clientName(OrderItemResource, "EdgeOrderItem", "csharp");
@@clientName(NotificationPreference.sendNotification,
  "IsNotificationRequired",
  "csharp"
);
@@clientName(FilterableProperty.type, "SupportedFilterType", "csharp");
@@clientName(ReturnOrderItemDetails.shippingBoxRequired,
  "IsShippingBoxRequired",
  "csharp"
);
@@clientName(WeightMeasurementUnit.LBS, "Lbs", "csharp");
@@clientName(WeightMeasurementUnit.KGS, "Kgs", "csharp");
@@clientName(AvailabilityStage.Signup, "SignUp", "csharp");
@@clientName(ProductsAndConfigurationsOperationGroup.listConfigurations,
  "GetConfigurations",
  "csharp"
);
@@clientName(ProductsAndConfigurationsOperationGroup.listProductFamilies,
  "GetProductFamilies",
  "csharp"
);
@@clientName(ProductsAndConfigurationsOperationGroup.listProductFamiliesMetadata,
  "GetProductFamiliesMetadata",
  "csharp"
);
@@alternateType(OrderItemProperties.orderId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(OrderProperties.orderItemIds,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(ReverseShippingDetails.trackingUrl, url, "csharp");
@@alternateType(Link.linkUrl, url, "csharp");
@@alternateType(ImageInformation.imageUrl, url, "csharp");
@@alternateType(CostInformation.billingInfoUrl, url, "csharp");
@@alternateType(ForwardShippingDetails.trackingUrl, url, "csharp");
@@alternateType(Pav2MeterDetails.meterGuid, Azure.Core.uuid, "csharp");
