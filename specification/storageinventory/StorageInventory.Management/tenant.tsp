import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.StorageInventory;

/** Tenant properties for storage inventory */
model TenantProperties {
  /** Name of tenant */
  tenant?: string;

  /** Specifies the operational environment of the tenant */
  environment?: string;

  /** Specifies the geographic domain associated with the tenant */
  geoDomain?: string;

  /** Specifies the name of the tenant's paired geographic region used for disaster recovery and geo-replication */
  geoPairName?: string;

  /** Specifies the geographic region where the tenant's resources are physically hosted */
  geoRegion?: string;

  /** Describes the physical hardware configuration of the tenant */
  hardwareSetup?: string;

  /** Indicates whether the tenant is currently in the buildout phase and not yet fully provisioned */
  inBuildOut?: boolean;

  /** Indicates whether the tenant has entered the decommissioning workflow */
  inDecom?: boolean;

  /** Specifies the physical data center location where the tenant's resources are deployed */
  dataCenter?: string;

  /** Specifies the intended purpose or role of the tenant */
  intent?: string;

  /** Indicates whether the tenant is fully provisioned and ready to serve customer workloads */
  isReadyForCustomer?: boolean;

  /** Indicates the Zone Redundant Storage (ZRS) configuration type for this tenant */
  zrsSetup?: string;

  /** Indicates whether the tenant has Limitless capabilities enabled */
  isLimitless?: boolean;

  /** Indicates whether RDMA (Remote Direct Memory Access) is enabled for this tenant */
  isRdma?: boolean;

  /** Name of the RSRP (Regional Storage Resource Provider) tenant responsible for control-plane operations of this tenant */
  rsrpName?: string;

  /** Indicates the current storage system version (STG) deployed for this tenant */
  stg?: string;

  /** Specifies the Azure Resource Manager (ARM) region where the tenant's resources are physically deployed */
  armRegion?: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;
}

@tenantResource
model Tenant is ProxyResource<TenantProperties> {
  ...ResourceNameParameter<Tenant>;
}

@armResourceOperations
interface Tenants {
  get is ArmResourceRead<Tenant>;
  list is ArmResourceListByParent<Tenant>;
}
