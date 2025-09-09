import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EdgeOrder;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Configuration.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ChildConfiguration.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProductFamily.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProductLine.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Product.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProductFamiliesMetadataDetails.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AddressUpdateParameter.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OrderItemUpdateParameter.properties
);

@@clientName(AddressResources.create::parameters.resource, "addressResource");
@@clientName(AddressResources.update::parameters.properties,
  "addressUpdateParameter"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(OrderItemResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
@@clientLocation(AddressResources.get, "Addresses");
@@clientLocation(AddressResources.create, "Addresses");
@@clientLocation(AddressResources.update, "Addresses");
@@clientLocation(AddressResources.delete, "Addresses");
@@clientLocation(AddressResources.listByResourceGroup, "Addresses");
@@clientLocation(AddressResources.listBySubscription, "Addresses");

// OrderItemResources interface operations
@@clientLocation(OrderItemResources.get, "OrderItems");
@@clientLocation(OrderItemResources.create, "OrderItems");
@@clientLocation(OrderItemResources.update, "OrderItems");
@@clientLocation(OrderItemResources.delete, "OrderItems");
@@clientLocation(OrderItemResources.listByResourceGroup, "OrderItems");
@@clientLocation(OrderItemResources.listBySubscription, "OrderItems");
@@clientLocation(OrderItemResources.cancel, "OrderItems");
@@clientLocation(OrderItemResources.returnOrderItem, "OrderItems");
@@clientName(OrderItemResources.returnOrderItem, "Return");

// OrderResources interface operations
@@clientLocation(OrderResources.get, "Orders");

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
