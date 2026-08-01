import { getSourceLocation, isArrayModelType, } from "@typespec/compiler";
import { resolveOrigin } from "./origin.js";
const anonymousTypeIds = new WeakMap();
let nextAnonymousTypeId = 0;
export function compareCanonicalizedTypes(base, head, ctx) {
    return compareTypes(base.wireType, head.wireType, ctx);
}
export function compareTypes(baseType, headType, ctx) {
    const pairKey = `${getTypeKey(baseType)}:${getTypeKey(headType)}`;
    if (ctx.visited.has(pairKey)) {
        return [];
    }
    ctx.visited.add(pairKey);
    try {
        if (baseType.kind !== headType.kind) {
            return [
                makeDiff(typeKindChangedKind(ctx), ctx, ctx.elementPath, baseType, headType, `${componentLabel(ctx.component)} type kind changed at ${ctx.elementPath} from ${baseType.kind} to ${headType.kind}.`),
            ];
        }
        switch (baseType.kind) {
            case "Model":
                return compareModels(baseType, headType, ctx);
            case "Scalar":
                return compareScalars(baseType, headType, ctx);
            case "Enum":
                return compareEnums(baseType, headType, ctx);
            case "Union":
                return compareUnions(baseType, headType, ctx);
            default:
                return [];
        }
    }
    finally {
        ctx.visited.delete(pairKey);
    }
}
function compareModels(base, head, ctx) {
    if (isArrayModelType(base) && isArrayModelType(head)) {
        // Array item type changes — the violation is about the array model, not the inner item type
        const diffs = compareTypes(base.indexer.value, head.indexer.value, ctx);
        for (const diff of diffs) {
            if (diff.headType === head.indexer.value || diff.baseType === base.indexer.value) {
                diff.baseType = base;
                diff.headType = head;
                diff.baseSourceLocation = getTypeSourceLocation(base);
                diff.headSourceLocation = getTypeSourceLocation(head);
            }
        }
        return diffs;
    }
    const diffs = [];
    for (const [name, baseProp] of base.properties) {
        const headProp = head.properties.get(name);
        const elementPath = propertyElementPath(ctx.elementPath, name);
        if (!headProp) {
            diffs.push(makeDiff(propertyRemovedKind(ctx.component), ctx, elementPath, baseProp, undefined, `${componentLabel(ctx.component)} property '${name}' was removed at ${elementPath}.`));
            continue;
        }
        diffs.push(...compareProperties(baseProp, headProp, { ...ctx, elementPath }));
    }
    for (const [name, headProp] of head.properties) {
        if (base.properties.has(name)) {
            continue;
        }
        const elementPath = propertyElementPath(ctx.elementPath, name);
        diffs.push(makeDiff(propertyAddedKind(ctx.component), ctx, elementPath, undefined, headProp, `${componentLabel(ctx.component)} property '${name}' was added at ${elementPath}.`));
    }
    return diffs;
}
function compareProperties(base, head, ctx) {
    const diffs = [];
    if (!base.optional && head.optional) {
        diffs.push(makeDiff(propertyMadeOptionalKind(ctx.component), ctx, ctx.elementPath, base, head, `${componentLabel(ctx.component)} property at ${ctx.elementPath} was made optional.`));
    }
    else if (base.optional && !head.optional) {
        diffs.push(makeDiff(propertyMadeRequiredKind(ctx.component), ctx, ctx.elementPath, base, head, `${componentLabel(ctx.component)} property at ${ctx.elementPath} was made required.`));
    }
    // Type-change findings from compareTypes store inner types (e.g., Scalars) as
    // baseType/headType, but the violation is about this property changing — the
    // ModelProperty should be the target for suppression lookup.
    // Only override diffs whose target is still this property's direct .type value;
    // diffs from deeper recursion already have their correct target set.
    const typeDiffs = compareTypes(base.type, head.type, ctx);
    for (const diff of typeDiffs) {
        if (diff.headType === head.type || diff.baseType === base.type) {
            diff.baseType = base;
            diff.headType = head;
            diff.baseSourceLocation = getTypeSourceLocation(base);
            diff.headSourceLocation = getTypeSourceLocation(head);
            diff.origin = resolveOrigin(head);
        }
    }
    diffs.push(...typeDiffs);
    return diffs;
}
function compareScalars(base, head, ctx) {
    if (getScalarName(base) === getScalarName(head)) {
        return [];
    }
    return [
        makeDiff(typeChangedKind(ctx), ctx, ctx.elementPath, base, head, `${componentLabel(ctx.component)} type changed at ${ctx.elementPath} from ${getScalarName(base)} to ${getScalarName(head)}.`),
    ];
}
function compareEnums(base, head, ctx) {
    const diffs = [];
    for (const [name, baseMember] of base.members) {
        if (!head.members.has(name)) {
            diffs.push(makeDiff("EnumerationMemberRemoved", ctx, joinElementPath(ctx.elementPath, name), baseMember, undefined, `Enumeration member '${name}' was removed at ${ctx.elementPath}.`));
        }
    }
    for (const [name, headMember] of head.members) {
        if (!base.members.has(name)) {
            diffs.push(makeDiff("EnumerationMemberAdded", ctx, joinElementPath(ctx.elementPath, name), undefined, headMember, `Enumeration member '${name}' was added at ${ctx.elementPath}.`));
        }
    }
    return diffs;
}
function compareUnions(base, head, ctx) {
    const diffs = [];
    const baseNamed = new Map();
    const headNamed = new Map();
    const baseAnonymous = new Map();
    const headAnonymous = new Map();
    for (const variant of base.variants.values()) {
        if (typeof variant.name === "string") {
            baseNamed.set(variant.name, variant);
        }
        else {
            baseAnonymous.set(getTypeKey(variant.type), variant);
        }
    }
    for (const variant of head.variants.values()) {
        if (typeof variant.name === "string") {
            headNamed.set(variant.name, variant);
        }
        else {
            headAnonymous.set(getTypeKey(variant.type), variant);
        }
    }
    for (const [name, baseVariant] of baseNamed) {
        const headVariant = headNamed.get(name);
        const elementPath = variantElementPath(ctx.elementPath, name);
        if (!headVariant) {
            diffs.push(makeDiff(typeNarrowedKind(ctx), ctx, elementPath, baseVariant, undefined, `${componentLabel(ctx.component)} union at ${ctx.elementPath} removed variant '${name}'.`));
            continue;
        }
        // Union variant type changes — the violation is about the variant, not the inner type
        const variantDiffs = compareTypes(baseVariant.type, headVariant.type, { ...ctx, elementPath });
        for (const diff of variantDiffs) {
            if (diff.headType === headVariant.type || diff.baseType === baseVariant.type) {
                diff.baseType = baseVariant;
                diff.headType = headVariant;
                diff.baseSourceLocation = getTypeSourceLocation(baseVariant);
                diff.headSourceLocation = getTypeSourceLocation(headVariant);
            }
        }
        diffs.push(...variantDiffs);
    }
    for (const [name, headVariant] of headNamed) {
        if (baseNamed.has(name)) {
            continue;
        }
        diffs.push(makeDiff(typeWidenedKind(ctx), ctx, variantElementPath(ctx.elementPath, name), undefined, headVariant, `${componentLabel(ctx.component)} union at ${ctx.elementPath} added variant '${name}'.`));
    }
    for (const [key, baseVariant] of baseAnonymous) {
        const headVariant = headAnonymous.get(key);
        const elementPath = variantElementPath(ctx.elementPath, describeType(baseVariant.type));
        if (!headVariant) {
            diffs.push(makeDiff(typeNarrowedKind(ctx), ctx, elementPath, baseVariant, undefined, `${componentLabel(ctx.component)} union at ${ctx.elementPath} removed variant ${describeType(baseVariant.type)}.`));
            continue;
        }
        // Anonymous variant type changes — target the variant, not inner type
        const anonDiffs = compareTypes(baseVariant.type, headVariant.type, { ...ctx, elementPath });
        for (const diff of anonDiffs) {
            if (diff.headType === headVariant.type || diff.baseType === baseVariant.type) {
                diff.baseType = baseVariant;
                diff.headType = headVariant;
                diff.baseSourceLocation = getTypeSourceLocation(baseVariant);
                diff.headSourceLocation = getTypeSourceLocation(headVariant);
            }
        }
        diffs.push(...anonDiffs);
    }
    for (const [key, headVariant] of headAnonymous) {
        if (baseAnonymous.has(key)) {
            continue;
        }
        diffs.push(makeDiff(typeWidenedKind(ctx), ctx, variantElementPath(ctx.elementPath, describeType(headVariant.type)), undefined, headVariant, `${componentLabel(ctx.component)} union at ${ctx.elementPath} added variant ${describeType(headVariant.type)}.`));
    }
    return diffs;
}
function makeDiff(kind, ctx, elementPath, baseType, headType, message) {
    const identity = {
        operation: ctx.operation,
        component: ctx.component,
        statusCode: ctx.statusCode,
        element: elementPath,
    };
    return {
        kind,
        identity,
        origin: resolveOrigin(headType ?? baseType),
        baseSourceLocation: getTypeSourceLocation(baseType),
        headSourceLocation: getTypeSourceLocation(headType),
        baseType,
        headType,
        details: {
            elementPath,
            baseKind: baseType?.kind,
            headKind: headType?.kind,
        },
        message: message ?? `${kind} detected at ${elementPath}.`,
    };
}
function getTypeKey(type) {
    const namedKey = getNamedTypeKey(type);
    if (namedKey) {
        return namedKey;
    }
    const existing = anonymousTypeIds.get(type);
    if (existing !== undefined) {
        return `${type.entityKind}:${type.kind}:anonymous:${existing}`;
    }
    nextAnonymousTypeId += 1;
    anonymousTypeIds.set(type, nextAnonymousTypeId);
    return `${type.entityKind}:${type.kind}:anonymous:${nextAnonymousTypeId}`;
}
function getNamedTypeKey(type) {
    switch (type.kind) {
        case "Model":
        case "Scalar":
        case "Enum":
            return qualifiedName(type.namespace, type.name) ?? `${type.kind}:${type.name}`;
        case "ModelProperty":
            return type.model
                ? `${getTypeKey(type.model)}.properties.${type.name}`
                : `${type.kind}:${type.name}`;
        case "Union":
            return type.name ? qualifiedName(type.namespace, type.name) ?? `${type.kind}:${type.name}` : undefined;
        case "UnionVariant":
            return typeof type.name === "string"
                ? `${getTypeKey(type.union)}.variants.${type.name}`
                : undefined;
        case "String":
            return `${type.kind}:${JSON.stringify(type.value)}`;
        case "Number":
            return `${type.kind}:${type.valueAsString}`;
        case "Boolean":
            return `${type.kind}:${String(type.value)}`;
        default:
            return undefined;
    }
}
function propertyAddedKind(component) {
    return component === "request" ? "RequestPropertyAdded" : "ResponsePropertyAdded";
}
function propertyRemovedKind(component) {
    return component === "request" ? "RequestPropertyRemoved" : "ResponsePropertyRemoved";
}
function propertyMadeRequiredKind(component) {
    return component === "request" ? "RequestPropertyMadeRequired" : "ResponsePropertyMadeRequired";
}
function propertyMadeOptionalKind(component) {
    return component === "request" ? "RequestPropertyMadeOptional" : "ResponsePropertyMadeOptional";
}
function typeChangedKind(ctx) {
    if (isPropertyElement(ctx.elementPath)) {
        return ctx.component === "request" ? "RequestPropertyTypeChanged" : "ResponsePropertyTypeChanged";
    }
    return ctx.component === "request" ? "RequestTypeChanged" : "ResponseTypeChanged";
}
function typeNarrowedKind(ctx) {
    if (isPropertyElement(ctx.elementPath)) {
        return ctx.component === "request" ? "RequestPropertyTypeNarrowed" : "ResponsePropertyTypeNarrowed";
    }
    return ctx.component === "request" ? "RequestTypeNarrowed" : "ResponseTypeNarrowed";
}
function typeWidenedKind(ctx) {
    if (isPropertyElement(ctx.elementPath)) {
        return ctx.component === "request" ? "RequestPropertyTypeWidened" : "ResponsePropertyTypeWidened";
    }
    return ctx.component === "request" ? "RequestTypeWidened" : "ResponseTypeWidened";
}
function typeKindChangedKind(ctx) {
    if (isPropertyElement(ctx.elementPath)) {
        return ctx.component === "request" ? "RequestPropertyTypeChanged" : "ResponsePropertyTypeChanged";
    }
    return ctx.component === "request" ? "RequestTypeKindChanged" : "ResponseTypeKindChanged";
}
function getScalarName(scalar) {
    return qualifiedName(scalar.namespace, scalar.name) ?? scalar.name;
}
function getTypeSourceLocation(type) {
    return type ? getSourceLocation(type, { locateId: true }) : undefined;
}
function propertyElementPath(currentPath, propertyName) {
    if (currentPath === "properties" ||
        currentPath.endsWith(".properties") ||
        currentPath.startsWith("properties.")) {
        return joinElementPath(currentPath, propertyName);
    }
    return joinElementPath(currentPath, `properties.${propertyName}`);
}
function variantElementPath(currentPath, variantName) {
    return joinElementPath(currentPath, `variants.${variantName}`);
}
function joinElementPath(base, segment) {
    if (!base) {
        return segment;
    }
    return `${base}.${segment}`;
}
function qualifiedName(namespace, name) {
    if (!name) {
        return undefined;
    }
    const namespaceParts = [];
    let current = namespace;
    while (current) {
        if (current.name) {
            namespaceParts.unshift(current.name);
        }
        current = current.namespace;
    }
    namespaceParts.push(name);
    return namespaceParts.length > 0 ? namespaceParts.join(".") : undefined;
}
function isPropertyElement(elementPath) {
    return (elementPath === "properties" ||
        elementPath.includes(".properties.") ||
        elementPath.endsWith(".properties") ||
        elementPath.startsWith("properties."));
}
function componentLabel(component) {
    return component === "request" ? "Request" : "Response";
}
function describeType(type) {
    switch (type.kind) {
        case "Model":
        case "Scalar":
        case "Enum":
            return qualifiedName(type.namespace, type.name) ?? type.name;
        case "Union":
            return type.name ? qualifiedName(type.namespace, type.name) ?? type.name : "anonymous-union";
        case "String":
            return JSON.stringify(type.value);
        case "Number":
            return type.valueAsString;
        case "Boolean":
            return String(type.value);
        default:
            return type.kind.toLowerCase();
    }
}
//# sourceMappingURL=diff-types.js.map