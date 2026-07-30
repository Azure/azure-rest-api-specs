import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Solutions;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationPatchable.properties);

@@clientName(Applications.createOrUpdate::parameters.resource, "parameters");
@@clientName(Applications.update::parameters.properties, "parameters");
@@clientName(Applications.updateAccess::parameters.body, "parameters");
@@clientName(Applications.listTokens::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Application.properties);

@@clientName(
  ApplicationDefinitions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(
  ApplicationDefinitions.update::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ApplicationDefinition.properties);

@@clientLocation(JitRequestDefinitions.get, "jitRequests");
@@clientLocation(JitRequestDefinitions.createOrUpdate, "jitRequests");
@@clientName(
  JitRequestDefinitions.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(JitRequestDefinitions.update, "jitRequests");
@@clientName(JitRequestDefinitions.update::parameters.properties, "parameters");
@@clientLocation(JitRequestDefinitions.delete, "jitRequests");
@@clientLocation(JitRequestDefinitions.listByResourceGroup, "jitRequests");
@@clientLocation(JitRequestDefinitions.listBySubscription, "jitRequests");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(JitRequestDefinition.properties);

@@clientLocation(ApplicationsOperationGroup.getById, Applications);
@@clientLocation(ApplicationsOperationGroup.deleteById, Applications);
@@clientLocation(ApplicationsOperationGroup.createOrUpdateById, Applications);
@@clientLocation(ApplicationsOperationGroup.updateById, Applications);

@@clientLocation(
  ApplicationDefinitionOpsById.getById,
  "ApplicationDefinitions"
);

@@clientLocation(
  ApplicationDefinitionOpsById.createOrUpdateById,
  "ApplicationDefinitions"
);

@@clientLocation(
  ApplicationDefinitionOpsById.updateById,
  "ApplicationDefinitions"
);

@@clientLocation(
  ApplicationDefinitionOpsById.deleteById,
  "ApplicationDefinitions"
);

@@clientName(portalRegistryPackage::parameters.body, "parameters");

@@clientLocation(Operations.list, Microsoft.Solutions);
@@clientName(Operations.list, "ListOperations");

@@clientLocation(
  ApplicationDefinitionListOperationGroup.listByResourceGroup,
  "ApplicationDefinitions"
);
@@clientLocation(
  ApplicationDefinitionListOperationGroup.listBySubscription,
  "ApplicationDefinitions"
);
@@clientName(
  ApplicationDefinitionOpsById.createOrUpdateById::parameters.resource,
  "parameters"
);
@@clientName(
  ApplicationDefinitionOpsById.updateById::parameters.properties,
  "parameters"
);
