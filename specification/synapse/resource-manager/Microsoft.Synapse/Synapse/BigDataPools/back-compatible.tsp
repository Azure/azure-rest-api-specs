import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace BigDataPools;

@@clientLocation(BigDataPoolResourceInfos.get, "BigDataPools");
@@clientLocation(BigDataPoolResourceInfos.createOrUpdate, "BigDataPools");
@@clientName(
  BigDataPoolResourceInfos.createOrUpdate::parameters.resource,
  "bigDataPoolInfo"
);
@@clientLocation(BigDataPoolResourceInfos.update, "BigDataPools");
@@clientName(
  BigDataPoolResourceInfos.update::parameters.properties,
  "bigDataPoolPatchInfo"
);
@@clientLocation(BigDataPoolResourceInfos.delete, "BigDataPools");
@@clientLocation(BigDataPoolResourceInfos.listByWorkspace, "BigDataPools");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(BigDataPoolResourceInfo.properties);

@@clientLocation(LibraryResources.get, "Library");
@@clientLocation(LibraryResources.listByWorkspace, "Libraries");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(LibraryResource.properties);

@@clientLocation(SparkConfigurationResources.get, "SparkConfiguration");
@@clientLocation(
  SparkConfigurationResources.listByWorkspace,
  "SparkConfigurations"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SparkConfigurationResource.properties);
