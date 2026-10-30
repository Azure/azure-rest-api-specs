# Go Acronym Naming

Load for confirmed Go targets, ARM or data-plane, through the [naming dispatcher](naming-conventions.md). Use only the TypeSpec diff, declarations, documentation, and existing `client.tsp` customizations as naming evidence.

Source: [Go initialism conventions](https://go.dev/wiki/CodeReviewComments#initialisms). Apply the following checks in order.

## Preserve Existing Names

Use the TypeSpec diff to identify newly added declarations and members. Leave existing names and their Go overrides unchanged, including those in preview or unreleased API versions. Modifying a declaration does not make its name new.

## Follow Related Names

For each new name, inspect related models, operations, properties, parameters, and enum/union members in the TypeSpec project. Use existing `clientName` overrides that apply to Go before the declaration's spelling.

- Existing `FooAbcOperation`: keep new `BarAbcOperation`, not `BarABCOperation`, when `Abc` has the same meaning.
- Existing union member `Tpm` has a Go override of `TPM`: use `TPMTransition` for a new related member `TpmTransition`.

Match the same term and meaning, not an unrelated substring. If the TypeSpec evidence is missing or conflicting, ask rather than guess.

## Uppercase Acronyms in Other New Names

Otherwise, uppercase confirmed acronym components in new Go names. Confirm their meaning from TypeSpec documentation; do not guess expansions or change letters inside ordinary words.

| TypeSpec target | Go `clientName` |
| --- | --- |
| `ControllerType.CiscoAci` | `CiscoACI` |
| `AFDDomainMtlsParameters` | `AFDDomainMTLSParameters` |
| `userId` parameter | `userID` |
| `recordAcsId` parameter | `recordACSID` |

This profile covers acronym casing only. Do not borrow C# transformations such as changing `enabled` to `IsEnabled`.

## Use Go-Scoped Overrides

When a new declaration needs different Go casing, propose a `clientName` override with scope `go`, for example `@@clientName(ControllerType.CiscoAci, "CiscoACI", "go");`. Target real TypeSpec declarations; do not invent targets for synthesized names.

Do not rename the TypeSpec declaration just to change its Go spelling. Preserve other-language customizations, and skip overrides that merely repeat an unchanged name. Report the TypeSpec target, proposed Go name, and supporting declaration or override. Keep proposed names separate from verified generated names.
