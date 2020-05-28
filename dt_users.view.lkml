view: userstest {
  sql_table_name: "BI"."DT_USERS";;

  dimension: user_id {
    description: "An internal id used to uniquely identify the user."
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: external_user_id {
    link: {
      label: "Admin 1.0 Link;"
      url: "https://admin.prod.aspiration.com/customers/overview?uuid={{ value }}"
      icon_url : "https://admin.prod.aspiration.com/favicon.ico"
      }
    tags: ["user_id"]
    sql: ${TABLE}.external_user_id ;;
    }
  dimension: admin_url {
    type: string
    link: {
      label: "View in Admin"
      url: "https://admin.prod.aspiration.com/customers/overview?uuid={{ users.external_user_id }}"
    }
    sql: concat('https://admin.prod.aspiration.com/customers/overview?uuid=', ${TABLE}.external_user_id) ;;
  }
  dimension: admin20_url {
    label: "Admin 2.0 URL"
    type: string
    link: {
      label: "View in Admin 2.0"
      url: "{{ value }}"
    }
    sql: concat('https://admin20.prod.aspiration.io/customer/', ${TABLE}.user_id) ;;
  }
  dimension: total_accounts_opened {
    description: "The total number of Aspiration accounts this user has funded."
    type: number
    sql: ${TABLE}.total_accounts_opened ;;
  }
  dimension: is_customer {
    label : " * Is Customer"
    description: "Indicates whether the user has funded at least one Aspiration account."
    type: yesno
    sql: CASE WHEN  ${total_accounts_opened} > 0 then TRUE ELSE FALSE END;;
  }
  dimension: marketing_cost_per_user {
    description: "The marketing cost to acquire this customer."
    type: number
    value_format: "$#,##0.00"
    sql: ${TABLE}.marketing_cost_per_user ;;
  }
  dimension: user_disabled {
    label: "Is Disabled"
    type: yesno
    sql: ${TABLE}.user_disabled ;;
  }
  measure: count_of_distinct_user_id_user{
    label: "Count of Distinct User ID (User Level)"
    type: count_distinct
    sql: ${user_id} ;;
  }
  dimension_group: initial_transfer_posted {
    type: time
    description: "The date the user's first depository transaction posted to their account."
    timeframes: [
      raw,
      date,
      day_of_month,
      week,
      day_of_week,
      day_of_week_index,
      day_of_year,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.initial_transfer_posted_date ;;
  }
  dimension:  inviting_user_id {
    description: "The user that sent the invite"
    type:  number
    group_label: "Referral"
    sql: ${TABLE}.inviting_user_id ;;
  }
  measure: count_distinct_successfully_invited_user_id {
    group_label: "Referral"
    type: count_distinct
    sql: case when ${initial_transfer_posted_date} is not null then (case when (${inviting_user_id} is not null and ${inviting_user_id} <>1) then ${user_id} else null end) else null end;;
  }
}
