CLASS ycl_data_generator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES:
      if_oo_adt_classrun.
ENDCLASS.



CLASS ycl_data_generator IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.

    DATA: lt_travel     TYPE TABLE OF ytravel_tech_m,
          lt_booking    TYPE TABLE OF yBOOKING_tech_m,
          lt_booksuppl  TYPE TABLE OF ybooksupp_tech_m.

    " delete existing entries in the database table
    DELETE FROM ytravel_tech_m.
    DELETE FROM yBOOKING_tech_m.
    DELETE FROM ybooksupp_tech_m.
    " Load travel data
    SELECT *
      FROM /dmo/travel_m
      INTO CORRESPONDING FIELDS OF TABLE @lt_travel.

    " Load booking data
    SELECT *
      FROM /dmo/booking_m
      INTO CORRESPONDING FIELDS OF TABLE @lt_booking.

    " Load booking supplement data
    SELECT *
      FROM /dmo/booksuppl_m
      INTO CORRESPONDING FIELDS OF TABLE @lt_booksuppl.

    " Insert data
    INSERT ytravel_tech_m FROM TABLE @lt_travel.
    INSERT yBOOKING_tech_m FROM TABLE @lt_booking.
    INSERT ybooksupp_tech_m FROM TABLE @lt_booksuppl.

    COMMIT WORK.

    out->write( 'Travel and booking demo data inserted successfully.' ).


  ENDMETHOD.
ENDCLASS.
