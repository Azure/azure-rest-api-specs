import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

#suppress "@azure-tools/typespec-azure-core/casing-style"
@armProviderNamespace("Microsoft.KX")
@service({
  title: "KX Resource Provider",
  version: "2023-09-01-preview",
})
@Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.KX;

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;

@doc("A kdbInsightsEnterprise resource")
model KdbInsightsEnterpriseResource
  is TrackedResource<KdbInsightsEnterpriseProperties> {
  @doc("The name of the kdbInsightsEnterprise resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("kdbInsightsEnterpriseName")
  @segment("kdbInsightsEnterprise")
  @path
  name: string;
}

@lroStatus
@doc("The full set of provisioning states")
enum ProvisioningState {
  ...Azure.ResourceManager.ResourceProvisioningState,

  @doc("Provisioning the resource is in progress")
  Provisioning,

  @doc("Resource is being updated")
  Updating,

  @doc("Resource is being deleted")
  Deleting,

  @doc("The change request has been accepted")
  Accepted,
}

@doc("Accepted values for ReadWriteManyStorageClass property")
enum ReadWriteManyStorageClassOptions {
  @doc("Use Azure Files Premium for ReadWriteMany volumes")
  AzureFile: "azurefile-premium-kxi-nfs",

  @doc("Use RookCeph for ReadWriteMany volumes")
  RookCeph: "rook-cephfs",
}

@doc("Configuration of the managed resource group associated with the resource.")
model ManagedResourceGroupConfiguration {
  @doc("The resource group name.")
  name: string;

  @doc("The resource group location.")
  location: string;
}

@doc("Details of the kdbInsightsEnterprise resource.")
model KdbInsightsEnterpriseProperties {
  @visibility("create")
  @doc("Keycloak admin password. Keycloak is kdb Insights Enterprise's Identity and Access Management. Please make note of this Admin Password to control user access to Insights.")
  @pattern("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\\$%\\^&\\*])[a-zA-Z0-9!@#\\$%\\^&\\*]{14,320}$")
  @secret
  keycloakAdminPassword: string;

  @visibility("read", "create")
  @doc("The Keycloak user name. Keycloak is kdb Insights Enterprise's Identity and Access Management. Please make note of this Admin Username to control user access to Insights.")
  @pattern("^[A-Za-z0-9]{4,20}$")
  keycloakAdminUsername?: string = "user";

  @visibility("create")
  @doc("The password to be used to log in to the kdb Insights Enterprise UI.")
  @pattern("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\\$%\\^&\\*])[a-zA-Z0-9!@#\\$%\\^&\\*]{14,320}$")
  @secret
  uiPassword: string;

  @visibility("read", "create")
  @doc("Email address for licensing and certificate registration")
  @pattern("^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
  emailAddress: string;

  @visibility("read", "create")
  @doc("The username to be used to log in to the kdb Insights Enterprise UI")
  @pattern("^[A-Za-z0-9]{8,20}$")
  uiUsername: string;

  @visibility("read", "create")
  @doc("AKS System node pool VM size")
  systemNodePoolVmSize?: string = "Standard_D4d_v4";

  @visibility("read", "create")
  @doc("Number of VMs in the AKS System Node Pool")
  @minValue(3)
  @maxValue(10)
  systemNodePoolVmCount?: int32 = 3;

  @visibility("read", "create")
  @doc("AKS User node pool VM size")
  userNodePoolVmSize?: string = "Standard_D16ds_v4";

  @visibility("read", "create")
  @doc("Number of VMs in the AKS System Node Pool")
  @minValue(3)
  @maxValue(10)
  userNodePoolVmCount?: int32 = 3;

  @visibility("read", "create")
  @doc("Storage Class for ReadWriteMany volumes. The storage class backing persistence volume claims for pods that have a ReadWriteMany (RWX) claim type.")
  readWriteManyStorageClass?: ReadWriteManyStorageClassOptions = ReadWriteManyStorageClassOptions.AzureFile;

  @visibility("read", "create")
  @doc("Indicate whether to deploy a Ceph cluster into AKS and enable rook-cephfs storage class. Requires additional compute for the cluster.")
  isRookCeph?: boolean = false;

  @visibility("read", "create")
  @doc("Indicate whether to enable Microsoft Defender for Containers")
  securityMonitoringEnabled?: boolean = false;

  @visibility("read", "create")
  @doc("Indicate whether to use Premium Storage for ReadWriteOnce volumes")
  isPremiumStorageEnabled?: boolean = false;

  @visibility("read", "create")
  @doc("Email address for alert notifications")
  @pattern("^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
  clientNotificationAddress?: string;

  @visibility("read", "create")
  @doc("A custom *.*.0.0/16 Address space for the kdb Insights Enterprise cluster Virtual Network")
  @pattern("^(?=.{10,14}$)\\b(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){2}(0\\.0\\/16)$")
  vnetAddressSpace?: string = "10.0.0.0/16";

  @visibility("read", "create")
  @doc("Authorized IP ranges. Provide a public IPv4 address range using CIDR notation (e.g. 20.38.1.0/24), or a public IP address (e.g. 52.16.10.28). You can also provide a comma-separated list of public IP addresses or address ranges. When you specify a CIDR range, start with the first IP address in the range. For example, 137.117.106.90/29 is a valid range, but make sure you specify the first IP address in the range, such as 137.117.106.88/29.")
  @pattern("^(?=.{1,320}$)\\b(?!(10\\.|172\\.(1[6-9]|2[0-9]|3[0-1])\\.|192\\.168))(((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\\/([1-9]|1[0-9]|2[0-8]|3[0-2])){0,1}){0,1}((\\s*,\\s*)(?=[^,])){0,1})+$")
  authorizedIpRanges?: string;

  @visibility("read", "create")
  @doc("AKS Container insights retention period in days")
  @minValue(30)
  @maxValue(730)
  aksContainerInsightsRetentionDays?: int32 = 30;

  @visibility("read", "create")
  @doc("AKS Kubernetes audit log retention period in days. A value of 0 will retain the events indefinitely. Must be a positive integer or 0.")
  aksLogRetentionDays?: int32 = 30;

  @visibility("read", "create")
  @doc("AKS Kubernetes metrics retention period in days. A value of 0 will retain the metrics indefinitely. Must be a positive integer or 0.")
  aksMetricsRetentionDays?: int32 = 30;

  @visibility("read", "create")
  @doc("Availability Zones options.")
  availabilityZones?: string[] = ["1", "2", "3"];

  @visibility("read", "create")
  @doc("The project name.")
  projectName?: string = "kdbInsightsEnt";

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read")
  @doc("Configuration of the managed resource group associated with the resource.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;
}

@armResourceOperations
interface KdbInsightsEnterprise {
  get is ArmResourceRead<KdbInsightsEnterpriseResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<KdbInsightsEnterpriseResource>;
  update is ArmResourcePatchAsync<
    KdbInsightsEnterpriseResource,
    KdbInsightsEnterpriseProperties
  >;
  delete is ArmResourceDeleteAsync<KdbInsightsEnterpriseResource>;
  listByResourceGroup is ArmResourceListByParent<KdbInsightsEnterpriseResource>;
  listBySubscription is ArmListBySubscription<KdbInsightsEnterpriseResource>;
}

interface Operations extends Azure.ResourceManager.Operations {}
