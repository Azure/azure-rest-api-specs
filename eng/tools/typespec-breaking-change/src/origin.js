import { getSourceLocation, } from "@typespec/compiler";
/**
 * Resolve the origin declaration for a type encountered during diffing.
 *
 * The origin is the nearest named TypeSpec declaration that "owns" this type.
 * Used for:
 * 1. Deduplication: same {origin, DiffKind} across operations = one finding
 * 2. Suppression: decorator on origin type suppresses all uses
 *
 * Resolution rules:
 * - ModelProperty with sourceProperty → follow chain to original named declaration
 * - ModelProperty on a named model → the property itself
 * - Named Model/Enum/Union/Scalar → the type itself
 * - EnumMember → the parent Enum
 * - UnionVariant → the parent Union (if named)
 * - Anonymous/inline types → climb to nearest named ancestor, or undefined
 */
export function resolveOrigin(type) {
    if (!type)
        return undefined;
    switch (type.kind) {
        case "ModelProperty":
            return resolveModelPropertyOrigin(type);
        case "Model":
            return resolveModelOrigin(type);
        case "Enum":
            return resolveNamedTypeOrigin(type, type.name, type.namespace);
        case "EnumMember":
            return resolveEnumMemberOrigin(type);
        case "Union":
            return type.name ? resolveNamedTypeOrigin(type, type.name, type.namespace) : undefined;
        case "UnionVariant":
            return resolveUnionVariantOrigin(type);
        case "Scalar":
            return resolveNamedTypeOrigin(type, type.name, type.namespace);
        default:
            return undefined;
    }
}
/**
 * Resolve origin for a ModelProperty.
 * Follows the sourceProperty chain (from spreads/intersections) to the original declaration.
 * When sourceProperty is not set (e.g., visibility-filtered ARM models), uses AST node
 * identity to find the canonical property in the versioned namespace.
 */
function resolveModelPropertyOrigin(prop) {
    // Follow sourceProperty chain to the original
    const original = followSourcePropertyChain(prop);
    // Check if the original property lives on a named model
    if (original.model && isNamedDeclaration(original.model)) {
        // If the model looks like a visibility-filtered copy (e.g., EmployeePropertiesCreateOrUpdate),
        // trace back to the canonical model via AST node identity on the property.
        const canonical = traceToCanonicalProperty(original);
        const resolved = canonical ?? original;
        return {
            declarationPath: buildDeclarationPath(resolved.model, resolved.name),
            type: resolved,
            sourceLocation: safeGetSourceLocation(resolved),
        };
    }
    // Property is on an anonymous model — try climbing to a named ancestor
    return climbToNamedAncestor(original);
}
/**
 * Trace a property back to its canonical declaration using AST node identity.
 *
 * HTTP canonicalization creates visibility-filtered model copies (e.g.,
 * EmployeePropertiesCreateOrUpdate) without setting sourceProperty. However,
 * the copied properties share the same AST node as the original. We use this
 * to find the original property on the user-declared model in the namespace.
 */
function traceToCanonicalProperty(prop) {
    const node = prop.node;
    if (!node || !prop.model?.namespace)
        return undefined;
    // Look for a model in the same namespace whose same-named property shares this node
    const ns = prop.model.namespace;
    for (const [, model] of ns.models) {
        if (model === prop.model)
            continue;
        const candidate = model.properties.get(prop.name);
        if (candidate && candidate.node === node && model.name !== prop.model.name) {
            // Found the canonical source — prefer the shorter-named model (the original)
            if (model.name.length < prop.model.name.length) {
                return candidate;
            }
        }
    }
    return undefined;
}
/**
 * Resolve origin for a Model type.
 * Named models are their own origin; anonymous models have no origin.
 */
function resolveModelOrigin(model) {
    if (isNamedDeclaration(model)) {
        return resolveNamedTypeOrigin(model, model.name, model.namespace);
    }
    return undefined;
}
/**
 * Resolve origin for an EnumMember → parent Enum is the origin.
 */
function resolveEnumMemberOrigin(member) {
    const parent = member.enum;
    if (parent && parent.name) {
        return resolveNamedTypeOrigin(parent, parent.name, parent.namespace);
    }
    return undefined;
}
/**
 * Resolve origin for a UnionVariant → parent Union is the origin (if named).
 */
function resolveUnionVariantOrigin(variant) {
    const parent = variant.union;
    if (parent && parent.name) {
        return resolveNamedTypeOrigin(parent, parent.name, parent.namespace);
    }
    // Anonymous union variant — try to find a named property parent
    return undefined;
}
/**
 * Build an OriginDeclaration for a named type.
 */
function resolveNamedTypeOrigin(type, name, namespace) {
    if (!name)
        return undefined;
    return {
        declarationPath: buildQualifiedName(namespace, name),
        type,
        sourceLocation: safeGetSourceLocation(type),
    };
}
/**
 * Follow the sourceProperty chain to the original declaration.
 * Spreads and intersections create copies with sourceProperty pointing back.
 */
function followSourcePropertyChain(prop) {
    let current = prop;
    while (current.sourceProperty) {
        current = current.sourceProperty;
    }
    return current;
}
/**
 * For a property on an anonymous model, climb the type graph to find the
 * nearest named ancestor (e.g., a named property on a named model).
 *
 * This handles cases like:
 * ```typespec
 * model Widget { config: { nested: { deep: string } } }
 * ```
 * where `deep` lives on an anonymous model, but we want to point at `Widget.config`.
 */
function climbToNamedAncestor(prop) {
    // Walk up: property → model → (if model is a property type) property → model → ...
    let currentModel = prop.model;
    while (currentModel) {
        // Find if this anonymous model is the type of some property
        const parentProp = findParentProperty(currentModel);
        if (!parentProp)
            break;
        // Follow sourceProperty on the parent too
        const originalParent = followSourcePropertyChain(parentProp);
        if (originalParent.model && isNamedDeclaration(originalParent.model)) {
            return {
                declarationPath: buildDeclarationPath(originalParent.model, originalParent.name),
                type: originalParent,
                sourceLocation: safeGetSourceLocation(originalParent),
            };
        }
        currentModel = originalParent.model;
    }
    return undefined;
}
/**
 * Check if a model type is a named declaration (not anonymous).
 */
function isNamedDeclaration(model) {
    return model.name !== "" && !model.name.startsWith("(anonymous");
}
/**
 * Try to find a property whose type is this model.
 * For anonymous models used as inline property types, we walk the node's
 * parent chain to find a ModelProperty declaration that uses this model.
 */
function findParentProperty(model) {
    // For anonymous models created inline, the model's properties may be
    // sourced from a parent property. We can detect this by checking if
    // any enclosing model has a property whose type is this anonymous model.
    // Walk the node parent chain looking for a property declaration.
    const node = model.node;
    if (!node)
        return undefined;
    let current = node.parent;
    while (current) {
        // Look for a node that has a symbol pointing to a ModelProperty type
        const sym = current.symbol;
        if (sym?.type?.kind === "ModelProperty") {
            return sym.type;
        }
        current = current.parent;
    }
    return undefined;
}
/**
 * Build a declaration path like "Microsoft.Foo.Widget.name"
 */
function buildDeclarationPath(model, propertyName) {
    const modelPath = buildQualifiedName(model.namespace, model.name);
    return `${modelPath}.${propertyName}`;
}
/**
 * Build a qualified name from namespace + name.
 */
function buildQualifiedName(namespace, name) {
    const parts = [];
    let current = namespace;
    while (current && current.name) {
        parts.unshift(current.name);
        current = current.namespace;
    }
    parts.push(name);
    return parts.join(".");
}
/**
 * Safely get source location, returning a synthetic one if unavailable.
 */
function safeGetSourceLocation(type) {
    return getSourceLocation(type, { locateId: true }) ?? getSourceLocation(type) ?? {};
}
//# sourceMappingURL=origin.js.map