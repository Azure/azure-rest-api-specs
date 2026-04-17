import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridCompute;
/**
 * Describes a hybrid machine.
 */
model Machine is Azure.ResourceManager.TrackedResource<MachineProperties> {
  ...ResourceNameParameter<
    Resource = Machine,
    KeyName = "machineName",
    SegmentName = "machines",
    NamePattern = "^[a-zA-Z0-9-_\\.]{1,54}$"
  >;

  /**
   * The list of extensions affiliated to the machine
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  resources?: MachineExtension[];

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Azure.ResourceManager.CommonTypes.Identity;

  /**
   * Indicates which kind of Arc machine placement on-premises, such as HCI, SCVMM or VMware etc.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: ArcKindEnum;
}

alias MachineOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Legacy.Provider;
  },
  {
    /**
     * The name of the hybrid machine.
     */
    @path
    @segment("machines")
    name: string;
  }
>;

alias HybridIdentityMetadataOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Legacy.Provider;

    /**
     * The name of the hybrid machine.
     */
    @path
    @segment("machines")
    @minLength(1)
    @maxLength(54)
    @pattern("^[a-zA-Z0-9-_\\.]{1,54}$")
    machineName: string;
  },
  {
    /**
     * The id of the HybridIdentityMetadata to get.
     */
    @path
    @segment("hybridIdentityMetadata")
    @pattern("^[a-zA-Z0-9-_\\.]{1,54}$")
    metadataName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface Machines {
  /**
   * Retrieves information about the model view or the instance view of a hybrid machine.
   */
  @tag("machines")
  get is ArmResourceRead<
    Machine,
    Parameters = {
      /**
       * The expand expression to apply on the operation.
       */
      @query("$expand")
      $expand?: InstanceViewTypes;
    }
  >;

  /**
   * The operation to create or update a hybrid machine. Please note some properties can be set only during machine creation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("machines")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    Machine,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResourceUpdatedResponse<Machine>
  >;

  /**
   * The operation to update a hybrid machine.
   */
  @tag("machines")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Machine, PatchModel = MachineUpdate>;

  /**
   * The operation to delete a hybrid machine.
   */
  @tag("machines")
  delete is ArmResourceDeleteWithoutOkAsync<
    Machine,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader & ArmCombinedLroHeaders
  >;

  /**
   * Lists all the hybrid machines in the specified resource group. Use the nextLink property in the response to get the next page of hybrid machines.
   */
  @tag("machines")
  listByResourceGroup is ArmResourceListByParent<
    Machine,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Lists all the hybrid machines in the specified subscription. Use the nextLink property in the response to get the next page of hybrid machines.
   */
  @tag("machines")
  listBySubscription is ArmListBySubscription<Machine>;

  /**
   * The operation to assess patches on a hybrid machine identity in Azure.
   */
  @tag("machines")
  assessPatches is MachineOps.ActionAsync<
    Machine,
    void,
    MachineAssessPatchesResult
  >;

  /**
   * The operation to install patches on a hybrid machine identity in Azure.
   */
  @tag("machines")
  installPatches is MachineOps.ActionAsync<
    Machine,
    MachineInstallPatchesParameters,
    MachineInstallPatchesResult
  >;

  /**
   * The operation to Upgrade Machine Extensions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("UpgradeExtensions")
  @tag("MachineExtensions Upgrade")
  upgradeExtensions is ArmResourceActionAsync<
    Machine,
    MachineExtensionUpgrade,
    OkResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader & ArmCombinedLroHeaders
  >;

  /**
   * The operation to Setup Machine Extensions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SetupExtensions")
  @tag("MachineExtensions Setup")
  @action("addExtensions")
  setupExtensions is ArmResourceActionAsync<
    Machine,
    SetupExtensionRequest,
    ArmResponse<SetupExtensionRequest>,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmCombinedLroHeaders<FinalResult = SetupExtensionRequest>
  >;

  /**
   * The operation to get network information of hybrid machine
   */
  @tag("MachineNetworkProfile")
  @get
  @action("networkProfile")
  networkProfileGet is ArmResourceActionSync<
    Machine,
    void,
    ArmResponse<NetworkProfile>
  >;

  /**
   * Returns a Azure Arc PrivateLinkScope's validation details for a given machine.
   */
  @get
  @action("privateLinkScopes/current")
  getValidationDetailsForMachine is ArmResourceActionSync<
    Machine,
    void,
    ArmResponse<PrivateLinkScopeValidationDetails>
  >;

  /**
   * Returns the list of HybridIdentityMetadata of the given machine.
   */
  @summary("Implements GET HybridIdentityMetadata in a machine.")
  @tag("HybridIdentityMetadata")
  @action("hybridIdentityMetadata")
  @list
  @get
  listByMachines is ArmResourceActionSync<
    Machine,
    void,
    ArmResponse<HybridIdentityMetadataList>
  >;

  /**
   * Implements HybridIdentityMetadata GET method.
   */
  @summary("Gets HybridIdentityMetadata.")
  @tag("HybridIdentityMetadata")
  getHybridIdentityMetadata is HybridIdentityMetadataOps.Read<
    Machine,
    Response = ArmResponse<HybridIdentityMetadata>
  >;
}

@@maxLength(Machine.name, 54);
@@minLength(Machine.name, 1);
@@doc(Machine.name, "The name of the hybrid machine.");
@@doc(Machine.properties, "Hybrid Compute Machine properties");
@@doc(Machines.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create hybrid machine operation."
);
@@doc(Machines.update::parameters.properties,
  "Parameters supplied to the Update hybrid machine operation."
);
@@doc(Machines.installPatches::parameters.body,
  "Input for InstallPatches as directly received by the API"
);
@@doc(Machines.upgradeExtensions::parameters.body,
  "Parameters supplied to the Upgrade Extensions operation."
);
@@doc(Machines.setupExtensions::parameters.body,
  "Parameters supplied to the Setup Extensions operation."
);
