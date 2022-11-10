CLASS zcl_test_samc_receive DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      if_amc_message_receiver_text.

    CLASS-METHODS:
      run.

  PRIVATE SECTION.
    DATA:
      texts TYPE stringtab.

ENDCLASS.



CLASS zcl_test_samc_receive IMPLEMENTATION.

  METHOD run.

    TRY.
        DATA(receiver) = NEW zcl_test_samc_receive( ).

        cl_amc_channel_manager=>create_message_consumer(
                 i_application_id = 'ZTEST_SAMC'
                 i_channel_id     = '/1'
            )->start_message_delivery( receiver ).

        WAIT FOR MESSAGING CHANNELS
              UNTIL lines( receiver->texts ) > 5
              UP TO 30 SECONDS.

      CATCH cx_amc_error INTO DATA(error).
        MESSAGE error TYPE 'S' DISPLAY LIKE 'E'.
        RETURN.
    ENDTRY.

    cl_demo_output=>display( receiver->texts ).

  ENDMETHOD.


  METHOD if_amc_message_receiver_text~receive.

    INSERT i_message INTO TABLE texts.

  ENDMETHOD.

ENDCLASS.
