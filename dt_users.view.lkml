view: userstest {
  sql_table_name: "BI"."DT_USERS";;

  dimension: user_id {
    description: "An internal id used to uniquely identify the user."
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

}
