view: Excercise3 {
  derived_table: {
    sql:

        SELECT
         ROW_NUMBER() OVER (order by 1) AS id,
  dt_transfers."CATEGORY"  AS category,
  dt_transfers."TRANSACTION_STATUS"  AS transaction_status,
  dt_transfers."TRANSFER_TYPE"  AS transfer_type,
    sum(dt_transfers.amount) AS Amount
FROM "BI"."DT_TRANSFERS" AS dt_transfers
group by category,transaction_status,transfer_type
;;

      persist_for: "8760 hours"
  }



  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id;;
  }

  dimension: category {
    hidden: yes
    type: string
    sql: ${TABLE}.category;;
  }

  dimension: transaction_status {
    hidden: yes
    type: string
    sql: ${TABLE}.transaction_status;;
  }

  dimension: transfer_type {
    hidden: yes
    type: string
    sql: ${TABLE}.transfer_type;;
  }

  measure: derivedtable_amount {
    type: sum
    sql: ${TABLE}.Amount;;
  }

  }
