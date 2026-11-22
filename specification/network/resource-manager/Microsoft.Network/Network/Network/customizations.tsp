import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "The SDK hierarchy customization in client.tsp marks the shared ARM proxy-resource foundation as custom; resources using this standard template remain standard ARM proxy resources."
model StandardProxyResourceInstance<
  Properties extends {},
  KeyName extends valueof string,
  SegmentName extends valueof string,
  NamePattern extends valueof string,
  PropertiesOptional extends valueof boolean = true
> is Azure.ResourceManager.ProxyResource<Properties, PropertiesOptional> {
  @visibility(Lifecycle.Read)
  @path
  @key(KeyName)
  @segment(SegmentName)
  @pattern(NamePattern)
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The template preserves the legacy resource envelope."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility with converted specs."
@Azure.ResourceManager.Private.genericResourceInternal
@Http.Private.includeInapplicableMetadataInPayload(false)
model ResourceInstance<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends Resource {
  /** The resource-specific properties. */
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(
    PropertiesOptional
  )
  properties?: Properties;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The template preserves the legacy resource envelope."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility with converted specs."
@Azure.ResourceManager.Private.genericResourceInternal
@Http.Private.includeInapplicableMetadataInPayload(false)
model ChildResourceInstance<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends ChildResource {
  /** The resource-specific properties. */
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(
    PropertiesOptional
  )
  properties?: Properties;
}

/** A child resource instance without a properties envelope. */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The template preserves the legacy resource envelope."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "The legacy base resource intentionally has no properties model."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "The resource key is declared by the instantiated resource."
@Azure.ResourceManager.Private.genericResourceInternal
@Http.Private.includeInapplicableMetadataInPayload(false)
model ChildResourceWithoutPropertiesInstance<Placeholder extends {}>
  extends ChildResource {}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The template preserves the legacy resource envelope."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility with converted specs."
@Azure.ResourceManager.Private.genericResourceInternal
@Http.Private.includeInapplicableMetadataInPayload(false)
model SubResourceInstance<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends SubResourceModel {
  /** The resource-specific properties. */
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(
    PropertiesOptional
  )
  properties?: Properties;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The template preserves the legacy resource envelope."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility with converted specs."
@Azure.ResourceManager.Private.genericResourceInternal
@Http.Private.includeInapplicableMetadataInPayload(false)
model TrackedResourceWithOptionalLocationInstance<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends TrackedResourceWithOptionalLocation {
  /** The resource-specific properties. */
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(
    PropertiesOptional
  )
  properties?: Properties;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The template preserves the legacy resource envelope."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility with converted specs."
@Azure.ResourceManager.Private.genericResourceInternal
@Http.Private.includeInapplicableMetadataInPayload(false)
model CommonTrackedResourceInstance<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends CommonTrackedResource {
  /** The resource-specific properties. */
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(
    PropertiesOptional
  )
  properties?: Properties;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The template preserves the legacy resource envelope."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility with converted specs."
@Azure.ResourceManager.Private.genericResourceInternal
@Http.Private.includeInapplicableMetadataInPayload(false)
model SecurityPerimeterTrackedResourceInstance<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends SecurityPerimeterTrackedResource {
  /** The resource-specific properties. */
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(
    PropertiesOptional
  )
  properties?: Properties;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The template preserves the legacy resource envelope."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility with converted specs."
@Azure.ResourceManager.Private.genericResourceInternal
@Http.Private.includeInapplicableMetadataInPayload(false)
model SecurityPerimeterProxyResourceInstance<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends SecurityPerimeterProxyResource {
  /** The resource-specific properties. */
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(
    PropertiesOptional
  )
  properties?: Properties;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The template preserves the legacy resource envelope."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility with converted specs."
@Azure.ResourceManager.Private.genericResourceInternal
@Http.Private.includeInapplicableMetadataInPayload(false)
model TrackedResourceWithSettableIdOptionalLocationInstance<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends TrackedResourceWithSettableIdOptionalLocation {
  /** The resource-specific properties. */
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(
    PropertiesOptional
  )
  properties?: Properties;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The template preserves the legacy resource envelope."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility with converted specs."
@Azure.ResourceManager.Private.genericResourceInternal
@Http.Private.includeInapplicableMetadataInPayload(false)
model CommonProxyResourceInstance<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends CommonProxyResource {
  /** The resource-specific properties. */
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(
    PropertiesOptional
  )
  properties?: Properties;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The template preserves the legacy resource envelope."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility with converted specs."
@Azure.ResourceManager.Private.genericResourceInternal
@Http.Private.includeInapplicableMetadataInPayload(false)
model ReadOnlySubResourceModelInstance<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends ReadOnlySubResourceModel {
  /** The resource-specific properties. */
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(
    PropertiesOptional
  )
  properties?: Properties;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The template preserves the legacy resource envelope."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility with converted specs."
@Azure.ResourceManager.Private.genericResourceInternal
@Http.Private.includeInapplicableMetadataInPayload(false)
model WritableResourceInstance<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends WritableResource {
  /** The resource-specific properties. */
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(
    PropertiesOptional
  )
  properties?: Properties;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The template preserves the legacy resource envelope."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility with converted specs."
@Azure.ResourceManager.Private.genericResourceInternal
@Http.Private.includeInapplicableMetadataInPayload(false)
model ProxyResourceInstance<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends ProxyResource {
  /** The resource-specific properties. */
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(
    PropertiesOptional
  )
  properties?: Properties;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The template preserves the legacy resource envelope."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility with converted specs."
@Azure.ResourceManager.Private.genericResourceInternal
@Http.Private.includeInapplicableMetadataInPayload(false)
model ProxyResourceWithReadOnlyIDInstance<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends ProxyResourceWithReadOnlyID {
  /** The resource-specific properties. */
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(
    PropertiesOptional
  )
  properties?: Properties;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The template preserves the legacy resource envelope."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility with converted specs."
@Azure.ResourceManager.Private.genericResourceInternal
@Http.Private.includeInapplicableMetadataInPayload(false)
model ProxyResourceWithSettableIdInstance<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends ProxyResourceWithSettableId {
  /** The resource-specific properties. */
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(
    PropertiesOptional
  )
  properties?: Properties;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The template preserves the legacy resource envelope."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility with converted specs."
@Azure.ResourceManager.Private.genericResourceInternal
@Http.Private.includeInapplicableMetadataInPayload(false)
model TrackedResourceWithEtagInstance<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends TrackedResourceWithEtag {
  /** The resource-specific properties. */
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(
    PropertiesOptional
  )
  properties?: Properties;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The template preserves the legacy resource envelope."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Required for backward compatibility with converted specs."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required for backward compatibility with converted specs."
@Azure.ResourceManager.Private.genericResourceInternal
@Http.Private.includeInapplicableMetadataInPayload(false)
model TrackedResourceWithSettableNameInstance<
  Properties extends {},
  PropertiesOptional extends valueof boolean = true
> extends TrackedResourceWithSettableName {
  /** The resource-specific properties. */
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(
    PropertiesOptional
  )
  properties?: Properties;
}
