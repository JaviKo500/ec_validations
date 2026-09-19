---
name: Solicitud de función
about: Propón una validación nueva, o algo que añadir a una existente
title: 'feat: '
labels: enhancement
---

## ¿Qué debería validar?

Un párrafo: el documento o el valor, y qué lo hace válido o inválido.

## Reglas y de dónde salen

Enumera las reglas, cada una con la fuente de la que viene (una resolución de
la ANT o del SRI, una especificación publicada, una página oficial). Una regla
sin fuente no se puede implementar: una tabla equivocada no da un error
visible, publica un validador que rechaza documentos válidos.

Marca como abierta cualquier regla cuya fuente no hayas podido encontrar.

## API propuesta

Esboza el punto de entrada manteniendo la forma de los validadores que ya
existen: un método estático que devuelve un objeto resultado, nunca una
excepción lanzada.

```dart
final result = XValidator.isValid('...');
// result.isValid, result.typeCodeError, result.errorMessage
```

## Casos

Los que la implementación tiene que resolver bien. Los casos inválidos
necesitan el error que se espera que reporten.

| Entrada | Válido | Error esperado |
| --- | --- | --- |
| | | |

## Mensajes nuevos

Cada fallo necesita su `EcMessageKey`, traducida a **los dos** idiomas que trae
el paquete (`en` y `es`). `test/l10n/messages_catalog_test.dart` falla mientras
cada clave nueva no esté en ambos catálogos, así que enuméralas aquí.

| Clave | Español | Inglés |
| --- | --- | --- |
| | | |

## Fuera de alcance

Lo que esta propuesta deliberadamente no cubre, para que la discusión no se
desborde.

## Impacto

- [ ] Solo añade (validador o método nuevo) — versión minor
- [ ] Cambia una API pública existente — breaking, versión major
- [ ] Añade valores nuevos a `EcMessageKey` — hay que actualizar ambos catálogos
