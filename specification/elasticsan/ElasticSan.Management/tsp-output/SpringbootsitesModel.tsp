import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzureSpringBoot;
@doc("The springbootsites envelope resource definition.")
model SpringbootsitesModel is TrackedResource<SpringbootsitesProperties> {
  @doc("The springbootsites name.")
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-z][a-z0-9-]*$")
  @path
  @key("springbootsitesName")
  @segment("springbootsites")
  name: string;

  @doc("The extended location definition.")
  extendedLocation?: SpringbootsitesModelExtendedLocation;
}

@armResourceOperations
interface SpringbootsitesModels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a springbootsites resource.")
  @operationId("springbootsites_Get")
  get is ArmResourceRead<SpringbootsitesModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a springbootsites resource.")
  @operationId("springbootsites_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SpringbootsitesModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a springbootsites resource.")
  @operationId("springbootsites_Update")
  update is ArmCustomPatchAsync<
    SpringbootsitesModel,
    SpringbootsitesPatch,
    BaseParameters<SpringbootsitesModel>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a springbootsites resource.")
  @operationId("springbootsites_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    SpringbootsitesModel,
    BaseParameters<SpringbootsitesModel>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List springbootsites resource by resourceGroup.")
  @operationId("springbootsites_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<SpringbootsitesModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List springbootsites resource by subscription")
  @operationId("springbootsites_ListBySubscription")
  listBySubscription is ArmListBySubscription<SpringbootsitesModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Trigger refresh springbootsites action")
  @operationId("springbootsites_TriggerRefreshSite")
  triggerRefreshSite is ArmResourceActionNoResponseContentAsync<
    SpringbootsitesModel,
    void,
    BaseParameters<SpringbootsitesModel>,
    ArmLroLocationHeader
  >;
}

@@projectedName(SpringbootsitesModels.createOrUpdate::parameters.resource,
  "json",
  "springbootsites"
);
@@extension(SpringbootsitesModels.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "springbootsites"
);
@@doc(SpringbootsitesModels.createOrUpdate::parameters.resource,
  "Create a springbootsites payload."
);
@@projectedName(SpringbootsitesModels.update::parameters.properties,
  "json",
  "springbootsites"
);
@@extension(SpringbootsitesModels.update::parameters.properties,
  "x-ms-client-name",
  "springbootsites"
);
@@doc(SpringbootsitesModels.update::parameters.properties,
  "Update a springbootsites payload."
);
