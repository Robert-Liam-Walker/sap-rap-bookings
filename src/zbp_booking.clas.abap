CLASS ZBP_BOOKING DEFINITION
  PUBLIC
  ABSTRACT
  FINAL
  FOR BEHAVIOR OF ZI_BOOKING.
ENDCLASS.

CLASS ZBP_BOOKING IMPLEMENTATION.
ENDCLASS.

CLASS lhc_Booking DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      setInitialStatus FOR DETERMINE ON MODIFY
        IMPORTING keys FOR Booking~setInitialStatus,
      validateAmount FOR VALIDATE ON SAVE
        IMPORTING keys FOR Booking~validateAmount,
      submit FOR MODIFY
        IMPORTING keys FOR ACTION Booking~submit RESULT result.
ENDCLASS.

CLASS lhc_Booking IMPLEMENTATION.

  METHOD setInitialStatus.
    READ ENTITIES OF ZI_BOOKING IN LOCAL MODE
      ENTITY Booking
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_booking).

    DELETE lt_booking WHERE Status IS NOT INITIAL.
    CHECK lt_booking IS NOT INITIAL.

    MODIFY ENTITIES OF ZI_BOOKING IN LOCAL MODE
      ENTITY Booking
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR ls IN lt_booking
                      ( %tky   = ls-%tky
                        Status = 'Open' ) ).
  ENDMETHOD.

  METHOD validateAmount.
    READ ENTITIES OF ZI_BOOKING IN LOCAL MODE
      ENTITY Booking
        FIELDS ( Amount )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_booking).

    LOOP AT lt_booking INTO DATA(ls_booking).
      IF ls_booking-Amount < 0.
        APPEND VALUE #( %tky = ls_booking-%tky ) TO failed-booking.
        APPEND VALUE #( %tky = ls_booking-%tky
                        %msg = new_message_with_text(
                          severity = if_abap_behv_message=>severity-error
                          text     = 'Amount must not be negative' )
                        %element-Amount = if_abap_behv=>mk-on ) TO reported-booking.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD submit.
    MODIFY ENTITIES OF ZI_BOOKING IN LOCAL MODE
      ENTITY Booking
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR key IN keys
                      ( %tky   = key-%tky
                        Status = 'Submitted' ) ).

    READ ENTITIES OF ZI_BOOKING IN LOCAL MODE
      ENTITY Booking
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_booking).

    result = VALUE #( FOR ls IN lt_booking
                      ( %tky   = ls-%tky
                        %param = ls ) ).
  ENDMETHOD.

ENDCLASS.