import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ContainerService;
/**
 * Namespace managed by ARM.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(ManagedCluster)
model ManagedNamespace
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<NamespaceProperties> {
  ...ResourceNameParameter<
    Resource = ManagedNamespace,
    KeyName = "managedNamespaceName",
    SegmentName = "managedNamespaces",
    NamePattern = "[a-z0-9]([-a-z0-9]*[a-z0-9])?"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

@armResourceOperations
interface ManagedNamespaces {
  /**
   * Gets the specified namespace of a managed cluster.
   */
  get is ArmResourceRead<ManagedNamespace>;

  /**
   * Creates or updates a namespace managed by ARM for the specified managed cluster. Users can configure aspects like resource quotas, network ingress/egress policies, and more. See aka.ms/aks/managed-namespaces for more details.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedNamespace>;

  /**
   * Updates tags on a managed namespace.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<ManagedNamespace, PatchModel = TagsObject>;

  /**
   * Deletes a namespace.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedNamespace,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of managed namespaces in the specified managed cluster.
   */
  listByManagedCluster is ArmResourceListByParent<ManagedNamespace>;

  /**
   * Lists the credentials of a namespace.
   */
  listCredential is ArmResourceActionSync<
    ManagedNamespace,
    void,
    ArmResponse<CredentialResults>
  >;
}

@@maxLength(ManagedNamespace.name, 63);
@@minLength(ManagedNamespace.name, 1);
@@doc(ManagedNamespace.name, "The name of the managed namespace.");
@@doc(ManagedNamespace.properties, "Properties of a namespace.");
@@doc(ManagedNamespaces.createOrUpdate::parameters.resource,
  "The namespace to create or update."
);
@@doc(ManagedNamespaces.update::parameters.properties,
  "Parameters supplied to the patch namespace operation, we only support patch tags for now."
);
