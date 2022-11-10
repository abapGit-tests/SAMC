*&---------------------------------------------------------------------*
*& Report ZTEST_SAMC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_samc.

PARAMETERS: text TYPE string OBLIGATORY LOWER CASE.

DATA: message_producer TYPE REF TO if_amc_message_producer_text.

TRY.
    CAST if_amc_message_producer_text( cl_amc_channel_manager=>create_message_producer(
             i_application_id = 'ZTEST_SAMC'
             i_channel_id     = '/1' )
           )->send( text ).

  CATCH cx_amc_error INTO DATA(error).
    MESSAGE error TYPE 'S' DISPLAY LIKE 'E'.
ENDTRY.
