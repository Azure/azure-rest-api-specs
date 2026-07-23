import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Common;
using Azure.ClientGenerator.Core;

namespace Microsoft.Network;

/**
 * First party service tag resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Follows the shared Network Common.Resource pattern used by every resource in this converted project"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Network resources extend the shared Common.Resource custom resource for backward compatibility with the existing swagger hierarchy"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Back compatibility with the previous Network AutoRest C# hierarchy"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy.feature decorator is required for swagger file splitting in this converted project"
@added(Versions.v2025_09_01)
@Azure.ResourceManager.Legacy.feature(Features.firstPartyServiceTag)
@Http.Private.includeInapplicableMetadataInPayload(false)
model FirstPartyServiceTag extends Common.Resource {
  /**
   * Properties of the first party service tag.
   */
  properties?: FirstPartyServiceTagPropertiesFormat;

  /**
   * The unique identifier of the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The name of the first party service tag.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("firstPartyServiceTagName")
  @segment("firstPartyServiceTags")
  @maxLength(80)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]{0,79}$")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Etag is a standard read-only envelope property across all Network resources for backward compatibility"
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Properties of the first party service tag.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy.feature decorator is required for swagger file splitting in this converted project"
@added(Versions.v2025_09_01)
@Azure.ResourceManager.Legacy.feature(Features.firstPartyServiceTag)
model FirstPartyServiceTagPropertiesFormat {
  /**
   * The value of the first party service tag.
   */
  value: string;

  /**
   * The reason for failure, if any.
   */
  @visibility(Lifecycle.Read)
  failedReason?: string;

  /**
   * The resource GUID property of the first party service tag resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the first party service tag resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FirstPartyServiceTags interface uses Azure.ResourceManager.Legacy features for backward compatibility with existing swagger API"
@added(Versions.v2025_09_01)
@Azure.ResourceManager.Legacy.feature(Features.firstPartyServiceTag)
@armResourceOperations
interface FirstPartyServiceTags {
  /**
   * Gets the specified first party service tag.
   */
  get is ArmResourceRead<FirstPartyServiceTag, Error = CloudError>;

  /**
   * Creates or updates a first party service tag.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FirstPartyServiceTag,
    Error = CloudError
  >;

  /**
   * Updates a first party service tag tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchAsync<
    FirstPartyServiceTag,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified first party service tag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Matching existing Network resource pattern (VirtualNetwork, LoadBalancer, etc.) that supports both sync (200) and async (202) delete"
  delete is ArmResourceDeleteWithoutOkAsync<
    FirstPartyServiceTag,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the first party service tags in a resource group.
   */
  list is ArmResourceListByParent<FirstPartyServiceTag, Error = CloudError>;

  /**
   * Gets all the first party service tags in a subscription.
   */
  listAll is ArmListBySubscription<FirstPartyServiceTag, Error = CloudError>;
}

@@doc(FirstPartyServiceTag.name, "The name of the first party service tag.");
@@doc(
  FirstPartyServiceTag.properties,
  "Properties of the first party service tag."
);
@@doc(
  FirstPartyServiceTags.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update first party service tag operation."
);
@@doc(
  FirstPartyServiceTags.updateTags::parameters.properties,
  "Parameters supplied to update first party service tag tags."
);
@@clientName(
  FirstPartyServiceTags.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(
  FirstPartyServiceTags.updateTags::parameters.properties,
  "parameters"
);

// Link x-ms-examples for swagger validation
#suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-examples extension is required for swagger example validation"
@@extension(
  FirstPartyServiceTags.listAll,
  "x-ms-examples",
  #{
    `List all first party service tags`: #{
      $ref: "./examples/FirstPartyServiceTagListAll.json",
    },
  }
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-examples extension is required for swagger example validation"
@@extension(
  FirstPartyServiceTags.list,
  "x-ms-examples",
  #{
    `List first party service tags in resource group`: #{
      $ref: "./examples/FirstPartyServiceTagList.json",
    },
  }
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-examples extension is required for swagger example validation"
@@extension(
  FirstPartyServiceTags.get,
  "x-ms-examples",
  #{
    `Get first party service tag`: #{
      $ref: "./examples/FirstPartyServiceTagGet.json",
    },
  }
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-examples extension is required for swagger example validation"
@@extension(
  FirstPartyServiceTags.createOrUpdate,
  "x-ms-examples",
  #{
    `Create first party service tag`: #{
      $ref: "./examples/FirstPartyServiceTagCreate.json",
    },
  }
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-examples extension is required for swagger example validation"
@@extension(
  FirstPartyServiceTags.updateTags,
  "x-ms-examples",
  #{
    `Update first party service tag tags`: #{
      $ref: "./examples/FirstPartyServiceTagUpdateTags.json",
    },
  }
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-examples extension is required for swagger example validation"
@@extension(
  FirstPartyServiceTags.delete,
  "x-ms-examples",
  #{
    `Delete first party service tag`: #{
      $ref: "./examples/FirstPartyServiceTagDelete.json",
    },
  }
);
