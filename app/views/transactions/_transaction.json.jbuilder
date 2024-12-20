json.extract! transaction, :id, :amount, :description, :account_id_target, :account_id_source, :account_num_target, :account_num_source, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
