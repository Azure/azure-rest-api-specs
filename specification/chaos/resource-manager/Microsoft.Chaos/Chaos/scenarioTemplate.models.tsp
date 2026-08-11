import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./scenario.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

/**
 * Model that represents a built-in scenario template. A scenario template is a versioned,
 * read-only blueprint published by Microsoft that can be used to create a scenario. Templates
 * are the same shape as the scenarios they produce, so an action read from a template is valid
 * input to a scenario create.
 *
 * The template is addressed without a version, and always describes its newest published
 * version. Address a specific version through the child versions resource.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
@tenantResource
model ScenarioTemplate
  is Azure.ResourceManager.ProxyResource<ScenarioTemplateProperties> {
  ...ResourceNameParameter<
    Resource = ScenarioTemplate,
    KeyName = "scenarioTemplateName",
    SegmentName = "scenarioTemplates",
    NamePattern = "^[A-Za-z][A-Za-z0-9]*$"
  >;
}

/**
 * Model that represents a single published version of a scenario template. A published version
 * is immutable: corrections are shipped as a new version rather than by changing an existing
 * one, so a scenario that records the version it was created from always resolves to the same
 * content.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
@parentResource(ScenarioTemplate)
model ScenarioTemplateVersion
  is Azure.ResourceManager.ProxyResource<ScenarioTemplateProperties> {
  ...ResourceNameParameter<
    Resource = ScenarioTemplateVersion,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = "^\\d+\\.\\d+(\\.\\d+)?$"
  >;
}

/**
 * Model that represents the properties of a scenario template. The same properties describe a
 * template and a single version of that template; on the template they describe its newest
 * published version, which `version` names.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only catalog resource served from the resource provider; there is nothing to provision."
@added(Microsoft.Chaos.Versions.v2026_11_01)
model ScenarioTemplateProperties {
  /**
   * The version of the template being described. On the template resource this is its newest
   * published version.
   */
  @visibility(Lifecycle.Read)
  version: string;

  /**
   * Localized display name of the template.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Description of what the template does, and what resilience question it answers.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * ISO 8601 duration bounding how long a scenario created from this template may run
   * (for example PT3H for three hours).
   */
  @visibility(Lifecycle.Read)
  maxTimeoutDuration?: string;

  /**
   * The resource selectors the template's actions target. Each selector names a group of
   * resources of a single Azure resource type, and is referenced from an action through the
   * `%%\{resourceSelectors.\<name\>\}%%` macro.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  resourceSelectors?: ScenarioTemplateResourceSelector[];

  /**
   * Parameter definitions the template accepts. Values are supplied when the scenario created
   * from this template is configured, and are referenced from an action through the
   * `%%\{parameters.\<name\>\}%%` macro.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  parameters?: ScenarioParameter[];

  /**
   * The actions that define the template's orchestration. These are the same model a scenario
   * publishes, and carry unresolved `%%\{...\}%%` macros; the macros are substituted when the
   * scenario runs.
   */
  @visibility(Lifecycle.Read)
  @minItems(1)
  @identifiers(#["name"])
  actions: ScenarioAction[];
}

/**
 * Model that represents a named group of resources of a single Azure resource type that a
 * scenario template's actions target.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
model ScenarioTemplateResourceSelector {
  /**
   * The name of the selector, as referenced by the `%%\{resourceSelectors.\<name\>\}%%` macro.
   */
  @minLength(1)
  name: string;

  /**
   * The Azure resource type the selector matches, for example
   * `Microsoft.Compute/virtualMachines`.
   */
  @minLength(1)
  resourceType: string;
}

/**
 * Model that represents a list of scenario templates and a link for pagination.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
model ScenarioTemplateListResult is Azure.Core.Page<ScenarioTemplate>;

/**
 * Model that represents a list of scenario template versions and a link for pagination.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
model ScenarioTemplateVersionListResult
  is Azure.Core.Page<ScenarioTemplateVersion>;
