json.extract! withdrawal, :id, :amount, :account_id, :created_at, :updated_at
json.url withdrawal_url(withdrawal, format: :json)
