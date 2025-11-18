import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EdgeOrder;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Configuration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ChildConfiguration.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProductFamily.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProductLine.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Product.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProductFamiliesMetadataDetails.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AddressUpdateParameter.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OrderItemUpdateParameter.properties
);

@@clientName(AddressResources.create::parameters.resource, "addressResource");
@@clientName(AddressResources.update::parameters.properties,
  "addressUpdateParameter"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AddressResource.properties);

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OrderItemResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OrderResource.properties);
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
  "ProductsAndConfigurations",
  "!csharp"
);
@@clientLocation(ProductsAndConfigurationsOperationGroup.listProductFamilies,
  "ProductsAndConfigurations",
  "!csharp"
);
@@clientLocation(ProductsAndConfigurationsOperationGroup.listProductFamiliesMetadata,
  "ProductsAndConfigurations",
  "!csharp"
);

// OrdersOperationGroup interface operations
@@clientLocation(OrdersOperationGroup.listBySubscription, "Orders", "!csharp");
@@clientLocation(OrdersOperationGroup.listByResourceGroup, "Orders", "!csharp");
