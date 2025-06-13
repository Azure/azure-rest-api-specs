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
