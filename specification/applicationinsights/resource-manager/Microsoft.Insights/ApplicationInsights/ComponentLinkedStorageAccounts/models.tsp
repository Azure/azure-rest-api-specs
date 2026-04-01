import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace ComponentLinkedStorageAccountApi;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union StorageType {
  string,

  /**
   * ServiceProfiler
   */
  ServiceProfiler: "ServiceProfiler",
}

/**
 * An Application Insights component linked storage account
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LinkedStorageAccountsProperties {
  /**
   * Linked storage account resource ID
   */
  linkedStorageAccount?: string;
}

/**
 * An Application Insights component linked storage accounts patch
 */
model ComponentLinkedStorageAccountsPatch {
  /**
   * The properties of the linked storage accounts.
   */
  properties?: LinkedStorageAccountsProperties;
}
