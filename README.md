# rap-bookings

An **abapGit-format SAP RAP** (ABAP RESTful Application Programming Model) source
repository implementing a **managed** business object for the **Bookings** domain.

> **Important:** RAP runs *inside* an ABAP system (SAP S/4HANA or the SAP BTP ABAP
> environment / "Steampunk"). These are **source artifacts** in abapGit layout, meant
> to be cloned into an ABAP system via [abapGit](https://abapgit.org) and then
> **activated** there. They cannot be compiled or run on a local workstation, and the
> object metadata has not been round-tripped against a live system, so validate on
> import.

## Business object
A managed RAP BO with draft-free transactional behavior, optimistic concurrency
(ETag on `LocalLastChangedAt`), a determination, a validation, and a `submit` action.

| Object | Name | Type |
|--------|------|------|
| Table | `ZTBOOKING` | Transparent table (persistence) |
| Interface view | `ZI_BOOKING` | CDS root view entity |
| Projection view | `ZC_BOOKING` | CDS projection (`transactional_query`) |
| Behavior definition | `ZI_BOOKING` | `managed`, base |
| Behavior definition | `ZC_BOOKING` | `projection` |
| Behavior pool | `ZBP_BOOKING` | ABAP class (handlers) |
| Service definition | `Z_BOOKING_SRVD` | exposes `ZC_BOOKING` |
| Service binding | `Z_BOOKING_O4` | OData V4 (UI) |

## Behavior
- `create` / `update` / `delete`
- `submit` action -> sets `Status = 'Submitted'`, returns `$self`
- determination `setInitialStatus` -> defaults `Status = 'Open'` on create
- validation `validateAmount` -> rejects negative `Amount`

## Import
1. In your ABAP system, open transaction/app for **abapGit** (or Eclipse ADT with the
   abapGit plugin).
2. Clone this repository into a package (`$TMP` for trial, or a transportable package).
3. Pull and **activate** all objects.
4. Publish the service binding `Z_BOOKING_O4` and preview the Fiori Elements app.

## Layout
```
.abapgit.xml          # abapGit repo descriptor (STARTING_FOLDER=/src/)
src/
  ztbooking.tabl.xml
  zi_booking.ddls.asddls / .ddls.xml
  zc_booking.ddls.asddls / .ddls.xml
  zi_booking.bdef.asbdef / .bdef.xml
  zc_booking.bdef.asbdef / .bdef.xml
  zbp_booking.clas.abap / .clas.xml
  z_booking_srvd.srvd.assrvd / .srvd.xml
  z_booking_o4.srvb.xml
```

> Generated as part of a batch of SAP sample apps. Domain: Bookings.