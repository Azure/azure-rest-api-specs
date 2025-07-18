import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EdgeOrder;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Configuration.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ChildConfiguration.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ProductFamily.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ProductLine.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Product.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ProductFamiliesMetadataDetails.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AddressUpdateParameter.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(OrderItemUpdateParameter.properties);

@@clientName(AddressResources.create::parameters.resource, "addressResource");
@@clientName(AddressResources.update::parameters.properties,
  "addressUpdateParameter"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AddressResource.properties);

@@clientName(OrderItemResources.create::parameters.resource,
  "orderItemResource"
);
@@clientName(OrderItemResources.update::parameters.properties,
  "orderItemUpdateParameter"
);
@@clientName(OrderItemResources.cancel::parameters.body, "cancellationReason");
@@clientName(OrderItemResources.returnOrderItem::parameters.body,
  "returnOrderItemDetails"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(OrderItemResource.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(OrderResource.properties);
@@clientName(ProductsAndConfigurationsOperationGroup.listConfigurations::parameters.body,
  "configurationsRequest"
);
@@clientName(ProductsAndConfigurationsOperationGroup.listProductFamilies::parameters.body,
  "productFamiliesRequest"
);
// @@clientLocation decorators for operations with custom @operationId
// These ensure consistent operationId generation in the output

// AddressResources interface operations
@@clientLocation(AddressResources.get, "Addresses", "!csharp");
@@clientLocation(AddressResources.create, "Addresses", "!csharp");
@@clientLocation(AddressResources.update, "Addresses", "!csharp");
@@clientLocation(AddressResources.delete, "Addresses", "!csharp");
@@clientLocation(AddressResources.listByResourceGroup, "Addresses", "!csharp");
@@clientLocation(AddressResources.listBySubscription, "Addresses", "!csharp");

// OrderItemResources interface operations
@@clientLocation(OrderItemResources.get, "OrderItems", "!csharp");
@@clientLocation(OrderItemResources.create, "OrderItems", "!csharp");
@@clientLocation(OrderItemResources.update, "OrderItems", "!csharp");
@@clientLocation(OrderItemResources.delete, "OrderItems", "!csharp");
@@clientLocation(OrderItemResources.listByResourceGroup,
  "OrderItems",
  "!csharp"
);
@@clientLocation(OrderItemResources.listBySubscription,
  "OrderItems",
  "!csharp"
);
@@clientLocation(OrderItemResources.cancel, "OrderItems", "!csharp");
@@clientLocation(OrderItemResources.returnOrderItem, "OrderItems", "!csharp");
@@clientName(OrderItemResources.returnOrderItem, "Return");

// OrderResources interface operations
@@clientLocation(OrderResources.get, "Orders", "!csharp");

// ProductsAndConfigurationsOperationGroup interface operations
@@clientLocation(ProductsAndConfigurationsOperationGroup.listConfigurations,
  "ProductsAndConfigurations"
);
@@clientLocation(ProductsAndConfigurationsOperationGroup.listProductFamilies,
  "ProductsAndConfigurations"
);
@@clientLocation(ProductsAndConfigurationsOperationGroup.listProductFamiliesMetadata,
  "ProductsAndConfigurations"
);

// OrdersOperationGroup interface operations
@@clientLocation(OrdersOperationGroup.listBySubscription, "Orders");
@@clientLocation(OrdersOperationGroup.listByResourceGroup, "Orders");

//SDKValidation
@@clientName(AddressResource, "EdgeOrderAddress", "csharp");
@@clientName(OrderItemResource, "EdgeOrderItem", "csharp");
@@clientName(OrderResource, "EdgeOrder", "csharp");
@@clientName(ContactDetails, "EdgeOrderAddressContactDetails", "csharp");
@@clientName(AddressDetails, "EdgeOrderItemAddressDetails", "csharp");
@@clientName(AddressProperties, "EdgeOrderItemAddressProperties", "csharp");
@@clientName(CancellationReason, "EdgeOrderItemCancellationReason", "csharp");
@@clientName(ReturnOrderItemDetails, "EdgeOrderItemReturnContent", "csharp");
@@clientName(Configuration, "EdgeOrderConfiguration", "csharp");
@@clientName(BasicInformation, "EdgeOrderProduct", "csharp");
@@clientName(BillingMeterDetails,
  "EdgeOrderProductBillingMeterDetails",
  "csharp"
);
@@clientName(CostInformation, "EdgeOrderProductCostInformation", "csharp");
@@clientName(DeviceDetails, "EdgeOrderProductDeviceDetails", "csharp");
@@clientName(ImageInformation, "EdgeOrderProductImageInformation", "csharp");
@@clientName(ImageType, "EdgeOrderProductImageType", "csharp");
@@clientName(MeterDetails, "EdgeOrderProductMeterDetails", "csharp");
@@clientName(ShippingAddress, "EdgeOrderShippingAddress", "csharp");
@@clientName(StageDetails, "EdgeOrderStageDetails", "csharp");
@@clientName(Preferences, "OrderItemPreferences", "csharp");
@@clientName(AvailabilityInformation,
  "ProductAvailabilityInformation",
  "csharp"
);
@@clientName(Description, "ProductDescription", "csharp");
@@clientName(Dimensions, "ProductDimensions", "csharp");
@@clientName(DisplayInfo, "ProductDisplayInfo", "csharp");
@@clientName(Link, "ProductLink", "csharp");
@@clientName(Specification, "ProductSpecification", "csharp");
@@clientName(OrderItemDetailsUpdateParameter, "OrderItemDetailsUpdateContent", "csharp");
@@clientName(OkResponse, "EdgeOrderOkResponse", "csharp");