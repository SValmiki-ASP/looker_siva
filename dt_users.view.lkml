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
}
