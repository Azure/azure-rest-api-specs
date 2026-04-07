import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Insights;

@@clientLocation(DataCollectionEndpointResources.get,
  "DataCollectionEndpoints"
);
@@clientLocation(DataCollectionEndpointResources.create,
  "DataCollectionEndpoints"
);
@@clientName(DataCollectionEndpointResources.create::parameters.resource,
  "body"
);
@@clientLocation(DataCollectionEndpointResources.update,
  "DataCollectionEndpoints"
);
@@clientName(DataCollectionEndpointResources.update::parameters.properties,
  "body"
);
@@clientLocation(DataCollectionEndpointResources.delete,
  "DataCollectionEndpoints"
);
@@clientLocation(DataCollectionEndpointResources.listByResourceGroup,
  "DataCollectionEndpoints"
);
@@clientLocation(DataCollectionEndpointResources.listBySubscription,
  "DataCollectionEndpoints"
);
@@clientLocation(DataCollectionEndpointResources.listByDataCollectionEndpoint,
  "DataCollectionRuleAssociations"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DataCollectionEndpointResource.properties);

@@clientLocation(DataCollectionRuleAssociationProxyOnlyResources.get,
  "DataCollectionRuleAssociations"
);
@@clientLocation(DataCollectionRuleAssociationProxyOnlyResources.create,
  "DataCollectionRuleAssociations"
);
@@clientName(DataCollectionRuleAssociationProxyOnlyResources.create::parameters.resource,
  "body"
);
@@clientLocation(DataCollectionRuleAssociationProxyOnlyResources.delete,
  "DataCollectionRuleAssociations"
);
@@clientLocation(DataCollectionRuleAssociationProxyOnlyResources.listByResource,
  "DataCollectionRuleAssociations"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DataCollectionRuleAssociationProxyOnlyResource.properties
);

@@clientLocation(DataCollectionRuleResources.get, "DataCollectionRules");
@@clientLocation(DataCollectionRuleResources.create, "DataCollectionRules");
@@clientName(DataCollectionRuleResources.create::parameters.resource, "body");
@@clientLocation(DataCollectionRuleResources.update, "DataCollectionRules");
@@clientName(DataCollectionRuleResources.update::parameters.properties, "body");
@@clientLocation(DataCollectionRuleResources.delete, "DataCollectionRules");
@@clientLocation(DataCollectionRuleResources.listByResourceGroup,
  "DataCollectionRules"
);
@@clientLocation(DataCollectionRuleResources.listBySubscription,
  "DataCollectionRules"
);
@@clientLocation(DataCollectionRuleResources.listByRule,
  "DataCollectionRuleAssociations"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DataCollectionRuleResource.properties);
