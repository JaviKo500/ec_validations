---
name: Feature request
about: Propose a new validation, or an addition to an existing one
title: 'feat: '
labels: enhancement
---

## What should it validate?

One paragraph: the document or value, and what makes it valid or invalid.

## Rules and where they come from

List the rules, each with the source it comes from (an ANT or SRI resolution, a
published specification, an official page). A rule without a source cannot be
implemented: the wrong table ships a validator that rejects valid documents.

Mark as open any rule you could not source.

## Proposed API

Sketch the entry point, keeping the shape of the existing validators: a static
method returning a result object, never a thrown exception.

```dart
final result = XValidator.isValid('...');
// result.isValid, result.typeCodeError, result.errorMessage
```

## Cases

The ones the implementation has to get right. Invalid cases need the error they
are expected to report.

| Input | Valid | Expected error |
| --- | --- | --- |
| | | |

## New messages

Every failure needs an `EcMessageKey`, translated into **both** shipped locales
(`en` and `es`). `test/l10n/messages_catalog_test.dart` fails until each new key
is present in both catalogs, so list them here.

| Key | English | Spanish |
| --- | --- | --- |
| | | |

## Out of scope

What this proposal deliberately does not cover, so the discussion stays bounded.

## Impact

- [ ] Additive only (new validator or method) — minor version
- [ ] Changes an existing public API — breaking, major version
- [ ] Adds new `EcMessageKey` values — both catalogs must be updated
