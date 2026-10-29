# Go Acronym Naming

Load for confirmed Go SDK targets, ARM or data-plane, through the [naming dispatcher](naming-conventions.md). This profile covers acronym casing, not all Go SDK design rules.

Sources: the Go SDK repository's [Go code instructions](https://github.com/Azure/azure-sdk-for-go/blob/d23e0b0d7144ef65a5ddcfbe0af126a2cbd20f3a/.github/instructions/go-code.instructions.md) and [code review skill](https://github.com/Azure/azure-sdk-for-go/blob/d23e0b0d7144ef65a5ddcfbe0af126a2cbd20f3a/.github/skills/code-review/SKILL.md#naming-and-file-conventions). These require uppercase acronyms in customer-visible identifiers, including exported types, fields, functions, methods, constants, and function/method parameter names. The release feedback in [Azure/azure-sdk-for-go#27820](https://github.com/Azure/azure-sdk-for-go/pull/27820#discussion_r4352470217), [Azure/azure-sdk-for-go#27824](https://github.com/Azure/azure-sdk-for-go/pull/27824#discussion_r4373655484), and [Azure/azure-sdk-for-go#27839](https://github.com/Azure/azure-sdk-for-go/pull/27839#discussion_r4381170600) illustrates the rule and the upstream TypeSpec customization workflow.

Apply the preservation and consistency checks below before the default uppercase rule. Do not treat every SDK review suggestion as a safe rename.

## 1. Preserve Existing Names

Compare the proposed Go SDK surface with the API before the authoring change. Classify each name as existing or newly introduced; being on a changed line does not make an existing name new.

Leave all existing names unchanged, even when their casing does not follow the guideline. This includes stable, preview, and unreleased names already present in the SDK. Do not turn an authoring request into a casing cleanup. These checks are stricter than checking only whether an SDK name has shipped.

## 2. Follow Existing Related Patterns

Before choosing a new name, inspect the existing Go SDK names across the affected package and related API families, together with existing TypeSpec client-name overrides. Use supplied SDK API evidence when available; the analysis does not require generation or a separate SDK checkout.

Match the same acronym or term with the same meaning in related names, not an arbitrary matching substring. Record the existing names that justify the chosen spelling. Keep their casing for the new related name, even if it is not the default Go acronym casing. When the new name already follows that pattern, leave it alone; do not add a `clientName` override merely to restate its unchanged spelling. Do not add overrides to existing names to document a pattern.

- Existing `FooAbcOperation` establishes `Abc` for the same term in the same operation family: keep new `BarAbcOperation`, not `BarABCOperation`.
- Existing `DeviceRoleToR`, `NetworkDeviceRoleToR`, and `NetworkDeviceRoleNameToR` establish `ToR` for top of rack: keep new `NetworkFabricRefreshDeviceTypesToR`. The [pre-change SDK API](https://github.com/Azure/azure-sdk-for-go/blob/8820831f890d49a47282cfe69b74e91d0ceb4201/sdk/resourcemanager/managednetworkfabric/armmanagednetworkfabric/constants.go) therefore takes precedence over the release review's proposed `TOR` spelling.
- Existing `IdentityKeyStoreTPM` establishes `TPM`: new `IdentityKeyStoreTpmTransition` should become `IdentityKeyStoreTPMTransition`.

An unrelated name elsewhere in the repository does not establish a pattern for this API family. If the existing SDK baseline is unavailable or relevant patterns conflict, report the unresolved decision rather than guessing. A confirmed new SDK with no existing names has no pattern to preserve.

## 3. Uppercase Acronyms in Other New Names

For newly introduced names without a related existing pattern requiring another spelling, uppercase confirmed acronym components. Use the supplied contract, documentation, and domain meaning to identify acronyms; do not uppercase letters inside ordinary words or invent expansions.

Examples for new API families:

| Current Go name | Planned Go name |
| --- | --- |
| `ControllerTypeCiscoAci` | `ControllerTypeCiscoACI` |
| `AFDDomainMtlsParameters` | `AFDDomainMTLSParameters` |
| `userId` parameter | `userID` |
| `recordAcsId` parameter | `recordACSID` |

Parameter names are customer-visible through signatures and documentation. Apply the same existing-related-signature check before changing a new parameter's spelling.

Do not borrow C# acronym rules or semantic naming transformations. The Go profile does not turn a boolean `enabled` into `IsEnabled` or expand a name just because another language's profile does.

## 4. Plan Go-Scoped Customizations

Use the TCGC scope `go`. For example, the new union variant in the TPM example can use `@@clientName(IdentityKeyStore.TpmTransition, "TPMTransition", "go");`. Preserve other-language overrides and unrelated customizations. If the effective Go name already matches the decision, no override is needed.

Check the entire affected name family. A model customization can affect synthesized interfaces and accessors: `AFDDomainMTLSParameters` should lead to `AFDDomainMTLSParametersClassification` and `GetAFDDomainMTLSParameters`. Propose a customization on the underlying TypeSpec model, not on a fabricated TypeSpec target for an interface or getter. Independently named properties and enum members need their own decisions.

Report the current and proposed Go names, real TypeSpec targets, scope, existing-pattern evidence, and any preserved exceptions. Guidance remains read-only. For authorized changes, follow the shared [apply workflow](apply.md), not direct edits to generated SDK files. An applied override is not proof of a generated name; keep generated-name verification separate.
