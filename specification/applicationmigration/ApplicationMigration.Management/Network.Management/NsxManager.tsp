import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;

/**
 * An NSX Manager resource discovered within a network site.
 */
@parentResource(NetworkSite)
model NsxManager
  is Azure.ResourceManager.ProxyResource<NsxManagerProperties, false> {
  ...ResourceNameParameter<
    Resource = NsxManager,
    KeyName = "managerName",
    SegmentName = "nsxManagers",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of an NSX Manager.
 */
model NsxManagerProperties is AzureResourceProperties {
  /** The fully qualified domain name of the NSX Manager. */
  fqdn: string;

  /** The run-as account credential reference. */
  runAsAccount?: string;

  /** The NSX Manager version. */
  version?: string;

  /** Whether this is a global manager. */
  isGlobalManager?: boolean;

  /** ARM resource IDs of local NSX Manager references. */
  localNsxManagerArmIds?: Azure.Core.armResourceIdentifier[];

  /** ARM resource IDs of managed vCenter servers. */
  vcenterArmIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OffAzure/vmwareSites/vcenters";
    }
  ]>[];
}

@armResourceOperations
interface NsxManagers {
  /**
   * Gets the NsxManager resource.
   */
  get is ArmResourceRead<NsxManager>;

  /**
   * Creates or updates the NsxManager resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<NsxManager>;

  /**
   * Patches the NsxManager resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<NsxManager, NsxManagerPatchProperties>;

  /**
   * Deletes the NsxManager resource.
   */
  delete is ArmResourceDeleteSync<NsxManager>;

  /**
   * Lists NsxManager resources within a network site.
   */
  listByNetworkSite is ArmResourceListByParent<
    NsxManager,
    Response = ArmResponse<NsxManagerList>
  >;
}

model NsxManagerList is Azure.Core.Page<NsxManager>;

@@maxLength(NsxManager.name, 63);
@@minLength(NsxManager.name, 3);
@@doc(NsxManager.name, "The name of the NSX Manager.");
