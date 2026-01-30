import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the module type.
 */
@parentResource(AutomationAccount)
model Module is Azure.ResourceManager.TrackedResource<ModuleProperties> {
  ...ResourceNameParameter<
    Resource = Module,
    KeyName = "moduleName",
    SegmentName = "modules",
    NamePattern = ""
  >;

  /**
   * Gets or sets the etag of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

alias ModuleOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the automation account. */
    @path
    @segment("automationAccounts")
    @key
    automationAccountName: string;
  },
  {
    /** The module name. */
    @path
    @segment("modules")
    @key
    moduleName: string;
  }
>;

@armResourceOperations
interface Modules {
  /**
   * Retrieve the module identified by module name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Module_Get")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/moduleoperations")
  get is ModuleOps.Read<Module>;

  /**
   * Create or Update the module identified by module name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Module_CreateOrUpdate")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/moduleoperations")
  createOrUpdate is ModuleOps.CreateOrUpdateSync<
    Module,
    Request = ModuleCreateOrUpdateParameters
  >;

  /**
   * Update the module identified by module name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Module_Update")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/moduleoperations")
  @patch(#{ implicitOptionality: false })
  update is ModuleOps.CustomPatchSync<
    Module,
    PatchModel = ModuleUpdateParameters
  >;

  /**
   * Delete the module by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Module_Delete")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/moduleoperations")
  delete is ModuleOps.DeleteSync<Module, Response = ArmDeletedResponse>;

  /**
   * Retrieve a list of modules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Module_ListByAutomationAccount")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/moduleoperations")
  listByAutomationAccount is ModuleOps.List<Module>;

  /**
   * Retrieve the activity in the module identified by module name and activity name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Activity_Get")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/activityoperations")
  @get
  activityGet is ModuleOps.Read<
    Module,
    Response = ArmResponse<Activity>,
    Parameters = {
      /**
       * The name of activity.
       */
      @path
      @segment("activities")
      activityName: string;
    }
  >;

  /**
   * Retrieve a list of activities in the module identified by module name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Activity_ListByModule")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/activityoperations")
  @list
  @get
  @action("activities")
  listByModule is ModuleOps.ActionSync<
    Module,
    void,
    ArmResponse<ActivityListResult>
  >;

  /**
   * Retrieve a list of fields of a given type identified by module name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ObjectDataTypes_ListFieldsByModuleAndType")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/objectdatatypeoperations")
  @list
  @get
  @action("fields")
  listFieldsByModuleAndType is ModuleOps.ActionSync<
    Module,
    void,
    ArmResponse<TypeFieldListResult>,
    Parameters = {
      /**
       * The name of type.
       */
      @path
      @segment("objectDataTypes")
      typeName: string;
    }
  >;

  /**
   * Retrieve a list of fields of a given type identified by module name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Fields_ListByType")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/typefieldoperations")
  @list
  @get
  @action("fields")
  listByType is ModuleOps.ActionSync<
    Module,
    void,
    ArmResponse<TypeFieldListResult>,
    Parameters = {
      /**
       * The name of type.
       */
      @path
      @segment("types")
      typeName: string;
    }
  >;
}
alias Python2PackageOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the automation account. */
    @path
    @segment("automationAccounts")
    @key
    automationAccountName: string;
  },
  {
    /** The python package name. */
    @path
    @segment("python2Packages")
    @key
    packageName: string;
  }
>;

@armResourceOperations
interface Python2Package {
  /**
   * Retrieve the python 2 package identified by package name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/moduleoperations")
  get is Python2PackageOps.Read<Module>;

  /**
   * Create or Update the python 2 package identified by package name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/moduleoperations")
  createOrUpdate is Python2PackageOps.CreateOrUpdateSync<
    Module,
    Request = PythonPackageCreateParameters
  >;

  /**
   * Update the python 2 package identified by package name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/moduleoperations")
  @patch(#{ implicitOptionality: false })
  update is Python2PackageOps.CustomPatchSync<
    Module,
    PatchModel = PythonPackageUpdateParameters
  >;

  /**
   * Delete the python 2 package by name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/moduleoperations")
  delete is Python2PackageOps.DeleteSync<Module, Response = ArmDeletedResponse>;

  /**
   * Retrieve a list of python 2 packages.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/moduleoperations")
  listByAutomationAccount is Python2PackageOps.List<Module>;
}
alias Python3PackageOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the automation account. */
    @path
    @segment("automationAccounts")
    @key
    automationAccountName: string;
  },
  {
    /** The python package name. */
    @path
    @segment("python3Packages")
    @key
    packageName: string;
  }
>;

@armResourceOperations
interface Python3Package {
  /**
   * Retrieve the python 3 package identified by package name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/moduleoperations")
  get is Python3PackageOps.Read<Module>;

  /**
   * Create or Update the python 3 package identified by package name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/moduleoperations")
  createOrUpdate is Python3PackageOps.CreateOrUpdateSync<
    Module,
    Request = PythonPackageCreateParameters
  >;

  /**
   * Update the python 3 package identified by package name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/moduleoperations")
  @patch(#{ implicitOptionality: false })
  update is Python3PackageOps.CustomPatchSync<
    Module,
    PatchModel = PythonPackageUpdateParameters
  >;

  /**
   * Delete the python 3 package by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/moduleoperations")
  delete is Python3PackageOps.DeleteSync<Module>;

  /**
   * Retrieve a list of python 3 packages.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/moduleoperations")
  listByAutomationAccount is Python3PackageOps.List<Module>;
}

@@doc(Module.name, "The module name.");
@@doc(Module.properties, "Gets or sets the module properties.");
@@doc(Modules.createOrUpdate::parameters.resource,
  "The create or update parameters for module."
);
@@doc(Modules.update::parameters.properties,
  "The update parameters for module."
);
@@doc(Python2Package.createOrUpdate::parameters.resource,
  "The create or update parameters for python package."
);
@@doc(Python2Package.update::parameters.properties,
  "The update parameters for python package."
);
@@doc(Python3Package.createOrUpdate::parameters.resource,
  "The create or update parameters for python package."
);
@@doc(Python3Package.update::parameters.properties,
  "The update parameters for python package."
);
