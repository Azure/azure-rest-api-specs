import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/http";
import "./scenarioTemplate.models.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

@added(Microsoft.Chaos.Versions.v2026_11_01)
@armResourceOperations
interface ScenarioTemplates {
  /**
   * Get a scenario template, described by its newest published version.
   */
  get is ArmResourceRead<ScenarioTemplate>;

  /**
   * Get a list of the scenario templates published by Microsoft.
   */
  list is ArmResourceListByParent<
    ScenarioTemplate,
    Response = ScenarioTemplateListResult
  >;
}

@added(Microsoft.Chaos.Versions.v2026_11_01)
@armResourceOperations
interface ScenarioTemplateVersions {
  /**
   * Get a single published version of a scenario template.
   */
  get is ArmResourceRead<ScenarioTemplateVersion>;

  /**
   * Get a list of the published versions of a scenario template, including superseded ones.
   */
  list is ArmResourceListByParent<
    ScenarioTemplateVersion,
    Response = ScenarioTemplateVersionListResult
  >;
}

@@minLength(ScenarioTemplate.name, 1);
@@doc(ScenarioTemplate.name, "Name of the scenario template.");
@@doc(
  ScenarioTemplate.properties,
  "The properties of the scenario template's newest published version."
);

@@minLength(ScenarioTemplateVersion.name, 1);
@@doc(
  ScenarioTemplateVersion.name,
  "The version of the scenario template, for example 1.2."
);
@@doc(
  ScenarioTemplateVersion.properties,
  "The properties of the scenario template version."
);
