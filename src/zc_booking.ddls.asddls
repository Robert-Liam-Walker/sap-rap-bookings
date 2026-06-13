@EndUserText.label: 'Bookings - projection view'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_BOOKING
  provider contract transactional_query
  as projection on ZI_BOOKING
{
  key BookingUuid,
      @Search.defaultSearchElement: true
      BookingId,
      @Search.defaultSearchElement: true
      Title,
      Status,
      Amount,
      CurrencyCode,
      BookingDate,
      Description,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LocalLastChangedAt,
      LastChangedAt
}