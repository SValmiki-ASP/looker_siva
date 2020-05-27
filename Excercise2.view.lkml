view: abc {
  sql_table_name: "BI"."DT_TRANSFERS"
    ;;

  dimension: amount {
    type: number
    sql: ${TABLE}."AMOUNT" ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}."CATEGORY" ;;
  }

  dimension: from_account {
    type: string
    sql: ${TABLE}."FROM_ACCOUNT" ;;
  }

  dimension: is_first_day_transfer {
    type: yesno
    sql: ${TABLE}."IS_FIRST_DAY_TRANSFER" ;;
  }

  dimension: is_recurring_transfer {
    type: yesno
    sql: ${TABLE}."IS_RECURRING_TRANSFER" ;;
  }

  dimension: originating_account {
    type: string
    sql: ${TABLE}."ORIGINATING_ACCOUNT" ;;
  }

  dimension_group: post {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."POST_DATE" ;;
  }

  dimension: recurring_frequency {
    type: string
    sql: ${TABLE}."RECURRING_FREQUENCY" ;;
  }

  dimension: return_reason_code {
    type: string
    sql: ${TABLE}."RETURN_REASON_CODE" ;;
  }

  dimension: return_reason_code_description {
    type: string
    sql: ${TABLE}."RETURN_REASON_CODE_DESCRIPTION" ;;
  }

  dimension: to_account {
    type: string
    sql: ${TABLE}."TO_ACCOUNT" ;;
  }

  dimension_group: transaction {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."TRANSACTION_DATE" ;;
  }

  dimension: transaction_status {
    type: string
    sql: ${TABLE}."TRANSACTION_STATUS" ;;
  }

  dimension: transfer_type {
    type: string
    sql: ${TABLE}."TRANSFER_TYPE" ;;
  }

  dimension: unique_account_id {
    type: string
    sql: ${TABLE}."UNIQUE_ACCOUNT_ID" ;;
  }

  dimension: unique_transfer_id {
    type: string
    sql: ${TABLE}."UNIQUE_TRANSFER_ID" ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}."USER_ID" ;;
  }

  dimension: user_payment_account_id {
    type: number
    sql: ${TABLE}."USER_PAYMENT_ACCOUNT_ID" ;;
  }

  dimension: custom_status {
    case: {
      when: {
        sql: ${transaction_status} in ('Cancelled','Rejected') ;;
        label: "Cancelled/Rejected"
      }
      else : "unknown"
    }
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: total_amount{
    type: sum
    sql: ${amount} ;;
    drill_fields: [transfer_type]

  }
  measure:  total_uniqueaccounts{
    type: count_distinct
    sql: ${unique_account_id} ;;
  }

  measure: cancelled_amount {
    type: sum
    sql: ${amount} ;;
    filters: {
      field: transaction_status
      value: "Cancelled"
    }

  }
  measure: processed_amount {
    type: sum
    sql: ${amount} ;;
    filters: {
      field: transaction_status
      value: "Processed"
    }

  }
measure: test {
  type: number
  sql: ${amount}  ;;
}
}
