@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bookings - interface view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define root view entity ZI_BOOKING
  as select from ZTBOOKING
{
  key booking_uuid                       as BookingUuid,
      booking_id                         as BookingId,
      title                             as Title,
      status                            as Status,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      amount                            as Amount,
      @Semantics.currencyCode: true
      currency_code                     as CurrencyCode,
      booking_date                       as BookingDate,
      description                       as Description,
      @Semantics.user.createdBy: true
      created_by                        as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                        as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by                   as LastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at             as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at                   as LastChangedAt
}